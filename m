Return-Path: <linux-kernel+bounces-523271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BFA3D48C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA71189BF63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF781EF096;
	Thu, 20 Feb 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZsN5bu0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1z5nsRr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F631EA7ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043327; cv=fail; b=q9ZeqiZSlrm/QKhjnoidHETVld3NOdVmEURdZr4S90U9CgGa7Hrit0eMM1odEPAspVmbweofVFErEBF9vh37eeTXIfkcvU5XyjpcnfPKX4GtXjWO6kjdX8UHHp5LGMH+B9JRoPxlHmfDpcUGM7pgGsgOc6QPgQX1r6aK0iw2QuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043327; c=relaxed/simple;
	bh=EOjSjyTeQ2lzSqwg21diWp9Amt1uzyTUN/iQ0enJFmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ubtI/0R4+v/itLViMvuXfKRL8P2ETsf+UhBTy9lxlfdeUlyELV0ljqcJnJEt7GxmLJcjCC/UozN/o9EB2zf2XMdlKWUsGTRdesGN8JHl6kAeoHgQmA+ftAnTdfapH2yo7eTbBG90XhH0PGAcBJVTFWZ7sYoXmRpmFyfrNtgpIR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hZsN5bu0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1z5nsRr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5fjZ5017645;
	Thu, 20 Feb 2025 09:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=h4mSPfcdz1h06Ao8c3
	APC7ICT21zxVA7O1p0uWgQneU=; b=hZsN5bu0amkSAEZ9FN6DgH2VKlDsmwFaTc
	jWBacn52m7FTfQOZfXosJO4e4CsMzVDhyLWmZrwtgnGr1b5PQPTR+9isse1V3Dek
	UgRyJQmGqiarjTfgr725U7cBP/xpSGMHyf7srNtgQftGaBjdBJdtgPwDifMbZWQj
	S0Sq7mRQc5b8LlArkftYnboqI3RTepLOPblneEO10w7cVcUkCC0gMTj2J1n6weVt
	igODYLpy7JuSBOY7AbYeNbyR4cs+y8uEF9Xzk39d6yB5QqB0p89UqcklMvhDdIVC
	NlC5JawZIwpT3uBFD4nXcoag2NFL5nN9TXK4wgGeCJl7WItiUcYA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nkqmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:21:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7ANi4025182;
	Thu, 20 Feb 2025 09:21:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08xn6ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reAV/lpaFiYTyCps9fg1XjZckKQoxcbgyhlwd7XQvL/7GrZmZYKwsrrLH0XyG7Vu+hJOJ2ioju5vykDb+LtikaZfA2/0YmRR4/DpVm2GA6+x/EKmEL/FCbvnRJxrMJqR408q9QBv6hyZwHTx0IdtF/KNmLvv9TC5Zepm6cR8ctizxu2QjFFEtGLRdSb3my7hO3ISJZO1Om3xqGHz/qgd9iOMLpbdOK7+COc+U1LlX5+hzmGR8icY+vzfjclYJQeoW0B9VyrWPQJuAuL4Y6ng5o01RTmWnfXL4zrg6AxHYELSUhF7IaNvyUGDIGLwQZ0IMrMZ8n1vp/qnlv4w0E09Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4mSPfcdz1h06Ao8c3APC7ICT21zxVA7O1p0uWgQneU=;
 b=vZBp+XopbTzTJjb44zZ3WG9Qj8PKZqa/rppnYRjVU7lazotYj3nI75t2An1tMRE4i5jQYCT5BI/gyWrDGQ3yoJk1VUoEf4TE3BbgONihKnwdaEJcrtehs2k+QHj1BHIYY9wnboOckB1bIg75HEb/k3rOPz8YlK2zdgkt4spiv7bHWuy31uFaT9To+4NgBnrycZN1nEJsAOjiKPv5KcKLxJBKG1LHxTw4URjDxSc3AaRGVJnhGZ4b2/n3BIS+WyEX7OXsuF9KAMjsDopAgM8fdX8U7o4CLeXxRH1YD/ODel8yJkQ1osmXgLMbv7ExSi495JaS4aTLARjdtqzFPd6qHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4mSPfcdz1h06Ao8c3APC7ICT21zxVA7O1p0uWgQneU=;
 b=n1z5nsRrQXy4w5LVVgp5dQwfMz6ynbFxTS+xXea2321Bs9ephaVFAx6ZvW+n7q8JW9WZ4E94FHiz2VOJQRMHx+zak5+xoET27kBOEw+L1ANV2uugN36VuxvclllgqW2O+hcFQU2f7HCMFNbI9niO/FBsUEpL7JKf2+NIwrk35Rs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB7481.namprd10.prod.outlook.com (2603:10b6:610:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:21:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 09:21:21 +0000
Date: Thu, 20 Feb 2025 18:21:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
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
Message-ID: <Z7b0CvTvcS47o7ie@harry>
References: <Z7DHXVNJ5aVBM2WA@Arch>
 <Z7blsPJiOPTFWEL2@harry>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7blsPJiOPTFWEL2@harry>
X-ClientProxiedBy: SL2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:100:2d::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1376c7-8aba-401e-b57a-08dd518ff034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cDOQ4hKy0y+K6pu1wV/GwF0TqQVu+zLGk68yKkqodmB36Qt4OQ3OKoAg+yQI?=
 =?us-ascii?Q?oJna6IXUum1ik/y3Co9AdOGsKOP81TpFjXu1OxHvf0W8Nr6KmyKS+Nq5kvkd?=
 =?us-ascii?Q?9CkddnoY76/yu7b7r3A81MWnkHk37zkbI2U7EyhGneEaqPnzvQTqUnsV+ZDI?=
 =?us-ascii?Q?PvkuAkM2jUyhLGIY92xN27/FDITvg9aAMNkrX1hUl+79+Iq25d9DE2Ymu+J0?=
 =?us-ascii?Q?Dfhg8kNH2cEuRkga020I1jePWAoDO4KLuN+FmGXFwsyzSHsE8N9tLGOBMjCE?=
 =?us-ascii?Q?lBe0/qmOl5ga6mLTPi/YCrYENerDDe4jPIv1lQYfaO/hnFPj2os7/Z6B69or?=
 =?us-ascii?Q?AHMwBBqSFIy28KMzKgncy5O69tnxUMLsv7WnJnpl+GZ1xe5ZhZszbxxpG7de?=
 =?us-ascii?Q?EmPOTSJq8Zkt0JM2cY194CGbFdbzOyEMYQAL4x65QZfuQIbuvlSRO6Z0zQuF?=
 =?us-ascii?Q?Z6U4zxhudDOwR2pFMpGkMTfELYM2ia2q40PVoJwtkWh1Q2nG5DjGVsCDkNF4?=
 =?us-ascii?Q?HdoAt0nvo85VxEhOdDInIuG6kD2+jdn0ZReMjNY5EZ1zvoP/CPn0jQlfdv9k?=
 =?us-ascii?Q?dCsH9ez+eP8neI4y3gmQkAYC1tung+aZ0IDiJ0AZosdN1hxBfcaBlZ9nLDLK?=
 =?us-ascii?Q?k1Q4Ea7rgEgEx3vf+eUjALaRM8bR/jLX1hN8navRRqqHfvwYjYnzON7ajkEp?=
 =?us-ascii?Q?78xU6nMdlpdQO3Vxr4GWc4N10sJae0LVzk+BbvVTE+8lEeR5db+j4n3a2SRw?=
 =?us-ascii?Q?KpinYfmGSyv8dKzyitE5YiYGYAGYahL+xdHWVUVPw3LBSiR3gHjF9I3mUrnN?=
 =?us-ascii?Q?FM0Ib4PGoG5WT9vkTFBg8TpCU6+MCqfAOaGw8VD9DBB1MfA3DGA5cDF/W7r0?=
 =?us-ascii?Q?CjIFqmmkRLpuXzT8Gou/bpJG4FDtPLxDfPpFLNUOSzWxQPqnw7qHQXABtkCq?=
 =?us-ascii?Q?KYabFrqAQOhQ3xbtJ885cILdpLNoWtcA3w2i2OKcjIwfwz36lxecGjbxYIjT?=
 =?us-ascii?Q?dNRDOfEFRXY3OEE8y8tsSkYPz1yECSNFf2JzQ05XyrETdy7OUCYoZ8wEU1I2?=
 =?us-ascii?Q?iAM76420leW4o7/Fywzd/XVz4Ryx7EUZgq52cZUNly42ESnRaJbWVyXgK0L5?=
 =?us-ascii?Q?1QOREUbC7X9aPpNeFisDOjXgq6Km3Lv/9a68O1TqXMllT6imchx4M0rIzO3T?=
 =?us-ascii?Q?juzd3HzB/CEx2wMmBBDnTwg3q5p2zzjBwD3sNVqr/va3Ymk3J1oD6CRcoS44?=
 =?us-ascii?Q?S8eichrN6qAlZtqWJhIGWdJ/dae/NDN0B5ihufGjCLYNl44lhFdfpoV97m18?=
 =?us-ascii?Q?I3YoX7FNG/3lhisg/v9eUTGjSGhVpM5qbCUGTa43mUQ6UJh6RxPFzJIaUOrp?=
 =?us-ascii?Q?tO0VsSTXkdo+x+OBE6fiZXUxn572?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fRnvmtxEe74HxGIYBnPG6VHdGdr+wb3gGWE4GPr2e4oBeDXr4yaVf8JhjvQX?=
 =?us-ascii?Q?9jhwdyYLiuDnebtl7o40smB8WqoClP/cD40z8xT1VVWghbPjkwH+rJ8z6rZl?=
 =?us-ascii?Q?Xbqu6xn5gIIu9rRsfw4HNjGiW3b3JKOHhd+hoQsXsYnMXcMMijoZ+sfedfHC?=
 =?us-ascii?Q?3YlMY2d+P2GAZ/XVNtPx8gylAYzjwk8jyv2qu89bS6mfriawSb96nrQ9jkhP?=
 =?us-ascii?Q?c5zLLyINpoSWyLTNIaC/DE1oyMvXTm+3sjcJB3VjtiZJNsbLH8sUhhmgsN2Q?=
 =?us-ascii?Q?r1k1t+Mi/bo0xf3zOMqaMvA76UsGxPhcwtLsy47xoW5Hgw4w8P8xAKaPJ2c2?=
 =?us-ascii?Q?bvMJzfJ7aYqqoZx5nxWE7PcMyqBfMX61D1X2RytfQ+IHR00g5LLdy4bVdVyK?=
 =?us-ascii?Q?/AHcihHNZhWSk2v4FyD9gUvD5/0LlPEHQFQPn/3y+pl7sRm8rAWIDMRhRI1v?=
 =?us-ascii?Q?tOTCJvWODzq1be+2pwRlnx0dqjaAijAC/YvDTp3wXe2MFNVzpci/evkL7uKB?=
 =?us-ascii?Q?M+uopSyxVpzmrisH4Ooz4FdkGVuh1y97Luxd4AJ1NUbC0Im8w1Qd+7HDZc0e?=
 =?us-ascii?Q?skUK29hDINiQ2PTfBKBBp99dNyoyEvmLwgchVD5A5ZZ6VahsjKTHwMkrbhej?=
 =?us-ascii?Q?ljS9kaQlcjVaRSJuZt7v5OEiOhFkHsDyNWZlGkanqSRYCFVbNpYJz/qNectL?=
 =?us-ascii?Q?YR/VSa58kzAzTWMUIym8DbTyI5s9ctEuhdGUFA87qYw4YrKQe0bdMwwAmmb1?=
 =?us-ascii?Q?bWxJ3JPy1dz5jti3NcKPdGp1wwqWw9zccQMIdKQ2ABqWbIHLB8TCoNs6S6f9?=
 =?us-ascii?Q?ijc43eCx4DpmSDdYrcw7uGp9LNGBwQrrcI5VioPVoymGfZPn+p7VD10Iq/28?=
 =?us-ascii?Q?UykRv4J9TUumFCYIh22MIZRE8zPjvxa8mhDM2o6a3JZgLlJpRNok5VvaGlhS?=
 =?us-ascii?Q?GAUQaxI4bmI73tVHds9sgiblgL2K0dXJS5qY3hszQ5ZMbWsZa0dOr8m1T9Qd?=
 =?us-ascii?Q?5yRB4MK/O6YJ0+vrJIHEEjOc7s1i5jAKx+GQH0u1HhILp/Q7SQXyIIqSaUG6?=
 =?us-ascii?Q?QOsYDtP1yD746Vbj+peNJkKovlEQRDoItm2CmHq4GcKhmGFqIKx0Wj8JXx1+?=
 =?us-ascii?Q?3VbTwcb08oDfokCSJI3Q5hgB3e6HuG2fvFLAuFcz308Ukb2Bgh4zWZksGXGK?=
 =?us-ascii?Q?mMoakAGWVswqawY3JDks7GiUIMCtbPwY9KDPqWdFg/j8w1Uu6MT3IRssR2+V?=
 =?us-ascii?Q?HnUUMwGKMb1m4DedvvYrKuj/lKISrM/U5KITTZslAu0NWey7jUlA0csNSJc6?=
 =?us-ascii?Q?GrmkQBEOVvV9RNa+uC7vz4BjyL9NKWhBRR/mZExdnF658rYYdaoTmdiXixNo?=
 =?us-ascii?Q?w/jk5Uu6AjKPOwqN+0Gjr497ZfbAQdMvvuGxHjGd210gh7i5PW6Ci/bFhu6b?=
 =?us-ascii?Q?VShAa+3LeuiAoGfev5G4j/Uf9fqhRjB9ClmaDXhDy1fV4UJ+tu8ucH52WVw0?=
 =?us-ascii?Q?yH9TFihApFFJdn0lZD6HJ4gOifofTxLjjdyCEP8X2NOmoIbBkAbeTKSsFfjT?=
 =?us-ascii?Q?5wUv7UfhmRBg7ZIp3wqtairjmrQ87O/tjZMqi05W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LIEQqikMdR6Ufa/98D/YagXMXKc9C17e4/5Oh9t0G9f/78wCiAoAXp25bjNSL/uE5rdOFsubbIzHXsPUbd8OsO8OlooPibnF9abSnCTT6wzuk3kpWZSb/+XeTiwggm3AKEyK4lBeyDZG26pjR2HbuCP3eCuh6U0qZs+U9pgkhjLuih1noL6FVYFMx14NXcGEsju/MMF46he2fMzoUmhmXbGscgIVrAS3AZQwLyhU+Dr9e+FU4WaINgp4kLxs5478waV3S4VfJsHMvYDeyfd4opwrxkvP7OrIG8DqugRXTttwe23yJi0tsn1vRIW5VP52VA0kv56qdC654GR5/hYhtspzG0cyciiMDR245BWRytBm33453qEef4zDqthg1dgKebJyJUpAbnQOAo//Y/oN4OQIh2ifm+bJZPXJKUhqfqrTEOa0tsiHpI8hymajl/kTBzy+IDakYe+gg2YuCuYOdA3ODtBHfqR3Y9/tESJjxfoK8A5ArriQabws9D8/F23o4l2+zMQ0vNr9EhsFqDZGhSWAHz+10a9q8Sd4az/XYlPo0Ea4lvTRxf1fOBzTmwHPWvDvgXCKwQ39/XTqZ/QS2s9t5WUA3sBq742K01FKMqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1376c7-8aba-401e-b57a-08dd518ff034
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:21:21.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNO8bmYwlk4zAA2HKrqmCXAtOrWozo0bcZX3j0RLNFEovqVrk4OIQVpIxEcdy5TNsZlhEO1F987OlMWzszD3sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200068
X-Proofpoint-GUID: BzCba0siDUkHgblPxnAjz0W6qNj715Dn
X-Proofpoint-ORIG-GUID: BzCba0siDUkHgblPxnAjz0W6qNj715Dn

On Thu, Feb 20, 2025 at 05:20:00PM +0900, Harry Yoo wrote:
> On Sat, Feb 15, 2025 at 06:57:01PM +0200, Lilitha Persefoni Gkini wrote:
> > The condition `nr <= slab->objects` in the `on_freelist()` serves as
> > bound while walking through the `freelist` linked list because we can't
> > have more free objects than the maximum amount of objects in the slab.
> > But the `=` can result in an extra unnecessary iteration.
> > 
> > The patch changes it to `nr < slab->objects` to ensure it iterates
> > at most `slab->objects` number of times.
> > 
> > Signed-off-by: Lilitha Persefoni Gkini <lilithpgkini@gmail.com>
> > ---
> >  mm/slub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1f50129dcfb3..ad42450d4b0f 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> >  	int max_objects;
> >  
> >  	fp = slab->freelist;
> > -	while (fp && nr <= slab->objects) {
> > +	while (fp && nr < slab->objects) {
> 
> Hi, this makes sense to me.
> 
> But based on what the name of the variable suggests (nr of objects),
> I think it makes clearer to initialize it to 1 instead?

Oh, actually iterating at most (slab->objects + 1) times allows it to catch
cases where the freelist does not end with NULL (see how validate_slab()
calls on_freelist(), passing search = NULL).

It's very subtle. A comment like this would help:

/*
 * Iterate at most slab->objects + 1 times to handle cases
 * where the freelist does not end with NULL.
 */

-- 
Cheers,
Harry

