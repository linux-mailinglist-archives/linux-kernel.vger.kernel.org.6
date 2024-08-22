Return-Path: <linux-kernel+bounces-297884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B796A95BED6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DAEB231C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44D1D04BB;
	Thu, 22 Aug 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o2ZJQ3qb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O8BHHaiU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82161D0DEA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354813; cv=fail; b=qlcL0OchC9o/IbO5ZfniLcTnEyxZX1ol7i8q+orHJIwcHroFJ4oJgmCsZCHiD6cII462Zm49+PXB+QAiDtC30G2qYK5crjePXSvlGbY/KiBwRRj8f0lviqRYxytYTnTnu3ylHhDjh6unQY4UW5Kc5LewlGy+awsWdslqDMWyllc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354813; c=relaxed/simple;
	bh=BkuZn8ng+MPHRdv05kMmtr0tJKYPuYt8BwBzWvxiKMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRMHkgd/DfrTTIE55mX4osHMBHt+9IeR+GrGwPErDIGL8NhJdz2QMQ0GBI7v8XfWoViWCyx4KdRmrFK1KuH4g4K838xmW4r11mDyOtJJdhtaSt80FXvQnD8PKYbTEyyn6oAtfmYVTTMFmjwqyeCng2fEDR6SgtAuN5XT2Ke5oHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o2ZJQ3qb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O8BHHaiU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWMd026319;
	Thu, 22 Aug 2024 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=cgnPrGOzOxWIrdBQ3R3NT9Fecz0tF71K+188l02T6BA=; b=
	o2ZJQ3qb63qJAQ6p2MH04wzbS2CXWwe+C1mGT+HyDCGuPSsaNkWy/wA1OSUXIXzj
	GLi46Q3utlqecBSNaIrF4ROheK2d2stv8RFCnqPy7jfChcns80aaIjq0rhVoIyl8
	1BhNh2b6q8dW/6QWtsEsvCwAvh+pArPD7VeAu2rgHUIPBquPpwwhUc9FvlmjSr0e
	RtVlpewyZ6NN0itG7cHTo9d2KgFsuWVas/01frpAXs49nW75Nk0rH8g7BpojdRDX
	SBjt/5xCN1+JlIcp8TY7mLHSRxPHCwHj8LfYaWtxLaKocKEaHVNoLmJqz4If3HPi
	12ejlfCtqTHxFIElfFvUCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v2w9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIqaQ1019453;
	Thu, 22 Aug 2024 19:26:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b0b9ckf-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNd7l9YbWk2/jhl/PyEmFNx9k2hFBNwdSI8NZohEe97TGFNwaXXEeOwt2a0RU3XMaY9fLqtiz8ycVzvMuDER96sjRs4/GjgwoxCGM/p3UBYpidz83qIP56bI2qZlvCTxg01gKRjID28zLVX8jUbIPHndLA/eB0w8Aa1dwFFTYfUOYBnokxf0OFcF0UqDQCBLmMIRFuqExW1r/8p2MVptBIEpARqx3hMXl49p9k6YKSkFX30YIrR36p6rALS47sbeVNvyxo2yZ+keGMH/5Okz1k/ETXiH5sIZaEyRcWcMnViGLh9SMu2PdiU9MuwfgFzbcfzKUsEDvKHfbdmBjsOhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgnPrGOzOxWIrdBQ3R3NT9Fecz0tF71K+188l02T6BA=;
 b=i5kHbxywR+keKx7i0lV9WdO6LwLDgCJp+lc8tBu4M4ftO0yP7wzAx1WbaDUPQYOptDMl2tafRPtuAhzJcB+D71o/b84Gl4f3oUqfFTrFp0+6aYkArrgxi4Zh5u29foL7ufjao/uFuShtbUkr34Us5NLpCPjSScVJUFr2wycF3v48Jv/9G0+THnt55uNyXiyR9CCHiLzVAHEzWDpnR+fn8RPEkEWULeGmKt/l52kNg49xFPTVNhtJER8C0DQJZq4OrB6fFTqbTgTfq7vNjc4MVu2DcYo37cXzEf/hvOjhNP4UDAX0v5k6Yf8zUUxmEvAIMiNdFL3SddO+y9rl3YRO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgnPrGOzOxWIrdBQ3R3NT9Fecz0tF71K+188l02T6BA=;
 b=O8BHHaiUqYwWZs0BmwUosB1TZJFtJgtflGwPMpUb1hKTBY2L6eKxKaC9D8+WK4Hn9wXnWnN0+v8iHEk8KWxYySGwo3kf2UnFgRkuVh2sjUgTX5Pliz1L/CExj7eFUWa99NVOWaeqzwfRkz5fhnlyp2/necnMVEVx339l3q7QTJ8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:34 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 13/21] mm: Clean up unmap_region() argument list
Date: Thu, 22 Aug 2024 15:25:35 -0400
Message-ID: <20240822192543.3359552-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 227d80f3-a105-484c-1fa2-08dcc2e0556f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XlY545hcT2Oip0m7q9MiJzceeWY5ti3nfdR7MJvDvPS2/YoomGUtr+LSLUwa?=
 =?us-ascii?Q?o5qDRKHo/iyQrhv5mtXUHNvTfLYLMC+uEWWAhbTkhcLic9NPNyGeujgpNOe7?=
 =?us-ascii?Q?IVAAMMaOL0Ytcae0/VOLPxVCzLa7B1Af4Zfroga5oWlCdliGRh+Bq9aQuHmT?=
 =?us-ascii?Q?c6e8aIEehaSQXCz8W/yibQLzNm0S3vCgyR7nlgFRR79ECaaRt0tNRE2vxUXH?=
 =?us-ascii?Q?H38Iv+lJmxs1n0Yn6XycTFX+3sCgVsATe+lNFlSLZQxlmUwqwGp4eZBbEdrf?=
 =?us-ascii?Q?YWSyuI4WeUdV3VC8F27EQ7UcrKWF7mHwowso4Otx5NTB0S8SSwAiQI1m4X6J?=
 =?us-ascii?Q?oAfDALdKJLEsYrFbhvGnRAcBTWjAldf6L6ac0ygG4Dm5khXbXKCiCbiiwNy8?=
 =?us-ascii?Q?NxCU2gHqaXZc9NCaawxQ2Qp+/J+L8me+EdaooYJb4I0P2rWjuRhlg+eOuI4a?=
 =?us-ascii?Q?wVUwEC/TNwRhl9wPjNV3CruADzPPa9Y/wzxiSytcvJq3zk61W9fgcBBjz/8Q?=
 =?us-ascii?Q?V5RE/exBQVgVMwm/jeaAOBNzxfsUw71/KvSLxThjEcZs4ArT4WumfiDZ5VPV?=
 =?us-ascii?Q?FwAs0m5s3OVW8B33UTGthPnb/brjVB8uoAOqbuUk3VfA8ydXDcS39Id88mzb?=
 =?us-ascii?Q?PmOkrXyF4IWwT0aXvZ3uUuanhMzPmJclwAJS8OcKRM7uJKJFv+rvAYQZD4yR?=
 =?us-ascii?Q?mng89VglppEuwsvR/rXhA7wpZPABkAyqlL5Efzg3ENUVEbU3Ajhbn0Fj8WSV?=
 =?us-ascii?Q?wdcgI6Q211OK8e8cEJkq0RdxrI3ChhlQ3g9GyP1Y8KP2DVmeQjTa2w7egLZN?=
 =?us-ascii?Q?nNaD21wBTguoCLkQ10zoqcGeEwlgluJe89LebNjk+6pdBtlhYimMN1hHT5xd?=
 =?us-ascii?Q?LitZ5ySebo1fgiIsekk2MbsrOvvt8w9Z9GHKVUihq7d0SUlIsz1kcMJsF6qv?=
 =?us-ascii?Q?d6CBwba7NXnG1+ISpWZRCwZMXFvMkS0LG2bECvbJhKDQwqk7gpErizMgh6b/?=
 =?us-ascii?Q?8Xy9qYPCQ5y1KGJq8sjKzufwLBAZExehfAKSIEdAATFCYXvsJku6I8B3+jYE?=
 =?us-ascii?Q?MFsXmYh9wOcFudaeRwqYsdkrAlLzV7RbzLDmRCvt0bXDhGxt9oxbOa2B72Xl?=
 =?us-ascii?Q?c7BfH+kJd5T6i4MhEgztLZ4RpW9ND+O37zkDOSVib+Bx9vruMh93L1GeLahS?=
 =?us-ascii?Q?XSIkLFmPi2maabqrFirXzwM0N56/N7aM+jXpUqzeIDJb5C9i2qL7oHQlpfMt?=
 =?us-ascii?Q?PIvp21N8IM3x7vgvaaXDnYIVaMe0g6kBLj4JZrPpfrgZMlqrzl2t0rLDvWkV?=
 =?us-ascii?Q?++dMd5Z/1qMvzdftSqcRCeFv8EiVmnSbE5aCDvijsHRHeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OMKBu+PaG7eMD/3FuAV+tIjQKZKzOPziKoOmnn3rnwVB28KRFgh+yCK9VfH?=
 =?us-ascii?Q?nRijcRsbj68z0QACKYReMV9JP8UJ0TZSmfahpNtmyv+ZhtMXy5hW2Rpx8KI3?=
 =?us-ascii?Q?/UCXMzccFT0Gv0byqjAbKLdc6jhXautfksN952Gyavb5YbTbIJ1ja/S5FtX9?=
 =?us-ascii?Q?kfTsXSN/xC65BanLv8WIhiDnKtWvirYxqwxw1/9U+DKyRdPj27V9c6xv1HoR?=
 =?us-ascii?Q?qiUW2lAiPnvgRdcfPbAJpt9W3zrNy7ywHAxj2AMJrGhnpunIevuxHcw6tFO+?=
 =?us-ascii?Q?T8fDKLvOg7pHXbMHqueTI6B4V2L2xZVSwDjgwoau9SUox9rss/xePUph5ePt?=
 =?us-ascii?Q?HVrXkDu6qXOK2DtTHTx48Al4S0hIlbRMR+KodZAmVTrQDizXkwAn8lzr7eQu?=
 =?us-ascii?Q?oW4hYwBKPOsPbzS/3j+Ccp6v+mUJQny0b7aJXDA5dmK06SFax2uwYk0LiUaf?=
 =?us-ascii?Q?ta5cD+YL+ziuZues/bdvLCmYz6h2xMRnt5OnaPQD3CvaB5kx0fb4u7i3HVA5?=
 =?us-ascii?Q?XmsS1gkojYOsiXWEkct3WCAfDqaEsMNnbg1icDwV66Fip01zDJTJghLnY5HJ?=
 =?us-ascii?Q?9UGPsYWwSN7uFm9EWA3N6gjgcvsqQ0zKiepnQGCt/L9tS68rDH8ZbOAOI8pq?=
 =?us-ascii?Q?t5zaMOFPL/ndtbO5F6zJFl8Zs/NJDru9ZajckzrEdWGAXq31ukcH3ygjLOqE?=
 =?us-ascii?Q?OEPQhGIyt9A6garrA+TiI57iqTq5X/6Fr6CqERan9RVbwVSxtY59LQP1d/fr?=
 =?us-ascii?Q?5Zy9sHVCkeVpzsA5n5g2FCeNUm5aeURYVQbK0sAMDe/3DK3+tRT2HLGAJUn7?=
 =?us-ascii?Q?11io+1+Xhq3d5VW4u/VCYs1Sp09j+Z7g3nLwBZvTEeKqoZblbcKuJAvgnrMq?=
 =?us-ascii?Q?ztRkvrnp18em2j59wPOw4e5L90ZX71LgpnGFwHNHazbE9iuUkXtf91M5sC1C?=
 =?us-ascii?Q?JWpZB2+CAEL18ZGnYiKsN9lON96b54ldHtlVl49kFfHSvjXYHseX7z3/TQuK?=
 =?us-ascii?Q?2gUGfISMGOpyA3Oh96WgsJhyfvY3/3O/VKSFMV1638qkPE7w+yBVpv91qtgE?=
 =?us-ascii?Q?yxEBrQK1eQhX32G3myO7NIQuugCXc4mvaMCcZ2sifvkEAkgapTu2ggACU56S?=
 =?us-ascii?Q?bL/PQUJyzezPFU3UWTC/sgm2WVbDl0oLPuKvOYIEvYl1HdNEBbR6DJybQXEY?=
 =?us-ascii?Q?xPjPbOOmb+5hSBNSjaxFolN4ay6puaIbzr49KBEYyOOqvz2D0tXmSwET3a2C?=
 =?us-ascii?Q?8xBQ3UwdDZEfC3NlNDkjQ/bUxd7/NG4g0kGKfvCj7HZquTUy8K+gbTXy0fac?=
 =?us-ascii?Q?1FWrkN0kCZ/EaWzIccPA/2BoShO0HsPDHb7dXgxrIeITXyuTrfnPPCD9zoPJ?=
 =?us-ascii?Q?38Fg5ZoDqkQVWVlA8MEtuO39lMwvA7j8peVpQTsIqNphDtR2t3CByBMLPjDN?=
 =?us-ascii?Q?I7OelESTvO5MrvHGBa+TcVmRP0AQMUD3yt/3xAcD0sLJh4rgXHG7sxVWs/Sp?=
 =?us-ascii?Q?uit/+R91Fjm5UrdVlV3Qr6RORTkz8yHWNzWiANuTcLAmfTRbAvtprM3aR5nq?=
 =?us-ascii?Q?d9LVhOFDM0jleRtfcDbFnqeR1Tz1+F42yjPHoGQk1ccleEce8HHZKqEW/U6f?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AxfSdg7x6OawfYdODFMsbTsQTOn/LDxohO1SDfCnUmVtNop70faunE4nBdfS862jQUK+JCGosIps13QLmkm30lUqXhNKw2bGvXAmHqk6ohgw/oa9loTOxb18lsQV/wKJhp40sxdswirRcGve8BiLTbTI29Y8iXYXmuGFAy+OTst3k9HO0BgX6m9YMIMj35jz+l80KKjQCfDkZi70f02BdTYTnQJRcWkI5ESvzucwCCx+U5PS7lowNKDWC60/vsjTg95Ekbq/rwLpIOOfX1+MU5Vc5E/FEbEwGbM5Ook3X5Dws5hdhrMQoT8Kk2xMLMKQaH0V35Pb2p3cnvpz4qVRUTElI1SIPQ1rEAYaKQHyOY9gEnFS3SqdCR37o+REswX4DyjHtNGfNCkAuZRAClBIVkpa9pMfVYFXQwm82EXsk8PCbSUPyxxpWKLL2f4o9xXCMPNdErvK2l0GnHJnvmUoJMCScvcAHSo5WW0kOFsdY1RoK1Jeuw9+BPiveiywoNKPueH+0xzHkVfcl4/5vUDvTgEWbew5fZFUo3x0eYL1H9joYL5HlBhW+Ml0TBfIGXeHnTOktkcIYk0o9CaBi35g0iP2FHE9r64mxdAQDL81BS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d80f3-a105-484c-1fa2-08dcc2e0556f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:34.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf9h4/hd5FU8UUq1zyWQOef59A10GQDt7quNS5/KURL6pETIbU5/sd+0fiYu0o+Cdqt+SjzM66hIFCK0YNMhvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: cFL0Gs0ZQ8Qc-ft_vAURaoRk6ov--8Il
X-Proofpoint-GUID: cFL0Gs0ZQ8Qc-ft_vAURaoRk6ov--8Il

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c |  3 +--
 mm/vma.c  | 17 ++++++++---------
 mm/vma.h  |  6 ++----
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9285bdf14c4f..71b2bad717b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1613,8 +1613,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
diff --git a/mm/vma.c b/mm/vma.c
index dda0dae069e2..9e11892b0a2f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -155,22 +155,21 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
  *
  * Called with the mm semaphore held.
  */
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked = */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
 
diff --git a/mm/vma.h b/mm/vma.h
index 7bc0f9e7751b..6028fdf79257 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -147,10 +147,8 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 
 void remove_vma(struct vm_area_struct *vma, bool unreachable);
 
-void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
+void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next);
 
 /* Required by mmap_region(). */
 bool
-- 
2.43.0


