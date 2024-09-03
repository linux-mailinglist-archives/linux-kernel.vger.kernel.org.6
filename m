Return-Path: <linux-kernel+bounces-313302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A736596A373
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3EAB280CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79147188A03;
	Tue,  3 Sep 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j0snegrh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tzCN6Ymn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8590187325
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379148; cv=fail; b=Q+w1OJswUhlB6qiFSb7oYfe28zKrUrHJ1klisx7n5MHWQDDDu9aTb0x9iXW88JGbWkje7Hx8dEBSVGkZBtHu/yyk5SHtGzYlisnzBT8BB4vMMzitDD5+MgsdOP3vMDuv0VHPi/qe1490TIwpo94eifqsSvBMfXCcBDHIZqPzX78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379148; c=relaxed/simple;
	bh=YQrsY0tJ5pWbFApdRYkIc4PDj97O6WOvO9YmiLwdkx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NeLsxO2pSdb31OFM6d78juKcW1v/KSCWh5bvL5G+ZlwGiuY+feqLcZW2B4Xlr8vGaA347B3Tk23vcEVecU2s/V+bcqUtsnKpNfPNr2YpIv+QXnZxJOv+hO3ynTjE1hppY6u6rimtXh4cS9kXoYihRAjzDpfS5VPM9UCBonw+C2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j0snegrh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tzCN6Ymn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483F4Lwh007602;
	Tue, 3 Sep 2024 15:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=BSVZnvyTflsD2nZ
	PYf9l1qo3gj7ZrXiTWe8qgcUi18w=; b=j0snegrhpJS3zCa21coaScvch3MJpAY
	UZxRmwCwp3Gs9z6kvkc7qW505chYTc6jcKXp2JnBN3JpeFmisLm4pluUpNBwOhLO
	jeIX3rYYvAqBfUeTE5jWJ4QSGLbenL4eXcTFB6H+nhZFuBYDZey++2YcJhLHIdPr
	H5ekV6jbo1kuzbufuwNBXGSR3br4icUru43St4RX6GJFKR1OhP09Ibh2jcKmwzWS
	MsBmwLlHt4BUmsoPyuZ9l0+xICND1lUhuNzxrmqeYOvJTO1Rwmtfmaq5jG1quNAM
	ZaYmEoXYloa2afQB8dHjud5TQE+UpudLlk314c83dNNxJHDZg4sUdFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dw51s7td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:58:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483FXpuK039558;
	Tue, 3 Sep 2024 15:58:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8wtae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 15:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSJjpCpgzT430lAPwipZ7e0gZxKiCOPy7kgR6ADVGxqZWj1oJIxTmaFsOt4Dfe4+yLumo8kPSaOtNDZPrNKQHUwGU+fe9OoTYrA+nLdvYNEklNNAhXFicNsJEf4u4Lo/vdVTHXH+McYKmIMWYChkF0FQisPyAgbh0ZrztIbsu3NGK5fEgimaSfIMtUsycEO5mIjR676A+Egad7pvIkPtMHccEfdYHljMuIa8oJoUwfwwVR4XHksnTyxBdB4C/sRPoA8VTqC7fa6lvAMbDCxnfMbG3XIkOI9w2/ylknwyvENIGL5/Zg8PIbNbLXa0B/hmFuBjq7WXwFD1DinHNcOEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSVZnvyTflsD2nZPYf9l1qo3gj7ZrXiTWe8qgcUi18w=;
 b=Zw28yDyXf/swmFEwhLkAu2/nTWs5ccRUAxFqtttrUwDAl1HuMeaxztafRp+q3xJr2Zuev6SAZFN1yC3rXnb/pSUquniSnQZRVtg/T3VrzOg24IZ0xBEF9TbR0Ud533LhZCQjmOIRkt3pbU68KC9ZNuN6fB3mi8c68qzjDFud8TxEMOqxHRalI2R/o4NJWXhjAsOrxXTuiQSZ1yO/VRx2rDP6qfny8tqT3UdOyH+jZd29eXwXUGb7eXEwJ7lot/v0oQcE+y9KZ8YisOhVSRM1xrR7/Bf10nI2RL06FtPs15DdQygJQUiziKbokL0n5jVHeJIHWL6+dphTkHghXfSuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSVZnvyTflsD2nZPYf9l1qo3gj7ZrXiTWe8qgcUi18w=;
 b=tzCN6YmnGP0G7HvDKt/exVEc9yWjycu0G5ndWml0iJBuhxbdTUR2TflxqR53uS+sgTDNtEtJXzoI+maxGOxLLwyW/bXuRUJtZO3sT7tVxoHgxMHWbUhG4TzLsiRTIhDb+18YWB8EcUWB9X2yceObiooQtTehVRUgACt17QYOyCU=
Received: from CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 15:58:42 +0000
Received: from CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5]) by CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:58:42 +0000
Date: Tue, 3 Sep 2024 11:58:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Xiao Yang <ice_yangxiao@163.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        andrea.cervesato@suse.com, oliver.sang@intel.com
Subject: Re: [PATCH] mm/vma: Return the exact errno for
 vms_gather_munmap_vmas()
Message-ID: <3zloqsccdzrelzht454tpafo3jseckjtnbyznyn7ve25m62uyf@olxy27mjxn42>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Xiao Yang <ice_yangxiao@163.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ltp@lists.linux.it, andrea.cervesato@suse.com, oliver.sang@intel.com
References: <20240901145025.2311-1-ice_yangxiao@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901145025.2311-1-ice_yangxiao@163.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0052.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::7) To CYXPR10MB7924.namprd10.prod.outlook.com
 (2603:10b6:930:e6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR10MB7924:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: d72aaeb8-3f21-4b91-4b0e-08dccc3141e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DTpvDv54sJ0jK3gZqkIOhMxCLZpxLcm3lyXXL2HfRfAyk3+kgHgWXWd17wUx?=
 =?us-ascii?Q?z0KQoH0TVyQbpviZgQlJPtwMBH5OU3mJxFOzP5XvZBXYi7vGHfukA5QgHwl2?=
 =?us-ascii?Q?sg5mABIPAVq4Q0zwxY5CisV0fWR8+DOEE1up7iTH3usp6VHgcQZkWOsujkTx?=
 =?us-ascii?Q?R6k1XxmG6Zadjnpr8ofiyQZQF6sFhjpw0gddAzEFy2I8kgsieBl5hXU/qri2?=
 =?us-ascii?Q?xOOIYmQ6RqDxPoqzcvjACPHSrsQVOSJkO1nT59K3NvffodyMfEulIJU/4Vkl?=
 =?us-ascii?Q?/crQKuj943ngOXKRcviQWJk8heHJ7Hu8ThRrf/10vgc8UFItwLSNm1mgqAyP?=
 =?us-ascii?Q?sFJBC9MfudBvqCceWn+t0nzAMskExW1Pc6Eg9Vk/pjBp66yP5ztulub5Hk8e?=
 =?us-ascii?Q?XCzAXp5vN89pPfKRynLqa+Z4effc0uIjUpbpWOu9Nta5JEXKE/eVnYP+CBbj?=
 =?us-ascii?Q?YOuiHY7Lw/zHAq0+s5imSmIpcLg/aCCq1IpjmyKBGlEP4E7aCGZg8bEG5Wkc?=
 =?us-ascii?Q?Tx7HSYX82kkvsFGbsxw1YCf24WOGXDG528XZiBYCDc/0KsL/gQOwD8ZRlxkb?=
 =?us-ascii?Q?ppZjEu4UwG1TBrA7m01YtelT5WqK/h49g422n8xOhdufC3/iQVRps8RWjbkg?=
 =?us-ascii?Q?AhxTr8zPNd1SVu5UnHuruB8NFJBgGkihk/Q4CX74Nx5Z9ghEjQJketHepYf7?=
 =?us-ascii?Q?H+MgOaJtKA8Wbv8CSsBX8m/014utQzTbYL2XGUafiuj2nhSAEJyJJiUWA8xs?=
 =?us-ascii?Q?HQWgX0yEIjrEI/z1/QtZgzU9XhenlY2mHXdYSvDVRMI30qQQw9ckjfXh9VkJ?=
 =?us-ascii?Q?5BBFOeQUh2MlRzfECh/j87CONaC8j4HofvKVEWHLOWM07Fezu6ARJXW5D8MY?=
 =?us-ascii?Q?hcJSdliVLYyfeO8XId5Qvt83rHUuY0/1+CuyZKqQLJUmx/LEPAQZgjD9/aoZ?=
 =?us-ascii?Q?0B5XzQJF/18ybpwFiBc5YmWxHaueX58h04cTVPW7/o0MizXJjbaaIVMNkRAi?=
 =?us-ascii?Q?e/DSUBykpWzDi87ceRigKZf0A/GE/ARg+7oiVyJ26HY+VW+HcUs8JOmcR6ae?=
 =?us-ascii?Q?+pblSpLvQrMUcqgaNj54k1h2bs15NnNDCvgYQkzNNwPEkuUPoHMdc7+ZCKVq?=
 =?us-ascii?Q?u5JqBrc/D5I+NNwvDi7ckoaI0gXegzynL3rbOtJL9wccJLR3GDjihsCKch3a?=
 =?us-ascii?Q?OSUw6FgPRFmvYS94ZimUBfNypIfmuV5V8j/bnGCIGgD+rFNQqcLZFbLwaRaQ?=
 =?us-ascii?Q?puxz4xNt9XelfoHbdV/vYryUjlgkGDWyK+w/WGGoZQdjDevYlIxxrCynCKt0?=
 =?us-ascii?Q?EJZlUCl/rPN2l2igN2rumuOXQ95OHe1SRdgFCPcbq2xH2JoHsiduJwtdiBMG?=
 =?us-ascii?Q?nN1QGOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR10MB7924.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylbxdeg2l+D8/DI01S+SUqfNQLWHSoUzBE8D0NgL5skIDzALwPUqhG5Wbtna?=
 =?us-ascii?Q?SU/Y98qsRqTruc4mnawY5npDDfjjw6EhYGu0RsxDxPBqHg7PJqS3bbGvUvFI?=
 =?us-ascii?Q?ZGroW80mRals+RhxYGUgjGwm8DvnMe7QYbLWjU/LCOsv8pilR93SWwXFKxdu?=
 =?us-ascii?Q?GjNf4NielEAzQZ4M5vQsi7luTiYFw0v7ljgc4gcPz1Suwhi3M5qC12OSvwHq?=
 =?us-ascii?Q?oSLpqaRGM4u+YmuBa+U8YB28bFcRrXBoHkUV4rxgc3bFqSPqQx25e+nhKKY0?=
 =?us-ascii?Q?ybe9naFZQ2LMhnW0kzZn04EVvBV06kft9q3/ubjzq9QIydcfWL7s9I4g5ZKW?=
 =?us-ascii?Q?iRl6vAHSGPrLMEm8/aS5PcGPsWOsT224vleNPWqi04cOSbDHZzNiC352mtXl?=
 =?us-ascii?Q?zvxXJvTfCM8qpCMKzIyjAleZpIZrOW8KWmbwFNlqooGW9BsNS8YczNRZzhk5?=
 =?us-ascii?Q?Lgp67XtHDJVlk4vJjJJaLcSp2Y5spnzTV4eYuGF3bckawse7WSkIHAC9sxVd?=
 =?us-ascii?Q?c9jLmZQgWB6U2LlQkYBf/gnZwrFjFeQcGZBaBzKx+b2FtCBeR/PLXs1c21fT?=
 =?us-ascii?Q?0Uw00i1O+bBRdtHa7RZ1/Rpf+cYpXR5AqDEfxiQLCe5ugYjVs9ab+6c97amt?=
 =?us-ascii?Q?8pJIJe5FBOwTRXkseSBWYxK5+WnluTBcSQPyRpVribIHLQv6dxVmiyCBwSfb?=
 =?us-ascii?Q?xlGPBedPmH4MVDutUNG/mTCx9wF7C04QtGjmGBPreEMMowORln22/0LTPahK?=
 =?us-ascii?Q?I2GlgNyO+2JtSeCfL3SMAJeFSVhghMYe3nghiFQt83NgLvrqvlNEs/BYs3bW?=
 =?us-ascii?Q?koKTbOUWxwAdDr7qg0lp689Fa4osuKIcwiq7fFgjRW4rPUXjq2L1T+/IfjnB?=
 =?us-ascii?Q?bJfupwG+so6JyQslyxGi3gEhZ0KPAuJGqfAch1IO3rt76R+OMLb1lHYqJhJ2?=
 =?us-ascii?Q?CKgkeS4H4IvPKT6SfaAjWCtIiT/NghT6aC/KxH/ydTzYuKG+O6gl6CsWWkOK?=
 =?us-ascii?Q?WSVx2mbH5wrhWAYtp60N5DUqnpKbmLfYMsxKQlm+RFWMBRr2WznbXeskO6TE?=
 =?us-ascii?Q?aTxtwYkgvz9Jjc8JDGFjfiGhBz6qBK5uOeFUp2jDMi/RBdCzoGnSijmB/v9I?=
 =?us-ascii?Q?zAtxvokBzSdb+o/x1GHLlQDl8h5vh7IBHLxJUKflepl1kCHqW0T+gzswv9EQ?=
 =?us-ascii?Q?j5hyyng5ItCW24IsvQqUJv0Hs48msF3adKyM7Ff3l+Bc8E+cgl5kaGSpneMO?=
 =?us-ascii?Q?EcA6tAmlWIcoi+g66XnpUYPPCCE1483bZiLXE7BUmfZGD2fVXv3chZwoKgFq?=
 =?us-ascii?Q?D6ubzFgWnSlF6+eY2+DzoNlfzvDCVDdkL9ZLqvtoqcJDoAdaiUmv0A9QrY52?=
 =?us-ascii?Q?Lngk9pwPrlC2OlBI8pzNKjtiipfBCzhXP3EJcB3lA2UH7ohtVeACQnMAFenX?=
 =?us-ascii?Q?PNLHr771xdwlhv/Q+KZNDy6v4fS93sM3C6vv92GSME1KCk5udIQzhmd7Ubr9?=
 =?us-ascii?Q?V3OZhxosrghg2CzveJMUBsVhOurtCyWE6mIJSKF8AL21YMNQsVKyps6E8osi?=
 =?us-ascii?Q?ykhiu7o49pxxMdEdwGlg82RvgvOJ9irOMfEhZtEn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mg5TsfaJCzmzQHx+d64IBjPCA51+DRisv8tcdxBoAsK33Ofs1ifvKJoiIZXbVnQQaDOP9cvama+6N8bgAp3JGxM6486glzUhf8nFLsS6bNR9A/kK2ERRlvceo4tpHSwnf1+82gd2bNHJj6j6SGI75mXC9MNjukBdHn0P0FrVwo/bOoFyXhcgTF+vJ68HyLVrzXiWQMPA3c1uhgCfZeekAO2xsT0IHYCqkFe/FAborxXgNPqo299CHY9WxIjm596G/1BvoKATP1JxvzNSK3+dEYDG/VsfxFleycIVJ4LZMXE4jKVXK/c/FwuEVZmFr4uE+jx6/oBoBB9sbxjhdBbDn8hLjCBmNNgMhgNJBVYuLI+VTZ5G8Qp4vl9Cn7AVathB1xisO1A//dYsZLfxQ21/lrtJ/9/tbv2TnOEgwd6or3RekIO5iYLHN8tJZFYCRiShDwNi7Rqu8dB/liTCmz/SCsKJ2p3G8hlXStcjU+WvFiawJ1crCRmDItuBQH5w83c4p1NrAFmtAWmnf8Jd8oPwPnpZP6IKJb3oREAlW2lUBjHhzvkDEASEKdu//Ywxam3xCr8DqpHOk85b2g+t4neAMKAc6yTgC/ZHQBcWm047qL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72aaeb8-3f21-4b91-4b0e-08dccc3141e5
X-MS-Exchange-CrossTenant-AuthSource: CYXPR10MB7924.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:58:40.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKmVenC5IdCxbNSrFmX4UueTkbVmOAWASgIvNGTvplptTJtsusGqpQTv5D/ckLXY2PjTJuc6GBvy1zYRFtb0FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030130
X-Proofpoint-ORIG-GUID: dCpwgxITVJWegldSrU5KFZBitnCsbhhv
X-Proofpoint-GUID: dCpwgxITVJWegldSrU5KFZBitnCsbhhv


Thanks, but this is already fixed in v8 of my patches.

* Xiao Yang <ice_yangxiao@163.com> [240901 10:51]:
> can_modify_vma() in vms_gather_munmap_vmas() returns -EPERM if vma is
> sealed so don't always return the fixed -ENOMEM on failure.
> 
> Fixes: c2eb22189bbc ("mm/vma: inline munmap operation in mmap_region()")
> Fixes: 5887a7ac2383 ("mm/vma: expand mmap_region() munmap call")
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408312155.fd26a58c-oliver.sang@intel.com
> ---
>  mm/mmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index c1781f643046..c9a0dc035819 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1386,8 +1386,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
> -		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> -			return -ENOMEM;
> +		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> +		if (error)
> +			return error;
>  
>  		vmg.next = vms.next;
>  		vmg.prev = vms.prev;
> -- 
> 2.44.0
> 
> 

