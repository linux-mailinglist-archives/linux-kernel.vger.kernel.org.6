Return-Path: <linux-kernel+bounces-308745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B496613C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59BC28446D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A619993D;
	Fri, 30 Aug 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="il15+mHZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZirAUA1F"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931119343E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019309; cv=fail; b=amgmL3hhtIGH81yoY/jLYCIuN3ckyPe3+wKCny9ScCMNgcIWnAEWxTssz0ZhRE8p8BbcUT7x4rb3nEjyFriY2Wi/PaQ9MttZHCwbf+KcpYoHefZVT0S7uFekzgp2+3j0AFOU3R/5o/Wh1M4vbzNSEhtF0m7IK4VoGH1Co5iVZbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019309; c=relaxed/simple;
	bh=dO7GdfLA4GjBteexcbeOMMcYKbSdWJR8TNXVAWrHEWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SI3EDfwfupfSF9Lwwh/qih5x+Ng6R78/cJb1WmcvcISOJGtHTeTM4srbMPpa5jc4Dr07jFlEmk/9wIdICbtFDBccWRgWbFXH4AYfT6S9LXYv03WmpPSBS7E8oFn/vNNPNMPLpMx41IptiRJMS6xnwH9TlgGrUwjxO9yW/fzcnjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=il15+mHZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZirAUA1F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U7tVe8021710;
	Fri, 30 Aug 2024 12:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=dO7GdfLA4GjBtee
	xcbeOMMcYKbSdWJR8TNXVAWrHEWU=; b=il15+mHZvw6S8C9VFGEBPIfAVLlRJnB
	SH3eQwO4H9eiFNFApAofnD+oZMj0XvtpkKsIPXYl7CGTdFlKJE98EUlI2o43USK3
	uci1HDRv6kKhwYyhzbQTmnHZafAfKdlk8OFEexm/NGx5EUIrYgCVAzfqmcP8HTBi
	/hb3xFcpFYtzkBj67NjOpWJ74P20w5iIHRbsvhnH+acf2ptzjA3U4oWnrbhkAmiW
	YclAr35uW8jdwOD+0Z9K7jLmmxwt5tE8eDwwUVYz19TiAua7x8/WXYE26uoW7r48
	cIeggjY9j+tdXpdb/Ded+s8fNeYsoud5c0JC65+ASkDxiVAIOeQh+sw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ax0gsgwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 12:01:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UBekGc020188;
	Fri, 30 Aug 2024 12:01:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8rqsb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 12:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8xqe3fkGQlc2UxInfqqKPRziL5/5D4OIwEaS3gYGmKSrftTCuxuWdxR78EcYTID9N4aPeBacrWl002KhRTYreEoHsz10/hA5qv7FZZbd7laVacUD3xrBHsUNVuC1u9DK6bMAsiFzV1+eVNyUdrUHzawDNYnx6YxprJUnDNqP+l+svw9dEZOFjiQzUjSJW0tAZuyL/Icu4m+x36BqEfXlhXbehgH2p7QWYjFzddWJ48D/bdMoe3Ol3HDpIfuLAudYPs6EvNZA8OYnEoh1A+C2Sm9V6Mr7e7ZYRsK7jd7sqbgukfeWh/i7XGsd9w3edEaJh9pKnU+eryBoIfbJw25Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO7GdfLA4GjBteexcbeOMMcYKbSdWJR8TNXVAWrHEWU=;
 b=V5b+UsbFDjzi/J5W44lWaroXe6Ng/cOaZWOiQ9Dlf28kzIMXUBQOj2327m2x42sk4tB2kakcP/02MOQPT+tPXwWh2mmeDTjwq6XqILGZTaFaUa8HMe/CFu718SQpQZiWppsaQ33MT6va/+IJEC0DoC2j+NC4RY8W91wJGb8lL33ELNndGWQ6ObH6gGoVZ+oizHNYkqiFQAZ/I6R/GH2fZkKi6yeYWXXkYrUMQFDlSjO9jk+YD3/Gh6FvDbMGwhSxzDYMdpz0UpPkYioT/gKTNOJeq2gO+N24QWvePZFVOisoHhxO4/pZLVMisSxIz8xvwdE7ADQVZ8W71RJhMQDyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO7GdfLA4GjBteexcbeOMMcYKbSdWJR8TNXVAWrHEWU=;
 b=ZirAUA1F54EPrEOTX3RhTobDSaRmJydjEdT7RMyvTMkyTKJ1d+EVZb+MzTL62wnzjNu0ob3N5wc5kAjWEzj7Djs7UOczqDoFf78f9k3o8pJRsxk5s8ykJeFzjYsTnw//OdYtIBHOQEvS3MiV0AL9HJnaaH7FpgkkRap+67r7ARg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5547.namprd10.prod.outlook.com (2603:10b6:510:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Fri, 30 Aug
 2024 12:01:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 12:01:27 +0000
Date: Fri, 30 Aug 2024 13:01:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr Spacek <pspacek@isc.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
Message-ID: <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
X-ClientProxiedBy: LO4P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3a7d37-4466-416d-ece4-08dcc8eb7a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MrTXShMCapZjgCixDWHHrKu9Ir1RJguszHZzoPDJCg+EeowSXhRAqnOqAK4L?=
 =?us-ascii?Q?DyXFWKvB+jTTbn0zoPXc5s3yV1tcmN+A640oDOdwO9vK7OBhX6KxZ6NLHyal?=
 =?us-ascii?Q?UK/PiwtAEMw816x8GQYCNA2VIxXyHks22XyLbiDAr7/XwHIEHzFTPOb+cUua?=
 =?us-ascii?Q?bDM8A1IT9H1xXcRAgy9ADef1FUh/FutedYnAYLshr+BFB1c3of4KEX4Xrov+?=
 =?us-ascii?Q?VyecEDM84qeD2rKDvclht9szgqVcGAMPL/BIPnxIF42IMUQwgs5KHsNReZWW?=
 =?us-ascii?Q?HwJU+ysypfsdDZY9aJhVbB2k5l43OJueYv8mWK4Xz/P3DOk8yvp37lgTbKwv?=
 =?us-ascii?Q?IATJh1cfIwi77mATfancwj2VO0UoxJ8v3/Ial/7sAy3HA7rHrQtUElypghvq?=
 =?us-ascii?Q?PF9fM417x7lU+ta7y87i87EhAgF6fuC+7hdgzEXFP6/ml1CzSYLsMC51M/c0?=
 =?us-ascii?Q?OGOp8ugTTeLaxvXPt3Ft/juj51mrYBOBqRVoAVhtHaoeghl/WWEIx8zvhusT?=
 =?us-ascii?Q?G1X8+jmXQ9MuDSsPxWR5hTh9y1IrsAas1WWJ6hktBxRdBTa9v8rRRQtLlzOB?=
 =?us-ascii?Q?/PGB3KrXT6YtGJSokcyvOU/GKd2oPIhU5Qr2FdNZYgtFWZgSvDIKa0U7w4eY?=
 =?us-ascii?Q?cOpSDcmMDwGXpP8REA2fFgJF8e1abzBeRi+rc8XcsOSResbcgyy82OGuIo7O?=
 =?us-ascii?Q?j6q7f2+ybvipHlOveTYou/RG9gdN0Rp8CMlB4phZkaalCS8rFjTtnEwnlVO6?=
 =?us-ascii?Q?noYZsoAJFG0Ph7X2Mx6rpiF8VdS4WhfOoIa5Tu1sxn97iVJuBt3PZDQrOkeZ?=
 =?us-ascii?Q?Y4G556nOt6vab1bNHNLmJVcVfrM5tzsCnaydlWqDGrGKlaevllpyEJpU4ydV?=
 =?us-ascii?Q?0nc3gUYa8j4Yoc52KGMTWrWFfM7mtXc5rc+qZAYqA9wSAiIH8DnHY1F1Uhva?=
 =?us-ascii?Q?DmN61yQLEGt+Ak0cYrxJtzhTCn6fBNB0NlUM80cZ+SXqW4Ml7dSuBvtbeqez?=
 =?us-ascii?Q?Y7oPftY5P6Qyj0Z8xOky81HHvCrctc6cRj9zzIOTXeDkJ6OGk1P2Vp5IwYcM?=
 =?us-ascii?Q?4iM8Cfzf8uwwr48HxzUIr2tkT8UZJQLW2Hw2L7GS/Ma1po8lg+xzdpZVosbJ?=
 =?us-ascii?Q?IxOVz7oSk+VahcV6JJl9zN6unwCqUQ0ttNMeeaIxvRJA4VgcHqujpUzCVS6w?=
 =?us-ascii?Q?3gXwjQ0HYN8K7fJEJViOodmryRFnWlq1RUvkPSfPqnydsepNoITIu48kWfsf?=
 =?us-ascii?Q?cHCUONpiNiIiZVmJ2wbDi7rwhkbmcfyX6vR7eJkOIu8HmuO2HhwIQFJE7vSP?=
 =?us-ascii?Q?nNLya6Whfl3I+Rr9NwQ1+G4y3CH+Y9krRa8p1yvQYGXFkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TtcxsdYBws+WqgdLjvkEKIKrqkUYgpZFJQGEcuw09czc4eq918axqQkwxm8B?=
 =?us-ascii?Q?WivQSLoR9m+J+u4neI3/SWxKzD7JAx+0KZXg2e7K1/uCi4GaRUR++Zd/Ghp4?=
 =?us-ascii?Q?QZlSxgO9L7B2/vXLLccgD7H5rJA36gj75xS6t8q0uIpIUY2Ev8CK7zDmIZS4?=
 =?us-ascii?Q?pgNx4gsdg0l/VV3YcqiJ41C1ztUi3WD5NdK7Aj/eQqb0vwHV1Mnc+yRiIp8h?=
 =?us-ascii?Q?a7UR07AzFpw+802DBd/Y91n3DTZeXfu1V23G5OWMV9xQRjlIuvcYjDFHzh6J?=
 =?us-ascii?Q?h1MXExfMkZfhPM7bHAVr8rBTz5nXodL7SSj9Go72cp6gN4aGtOQNbsK+R4bF?=
 =?us-ascii?Q?Irvb0ooRtjDNTRiRytGLwIBkq/egwvGFnfPdLUlfJ08vF6dfH2oeZ2IJrDVc?=
 =?us-ascii?Q?Mzpx6NzBWd58SCcGQyQ88X1V+8Y/fK98/KqCLMPB2+PUJy7Cn3VXfh+RMheL?=
 =?us-ascii?Q?P+jhPnEWIU7cEq9o2qhShicRSRBjweT31qLEcO2GrzAxUBcx6ktYFYWCwdls?=
 =?us-ascii?Q?F4OaBE+JckzqLhglywKoyz3MipBum6PhurkeQx+ZHv5XVD+j+GgAXDW1apcv?=
 =?us-ascii?Q?jRdJB6sK11FRJJWt+B7lFVta2/BTT2PUj2js6BXLqYeWuWFNl6tP0mrc/jLA?=
 =?us-ascii?Q?WbOeBP2+hNR6HacZ+U+PfCyeJy4DpO7dJQ+i2g+nZEy+P19h0XoMPV0/xx03?=
 =?us-ascii?Q?Pj4lm+YREQnSgkLgJzoBCR82EfVMWdRWnCcfMmsOZK4omAqVIlqqqreUBqf2?=
 =?us-ascii?Q?s6WShDcBefBzaj2nlguIWGRxXdiAzCtszirKG9QNAD7+PuqwC8CK4Fi6oTOu?=
 =?us-ascii?Q?MlmhN5D+UIsFSYpcQF7oYkbp1hKEj5ifmuRMF3T8a0qjspJvGtl1ZuZB9diu?=
 =?us-ascii?Q?T9fVKb35/THw2bDxqMY8aFg0pNDCa/UVhMNB/BfY3Bz3CTtp/ljs6QBr8l1i?=
 =?us-ascii?Q?pWMZ1KOsTZS1QUBeghAlGPIMg1X2LhEZLW2YiZLLhOoKBCPGfXK+FkssCPDw?=
 =?us-ascii?Q?O/pL2Re2VgNBX0NPHSq5izOlE2QqMnr/hIn25LM/PDgf8pEQ1uSUuzMrFRbM?=
 =?us-ascii?Q?MXlmInKuUP2PkzSiNq3JEc/mRuqYJ8wx+zdWUoAWiEVI78zaKg4fDiqQG1uc?=
 =?us-ascii?Q?HIEGLmG1nsg3K3niLrRxDRwsronLisqtMfuMu/7uz2SZNzu6WXRzrQJqXSil?=
 =?us-ascii?Q?LpLpDFGVM/amH/1kka9zqw2mn9BI738B9dnhthsrWNmWAHALBYkSf77Zqzv1?=
 =?us-ascii?Q?RgAw64heLEwPwD+jfpAsywNaTxglj72U+Bf8E9pJN5y/yCDCozRpy/jOOD5Y?=
 =?us-ascii?Q?DoLlWMzgEXOFz5YvvX+FJAbz/Mz7mgX/UGTj62EsdjXaaHxtna0PqeB7nDDP?=
 =?us-ascii?Q?Rp3IDTdOJ1z1fdu1JQg5D2jQiGHytVZl33Q6o5Jpz+S2757v9VJewuryHwj8?=
 =?us-ascii?Q?ThpsZ7/TZySAzn+x4WNZmqwnnTM3kn+gy7D6hKRyo9zT0RFkhdjYwc9Mfjbe?=
 =?us-ascii?Q?KWcqWlXKRL/hvMInSOezzjsyOlga0+9G+1P3Xi1kAQDuOjad6boAa83kprqg?=
 =?us-ascii?Q?zpQtk6cDDjf9+9pU6MjkZiojzuUzIWbCziD6+Su6kayrhf+nSQR/PuuZ6gEk?=
 =?us-ascii?Q?FCT7RNTfl2pBZHa4lSkYs4VPrnoQHXqxRk6UmzXwpGgCRt2UDu6f5zekYl/U?=
 =?us-ascii?Q?aMHDxA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	49c4DMXy9LDhCrs2DudXplxfEs19JmqcpCFee2SXEdiA919pvFtIKmZd6jZAqPogllNPjLRyhf+Q6zuctUvhWFN3LozfUhi0LY4fQV9mMCc/bNTNTR3MhQG4sM4pXyz+C2kyoDt8xbxxDyZKsTgTadf/fKm5xTONZC6q0v8qzujzGlUYIFXdjQ0C/+guXqbtknt8Hl+Ip3NYHqnKLkOQlTTKFXJH48pFDOHAz3pLzulXNXJer6f2klQk2kCiQF6L8zQSzdUHdKf2bSsDpZUCZ7IXRivWiumxAL/OD8gJUMx+cl3ksbIoQJjn9ASfJlAducPkIAlTX0pJT9gqSgKnN5QRBCvTYDvs+QpIxYB/kuxBQrKwbeyMevvFc3wfq1Oc2BCu6E+G9klcx89XrZG/KXv54GBXnniX+SrQFjZAw9D31TZZJ8BcuN7zNIBX9gSXsm1+t88LeURDyHJmXQHqmkMEPzdq2JT6GuVMCeLYSl7INyD+uAwdSZ4vLcSEUZigpkqUM3txMqkD4l7mBOtbPCZ2BTlvHohxkqzM7anHEDwHPVq5Xrp7vdlI5t+10Nmzbf8MUrzaAd22XMvv2PpPqkb83/gp+lTsGfitliAUxqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3a7d37-4466-416d-ece4-08dcc8eb7a0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 12:01:27.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lDaxV14/QqtLXfh72T2Jf93ph/LiDay5ROsJLrac6u2JyiuUBUoIwEj/IqkTXLBVG45eQom+ILBClgYRjRr08orZogiEU51gBuPQgzNzhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300091
X-Proofpoint-GUID: frj95kXgTykFv49c3-x3OJXB_H6aWsXA
X-Proofpoint-ORIG-GUID: frj95kXgTykFv49c3-x3OJXB_H6aWsXA

On Fri, Aug 30, 2024 at 12:41:37PM GMT, Lorenzo Stoakes wrote:
> On Fri, Aug 30, 2024 at 11:56:36AM GMT, Petr Spacek wrote:
> > From: Petr Spacek <pspacek@isc.org>
> >
> > Raise default sysctl vm.max_map_count to INT_MAX, which effectively
> > disables the limit for all sane purposes. The sysctl is kept around in
> > case there is some use-case for this limit.
> >
> > The old default value of vm.max_map_count=65530 provided compatibility
> > with ELF format predating year 2000 and with binutils predating 2010. At
> > the same time the old default caused issues with applications deployed
> > in 2024.
> >
> > State since 2012: Linux 3.2.0 correctly generates coredump from a
> > process with 100 000 mmapped files. GDB 7.4.1, binutils 2.22 work with
> > this coredump fine and can actually read data from the mmaped addresses.
> >
> > Signed-off-by: Petr Spacek <pspacek@isc.org>
>
> NACK.

Sorry this may have come off as more hostile than intended... we are
welcoming of patches, promise :)

It is only because we want to be _super_ careful about things like this
that can have potentially problematic impact if you have a buggy program
that allocates too many VMAs.

It is a NACK, but it's a NACK because of the limit being so high.

With steam I believe it is a product of how it performs allocations, and
unfortunately this causes it to allocate quite a bit more than you would
expect.

With jemalloc() that seems strange, perhaps buggy behaviour?

It may be reasonable to adjust the default limit higher, and I'm not
opposed to that, but it might be tricky to find a level that is sensible
across all arches including ones with significantly smaller memory
availability.

This is what makes choosing this value tricky, thanks for you analysis as
to the original choice which does seem less applicable now, but choosing
something sensible here might be tricky.

Also there may be _somebody_ out there relying on this limit being quite so
low.

[snip]

