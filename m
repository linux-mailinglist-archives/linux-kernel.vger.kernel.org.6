Return-Path: <linux-kernel+bounces-357551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFAF997269
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32672280D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C71E0DD0;
	Wed,  9 Oct 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mzdv9wSb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GR1ZJxt6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7B1E008C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492903; cv=fail; b=cYAySvHLE2pon2Dmg6ldyfzrVwim3Lo3krVHu7lz/UjxS71HFpZeoezIsWamiSMlinqkg4MI8E7isgRX1psZD4LHPm0tfuhlP9inC1KMunywxpIXFHBB7J0LarqRfAs3/dsZ4zZXEEhp/kfn1VJkOV5O1O3C7cIavCJWqb5G7TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492903; c=relaxed/simple;
	bh=1YbLz2fypZqGXkATx2cckN6wu2rN4AkDYvJUBA0h9JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fmckSq5tLOOkydoySoNFWGiy8fmv8mm8F+i+JR36/3n2t7DOs/x0oSj+UUk5MpX3Qg2n2vsGV+H143a+DTl46Ubl0negp0nYkGDV38M6rANMuJa+8zBw1/dm0csQ0nfGSL/DX38utLsv7uOC4CalucoQwJodPb79PukOSYyvCVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mzdv9wSb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GR1ZJxt6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499GBZaI013508;
	Wed, 9 Oct 2024 16:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=unuUoaUpkVYJi0lH9537P+r5+dXAKp+PWiwYPTCN6UA=; b=
	Mzdv9wSbc1e/ATSR38D5g+8HCA7Lrusn1H8x/lbaE11aj7hAA6hTp43/TGWto3HN
	3ffev6mY5mpiWTqKjUogugUqVBG5LmPGWvnu0nF3uQK3zhIvzZCZkXOwA2PJP+Oq
	yoj3D8RTPsdEio5c56fW9KCaMzFsKua6OQNzZza9Jvja8e62Ow0E1JtSGu9NDDgy
	sEzaQrNNRdW/ZGpkLmQmncZ8agfr9xoYIsjLQebJnwRastNiPVlM5wmaWyBRysMb
	EOhrRaeIJgKVC//FoOv36WFnN1ShWnwepvOIikOWDYcXYE2PGl+lau3gRFQK93xs
	/yDM0OXelKTen3rG9ZcKMQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e0w75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499FedFS022916;
	Wed, 9 Oct 2024 16:54:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8ve1j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 16:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyNOV8ztWH246TxWapU8h4DwI7/mQxDq4OuFuqluflwgV66FEQtZCbCnT7tHl3a+WNBLqCRfJQC66ps4zkjOJ8DgbNLPfrC5KtIdwyr7xvgcd4lxxHquwry6zBSYmDHclh90H54x4Ot9NrL458b1i+o6S8N9tJDRZKo8L3Tz560TDZYofYL8hZWYnbjcG3fkIlhHjbcD1X6d6j5BUPnb/GZn+6YUtUvY7Uc2Chhhe0C+GzdfTL8zrQok3x9hP0cbjHF6Vh0mJUSrpqSxqc2XIXjJ3XfUrI2uzOUHcE9wj07ItQGZ08D+d0uREN6UIFezPuEuyX+IpUHXxb6EDTzBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unuUoaUpkVYJi0lH9537P+r5+dXAKp+PWiwYPTCN6UA=;
 b=xl7zbIOcjD81PKgIUJhhqm15qpB75t/jcKDZdyIelFIgOAZO2JPNOiqnlaEkf/byn5xu0xTz4h2L90PFadqhhqK22vJTBMDgf4X1RzgvmZBnq5yf3gDYJG+g/d60dnKYqb7pWSpQv3NYBU1vPe0TqcPGKuN/bSn/a8eL8Ne2Z94D6nMUq0M1qd5NQh2brHglk3quQSbkcWW2G2TbQ9w+x+b/IVfdekaurm4jOZNYjsap9+zHYZSVO3/20ONPeHpoV4FNk2ELP7rnf3UXZa13OaPeGBOaCnsyR0kqQUE+PrGMSjSw/dXpqRW891uVTiCt+Xq/xLef8NRsS7CEw/0gEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unuUoaUpkVYJi0lH9537P+r5+dXAKp+PWiwYPTCN6UA=;
 b=GR1ZJxt6Z6Z6/XzQUD3VxCV+CeVGug6lIBIz3ropN9cAeUwPJmWmLfwq6SsuBsuT+zSLd9GYivFBBn0akd4XvV86XYW2bQAXylOz1DyTAusN+L6HdPAqwK8snVB6XabRnixD5Yp/XETnn8OoEOwBVQqAP+0O5fw5XUUFslG9+wI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BL3PR10MB6044.namprd10.prod.outlook.com (2603:10b6:208:3b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 16:54:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 16:54:33 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de
Subject: [PATCH 7/7] powerpc: add support for PREEMPT_LAZY
Date: Wed,  9 Oct 2024 09:54:11 -0700
Message-Id: <20241009165411.3426937-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BL3PR10MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: e28a837b-5985-411b-d73b-08dce8830cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qgcjEIT5N7xMkOvGdqDwj+hOOQLNoBdNgCCHuu/XMXCBs+sgX8Gakt0D+Spe?=
 =?us-ascii?Q?PklygFTHhzfM5yv/uMRjQ9oyj3ABBeGMwJ8/fKraPM7YtLpmAfyzj1m34tty?=
 =?us-ascii?Q?Vt/m2NTaFOaWYwxJC4VTho8IPK+h8y6NIUaAf8fHxV9Gng2Lj8Tf02QHhmkr?=
 =?us-ascii?Q?665xnQpZRBSlanPEaSCgdGzONI0S80ELDWXla9kkxYSWric72jkxXaWJhzf9?=
 =?us-ascii?Q?FgrDPMmiqzPkfjeQCwGzB5v9X7vLoAQhu2B5DgXekGfFfQgrM1/o7mlA/3XU?=
 =?us-ascii?Q?iLXOeZU4ETTVDBN1BvBpIUPv1lk9HMXbYxzfvCovru8wIm98cT7ouk0+3gw2?=
 =?us-ascii?Q?UFPimw3uCAgIKKmitS+L+L6ZQUofVYak4xf1k/Ge5IP8P/AogvsORq2dhntw?=
 =?us-ascii?Q?Iwce8tPF9KtvVX9VSGRT7r7vfGtFNbF5Nz9A9EWEn77f6DyT+KTJKfW+dYuS?=
 =?us-ascii?Q?I/8Y1sqz/8XSUDNnaeVg6yBy/ugcJl3G+i1LtMChwkZgHs+B4xJ0jPdyYBMI?=
 =?us-ascii?Q?nmITzICKvFggYeSEkDomI1OfvZKN9zBZBJv0DFUC4ndqZPX/RipfBiXcQYBZ?=
 =?us-ascii?Q?cn8ZSuqMlu26Ijf+SAjFXtsRFXlc/ezWHtHa0kgMl3TqyKx9x1B2wC/IxB/5?=
 =?us-ascii?Q?8p7cHpQEZ1ZgeppIXypika534gNyup+A6VaX6sG/SkYITYdEXFTYLbEZy5i8?=
 =?us-ascii?Q?S6x1DYcLFVVwVL+QWhWW1i4TIZB44rrlYvqbXsBfMSlAX8JyTbCYX7ouKiP5?=
 =?us-ascii?Q?8SrNYsS0909f8Gdoi5EX6FfQGiYK72xwR6teDnRBEPtYJjyGLzrdv+dDmmLi?=
 =?us-ascii?Q?bb3tnlLOiKFYFweG3Iu1tRXTvEvdPXqq+tAXwQj6eDD7m/KvEBTkyJIHSNDH?=
 =?us-ascii?Q?x+KeCJoRxkiq+Fyxc1gZpTnR7sZtnAa1ehIA8vqk20SZ9ewF/eOCdY4yiIS1?=
 =?us-ascii?Q?/GXA4w4JK8LxU8Vr7mrcAatSt2xm83daXrUzaSsd2yQthvFvrUuI3K5B/iVk?=
 =?us-ascii?Q?I8+hN8Ahl6yl3udzLEhCEUpsHmQQbSxk7VQAgc8KvM8fDWNZyOMTEmdAIc6R?=
 =?us-ascii?Q?ncpVEHW6QNjS61e1sTkpxApQErcSMx1QVlN/bBUcvW1PFMVsBdi75jKuMaDM?=
 =?us-ascii?Q?Cl+sCJmFG3I+ZCz8IK0opxEQ7pdqsk2G9k8mmAD34JIAr8jJL1SEQhm3NX6U?=
 =?us-ascii?Q?DnK61jurDTG1GkjV44jQA0VNAjp03YKYuD7QBeEOKiHnYDBNJDu8IW2b09RF?=
 =?us-ascii?Q?5J7mkbEtqa5BwbFJiEO7/PGmHvuybVu4HjV6KstpOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iGV8RHHzZ5FDjgky6MkQTcWGu+Ib5g2yM9/mwyq7mcA+0XdQ+zrCrw4v0Zfu?=
 =?us-ascii?Q?DM8eavxuDvL8JvA5VDFSjE8AFWgWyVc0p+bvWDjHOt+l35OK0HhTTK9ayv06?=
 =?us-ascii?Q?8z62SgJE0WDdxZN0uPjol81mTMt3NOSZS7L4qi2rvBdNyGFP00ZtNQ/OaABs?=
 =?us-ascii?Q?PRwjfCTXYJXhrT/QYEXG5yFHr9Gtrp0I60OXV6hVBGfK7+QUhqVuCTboF9Bf?=
 =?us-ascii?Q?2OW3oSIifIbUB4ygiXk2yj3bLwFacN8pxjqMRqYyMyqnOljOtSYHj5qj0E/x?=
 =?us-ascii?Q?jqJW30DfdB2GtQfzvlSKt/2RzE7o0tzuBIi0l6sAfNfs16UvXUtUkof3QCdi?=
 =?us-ascii?Q?VlUAYWPx+warbqlHcApE24IT6CSV32BOVMthbXY90z9ML6VCVGvioDW07jbx?=
 =?us-ascii?Q?93ycFgkn8j5BY0uCLu2DcnYLCz1D2hd2wCH3AL0e+qKS937RutIj1xL3YpmW?=
 =?us-ascii?Q?bvgZgzNMZaiaemrTDasFRgH2J4Is/FVC/NLjZ8dvdjBp8bsTmeC/gcVSmY8A?=
 =?us-ascii?Q?fFnBW1I70ADyiel/JPnSj5fe6VvwA/zoTwX3pFKI4YF3QbcvfIQSB+H9yIEf?=
 =?us-ascii?Q?3Cc3wkXIUROjConFDbdZFp10b8Y+4uCq80M7bQQxDBNJhGqoPZY0tXiSf3nK?=
 =?us-ascii?Q?DU3zti36KP0th1nh9rdR6W8JSBeYImLZJgQGD+7aNt8atzdebaPd2LTDMzG4?=
 =?us-ascii?Q?/o7AFez28IHkiOcLp6uOCayTNQIdk0wvNdFxpHVruEjrqsuXa0pf7+cdC+9N?=
 =?us-ascii?Q?p685xtaGHWPwvU1r4xjgq0k5IPg7Rg/ctvwykzZT6VdR1t5uelN7eyZ+1Ol5?=
 =?us-ascii?Q?qfpZXy3jjZRnJDE8plutPQxGGJwiDkY8ckimFIQxk2QTLo14fyIlHB+2dqXM?=
 =?us-ascii?Q?Wgrjm/334hMzRe8XNS9OZXAMbML2+n6ggKMK70hj6nlnLvJhS0M+I30MOtd+?=
 =?us-ascii?Q?Id2GK4i73FyGjBHAPD6V4DjPBdK6NQubuC0Y3ULqwXzwzYDTGGWX+i7NFfzR?=
 =?us-ascii?Q?owRwLY2ugc6O0w2LQgEuhqmYAiQhq3595TfCF2E1Mf6q2B5kMrt9gWDfv/XP?=
 =?us-ascii?Q?wvylzU5sYPNpY1odyPO+xSmIEJu8hUqACH9qzAhDSuKPyuyYmcVqzFYHCVCj?=
 =?us-ascii?Q?H0vX29ggImCv7yPPuPCpkVZa56U021Y27XhhWMHH+4uid66e/DN+cVK491TN?=
 =?us-ascii?Q?gLIjUM9SscJw1tCCRFvUfZya8JV89xmCuJtLpQB8RAuc+RBQXEbQ6KhZSZiF?=
 =?us-ascii?Q?AvBb+DZ5yeuDE0pIEdaKXiJ2b5wN8swc55ab2CYFLCpimj+XWq3b+1K4/8X/?=
 =?us-ascii?Q?3crP+A3BVmLzFENruQtcFEOMydtFMJs4ucZuiiIjHCXKd0XFaj+h5b0No2rm?=
 =?us-ascii?Q?R3kGnr7UspEcu0Ta4fIwUwbgZMND9Dy6/WZ/EwsvuRcaRBd8cJVcxjw01GUJ?=
 =?us-ascii?Q?GdE3hmw7jfzEt5FUNoJ2LZm+Y1m6WjXySYctAb7Bkhp62/8Yb/abqREf14Bq?=
 =?us-ascii?Q?BU1p3YScHxa0fOdNtR5k27t87Hg72NLmPuo2qMQlqvbOZ0qgIH1EKiQTUBmy?=
 =?us-ascii?Q?X9i2BFs6onejBPAgulorfevFpJkfRu9jImSq7yI/h0C3sJs0Kzzch1Ph0gbE?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ctlzRu2P+d7fEhElTpcpNw2/ITSKe4R2BWUp9IBcPxb2MoA2DIOhy0YrYl8cWj/YYnvDafxxL3mWkp0pic2GBrsfecPyfAGxnT9o1mWg0Ki+RxwhpiHxcCHnKckbVAPIfgIbT7ScS0RZZsuB4+VKFnRoZqtPKGxYdlqIC97D6lJIuXTkFPM/lIP5lc5WdJVyqNgHXJK3nX8ZQmT+igDxMoWRooKyeykI733PJdiOwumWbH+/uhd68MIrFA89H2CUv0oAWCjoDM+VPmBKuA+T57wm11FWeWKXqD6mQ+g1FhAOm5RbvB96vLrxBdVR8JOmmCqi9zmm2bcHaIbWN1kKIYillOVm3E9g9iKPfvYlYDkLS98rBheXowzlTO204/y4b9cARK/m7H+RI1xoisrVU/zzkyfuZ4edQ0oL/XIxSlCAoKQxR1xDyxm7tR/YZDoWbLPWpxzBtOehFSCmsuAJq6f6Dga/0UovRRM/VXyb7IhMPF8tQzBXTYkTwJVdC04DOtLUuno2/OsAnicLktsPwGOJsieGdvYTdg9HDoxyT+DLlFfbUEdXy7clvQpwtgcGBqF/0CDsHPgMv4Txor399di6Z3972Om3KBq/fUJMWrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a837b-5985-411b-d73b-08dce8830cc5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 16:54:33.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+vZTizKsSLjfpMl1D/gI0D+uwSoVACWfRhdRJJMJ2f75xCYF41AGkh95EuEAPEPEUOiYLFzdKvxQlhmpZKa4hX8ANggSfSXFkyjz6SWHls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=775
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090101
X-Proofpoint-GUID: s-WOBoIYDGRgydoS06Dnzhirnrq-nmPQ
X-Proofpoint-ORIG-GUID: s-WOBoIYDGRgydoS06Dnzhirnrq-nmPQ

From: Shrikanth Hegde <sshegde@linux.ibm.com>

Add PowerPC arch support for PREEMPT_LAZY by defining LAZY bits.

Since PowerPC doesn't use generic exit to functions, check for
NEED_RESCHED_LAZY when exiting to user or to the kernel from
interrupt routines.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
[ Changed TIF_NEED_RESCHED_LAZY to now be defined unconditionally. ]
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/include/asm/thread_info.h | 5 ++++-
 arch/powerpc/kernel/interrupt.c        | 5 +++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01974cc..593a1d60d443 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -270,6 +270,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RETHOOK			if KPROBES
+	select ARCH_HAS_PREEMPT_LAZY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 6ebca2996f18..ae7793dae763 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -117,11 +117,14 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
+#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
+
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
@@ -144,7 +147,7 @@ void arch_setup_new_exec(void);
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_NEED_RESCHED_LAZY)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index af62ec974b97..86fe60295de7 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
-		if (ti_flags & _TIF_NEED_RESCHED) {
+		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
 			schedule();
 		} else {
 			/*
@@ -396,7 +396,8 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPT)) {
+
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
-- 
2.43.5


