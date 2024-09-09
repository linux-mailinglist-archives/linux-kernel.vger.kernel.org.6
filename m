Return-Path: <linux-kernel+bounces-320992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5A971318
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BDB1F2432B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B80C1B2ED0;
	Mon,  9 Sep 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O02zO2h7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WFErUjwf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B1194143;
	Mon,  9 Sep 2024 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873355; cv=fail; b=aevYezh2cVNxovTbnnSR7J8Z9ZY1dhhY7gAGrl2rIkRNEYXw+1qBGmbnFdx0eJj92fYeuE2lQI3C7XbnoZQNkQlV/hT7MevV0mKZXPLgs+2hddiEU5d9CNuXTPUsy5nrIi9uoIk03iwmcwUdeBUPZ107JA3gyuoGFcQGCBTHy4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873355; c=relaxed/simple;
	bh=oNPcJF3lQ4JUX99DlSd1RJYnA0ngMHKtfUUOpfdtBkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=daB0SOCDVMJ/SkhG3DLE4gQYY1A5OC3Ji+UvQyrznMFTvojOiTniRhSEpcO17mSoBwYCtj57mm0Ez7lDSm4gfmBJPhW/+FcqeUVi2bj/kEkVVbHDXz5mCzTgKUxtUScJ1+IrLuXrTrD8VCU9VbXM8KZ0CnvGu35Yly0H5lkuDg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O02zO2h7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WFErUjwf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4891tpcM031249;
	Mon, 9 Sep 2024 09:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=5RoBoxrVOCeWCpM
	QFde77R/nFDitiVABHMgZBbAwURs=; b=O02zO2h71a/LPU75XO8KieCz5dkzSU/
	Cxjz7EVsTIl0ikzHv+M9p0kqmhvJCuT2n9JXKThcV8Bn5/MMSIThgCexDWJzVMIm
	Bn1dpLSJU654aH98cPFvQtFBwd9j+6wJ5yCqYGxxYTVXgw/xGz9lsESyHz7Cj60y
	Ld9Kej1UBbTS+5x3m9vRCeuYB4Y45Th7+/1SY+XT70It9DDEypj5WUotL0C373sc
	53N481w1+CDZ6cc/jipdSJPZMZ1qU6t/l+va8FUTtjb7yo6bNSn95g5LMbDnd0X4
	smS9ceEpkBNP1SMwlFF4lwHSKnQAEj7DIMTQBMna0qp56KOd4lleOKQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb2dt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 09:15:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4897gDZF004967;
	Mon, 9 Sep 2024 09:15:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd96xkg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 09:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ti3ybpkJINUssOaDRhqXJgi90qMxj40uehXbocgHvqXsgYyfSmkkvojRl2Igz4zmLUHowEqvYaptErjjUQ36NZTHjI87KC/+nVM6pHANBOsGd8aOypZhedHBwD23iduvhOs99rzL4/SlYX5McDvQuxeEMeUJKjY+AqE6LOZGzWmXm/zVNa0yKXCvTOP5xBiFD+H5LpmIshS0e0fI8ZKWLJiefpg8AdjWg2fFSZtQf/VdfUEUL/Ib7znMFT9eGir1JEW7QD733x71kdLN/pFr4zlBUDEA5EV4JU+Mv+DPaA8ftWbGptf1FJUo9v1zz+iklzLoxc7pqquJd23oJF/xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RoBoxrVOCeWCpMQFde77R/nFDitiVABHMgZBbAwURs=;
 b=STEpv0n/MbZ7AMiru3Lqq5fRgi2t0xt887PKcK15v0aSjzb2g9mn926XTK5/Mt6+6l6Q45X7Kt5fblC+Op+ipvQqRl5VehomvQXgks7xl1dW3wgygYwlr2COdllJ9cCaN/EigfKrrasH/P4qX8nip8UjA5sDkJy8B9Kc0UfVOTnRRwlQA/VTEhD9Mcq+QBtRarEUnzT1KdnqJ8KqKrn8s/tj6iqWIwT7myaOQD8toDr2GBv1o3ouKYD4l9W/k7a81c2uVw30aRKYsl+CLPd8ln59SIZGrzpeedOwFXMhigysINudh2tLsXZLbkkmFG4JYS7xU0oruZY0a5NPW4fe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RoBoxrVOCeWCpMQFde77R/nFDitiVABHMgZBbAwURs=;
 b=WFErUjwfoku4iSVOLZFOoM5ATxXbdr1cbcRTTtE+HdSoROvkx1N8yvmv6OVshnmCzaa2B5/JI71ZPrw2FHzIZt/zs57npIEOJm93rCpxz/DYmu88fRRN8rWhxQrE1qxgiDJIfUPrA0ry2oXyaKkk7MQBWntQ08v+NT2OTe4hiSg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Mon, 9 Sep
 2024 09:15:41 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7939.016; Mon, 9 Sep 2024
 09:15:41 +0000
Date: Mon, 9 Sep 2024 10:15:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: jglisse@redhat.com, corbet@lwn.net, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs:mm: fix spelling mistakes in heterogeneous memory
 management page
Message-ID: <9fdf8ae7-332e-4266-b43b-df37fd7e20b9@lucifer.local>
References: <20240908161928.3700-1-dennis.lamerice@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908161928.3700-1-dennis.lamerice@gmail.com>
X-ClientProxiedBy: LNXP265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a1b335-f6f6-471f-cf08-08dcd0affa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQ/MNnWK63gmwT6E2CK3MGvdRyyOb5sw59g4X8x6nHEyjXgLwSM0zXpSiqo4?=
 =?us-ascii?Q?FCavwZwzbh53qpcu4ZmYRygUy+Vh7u0vdY8FCHhXOEph16D+1d1yvwurBzVT?=
 =?us-ascii?Q?gHNGxNi9q+U1BRsvX7smBoh408M8zprs213O2VWeKYDUYLJynkzGdGSw8LQj?=
 =?us-ascii?Q?lDzDTkmidFCyG6P8Xbi4NB0vw/6gCBdn2BZXwk5hLDpIdvJ3OKiRQnf8EToY?=
 =?us-ascii?Q?JmGvr7MobV+HckrO/983kYk8LRNchjmcjgGAkFXlIb+wlXCl4gCdofOa43BG?=
 =?us-ascii?Q?LhW+sdmZh4GrK8dkrp/Xtcg/WtvQOYZbMyiMXL9HCZvAzOWdwkzfUOkbuxVr?=
 =?us-ascii?Q?Jx2rGvTV3cmfeDSYHgTz0OhshSbBTbU78R6l9Vk3P3bsNgKscp4/LDi52peU?=
 =?us-ascii?Q?wUK4j7Ps1WCha123ZpV1r4hGu+gzWFO/BOsUg/5TbnqUTTcLmKGH63I8ful3?=
 =?us-ascii?Q?J44eoz4fPglD5RnpjsTUGo5qAKsdKHxLwwIBl4O5lYxXKS/xvx4THChfrBkx?=
 =?us-ascii?Q?RcYPvAtjp3xX9u60XPzuDQ0jBLfsOHrVd5m1eQcX8j/nSBrXweraYZ024ONd?=
 =?us-ascii?Q?aZF0q+MNCKgKNieNTar54zPLHEu48vVge4AKs+Nx0mj9B9i5eUYCGaoAPyW5?=
 =?us-ascii?Q?yDjoF503MJj2omN6qmPmIv2eNcGb5tXKX8uiV0vBoSZ1ITY6jFn442MKjYss?=
 =?us-ascii?Q?A9dN+/R+gBtQ+gMpptpOFpJhTO78tcamPv13HV7jj98orgonsyPEmXsdJZ/+?=
 =?us-ascii?Q?UA2tiP/1761X5XHtjbYIAmR+S6ViMwqHspIUMvNfarTVlSuvshca2GF8KcQQ?=
 =?us-ascii?Q?bY0bI43kLdN9NOMBMSjqOdNYnZxLdCA4xA5nAwFiXm9e2fL3FhJkkHcMOBHb?=
 =?us-ascii?Q?P4b9l6PJzeO12VqGvKx/Td6EIVi9PhTm35MA/ZyY0YheG8d5WAkQzZhibHRS?=
 =?us-ascii?Q?ao4RY8u1c2M31iIB/un6z8+io90e/2ZIJWN8/d5e2ucGeVxfb+9wifGS3Pj2?=
 =?us-ascii?Q?c06rFxbzG4oCS351AVKP0QUYEto6j83GxTutV6rCZ3XMYU6OXDq7Lmd6AEXy?=
 =?us-ascii?Q?goIOcwa1JThGzqipjFVLtAukrZPukgGxAXhJRodhtfaJ8e4yaiQWRCl3tG8R?=
 =?us-ascii?Q?rrK7KNPp/eKijd9KY/xvgsK7g6AteV5ZzK7mLfeXEDKS8VYc8Lnsqrx3nGbl?=
 =?us-ascii?Q?bF8sAKF9iMI9XPlXu1ht33o1YoHPn/n/mH5iRgElHXw7q/w4Xl4oGDr3ds00?=
 =?us-ascii?Q?4jWs6v0YYFaHIdcuLRAsZmplPbxP5PB4p3lskJhZYopt9o/Dl+t2AUUw3hgm?=
 =?us-ascii?Q?0zFANqB2BSwhOx+DecWx0+o/4r8vApLLlDYm2bJtpgKwOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tA3TT1OwmeUtmIBhYE8u2TJx1+jTZtGosAr18xemFwdYbNxhugBeLXjMwFsP?=
 =?us-ascii?Q?jPpZA7cOWejDA4L6FErYFvcS7o17zvh+SriP/OoKFZrH3RxYoUYHr1FkqrVy?=
 =?us-ascii?Q?wy0LRIbfHn4pmGXDXGN1WSugUhSEH1rKuWNBxLnBTzeSZIh9xg0HH0YbaesB?=
 =?us-ascii?Q?fewFzhwIWURrgdk50NnPYgHLTJqnayo4FVEFpdWy4JP6yeWmjMN4lUd953x0?=
 =?us-ascii?Q?bhdq8yjxL9Yab96nal+G8kUVZQhlNFeGTTifsWnfW4q/z4n8qQmvcy+PSdNz?=
 =?us-ascii?Q?BdJk26mkQ7otcqB/YNFvFEWW3U6o94HesntdvpqOmfMt1Wxw6HJDCfICjij9?=
 =?us-ascii?Q?FVskftGGXkiox8aHX4u9jQY0GGu8y9zsvT/lKtQ0Drhqd9jOS54STV6MD2T+?=
 =?us-ascii?Q?YUoFFd8p+qOZ18ZnwGQtdPVjsEnpsOgzwzy/bOR58Qf7rFLpK41FjW4kl9Ct?=
 =?us-ascii?Q?qC/y2yF1WKZU4bFGeAiRUpA5jJimeOHc2Y/vDbj6Cl1vF0p2L0epYHNR2l+a?=
 =?us-ascii?Q?bdXnSZdDbdo0EAqVznPkaKOWrZczzFEOE0+i2mB3ku25T9YKgcgUjF9/kWff?=
 =?us-ascii?Q?y6BwR3fDiBUUb3LWSqoV7UxlGDhZyV4D6iUcRytSQ4kKVSTGCJF1BhcLMURE?=
 =?us-ascii?Q?GYp9RjA4eM3m8GCRrZ2Hc1KmHf2xPB9Ya3cWdGo2/bfj4haO0zQZmrJC7Ro+?=
 =?us-ascii?Q?q5/Nl5vgeJGpv6LFRmJd+oDCVApZMVsxE9nFFkl9vMXpF8n3ePOuPNNwT60B?=
 =?us-ascii?Q?Y3KxSUR3NJaZ3E/lybr8zdI3FNrHm1VrPUxZeydhpqcpE3Z1MIFt/yJQJEN5?=
 =?us-ascii?Q?zyiGxYvcE6byeHCkEkFyJCDqDNnLf2WmnstYXU6QU8LU8Otmm5OhgnXRJ6H/?=
 =?us-ascii?Q?PzQuxTSUyxZDz35cGRI3gshr2R795jxMADoOVHEya2LNjc7eKXbULtn3VEgR?=
 =?us-ascii?Q?m6/0pTl8WrjjsKOloOZhTvNZ+YRo+wAtVp6wGDd2D4+IH4QN1a+rXysz+KyY?=
 =?us-ascii?Q?gWG1vQcOZbQGzJBn6KLjCccUrO9U3IlQL2vNOx2L5tc1gTKtBIvAFbd1REr9?=
 =?us-ascii?Q?nSgVGTtMgi5sQd2xa2jfz9LbyzjlT+I+fx5K6Be7wqTT46WJHwZTcfQ8OY0G?=
 =?us-ascii?Q?tsiKg9pwJvU1EhMyLIbX6wibXJIMUWa045NL4Utqy70kT2xvi4N5h/9s8v2y?=
 =?us-ascii?Q?kmW05uUJmfVS1oFujvndLDkMHin+R2T8ZtKcxZ6+oRTFjwzBr+HhvcvCOw5a?=
 =?us-ascii?Q?MAKkBAsTSzDMtTsutaFDsUlDKXUwCT64RPZDUf6xIRYF7X4zYntczSQ0kDSI?=
 =?us-ascii?Q?uNDGg/YPiwvZ8DTykH9Udu9uoESBg5HQPH/t6LLPxa9GCdfEwwd7loCKimfm?=
 =?us-ascii?Q?V30TC3W55NeUFbeiAsKcHN3ySeSRrtI4e21NnUtY8woKxzEwodXK4rLz9KB5?=
 =?us-ascii?Q?MzZF2kq5cHwZJ777kk5yE9hnqe099bmiM6CRP4zxKANwJBajyEoAxLQTkGUr?=
 =?us-ascii?Q?qRyWJ85aR3WAZPVlEW1bCw8GDUfc4FX40hyg+WUWwQmAJwQtEXfLtbIFfIg5?=
 =?us-ascii?Q?/aTE/i8LKnea+RkFo3OfyzEuLkWeZugtAA0lNZEfwIZSAyYk8ITUk3Mujfoq?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iYttVzncHeSqlumrhUaDR+ZQsNTBOea/LOGiqXclg3IKCyycrvzvE5c2L/Fv5pcDs0qgE+ZZybRljiXHRBEpA32S+gLr1vjj7G5xFi12Gf06pm0rgPYFJriAhNkeMe1Ua0wHN771dqqTNvyB+I6ej/SULA5o/9i2yHx9vfqxzS8ID1aVGDgdp1LHzp+AaDec3I7hysS8qFsC34Dxi+mjpm0HCRzCsGnYG2d1twmn081htQiY0KEpSoRz3lbKdOSdh/wZMxKhkCXGiEl0YW5SAb316o/ebUdNzkW+TewyXwzGXfmwziUh/CMvVGLjBd/pVq4WT2HXMbelip/8lrtsSLYJpLljky7zh3cuPvOL9PVumir/y6n3dpIuI+ATJAnZorMRAtsn/8ubuNzX7Dm4V2mza1Rdx/vJNmT4DdzhF1D+ygqf28kK2/sLtILfVB0k+9ZavKWS53fZYhtqHflfPM918N7tJEEAqqvx+nBtvqBtoRE6OiD4nHE5KbAjmmek66AUsRnkoiwnsXe+tUqEUJERkkJ67veMjDKNTgm87JrdVotFRcpErtHUFvTPAZD2dZjWxwnUv293AckDSEgxE2D6l285vKDCkmwg3PsNxvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a1b335-f6f6-471f-cf08-08dcd0affa0b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:15:41.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s4USz3ZrTyZk43gYfrY8/BvbByxTBWXBGvw7jvhfZHWdfT+3ZKgoyaTVtlWM/WatI21exuFm2fjlRoGhWBTvqYElIVKJI+WaM0NHhJCcUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090073
X-Proofpoint-ORIG-GUID: s_rCbAZRJOXn2Vxdt0ge6ZIzcK5nM_O9
X-Proofpoint-GUID: s_rCbAZRJOXn2Vxdt0ge6ZIzcK5nM_O9

On Sun, Sep 08, 2024 at 12:19:28PM GMT, Dennis Lam wrote:
> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>

LGTM,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  Documentation/mm/hmm.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
> index 0595098a74d9..f6d53c37a2ca 100644
> --- a/Documentation/mm/hmm.rst
> +++ b/Documentation/mm/hmm.rst
> @@ -66,7 +66,7 @@ combinatorial explosion in the library entry points.
>  Finally, with the advance of high level language constructs (in C++ but in
>  other languages too) it is now possible for the compiler to leverage GPUs and
>  other devices without programmer knowledge. Some compiler identified patterns
> -are only do-able with a shared address space. It is also more reasonable to use
> +are only doable with a shared address space. It is also more reasonable to use
>  a shared address space for all other patterns.
>
>
> @@ -267,7 +267,7 @@ functions are designed to make drivers easier to write and to centralize common
>  code across drivers.
>
>  Before migrating pages to device private memory, special device private
> -``struct page`` need to be created. These will be used as special "swap"
> +``struct page`` needs to be created. These will be used as special "swap"
>  page table entries so that a CPU process will fault if it tries to access
>  a page that has been migrated to device private memory.
>
> @@ -322,7 +322,7 @@ between device driver specific code and shared common code:
>     The ``invalidate_range_start()`` callback is passed a
>     ``struct mmu_notifier_range`` with the ``event`` field set to
>     ``MMU_NOTIFY_MIGRATE`` and the ``owner`` field set to
> -   the ``args->pgmap_owner`` field passed to migrate_vma_setup(). This is
> +   the ``args->pgmap_owner`` field passed to migrate_vma_setup(). This
>     allows the device driver to skip the invalidation callback and only
>     invalidate device private MMU mappings that are actually migrating.
>     This is explained more in the next section.
> @@ -405,7 +405,7 @@ can be used to make a memory range inaccessible from userspace.
>
>  This replaces all mappings for pages in the given range with special swap
>  entries. Any attempt to access the swap entry results in a fault which is
> -resovled by replacing the entry with the original mapping. A driver gets
> +resolved by replacing the entry with the original mapping. A driver gets
>  notified that the mapping has been changed by MMU notifiers, after which point
>  it will no longer have exclusive access to the page. Exclusive access is
>  guaranteed to last until the driver drops the page lock and page reference, at
> @@ -431,7 +431,7 @@ Same decision was made for memory cgroup. Device memory pages are accounted
>  against same memory cgroup a regular page would be accounted to. This does
>  simplify migration to and from device memory. This also means that migration
>  back from device memory to regular memory cannot fail because it would
> -go above memory cgroup limit. We might revisit this choice latter on once we
> +go above memory cgroup limit. We might revisit this choice later on once we
>  get more experience in how device memory is used and its impact on memory
>  resource control.
>
> --
> 2.46.0
>

