Return-Path: <linux-kernel+bounces-280058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C939294C522
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25976B242A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1F3154C18;
	Thu,  8 Aug 2024 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TSrRCArL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j/JZnMB8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CF433AD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145062; cv=fail; b=V/1O7cYcHNSPn0c/Hts/ZwJiuaj5a2KRc3DkxChy34MEN1IcdLjQkOGlozxiDbf0TtF6NYf35WDgEV8GZet7UIR/dLvcCzNOiC45aSFEWjUd+WZ2+bKDMLXEgmxKsntVKYAw+lib7B/+TldhHqUrc7acJTD96FmdDvdK/XodhvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145062; c=relaxed/simple;
	bh=AkJaNgO4ZiN/6tLzRQlCRkAxLXx3few8/+8KqkjEYEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KijmDE9NnFc2o/WARnAHEaFo+lrY7pACQplZefYC0Gqv226wx1Nw6gyORGM2gWPTJxkmyCTa7MNeJDEa0SEq0OTbPSUNa267e+bEYQDNtIkHw4A6GvhbuOBPG0JYYTFLV571HKLTYNdOzDd9V8U0tXQJPZ+IjJTiZF4ON+l7DEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TSrRCArL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j/JZnMB8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfXcn003024;
	Thu, 8 Aug 2024 19:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=hygLTtXtiCfa3Rm
	ggsgewwCM8H6WdEMDOolwUDoGleo=; b=TSrRCArL7UWwiSLkXgqNITf9IAFISPS
	dIkgTwtM3H1Kxd1M51aPpzNHm8/JxQ1VSYPLgTXBcsjWgbz0MZIi5bCAXKBGi25W
	x9tdfO9vk979cXow4YXDqcgFJiBivLvsja+lG8xNPRt6nc9777USNITzNDsDc12l
	BsQ1Qdw2kFjSzVkONGPRWdWTi3wuG1EzQYd1Ds8wA9g8ikbCodCjXdQSMOoIlU/J
	rGuPcV9kqG9dhRFIbpDSO4JXHi/Pn6RtOocI0Z8F6umXyV/RneCUoAS5VQeGRitX
	t3J8e9YQMt/tXkzU70ke2WGFuu5+WezYgGa8yCDdGffLaEQs8R5nLbw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sce9agqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 19:24:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478IsrqW040732;
	Thu, 8 Aug 2024 19:24:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0c4xsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 19:24:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLTwOCaHYXzzNVXQ6z6lgvU5cEmEeQfUhkjxctMO6i+wjCNWzKXtV4JVyTvAdDc0T3UcvL3NUFfkXqeXvkD76ea4a5jJ8WMyYrdYaMeWgVloyoAi6dJAk5/a3TLsQGJm1ph+Th79aVdgKWZf1doqz3i7efd6Yb+8anB/vjwgYUMMjbJUwLBwejel6GlXuNAFM1G3UqxYsKY6CQuwm8Auv/FS2jgJvCwWijbsUsmQDgQFcYbqn05RZhzPSSb/r1Nn3hGDAkmMUPl0GPVr4iMjYZQoBEdqmgkcTP35LB3VlEeQa9yRGmWWdKBStH04ojZ2ioiDZkXWmNAXTLBGpAOs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hygLTtXtiCfa3RmggsgewwCM8H6WdEMDOolwUDoGleo=;
 b=w0Me/wRRW+pj1SRdFWf0ezepy0i+C9xKUnFD//Zj17FUVvRnabiUgqBCuuOZwYbsutBkYoU+4RLOuU2ro7riQ4l/VNybTrLhkjMP/CfRb62zMPUdFiNl+6lqPwDUfjJdmTw3LbPuUtSdX70PHt/l+qvLGzcncEUru0no6viIwozB+ExlOdjBLqBHczhyKvRz1Mk/a5Q0MqZ32Z+9Z8IwX9C1oOSZi+FqiYUXfw5R5UoNpoKS5Gg+FfCF3cuZ21TyH5eR/YKGX2nS4aXxcAei2HGEiWVZxIntWRSdopTU2sOJ+Sf4wyUUjlaHQLcmbMN6WDIWZx14oKO4SDrMY+gX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hygLTtXtiCfa3RmggsgewwCM8H6WdEMDOolwUDoGleo=;
 b=j/JZnMB8F8fhEUvw7mNbLvOS0LnAn8eQ3l0m0906PWtHa9VenhbIov+NYn/kL7M9Jn92EmGJK3OiYqGr5Ir6iZCw5hDjfjkeWnmFbjhH+YysMGLJ1BoshFr0gYHxjpBn9XXepvF1TQsa04QSR9rTI3QdjTDub0B8WLmQb2kkq4k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB8175.namprd10.prod.outlook.com (2603:10b6:8:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Thu, 8 Aug
 2024 19:24:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 19:24:08 +0000
Date: Thu, 8 Aug 2024 15:24:05 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/2] maple_tree: add test to replicate low memory race
 conditions
Message-ID: <oqan7j6nqyu4aej2crmio4uvukmrohinbnsnwcemk3l3z76z5w@kva7whwrns3m>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org
References: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
 <ZrUZPWZVbA-2OBaV@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrUZPWZVbA-2OBaV@casper.infradead.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b99c799-e8bf-4d4d-0c5f-08dcb7dfac88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7jHO+GFcotHrtu9ogsmivEnpWaFuzCebADBGE5w+PiH2aDMxLB+PN4eP372?=
 =?us-ascii?Q?LSINTXUV06UiKyZD61G17YxoYH0P1oy4u619sF6SnVRPlmWXWVVN5JoT+xNu?=
 =?us-ascii?Q?yMkk50BooY5E7pfUqkXMFpN4oi8VYXshv3uRP+MJkrFTrPWtkibVMwgINQCt?=
 =?us-ascii?Q?MkIzlbgv10GiLxun7sKxf59LS//nJ/Q9PIGK4rOA4bVzO0FXKqkk9+2wb6Ed?=
 =?us-ascii?Q?7kOU9Ir2bkZCk9zwQqvJd8Y8Dc86JKZAZZvPmli7AnKIWECw4KD/MgbqqSZ0?=
 =?us-ascii?Q?uT9SilcT5T5yRnA3NzUw5XbXLBNhaELkKBmJC7sr4r9dgLRgQruvIRDuYcT3?=
 =?us-ascii?Q?D1haozbrdZ3Jm5Ir3Nm900iPoqE71P/fbTPD5hZQ5CcICxSy6Nh4y+FlPQMi?=
 =?us-ascii?Q?Ym5CGjd88YYZJANAT8WIHvoY1uUBXE6UPIa5nnslpHnGnakGiN+MGzTkcXHh?=
 =?us-ascii?Q?QcaH6Kc/+ZcekLXkiZfqMgEKCs/48WbUChJihT4uSAF4DHKbHkN4Brz2N0B5?=
 =?us-ascii?Q?gm882cVxlChrVKd9oKxCs49bq4DHiPxnNMz+X3w8XnRq79dG3D2buYif893S?=
 =?us-ascii?Q?5kCCXHYzgcz2JdKc4lW0kgnGVCvr1qhMBEdeWTZEpTKCgkC2URoZO2ySkgtj?=
 =?us-ascii?Q?1O6Ih6/loNXifEcaReQ7uVFjSPMP+YksuWBz5zHOCMuhLSHnS6xgU6I91jAf?=
 =?us-ascii?Q?U7tlS5dfs3bR1CML/0hfSCYkZt9lA8FyvFCX1LWYT9lTuCfsD8ZJkt2S99d5?=
 =?us-ascii?Q?qrTWh2JLDdbItQOVOewvv0xkCy+OmHKJv4AlciPuZdKkq5A1wZdOzzM1etdH?=
 =?us-ascii?Q?SuObO9QNvY+nhXht9xDiyXvPsXLaZ1vKMwjdxRfA+mqlIMh5cbEGxLILGMxP?=
 =?us-ascii?Q?lTGLd1tSJwu582R+/RkVakvV9qIQ4J/ayHg+01DP8R8S2AZPTOypdfeUvgzb?=
 =?us-ascii?Q?ly0A1MaP3JyUDLJRNu08HQA021ErjwDaHNdaKC13tzhrN4Twek2w8sMi7Ugp?=
 =?us-ascii?Q?6Aqun7O2FrRPbEyA+fi/ky2ZcUCu9mYrsvCBCquPLerg0touM57eSRKMZ8jA?=
 =?us-ascii?Q?OsXMXw6rcqmUXuGvxorJfC22TSfdyoOhesb4hLAUypBql5KZB3952DJxRr8v?=
 =?us-ascii?Q?pRwaVkhYDGzr8FZTm0oBXUnK+5KaNyZ7F/3ZVOCBAhe9kdXjLu2lMLVxigO2?=
 =?us-ascii?Q?dyeuJmk7o+OMowuWd3WP/mRvmvgTxaTdORhlV46yhoehURa/nG2ECugbXx6N?=
 =?us-ascii?Q?oDv0yfiYZzbJtGftHeXIkNvoy25Lq45kr8cJVLQHCbnzM2T7M9jjM/WTDPqa?=
 =?us-ascii?Q?sQV86vNSAuu91AQ/ZReTEwZpMcNsXRB+q4vxOVVWEyhHxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVbA6aPwFtIpcBYFNbHLx1X+jdIXPN7ZmAyPW/XSx2M/JV8Huknz3ZC+e988?=
 =?us-ascii?Q?MjZAdNEnjfEVd29Z2jRf7y1kJklyjUNhAFnZY3qYg7OsAAoRtW4XLFEQr+Nt?=
 =?us-ascii?Q?KA+rToxbt3383XryOAduEfzcCWxCW1y0Tkst36WFqwAEzkXw15HwTNbBgaRA?=
 =?us-ascii?Q?EMV39f5B6xvAIV7uH8KATLSGP7XR6XR11DiwN6fiGNzjQJpqnKf5Z9tcc6Nu?=
 =?us-ascii?Q?srB2NhUoz9QSzCVnZVHHCRnNjPJ6SbzEPd/v3Pt4RCAF4otLOkUfKR6QwaV2?=
 =?us-ascii?Q?RyihELL87KsIPjzRAKxAPjcomZBHa8OTZ9UBFHG650FE0tCjCWFHYGHlO177?=
 =?us-ascii?Q?bQlNXQBTgjfLmnGL8rOMfiksS2LNk2aT3gRP04KBlQdHmUP6Q9nnnmqDaYlf?=
 =?us-ascii?Q?RKo1Lj16TLtPyNENUb1BG7F9habeYYODKKv+P5NHodw29ihH3E84qfsGz1NG?=
 =?us-ascii?Q?fo8VLS3ce+o1GlmomJk8cgDW6cuAr5Hnt6VFsQZOIMutM6ihVnUtzdipf1WU?=
 =?us-ascii?Q?e4LhtD3xvfvV/ph82sUs83wFBdj09DIEv5urndKESMFFh3mI6fCOELKUdwA3?=
 =?us-ascii?Q?cMytBN0oANx40oOBgdn4Imu9VEqlrKPNVj8NCrcD5gLEljhyq0sO9eylcvG8?=
 =?us-ascii?Q?v/q60XR921C6eZiV+ilvNCA/g14GCdz+edO8aGolA33XToOfvgKkT71Lzkih?=
 =?us-ascii?Q?vb/PQnXQdUtm4Ai7WuuRSlAcJ63aFI3W/AFd42x8V+M9xBIC4XL1XAzZA/kT?=
 =?us-ascii?Q?GCmQrn02ECH77eDYUrNGMjJhge0v8E/g8B5ZiIdqdLnwIl858ujX2G8iW2lc?=
 =?us-ascii?Q?OX0KmJqMO3AtmyTqD9NqFjV26GIqFXmjk5+ZTlEx8wfJWDjUd7iIy8mahAtT?=
 =?us-ascii?Q?/YXqqhAWZqOnNtkrnHUT6vLWDYA0oxPw1RDKbvOM/ZObd0CFwma+qtzgefLg?=
 =?us-ascii?Q?yWTFkpe7ZYGGRiTCmV60iKXwLGULpkTlTEx029spg3wQ5wggswy/GnJQEHab?=
 =?us-ascii?Q?OndA3taEfYiSZWK4+Q3YDn4uIvBha6OHIilbWmGMVwztrvQbFSmT0SX5BaKr?=
 =?us-ascii?Q?ABfZMID4lVhXyVnYAr3E7OjLqO3OJh7tBZDd0Ua/hOvR801YrEKlln+3tUum?=
 =?us-ascii?Q?mlCu4k+h8sp6Fkfq0F3NGwr2yMbnRSndkg5i9gdYoQm/TTb8f743Iff9d3o8?=
 =?us-ascii?Q?x2lQsB9H1WfYXWkmdaTaNjNi9nHs3wHjZ1XBACFHQTc3cN7V9IHEGTowQQv9?=
 =?us-ascii?Q?tN5EnT1x56Jvvt8YiEtfTD3xZuZnES7xhN19GsP28vjZGWPti4AWCPbldm8C?=
 =?us-ascii?Q?HjjtVsUVlnNrtFtCj9eUPiUqe0lNqUW0br4wbFUf8yHAoZlJBangyfZNUxWU?=
 =?us-ascii?Q?84kZTF3gxfqNwcG7vm2V5rgpqmMxcnBY5MLIr+fIsPDE264UG75g8YG9m8Zn?=
 =?us-ascii?Q?fVumQJ2t31Ps/IOxJpRcE/C6R0KnqiMCAJfJv+vJyTsATCCJKSze1D7B7Y7+?=
 =?us-ascii?Q?SolgiYZcWQd37CMXuxgsW/n7qhZd+js7jMEiV+JfXCyA+JChKz7nt4HIkC8S?=
 =?us-ascii?Q?qHKk1ei1v1v3WER1k+i7OQJ51zul4qyYIldh3VNQcrTE7A7wUdL9xjx+u6PH?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nYeCXIZ1vWpOwGjZlpzeukWesaXLKpZGfqcFcXwsvdlMRX+vr141HSIxmNTxnCMhJe8tWveC63iKlGDYuACl83b765Vo2RKLexlsYaUVJ/RCoXDqsnEiJeWdKwLV/DGL75RoCJcrThmEbLXCV6DggabP+lZZ2Nj5bCVJPTKV8wjzgETqGdi/EHnfzzLiR4d6wNecb2etNcxsp7qbQ5gmfxZsp+ulHo4q+n+LOh/SYa0X3E+0Yg4COqT/meGEJrsreNjhOsm+n4+3o3M9lcAHw/hm9imWqkeIsBrwPoKyCPGRLaBUWH8ot/Bsb9wDvsphysjCtt0+4jDhEcEXD3FA/EUTLMoaf0wLrnPrxCoSVtmh58+yRYDlD18XFz74aVzo2w9udStfwnxyVLOL4r9f58vuHyRGQAx5KiC6paew5vGgvbJBFoTm5M4BjdLqLKjO4qTk84ik1USFTonbKPSmR5cF7IykVuLGaEurK/A2mO5vj7522OysCtqaMHcZrqlheX0bvFqV+h8gRVFtkQsw+EJ8VqyjLP6zQXKT+714nmYa6eizdpSQmrtmnJT4mi1VYQYxlwanrLmLmrxHw2SCjSdHvuzIcEHytNaDEo/FsCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b99c799-e8bf-4d4d-0c5f-08dcb7dfac88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 19:24:08.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzpV0WCJu6XhTKqDc9BQwGAK9KIyhOgO5q3Mub7veWf+FRvjvu4BEx5qn1PI+x+jxrohPQCbBHxvHxSZL4iStw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_19,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080139
X-Proofpoint-GUID: zqqN-IFrQ-NCWAIoD0xZ9nW6SGF7uS2i
X-Proofpoint-ORIG-GUID: zqqN-IFrQ-NCWAIoD0xZ9nW6SGF7uS2i

* Matthew Wilcox <willy@infradead.org> [240808 15:15]:
> On Thu, Aug 08, 2024 at 12:29:59PM -0400, Sidhartha Kumar wrote:
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index aa3a5df15b8e..65fba37ef999 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -6997,6 +6997,18 @@ void mt_set_non_kernel(unsigned int val)
> >  	kmem_cache_set_non_kernel(maple_node_cache, val);
> >  }
> >  
> > +extern void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *));
> > +void mt_set_callback(void (*callback)(void *))
> > +{
> > +	kmem_cache_set_callback(maple_node_cache, callback);
> > +}
> > +
> > +extern void kmem_cache_set_private(struct kmem_cache *cachep, void *private);
> > +void mt_set_private(void *private)
> > +{
> > +	kmem_cache_set_private(maple_node_cache, private);
> > +}
> > +
> >  extern unsigned long kmem_cache_get_alloc(struct kmem_cache *);
> >  unsigned long mt_get_alloc_size(void)
> >  {
> 
> This should surely not be in lib/maple_tree.c ...
> 

It has to be as it uses the kmem_cache maple_node_cache reference.

It is located in an ifndef __KERNEL__ and an ifdef
CONFIG_DEBUG_MAPLE_TREE, so it won't be in any kernel builds.

