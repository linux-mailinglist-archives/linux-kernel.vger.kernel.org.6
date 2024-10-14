Return-Path: <linux-kernel+bounces-364740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7378499D8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFFF1F2061E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323521CEE84;
	Mon, 14 Oct 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7ZWkJ2n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V3XTqH97"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A214683
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939907; cv=fail; b=e4FCQ+JhjNbziBGBEeYiqYC+sybKs6C4d2RTmJVVMmxvVV5HNfdOqet1qdzGS+YShasR8D+E+i9aIHMthU2Fqx9Q1BsudPHuI0z90f3oMCz+cbnYKWOn9btQqTVeM+0sXezMcRyggSAbSA5GBKX3468l+JC+fCv3bFac5itMKvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939907; c=relaxed/simple;
	bh=toCLbUPNvYviQiL7lXS6WtzU9LFhddEkafL9n2MPG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMsvRktRZc9qMZ2G5SxOeKv1cixL0kP4S5YmXjQX9q/hF3llTMppxeij1CZ21t1cNgbB8+SxpOp8wXyDOuvQxnmH/COyrE/FmPO1PI5Of/ijfBO9Z2UhsPqiMGaY2rQ4OUNukF+WcQjSWcUOLs5Ot+w65nIgNGczg8qeXfVsw1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C7ZWkJ2n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V3XTqH97; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EKta5j005054;
	Mon, 14 Oct 2024 21:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eASB8MhUnPZKspDD7g
	YFj5QYqlCzwXlyK21/HIdKloE=; b=C7ZWkJ2nnFMjnJgWKNNp2PLiFierJXxHod
	6zfp0oY2BCyVlFkUKxByhNU8IU9qzXbyMNlTinw0oMNvxhz0W0R6VbEMkqYPUYc0
	C6w4AY5vDpVUsdRbpXqpJHAhGvkuv1ZpoOBH8x4YpK4p+lNb0/C8hiTxBNqxB/+R
	sNgqbql/nV999VHtsSRrIbZbWcqL039fzLSSg5nvwz1xryyh6Bo92ylkF2SsjnmZ
	SErmSMl/uyPB+1BmX/Ko9JaNWzl99rpo8ECgFDjjJQ85xLxU4n8+tTE3Bd9ciaDX
	dSxThZrAj56A0TA+M9xR8vBOiPOZQ/tZWhs03UBXkzG9t9MvUQgQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cfj6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:04:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJ1sBq011154;
	Mon, 14 Oct 2024 21:04:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcv9jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:04:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1m+AjtKW7nCsPkWVdgaqcwhNMIi6k1c5nC6eCUVleM4fvQrYJpD6Fp6Ae9zi8VsB4ZQKItfo2f5PyZRnxxEpNefcR1HXYvP7v8A/EQLfj8Q5AhEDcd0ezF876gApRDcJBqo1uPXAp8/Axx91KYEuyOu0lJbO1VRrg/k9sDOtS87b8mtgzkv8mRqz6oWHXzTNyU8bxvKBcK79NGrvuNlRa8mHtyWB/DhhCmBEhmp+07cLuyxyygJfAW1Bx+zy2/3ZI7gPcznd0WsnH2IWPpQJWmr01tssjw2In0GdTB0535ISagYe5uQ/PmQHWSGejSa5+XTpjZrJ6WmfqzSU1i8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eASB8MhUnPZKspDD7gYFj5QYqlCzwXlyK21/HIdKloE=;
 b=gsnIsoRyPfqtBoI1T9SWQ31MMjgy5JGUKgA8gX45yF517ctIZNQ6fc2GrCDrLeZpfblpJLw26ND3bxqK8T/D3BKHzvzN+h9FjuzeDfxZwiVtbaXeFnG9OHP2x7da5ySR/DlB7xXPjKl7IPoKcjGoICck+69sMhzbrQRolBN/Gpruhiikwel1k337igLVTKRnou+V7scTuNf7NywzV3zFVdr/TDVdugBcz9lALJQeAMUP7vWxftiG2pEktvwXv9VnG+EcH4oB0/XmnFzvH178vliV4fpT/ofg9wapoXSDjddmI9lQ9Li+KZGCadDfSFPB52lpjGSBul4eXBXgx1O2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eASB8MhUnPZKspDD7gYFj5QYqlCzwXlyK21/HIdKloE=;
 b=V3XTqH97mSrjQq/qYx40uXDQdavqFnuHxSYNBS2DM1QrYwPp798BDmFD8vYKUm4QkJvwXIBJpbYreumoVfVe3SHUy3s0JOJ1zAinKX5RdDVKE+RlWYGNHzmq2MGngiAIFjG+He2uddhUO1w0V6mPSXUNGNnU5gr6E6ri4+5Bpg0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5849.namprd10.prod.outlook.com (2603:10b6:303:191::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 21:04:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 21:04:53 +0000
Date: Mon, 14 Oct 2024 17:04:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as memory mapping/VMA reviewer
Message-ID: <seb3uitw4eolttq5do4buzgtgkbgr5gzg3a6op7fxo4wvem2nn@6jtz3uhmyt75>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241014-maintainers-mmap-reviewer-v1-1-50dce0514752@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-maintainers-mmap-reviewer-v1-1-50dce0514752@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 492b784d-c44a-47c3-3d12-08dcec93d9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ddlOj2SH6pHyKOmPjkbluLo2dSFX3KzfpvniiYYLp0JtbviI7g/ult/Hi95A?=
 =?us-ascii?Q?yCYMTEf+MlP7MyFFH5LsfuSDUfLXjpENN7rqlNFZuABX/sEUgUdEYgKdPV7C?=
 =?us-ascii?Q?ycFNt6MV8sX+RWxK9zy/sdGBVVe2ysa9jwHSKF5JCmCnJFsXBE9HtOSID1YV?=
 =?us-ascii?Q?c0aEmX1/bScXf5YoIoXBDyZKEEl97FXV/q/c1BebfouGWKtqwLghJf/baWwj?=
 =?us-ascii?Q?f1TLTrZm9E2dJDl9F5A/2+gTwlhxRLvvqw5Mus7ZLzVe3BSfPMW63856BcHz?=
 =?us-ascii?Q?6XfuYt0Dy3+/eZsaASEaAxNgOFWtevaExtmB09YhBWQHFPH0alNWKwuWxDLD?=
 =?us-ascii?Q?u6GzXuWKAXER3yh08f5OmKOMkyOIOAoVKT2ilwDDtjSpNXFIebeIrkkpy7St?=
 =?us-ascii?Q?hAeB2zUGi+yy8m0Q7oejYUQqYhMU36DItSTSTc57yDHo7emMx9ae8nNA4y+7?=
 =?us-ascii?Q?ps/dtKGHg45+DPFnMCjn+6w8RTGSzQvx6mTO4ZS7h0p9w9RavQR+9dJN9bQh?=
 =?us-ascii?Q?97z7i5iNuAy6QYgkQGHEvyoE84fzVuhax1aKSs3r2Iqk6SKmDsrVNDajt+Nv?=
 =?us-ascii?Q?Skgv/afpWr53d52QAWEMNrA9Hhlye92DQJ1IBH3RldJF2TDveWPa9+iFSW9K?=
 =?us-ascii?Q?B681ZV5DBcdetMZEqzM4HRztVpz0pypqbscfGD7TpKOPK4Kq0mQpC4P4X8wv?=
 =?us-ascii?Q?b1IrD6Xpr57PemPKNYCkiPBn7d8x8B0BwYkFV8z6TMni5VeDkgDH28lwVpJW?=
 =?us-ascii?Q?2JH/snY4E+d6Xb8KCgQBf5iA4JGM2wNG3+o9Ho13v4NGHUsxMqCJiQBvYY7L?=
 =?us-ascii?Q?wKlxSpaOIdyTjxhxJpq6+VDO/5S1CHAkjcGilT2K/7jaBLE9khIrONd2MOhL?=
 =?us-ascii?Q?NGYQ+ToVNN68LqEoenhf3LDo2O5XLh1n0aCIy+1bwczEA8X+VqueTCr7CgGd?=
 =?us-ascii?Q?lPeCSNSpe6c+3+DCAM70aAsnlGh/FeESN4aJ+Bw/vTLp+LppavowxsxRd1Y5?=
 =?us-ascii?Q?qPfumHATYb1iQNUxmYWqOt9MOZQ4AJotjCudgKtvzC1+2IXg8cKlyRSvTNwS?=
 =?us-ascii?Q?j+4pbgEPgdM1/dhe2BY8+2AwGBkAwDl71lDjYrw2U/qo3gZxhEJJnHdJAgmf?=
 =?us-ascii?Q?67Bqieci3/tqvgLX1Gbuu/t34cfDQ2QNFV++L97gXXuHgFnRHIwCxiuPc0pT?=
 =?us-ascii?Q?s1QE+2u/cujuHIVcfZ2fgy02oK8xCIo6aRfRfb7Y2gSg0APYgZE66x+p/Co?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOh2bUIJF9TQDFVP/y2SFflrvRDudxsBSFaLMotEsSKZLGavVPsl3pEZXcYe?=
 =?us-ascii?Q?zVtquzSQNppGZUJnhiK3S3t8IeVsERMrBZUDflRBAbToDikHEOH2bu7u0Ret?=
 =?us-ascii?Q?4Q4ja9l/eeTRchajycmFYFe1mHsIJLJa5hjzcKincfR5DDdxtqDohx40RCJF?=
 =?us-ascii?Q?Z8roCiA+NOFvQ7FmpnWoLt+WhYDfbbiDncQFbNxwSz6Ktjovqr2HI1TdCc3D?=
 =?us-ascii?Q?VDp/AkmX6m7luqQbPYbz20nzirNNIrWxmYnpQX41HpvjSR7lZ63kiRZQzrze?=
 =?us-ascii?Q?pcwzd3qShMoldbU1j5HjJg3SbsojzCRkidqSHEZvbmbYibyOEISkwxxOUTJE?=
 =?us-ascii?Q?JWEZWZjAhQakvSGDJXlMJqN91n82YtvjA0qLqdWWV6KAfYwvh3/0PTkZo97M?=
 =?us-ascii?Q?aLOMlDPe2mz+GRYmEFDOe5AYF53WIKaLhX0w3Ly+JcTLRPPx+t4EEgaVEJLE?=
 =?us-ascii?Q?x1iLOliVEAukFQHs/tl7AWNEHtyWE288n3Biuqxhwg22gIlHfSEpzAXPll/6?=
 =?us-ascii?Q?tj2czUvk6X5FU+mtgcqAs6gaLbUh3Ea6vuhERft3X4ji3LLC+ZLYth2qFTwC?=
 =?us-ascii?Q?ws+ZzT/Z1NTxjKl9PXxJ+2PpYdGA9KvF7/GBwXbKLLDdtpa3e/fSx1O1BxZs?=
 =?us-ascii?Q?jyv5XWmrHJzTkVrBLbCMU+ilCLDD97I1Ldl4IFW9IjYvEiq9V8D6sTlmEtTw?=
 =?us-ascii?Q?UVZU+g6qpWIOsu3NXkjHXPU1KonSicTnoohrEuqBNoHPKLPQr5+ignYbmaj3?=
 =?us-ascii?Q?IOc02yXbCWwfMbpBUpwYIe7QvUmDtPYyqiT/chUtGwlnz8i6DxSEOT6G6OSM?=
 =?us-ascii?Q?XIvts+bJIkvrcDV33S4uqmRe1vYjq+nDmFE1Maz0Ns0DAis0srTYPzlr1LBM?=
 =?us-ascii?Q?hfR44GfUK9xGpuY0EPS3M6rr64tw7f+NvkyQQMnP/TIUXQsZNb+a6DXcmddR?=
 =?us-ascii?Q?OCd3oAV0BN4RRYS+P7qP6R7WfRzEIhMJSWT20knOY20KrRXuyOUqvlMg1IZi?=
 =?us-ascii?Q?WKsB4fsUhZI8W5NLREoxrhbt2b/bNswrkmrPPz3kZi4MMRMpgZcJZNeZZ/cz?=
 =?us-ascii?Q?Qi58dJiGFtJ4bmpOGXda6Qz9Ikl8uewBJaLQ8NKWRH2EPV4YMF+aNUFfpK6V?=
 =?us-ascii?Q?+dvAeAsoU6HfCVbktpOkeDGZx+Cd8oYAJK7x+ewcsFrYke4FCfJlHOoXx/qZ?=
 =?us-ascii?Q?Ac884MZK/6XyiQQ+oj89a2PKbfynaepA0/0W9h6/vnOTajKBasDS7xNsl5Av?=
 =?us-ascii?Q?UciXlzZW0ruiwlI99nEMwdqeSBkzaGLgYD/Bed5a+hNP2JYb1catZSLTDM33?=
 =?us-ascii?Q?3S6dh+Z2OSfiQCgYwIURFPFc9sULe6OMpLhmNxZUdbjXnfqRLueXFk8DYsGt?=
 =?us-ascii?Q?i+uWbjXxC9cGbeJ2BPQhs2skuIhKTnpmll/DLcldZU83FvqtnaD2sVH8bsax?=
 =?us-ascii?Q?AauSPxLPrwAiK10Ky8Ztm3hM5jd4l1Of49PUUuXygn1+m3ZrB+Pln+A761s6?=
 =?us-ascii?Q?H/CKu0sB71K1KFaFXhrJC9v2txS0k/DxTZ6PrcpU89RpRevUyzA/FVBfg3lU?=
 =?us-ascii?Q?TQxxh3ckwh9vaMdHyCsfGaCwKbY08Ty3irt1n/qN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vDBLnWk1N97TC7llAJu+dSKrELdXyT3+AT4eOtgqcmzadPza+ExNXkrczy1TQkYJI0ZX6tCyAgw3GySILTzDpHfV4tC5gp8jkvxIhoMpQ0dcbZ7jgg4R86ucsPkUY9E/jEJLQoHKERYQie41a60fZT4EYJtCt4tYZ7fR9YoZu0r31CnaI2iZyOJrFATqF0WjvZpiTQNKCTvIK6HAX+OffIa0benWX+5zeX1cYGETOHPGHtmI8qXV+GHd294/jWl1VGd5NLikyC6pt0e9eId1qgRtMnKZ2xY+3ykiuXvWKuU2c69y626yeax6WjN6zG8sRduvWvMQJxjYcgbnOsf+ywu9reCnCywrW+/YZIM6xgSawxbMC78/9fB8XEHgbdTx5MLPQ+ZhsncZ1O2T7N+kNTKfw83spZDW8RY4Jppo9nzptMRYVc6D67ldwLSeyCUtebWBEeNL892YLvESzPZb/ZNUfkAl2FWIffK3ODtHN9/WMxNqDmixCJfYZrG7a233Zn0vCl5IcrVtsVAlsp72he/JdFcGuwIypOFjfMiJafxnxjI6D/Aa+KfG+6t+hdv9g/beS8fR5aDD1+MxDta3nOKr+2+JPZF3oPcWqQexrYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492b784d-c44a-47c3-3d12-08dcec93d9bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 21:04:53.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXoeaQ2u/7ID4TJOAZ0HNH0e9gHNXUsTyddMV5WQT8oCRKJ27sq+K2sN6kIBoyxViHO8hXdiurvMlodu7r+fuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140149
X-Proofpoint-ORIG-GUID: cpa1CAklrNJBJVtlpkRSndTpv5ojh6Vs
X-Proofpoint-GUID: cpa1CAklrNJBJVtlpkRSndTpv5ojh6Vs

* Jann Horn <jannh@google.com> [241014 16:51]:
> Add myself as a reviewer for memory mapping / VMA code.
> I will probably only reply to patches sporadically, but hopefully this will
> help me keep up with changes that look interesting security-wise.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> (as discussed with Lorenzo)
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 659aca7cfad3..6978444f81d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14918,6 +14918,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>  M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Jann Horn <jannh@google.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
> @@ -24733,6 +24734,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>  M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Jann Horn <jannh@google.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	https://www.linux-mm.org
> 
> ---
> base-commit: d4e7ab0ed929645bee32538532039d3d451efb00
> change-id: 20241014-maintainers-mmap-reviewer-82a031ff2425
> -- 
> Jann Horn <jannh@google.com>
> 

