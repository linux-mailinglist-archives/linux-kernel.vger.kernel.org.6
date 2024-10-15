Return-Path: <linux-kernel+bounces-364996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C599DC09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693DF1C2198F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8D15ADAF;
	Tue, 15 Oct 2024 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FHYLXmd6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pxpeJSBH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452713D291
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957882; cv=fail; b=eDp6s1sKKTL+PR62k5AZBgug1r7DyJZPjxDaQCS6W53UnaosUmzbSt85yBOu4GwnDbkSMd2B3OY7mZjO4fuwaenBcHSjUb72IrkmsbuUI4WWth2iuuJOlW6nAo9tUPTOP5nkd2HUeNKpF1cLggyMLEl8r3sWgBd/aOaYzvw4Y9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957882; c=relaxed/simple;
	bh=hK+lsTiwNNMeM0QD6KJMikWtmw6KhQXQmwXzci2x4Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfXe23YiHvHRxmL+PP0bCOMy4iav4pZDJlT5RDTMb6aReykrjGeXF7EQ9zCi373Xce8FXKqBIrKjt9pW11AZpCHeylrj4kgg/NC/6Pu/r/RY0Kd7qBDrDg2zdjJSo4jns5qWsR4mXw63Ib/efk59v+DCb9DQf/5bM5HfUrHeC+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FHYLXmd6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pxpeJSBH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1BgOf018809;
	Tue, 15 Oct 2024 02:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=14VjmrwVE3tZic1PDS
	2yfay61Q4TpF8wR12Q8gVk3rI=; b=FHYLXmd6QoXyQ91TqBs+ngOfciZYas8OtK
	eeRhcP2+tCjTF8iM1wsjxOR9bNAqx9ufWgnqzmbavbOunpzR204WSyn7UFnNtVrx
	KU6xWibQavcbUYWpBuaLi2+yhXI6FZScrRJjlRkWKhK/b1X+xb4Lp2KOVTOwVXlH
	iJvLmOwet8UpnHZ0NXCIrpdhcCdbtN8ZO18eoUw/5Y95D035FyHJhGN//ZUos/qo
	buJylOCxS3UN6yLq5Kd+rI6xOU6HqQT6c/unqNaMNA+uPqGYVgvOBUu2e3JUjxdT
	AxCeWJOpXTp9vDKiuZbxjSpMPduCZvsjSPulghkQc5nJmUQOzy/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1afhk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 02:04:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F1JNvM019937;
	Tue, 15 Oct 2024 02:04:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj6tutc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 02:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U826ASGOt6Wf6gnYsmBxOZSsLLkE/q5eo+FVK3eU/yOS6Ou2Dncj3mj3XxIlQETnfuQP/s3G9syHpydiJiEFLOBjVLBd+uCFAezEK5l9whKGELAP1QWgEFNITfIZxB0TnjCIHVBeTG2BblH+xWGy/4wCq73EZatd2SrInhoQvWrVRt0DsKYxKHahe8gvRUvCvtYk6Qj4dmf5YwW7KYs/bAbYtZtMCSe9mjFefqFyhffUi7yEwaHmXDm8ZHF2UaToxfNBNdIdzz1ecQtTADkIZELslT4O/aBQxSax6QZvOc5XhIG/xfrNrXALKNkUfM/Tj+Fc2oRtp5YF53lOmUCv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14VjmrwVE3tZic1PDS2yfay61Q4TpF8wR12Q8gVk3rI=;
 b=MC1PwscXncpeVy0HMhx4PTYbkqzrEijiQ+fpg9ta7OqV0PPpcHprvt7X6xFBDxMKNLkEy3oQMqgmin0zwa/h7rJDpSNwGaAcolHrHNlG5rgZLu7F6o4glAxL5i89Qn30KZ0aHyrJJEOeXNmcXOs/UP7AYOW7BhjEXCPtZlGeLtlhxBNq5jdlNJOmiIVRgyuAKFzMgKWuGoJCRH49GxrIe9xc7qdpatMPz5C07iEwDjRCyopBDRQSZIaoC1VRDbjK4w+j50QUO8TCFrjWhpu8prvbNvVkPAQcv5sI77U+ZRBv1lwJTdzSFVBoHMUHCvozre+CswuXrjB8Mnd2JuVqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14VjmrwVE3tZic1PDS2yfay61Q4TpF8wR12Q8gVk3rI=;
 b=pxpeJSBHWV4f2XNuWlHvPj8iVhWGBYW00zbvvjqe1M6kwzhvEsL8O7LwDIphratM4RdMTjvam4BGZ9r4pf6COvZtS/nzJBklvrYTqHfi3g1eYe6xGCJO07Z25c+i+BGxPr63pcCirfB/qLz40smLZgnSTScjLHxP1fsDBX0PPEU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4278.namprd10.prod.outlook.com (2603:10b6:610:7f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 02:04:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 02:04:27 +0000
Date: Mon, 14 Oct 2024 22:04:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH 2/2] maple_tree: refactor mas_wr_store_type()
Message-ID: <3keqnxijxstmppmci46icdfr7cshskhfzdztv4lwjjbykahjdl@riniqq3ba364>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org, 
	richard.weiyang@gmail.com
References: <20241011214451.7286-1-sidhartha.kumar@oracle.com>
 <20241011214451.7286-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011214451.7286-2-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e09ad9-0436-4197-a456-08dcecbdb2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?97BwFt7XEY/L/kqfQJ78b+ToM0hAsVDM4Tf3XDgyDhC50T92+h779lcQw1MD?=
 =?us-ascii?Q?JwhCF3bQq+fO+K74csrF2NzyR/QpF9H+KphUdpYRR0biohQtE+9nZ+s9ajx9?=
 =?us-ascii?Q?JIEkcTYUEPyXrMUDvtjZUtWraDpDk9iU2jWxJ+UyuxvZLBqnSM3X3wh8dNj6?=
 =?us-ascii?Q?SdRr+cj+zjeUZnlZ81GuF2vmgAg61atuf0Pk+HfDcEdtI9TCOsNKGgxipozO?=
 =?us-ascii?Q?DKleGCS8bJgfM/epuWos8Cd92zLNNNe1HKWQWtqi0e2md8/dGPOSaprmbv6R?=
 =?us-ascii?Q?RGt+wTqjvY37aVjyGStE6m6DS81bKS9XEYUtJpysXec6UdP4bUX0VttqOsXL?=
 =?us-ascii?Q?mvWv/5duYS620Sgmoc3gf/guTVFvLwmfX8MfDlYQ0ElS8xk2VTbUdUFpKx7V?=
 =?us-ascii?Q?qcU1ii2MRB57PZRsTk8g4VGSkv7bCEEMXonOziwhYOqc1uUDqdvTIlmDRxqa?=
 =?us-ascii?Q?6oI+lmTGqYeWpZ3+9PeUZRDnllOkqEYnEAgdEGQVamXmTaBSxY/95CBI53fv?=
 =?us-ascii?Q?cgv8CKeUp6KmR8az7CoTUAcQ7LkiBVvRirz2qJH30pbIdWW6Wzf8HrvsPsc5?=
 =?us-ascii?Q?3HYgzkmefVSM12JmTYTHCG/2T8cCPmfNjc3ZsTQgqYfulud+i6ezZnwl01E6?=
 =?us-ascii?Q?iEj2mtEzn0E14OFKxSrp+jG1JWKU8vUaluyDUazaIgpGNIiuAmOr7nfAFtIR?=
 =?us-ascii?Q?mbR+wv2dPRKMp5ccFs9fasXcKT0TCZZVHXXd4m0LdO2Gu4FwYL8RVHf6V1H3?=
 =?us-ascii?Q?HfnxYqoYB1wlpD0RT6C/zisF9n9xLo9OJSa+Ehc5rmZXCPq9jjJqz7c6ST2X?=
 =?us-ascii?Q?ylgNAT0+W/PmETdJeqeXeyFEoqD+WwW0iFklI/KKfxjj5BBF/4LN1oWlKlee?=
 =?us-ascii?Q?BF+47gXOo84ZQyOxUN2f/yNJv4icxAHIlIL8TM6KhsVxUC/2VBqLpW/DLyQL?=
 =?us-ascii?Q?WE+J1VFl2ZV+mdiyrXyFTXMUMRSvLAgyrIFBAyVktOhK4m5vkdqT5nKoyeEm?=
 =?us-ascii?Q?fv74xf71TiJsKPJ3TQ6Fsif2OU/Bp3lK9XiEWImuMu3fCp4FvWUEydu+4aG5?=
 =?us-ascii?Q?zDcvwwoiJUCVjEUmGLpFbi48+eAfV+C0/I2FnESMq3Go3h/btqZRfCuR8a9U?=
 =?us-ascii?Q?RH577KQdSnod8fQV9K0EEbDBNr6fADGnTdUqw2Rhz+0h0gwaXb56I68J0ve/?=
 =?us-ascii?Q?+N3FfZdvRJ2ZgB4U8FPvvLuK1kXbk+e/C/OF2EtXJ3UmsDf89lqUTBkair7F?=
 =?us-ascii?Q?tpjH8vAfFYwynl4FHjQQ339yOJDW/kBx8aObkDOYig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TguwH0q0HXDT1Myl9dOszyl9MBbTTomgZT47uofGl8/my9kpTWOJqeiuHK0d?=
 =?us-ascii?Q?fo4Z+NdOvRn1aYSnVTGvETwkNq0MnWg8MyBF7WVsAnsMQISkXom8xdmZxgI0?=
 =?us-ascii?Q?ngG73qO5I7rRqq6ejlsiDbIrRZRnJweHBVtBUDG1AVknorxNFDXVD2kw1mQb?=
 =?us-ascii?Q?rH7lM8lxDRfUb9f8EN5+SgoYMwj+0527vwwAdcYqs21vMjAea60vtiF/23Cu?=
 =?us-ascii?Q?Af5lKFpsJG3eqC7l0ND+ywg0g8NH4Tz5z0PoS5yXTtphnv3EvBXKMBbM6i8t?=
 =?us-ascii?Q?07HPFFBpQUn71AnSs5dENIHec5drQESoHw3Q50Fa9J8kqXf/rgdILIFkJ/k6?=
 =?us-ascii?Q?k0rMT0hRRx73ZjnXzprEBeLsER7dlvnsy2iq999/U3nxs6YhyvdsIaMBHqLa?=
 =?us-ascii?Q?+C9AGcalc/Y+nQDXla4jk4NEKHhx0ABjC3dWQR1dIqmJFyUg5iWP+eMelJDF?=
 =?us-ascii?Q?OebVDVc06GmFRLcfkLQ2ff1WDJTaMPCTmzEQnMr4V0md3suJq4fv4k5/LTdt?=
 =?us-ascii?Q?PHF6/gjC7VcngNnB7wuLvq1b8idXahkEeG6LWU6rkwjwDP/xuMPfDAjmL8AO?=
 =?us-ascii?Q?/bNctpn2sEYFhtcE1FTdckCtVcyeUqcC6RgLkj0Dfg1ue6qE3kp3wxibjk2I?=
 =?us-ascii?Q?esXhqKtMb7aV2hY1Cx81qWdKYVesoCikZRXNPpk4lHSoAACR7LvAemZ//HlP?=
 =?us-ascii?Q?CJGDa4MrMYPVJS8Agb1nKppnoFld6Do7rUhfPbiapAcrTsW7NJqonebVrsp/?=
 =?us-ascii?Q?oaLMiZN2MXXhjrAnM2FCrta6XsbiYc7YXKYPnoi4Tlu6e0WRSW9qODf8CDxh?=
 =?us-ascii?Q?CSjFoNNKgqH7HpP22dQQL0CHvdr0NoYpi3quXARrJ1rS5KM/PhvfEiLnf292?=
 =?us-ascii?Q?ar1im4890af14CWPM0rF2FbUqLgISglUIjYv5zcvcSLDlYQPtJ8UgB03OfDy?=
 =?us-ascii?Q?EMS0gQv/mEsg0kjjk+Jkm1f05sGRLstudJ3U6na7q0ffZrF7lwXAQ08pkXZS?=
 =?us-ascii?Q?Kikz/Z4s2+Xzi4HY7VKKJKOwoIaeg7VXOpUiit0TFVpiH0OxS6KqEj+KxfwQ?=
 =?us-ascii?Q?RjB7Qm1joW+X8jQx7/XiTQyZvhQI69q6+q9BFDer7WyAOh+AFWkq5wu7CU0m?=
 =?us-ascii?Q?+RN4Bw8EM5hQeLRVfzI5uN1l9zemP//2AgFs25Q6oi+39oTrU7NJJ8vX6C/p?=
 =?us-ascii?Q?7/I5WIeogwMfpV9g43VIAwAKWR4xZXzJBeNArHkmBX/lM8+7Ug0F94ffMghr?=
 =?us-ascii?Q?256f8lS3seJ5jk5PPehV8kikKt6Td3dvaKkj9zSXQ4wcLV1d4PqwRvvDiBT/?=
 =?us-ascii?Q?K1tqe0qD+rcQRWiL3Lbmp9ue5nJ0GUT/CHk8XKuHj93rfpH55c2HLrvVFli+?=
 =?us-ascii?Q?0YQEny1eT75A23/f1/yhFe0pz+ZjMlksPv8Mu8L8o2Y3I12LwwUIaBZfL6gp?=
 =?us-ascii?Q?gYqci4764ppT5bc37wdGL9B5dcHe+0L/QO9tlf2XLHMzhQ3l8v4FvMGkVdNy?=
 =?us-ascii?Q?f35Wk2zp0wa6ihI8PQDFl1sUSlhYrtr0Z2YZGmSgnl8N47N6xFctjo6NtNWX?=
 =?us-ascii?Q?H7hRjqBEIx+ezVmMsqDHiH13sDy8u/R6ZM96HOxGONd+oBNbZj0XHaTlNMRr?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sqbMCtrbLjMt4O3eO1B/KLH6wpl2JVL0c2yqiVST5On3jsPNeJpbl7+P63R6xKvYVbs+kl2WdapIfnRv3ZvNf4CYXjvYFEsad4eYMVw//eBYNRZu3QccAoFxvxMa5RQDCaNGoYOeV+il0GIZZLVVAz6tvbNEouUNiiKKE/b7yx7/bjWt+8cdoQ4kOLjFDeDENltEvExohUfbnGoOKQnPHx6ywA7cC/h46vCRgJKuhyakBx37j3cu2xv1WTwVebBrh5JBJOjNOPzWwuKHAjKPgssLcZgSKLIHig83RX5s+OLe4lCdtUUOOurP36Inr6qP94jsgXVHFN9lzRDZe3iZ8AXuHivOtUgzayi/Z7anjoOyt8zIas2efX1aN3ngNZtmYb8WSPJkZ6FzVBvBCuitHIpFPH0jISDx6lpTZR6jmc1HWhEIMohWPqo8j3+H4frjzqiLZlmNSgdOeasYl8JhGsRk7MNUIKRoMCK0k9ieOP/7AueKzcJDuSKubKIgYJNI0SUT/sazDNKf5O5j2quksDgjgVNT3HPLyjfQ2HkxLIt/xT0CFaZnJk7Hj6UVV6op0PHSmNgSTBzFtp3cexJkVXWSq/Bqggs76IeRVLfjOyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e09ad9-0436-4197-a456-08dcecbdb2bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 02:04:27.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv4PWSzQbtpfPNk3ErLsH8HeMWowCH42TbHVKDPmAoeFBhh4e8+ZrMceq+Wj451sSlb+KedBC2LbSL2ynEoq5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150013
X-Proofpoint-GUID: e8hOsuy2aF2W0kHoZ2PCCKwC0uCfbbJn
X-Proofpoint-ORIG-GUID: e8hOsuy2aF2W0kHoZ2PCCKwC0uCfbbJn

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [241011 17:44]:
> In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
> this check fails, we know that ,after this, new_end is >= mt_min_slots.
> Checking this again when we detect a wr_node_store later in the function
> is reduntant. Because this check is part of an OR statement, the statement
> will always evaluate to true, therefore we can just get rid of it.
> 
> We also refactor mas_wr_store_type() to return the store type rather
> than set it directly as it greatly cleans up the function.
> 
> Suggested-by: Liam Howlett <liam.howlett@oracle.com>
> Suggested-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>

Reviewed-by: Liam Howlett <liam.howlett@oracle.com>

> ---
> 
> Hi Andrew, could you please drop
> "maple_tree: remove conditionals to detect wr_node_store" in mm-unstable
> before applying this patch
> 
>  lib/maple_tree.c | 72 +++++++++++++++++-------------------------------
>  1 file changed, 25 insertions(+), 47 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b3b1d4b8126b..a5e982e482dd 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4191,24 +4191,22 @@ static inline int mas_prealloc_calc(struct ma_state *mas, void *entry)
>  }
>  
>  /*
> - * mas_wr_store_type() - Set the store type for a given
> + * mas_wr_store_type() - Determine the store type for a given
>   * store operation.
>   * @wr_mas: The maple write state
> + *
> + * Return: the type of store needed for the operation
>   */
> -static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
> +static inline enum store_type mas_wr_store_type(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char new_end;
>  
> -	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
> -		mas->store_type = wr_store_root;
> -		return;
> -	}
> +	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
> +		return wr_store_root;
>  
> -	if (unlikely(!mas_wr_walk(wr_mas))) {
> -		mas->store_type = wr_spanning_store;
> -		return;
> -	}
> +	if (unlikely(!mas_wr_walk(wr_mas)))
> +		return wr_spanning_store;
>  
>  	/* At this point, we are at the leaf node that needs to be altered. */
>  	mas_wr_end_piv(wr_mas);
> @@ -4216,50 +4214,30 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>  		mas_wr_extend_null(wr_mas);
>  
>  	new_end = mas_wr_new_end(wr_mas);
> -	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
> -		mas->store_type = wr_exact_fit;
> -		return;
> -	}
> +	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last))
> +		return wr_exact_fit;
>  
> -	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
> -		mas->store_type = wr_new_root;
> -		return;
> -	}
> +	if (unlikely(!mas->index && mas->last == ULONG_MAX))
> +		return wr_new_root;
>  
>  	/* Potential spanning rebalance collapsing a node */
>  	if (new_end < mt_min_slots[wr_mas->type]) {
> -		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK)) {
> -			mas->store_type = wr_rebalance;
> -			return;
> -		}
> -		mas->store_type = wr_node_store;
> -		return;
> +		if (!mte_is_root(mas->node) && !(mas->mas_flags & MA_STATE_BULK))
> +			return  wr_rebalance;
> +		return wr_node_store;
>  	}
>  
> -	if (new_end >= mt_slots[wr_mas->type]) {
> -		mas->store_type = wr_split_store;
> -		return;
> -	}
> +	if (new_end >= mt_slots[wr_mas->type])
> +		return wr_split_store;
>  
> -	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
> -		mas->store_type = wr_append;
> -		return;
> -	}
> +	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end))
> +		return wr_append;
>  
>  	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
> -		(wr_mas->offset_end - mas->offset == 1))) {
> -		mas->store_type = wr_slot_store;
> -		return;
> -	}
> -
> -	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
> -		(mas->mas_flags & MA_STATE_BULK)) {
> -		mas->store_type = wr_node_store;
> -		return;
> -	}
> +		(wr_mas->offset_end - mas->offset == 1)))
> +		return wr_slot_store;
>  
> -	mas->store_type = wr_invalid;
> -	MAS_WARN_ON(mas, 1);
> +	return wr_node_store;
>  }
>  
>  /**
> @@ -4274,7 +4252,7 @@ static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry)
>  	int request;
>  
>  	mas_wr_prealloc_setup(wr_mas);
> -	mas_wr_store_type(wr_mas);
> +	mas->store_type = mas_wr_store_type(wr_mas);
>  	request = mas_prealloc_calc(mas, entry);
>  	if (!request)
>  		return;
> @@ -5446,7 +5424,7 @@ void *mas_store(struct ma_state *mas, void *entry)
>  	 * overwrite multiple entries within a self-balancing B-Tree.
>  	 */
>  	mas_wr_prealloc_setup(&wr_mas);
> -	mas_wr_store_type(&wr_mas);
> +	mas->store_type = mas_wr_store_type(&wr_mas);
>  	if (mas->mas_flags & MA_STATE_PREALLOC) {
>  		mas_wr_store_entry(&wr_mas);
>  		MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
> @@ -5549,7 +5527,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  	int request;
>  
>  	mas_wr_prealloc_setup(&wr_mas);
> -	mas_wr_store_type(&wr_mas);
> +	mas->store_type = mas_wr_store_type(&wr_mas);
>  	request = mas_prealloc_calc(mas, entry);
>  	if (!request)
>  		return ret;
> -- 
> 2.43.0
> 

