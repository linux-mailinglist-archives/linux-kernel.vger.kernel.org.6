Return-Path: <linux-kernel+bounces-281216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959AA94D46B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166311F22AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620651993AF;
	Fri,  9 Aug 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qc5HVTqk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nc3vl8Ta"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DF168B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220138; cv=fail; b=aeTqx0V1mj4g2e8b0ywfHFNBl2c7rSrXFdT6Y16mGJuMJCma4AdYfkywPL1eEEQ719CfH6HWk/LcFcF2ZPowNBaEYmDHIa+wsZXcNyXtzC5P1q3aAzv0roqg5v8qxshjSW2bFcl3OG5vdO61aRHLYqjIOW6u6AQMvPk+mKUrKB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220138; c=relaxed/simple;
	bh=29w7CCKLjerc759F5NYl3J5uJ847GuNWFSClFpqb3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HtMfPUzVxCt57fdupSUsoC6J0jmR3WGkOnfWwkspX+GPpOcqqouyQ0SIitwMTWK9U2T8WlU0t/X7zgZKV9Kd+qTzKpcMOMUarlnvvTbUjoe7DcZTVmgBJfiH8StZ4QUO4Ezqi60039I6yyPX8L5GP8eYD5FEKVxHqkLcpAveBP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qc5HVTqk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nc3vl8Ta; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMVM7032135;
	Fri, 9 Aug 2024 16:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=sjMh/IXOae2JzZ7
	6D0h8q0tNNt6In8uCYeJ1cv+Ihzc=; b=Qc5HVTqkO+REx2YFfCpC/MTE+IzL3s4
	H7r+0NbWb9Yb3PUkej+fVPOKJJco2Frjm4sk1Jtmua2tyluPocjKs5qlcbllfnOZ
	eGLQsmlZiqB0vElqxI+umhu20p6W8yAwJcz163RtG7ajoG252jIZnPkSc+qNb/n6
	RQJFdX24WcUuUOx4aaPSzmiyLN0yo1OdOg+s8xrVO9jNfVrtxcGMxe2m6/kktN1w
	hlw4AmLoPy/O337khnUVCqdSjVmBEGc0nllXBMbmbWXol5ixeTHktCW+lp6kqIgA
	JVGBfoojumMBi4bJWh9EsSZ4AZkLqnDUEnlFToEdAS5wLtPKvTddFvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51mcx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:15:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479FL4kZ040660;
	Fri, 9 Aug 2024 16:15:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0d73k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBRkZ3lH1p8v9aWei2q4Pkuk9qgCGoPRWcFj0365bwjZHjzM5c/XngC6fmOiQokFNQ2mWBJ/onJ2aLkqHtGBptZjRAu49vS6o7HLK+avEbdpXaLDMN/o6uXslF+vlG5dC87kTNZTCr/uIhT/KCH0S8FLkoZ289Sg9UM2AIvVFgVEFY89GzIKEWqra6bNV2hIFVb+MGhl7ukND4xGcyrTUJX6yTm6TS4Q/d77HcLaUz7pWSRttG5uD5FNs7j1VlSeL1/3f9Ml1VRXjiL9jjbZmwEEKLfFx60N3x+G/DLgLvNa6Q7tAKf3n8yyiA8ar40jX9OvDo/eQgwODws+weP1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjMh/IXOae2JzZ76D0h8q0tNNt6In8uCYeJ1cv+Ihzc=;
 b=seCucM7X+nKwq+vhBDTCynEwPPgGigWuUw6RRjBz325qlx7f6xwMU3g3ILCTBKCaeBc+OStnf6zwUvWKjsZREZ5n3BSbJ4w6N1C8PRcNxuO2KOAL/U/itgBPWpgiOEQrcand1S9iatUoCTFH0X6GLgxwbWe8+fBN2zEIgvQBwbM62TYb2PNPGiPCXsIdKeUcMJYjqLfIVuB1cTnnDOTiwT7JUb0xiX4K8LmNJ08FCQWehU9KAEie7/Xx3dL8wCcZBDTA/M1HysRDmWRkWVEPOyPPKxHwdulqjgjt8i2fBV7RcQFpMULovkUCtYW1gCu5oBoYlVTFnMhh4Ig+cmo8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjMh/IXOae2JzZ76D0h8q0tNNt6In8uCYeJ1cv+Ihzc=;
 b=Nc3vl8TaW6/O17MmvVH5kGb3J6vdHDtyytHg8qeWIB66R6T5GAfMbftPGYM/MF7BPcuY39UE6RBNt7bvU/iuQFOEaogjWyIHHIOV0+hdaA9qC8BIzjtDQ7GQ76MBmDtO+bYy98/iruoFsM6sxFNG3ntzlNI8jiLgrMEJspmmx2U=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4335.namprd10.prod.outlook.com (2603:10b6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.10; Fri, 9 Aug
 2024 16:15:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 16:15:16 +0000
Date: Fri, 9 Aug 2024 12:15:13 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	jeffxu@google.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807211309.2729719-3-pedro.falcato@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0069.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0a770b-06f3-445b-dd5d-08dcb88e74b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RILyWqRzId2lPznUIjBhaYyTTOvjZqr0T2jlc/fi1SpGxENj8GLZpXC+U2xh?=
 =?us-ascii?Q?01eDrforbXN0FeEQx06kF4OnEEQ9v5UQKmFDfZtde1nclOk+SYDKGttc1vku?=
 =?us-ascii?Q?Ajd2yE9cOIHK8XYHYpaOiEA6+xyO4LNDW3XyXpxzd6nN5bdQ95VBTw2VNTuq?=
 =?us-ascii?Q?cIKlzYRDpa1o+iJ19+vCkACNF6h5Mbbu+7PQImLGokhNcKr7aZWf54WXW+y2?=
 =?us-ascii?Q?J4u1ELEweFjYNDOJWrdUtFq1h5biwdPchaWYHKAzRuO3RBMiqGE21Hd3BVFM?=
 =?us-ascii?Q?gscmkHXgfh3Jji7BXC+sJiKoAU+L4BekRy9sUB32uytVv1pfedcL875Fy+C8?=
 =?us-ascii?Q?e/h9AurTNrijeRc16Fftke4pgaVSqeir/eNUWcJsQ10sG8ZsLpXPqjOwpFUk?=
 =?us-ascii?Q?U4v7hXJBt5FDczDrisEl5U0I3hDRNKZBKeH3hLM/gFBAbLMhRGioHLbI6wcE?=
 =?us-ascii?Q?9eGiO1wUtE1qmNT0bMpmJtYyhgHt14XxbxuT48oZF0F/sEJ1jMuuLkEC5Spq?=
 =?us-ascii?Q?KWkj6K3ZIwU2bUsQq77KfqZF083PBL8eCXdtPUKIJD6Hv5I5eVqCD1zdcrYw?=
 =?us-ascii?Q?gzB44kLO3uC4WPPCaXatWTYeUqp/N3+v3qS1NWNxPxN9YyC2iNAoIS2kM7oU?=
 =?us-ascii?Q?HjMUOfW76IoQYmyHRRo19v4LrFLcrbP6/9IJV9LITI12aFLk50ykLaDQ8AqY?=
 =?us-ascii?Q?pnuMdfim2VWcMB37XDHX/KSc8Q0vaMDTAE6HOPwuFi6wKvZOocQnHsCwtaDj?=
 =?us-ascii?Q?MkV2ILCzxKS+UG0Cl4VB5/7hii5zC9PtrV2dkHDzWpsICNqbYtF13Z/YNI8S?=
 =?us-ascii?Q?Am5Si/MnhPsfo+UxkZLIShwVzAyhHUsRm5JfpF7hjGzsoZgVLyiuXrNiqd9U?=
 =?us-ascii?Q?u1b0d0ZObBSF/Q7ji6wG+Wr692ZfJOu6s12RJCJJhN42S1ebuYBzo3RCXFqb?=
 =?us-ascii?Q?Ziju27YFUCo1w6OPRVBtcxrsa9PVO6Cyi7y1HbTPswdWC03REoVC/tb7qiyz?=
 =?us-ascii?Q?Tbj+2mcN0KPsM4CV6jDdwmUmboVeFDFu8SXz57oMEF0KrzEtoMo9QHFutPh2?=
 =?us-ascii?Q?hUA3h0OVFsSyJvwY1e2zX8EiYTbX7Hj2sAfP00uhDf2CrqJKpSoCiqAfVz6k?=
 =?us-ascii?Q?8aYuzkVs6xs862d1OW1yK9FhOU1wDuPsKtK1lk0fLRgwTsphdZrBm0gIo2sT?=
 =?us-ascii?Q?KiXGUPfzRpXWJSW+F5vclVfyz0iSPBMEaXojvbW8EJBf6QpAQOdhaO03jKQ6?=
 =?us-ascii?Q?T/FxDY05Bqa5lWMPd5w6ZJCfPuwKql8urNFKUpygxadLrHfrfHbpvCF7cpa7?=
 =?us-ascii?Q?4dya+Xdpg9FP2WLTpiEHmQwiPxJLySgyHVTzpTfqmFHrGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OO4EUGdMBpFlNN2iT5oei0gEiL7hvP+ipRTGfmM3TGqprOZBiXFyaaOax4eK?=
 =?us-ascii?Q?hWxBlmK96M8eJlrTFOzHu8T6oD3fNBlcUwMBP9cglp6XATHG8yKS7k6L9s9L?=
 =?us-ascii?Q?8PHdd5IFZDJ3yQ/5YsXf+qXMSovlP/cYvsJ46arX2mTCccN4oQl/raoFrUT6?=
 =?us-ascii?Q?RnNI7TfSMqOMTqZCKvettLge2lf4xTvPIr4fSu+77knReiFGmW8osaoBZwq9?=
 =?us-ascii?Q?jn2jkvZv/5ddysT9p7jfDE4/B+gMA/+QD8QdvILFtIyjP1tEyQq176C6fS5/?=
 =?us-ascii?Q?4KsuIwJOJWGkuGQv2aYSfhiiHjFLCFsDU2Kjo1OX7BWsdwHU0T4ssdMpCSJS?=
 =?us-ascii?Q?eOoCwTMeHfxr+6BxIBIcmS/6txXNX3o2Rus1bavAUUeXngwf8j44KcghneFJ?=
 =?us-ascii?Q?YGScPNqszu+krJbd7mNfWXL2Q5z3F6VczpTVHSotHyKQEqzfQKQ7IQNs0gs7?=
 =?us-ascii?Q?879B8ggptq+2hcyFzL/atkUc9B6t69iaRL4PbgwF66lSbnoHBP9HMyRC5tu4?=
 =?us-ascii?Q?kcWM5cDPZncdZ/jeQ9XdjY+qiLKeTK26Ov9ypl++6rRxZq9mytNKEAKVoh4i?=
 =?us-ascii?Q?4aUj4P/KB9l7gA8vbQkxpsMfddlvR9O1icSDFJLHkFJIU5bPJ1TTiAunFO+N?=
 =?us-ascii?Q?0l2GuWpulGkOr5Yn4Q6T5C0+1icnLv5HQ/BWDv3t9Tbl8FrGS04JUl72AHt5?=
 =?us-ascii?Q?dikC8ery9vcgwjiHN5y66L1z7B6i+YAwjVPUc0+n0/h8Aj8f5XpyfhUV6UfM?=
 =?us-ascii?Q?lGTDUg6ziuwbLC/a88s9AxQ/DA2/eceY8x7bRaGgpK2MiybSkHpsxbUI//+K?=
 =?us-ascii?Q?OJBTqzQcUlMFYC85Awls8BrHlPQKMQ8et7aVrCUr4dqcj4lXjgi3aLRYfss7?=
 =?us-ascii?Q?D+EbKZ7oec5uCXrBFJI8BoSNTqSu+dR2Vg0owiL2z4lkK6g4ONccMKIlEXTh?=
 =?us-ascii?Q?tSDKL/QfVNWCz+sZmZSFD1SxzLz0wAuMXfY5tQcnv62qt0u2389ZekJwLnsI?=
 =?us-ascii?Q?C1e90J+fjLZm0oqm4wSK4kQEKR4SXe+tIRBYwGLvZGZcXIqwcj1u+pMvaf4h?=
 =?us-ascii?Q?fkjK8X7t5g9Ywsf9X9sLBGj5eGYoPIpry/BlVvchDsZ+THN+14595ykbD63J?=
 =?us-ascii?Q?Zv4oTgLDFjzLf08WWY9oOhA3HsHJZLI49V1QoTRPPKBYjTUeOEQiauZjGvQx?=
 =?us-ascii?Q?oU9/BkjPBip+KKSrsVFFGBwhPBYcHCasKrKK7hmF/7VvtmscjHlQ29Ja+e0T?=
 =?us-ascii?Q?rtcVeXRIkUhRPNaVdmnPJH3v68WrftrkdsnUyn1jia5+Ob/rJMPOrYFJGAM8?=
 =?us-ascii?Q?13bfBp4v94xYrsM4CwqJGhS+rVHT8chSdS3rZ/paUUXmeaAm4ZG3ndM/193N?=
 =?us-ascii?Q?KC2CxwEHdH7f6xWPnVaJyGJwFPoSsyYSae8PGnbnl7USNipN8DbXEPIj7ypC?=
 =?us-ascii?Q?OoEZf+AqpjDBdoczDKquQHEnP3SsSz1Wypc0SIwPyC3OdCr/lAsC/ugA2kb9?=
 =?us-ascii?Q?OUtT5+hhc8352vYxYnxfY1ZsA6o0tPl0EzyL/jTvaPPPNKP6+i2fwupPxPnM?=
 =?us-ascii?Q?x3g9aAQyEf3qXizSLdBuCTC23raOM4yudxT4k+IyGdtZp8ICE6u0JIV9H8v2?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pTFJ933S4I65Ddo8/led3JriBbzp+8POONqz3652w/93YYTZkaPfbnroPN5TVSDQAZ/lozj4EJ7idXYxJHEqx71mzKiwUvz/EiM1L8vb8aaknBIUHFtk5UKQonRTbDDIUI4DQrIzQB26tGl7b/n2v1DPB2tW5CTvl8kwqxa6wyp4qDf3WF0IZYYOwvbz8TK5pIXLMHl7GH8XoPd2UxYA6/3EqvmFfqR1G7gixd9oY5ozCS27nlHcmefgsuAlNsFNi4qfF4fs16h/qIkOdx1rPF0lPEXj9zj/jP8G6jSYWfoUEBebZ4jwYoWc2H7KNzU90ADT//QzAeodcLwsVvKmMD0wk/ROJYewliuvjyTU4YCKk5eDPr2lIRl39lagZfCCh4CoLox97vA9skFYk4uENyorOyrCFDjv8hhjcCi9DdlqSNS2EXVzN5jK/VhP+LCIT1vTIBGPc1nVyR+6BONAy0OmUmKDLcaXNvTX9y2rGbsPoDKwpTwtdrrqGRAKaeKqY6yOqIlqFDH1YHP+CdRNinAI2wh+nXvjlFoZhwBbB9CvpVPsUxODPqWHrjpG/ItWjnMNZJptuAFz1vT+gWkc0qIds2xa6YuZNq8/9TS/ztQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0a770b-06f3-445b-dd5d-08dcb88e74b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:15:16.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFRuaOO1WsRi3vjyJ2v+YLTvrhwRMKr6b3asBnW0IU3nixuG8lpCj50xnSxL6tAACkjt5YbJlZnMdvhfByd/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=791 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090117
X-Proofpoint-ORIG-GUID: BasWmD8ZaqGwJvpxK3O7WKUM8uTBahwI
X-Proofpoint-GUID: BasWmD8ZaqGwJvpxK3O7WKUM8uTBahwI

* Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> We were doing an extra mmap tree traversal just to check if the entire
> range is modifiable. This can be done when we iterate through the VMAs
> instead.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mmap.c | 13 +------------
>  mm/vma.c  | 23 ++++++++++++-----------
>  2 files changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4a9c2329b09..c1c7a7d00f5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end, struct list_head *uf,
>  		bool unlock)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> -
> -	/*
> -	 * Check if memory is sealed before arch_unmap.
> -	 * Prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
> -	arch_unmap(mm, start, end);
> -	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> +	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
>  }
>  
>  /*
> diff --git a/mm/vma.c b/mm/vma.c
> index bf0546fe6ea..7a121bcc907 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>  
> +		/* Don't bother splitting the VMA if we can't unmap it anyway */
> +		if (!can_modify_vma(vma)) {
> +			error = -EPERM;
> +			goto start_split_failed;
> +		}
> +

Would this check be better placed in __split_vma()?  It could replace
both this and the next chunk of code.

>  		error = __split_vma(vmi, vma, start, 1);
>  		if (error)
>  			goto start_split_failed;
> @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	next = vma;
>  	do {
> +		if (!can_modify_vma(vma)) {
> +			error = -EPERM;
> +			goto modify_vma_failed;
> +		}
> +
>  		/* Does it split the end? */
>  		if (next->vm_end > end) {
>  			error = __split_vma(vmi, next, end, 0);
> @@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	__mt_destroy(&mt_detach);
>  	return 0;
>  
> +modify_vma_failed:
>  clear_tree_failed:
>  userfaultfd_error:
>  munmap_gather_failed:
> @@ -860,17 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (end == start)
>  		return -EINVAL;
>  
> -	/*
> -	 * Check if memory is sealed before arch_unmap.
> -	 * Prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
> -	 /* arch_unmap() might do unmaps itself.  */
> -	arch_unmap(mm, start, end);
> -
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(vmi, end);
>  	if (!vma) {
> -- 
> 2.46.0
> 

