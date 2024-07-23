Return-Path: <linux-kernel+bounces-260435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D793A8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FA71C227A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179D146D4C;
	Tue, 23 Jul 2024 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQg/Y5Kb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RsqpFswL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918BA144D36
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771982; cv=fail; b=FeAioHMayRGytSU/3ZmIbKUpASVVxdX41SFXYwUccr7EcXb0phkuhd6gmMyhgTrcreZ7kTkzJnROl9kUGpwyn8l/PyJkPN/IMzOLQOr1ZYT4YCFIzJtelsCiTQQDua/Wk7Ftot9vgyWRaYSphA9iSUTZjxuLVj3HayMGbLp/X1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771982; c=relaxed/simple;
	bh=vNUssxZlRgBEwwTZWTHuCGMKYOFRKyrNPKnfNdiSZEE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hTwXnIn3YQ2wZSU/F2sJXigR7GWOjHdOxku0OW1EMEs+f++Y9F5d2GN1m32thetonodKdnVYxwPbWyHjrm7QDPp0wj9nM67kXW+XPbjuk7vRKZcImXHEETsdXnU798Tgz7jgI6p6yWtHzp5w1Apj6rYS8qAUtcZuQEmQA5NKa1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQg/Y5Kb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RsqpFswL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NGQTKm021304;
	Tue, 23 Jul 2024 21:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=R9F6Y+tHx3ZHdAvncBoD6eUIxwTMNbF4DEpsgYH5SUM=; b=
	gQg/Y5Kbk+OrcWLLR4IkGuVuKswzdRXOC0DLXYKBEztWoff1SiH8gpExKkj4Bpfw
	JHKITvNLwHP4ljC1gC9e0+i9QZCl3gKG3JcJaxG4tNTrtZnWQl4CoJUpTOnN/2W6
	/E1ZN/p5IhMi4rxtz2O0QNAbuJULX+0RMEG9hpNl4ArCTBp+FhbxoOXOEvY8MEQV
	t1g0mWdfHLZHkQGFKpgd1KKNrRGR++3icv74bhH2yRTI5zYpSFgTuoxXJ+bm0rcp
	pQR0MTV2llQM8XXY+Ll3vJPy6URbGxD6eBHN5FTmpaYgkFpaZUtWTy7XKSL4tGl5
	Bm+YLAmO7zY61nD71mOJgQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpfx4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 21:59:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NJuB12011195;
	Tue, 23 Jul 2024 21:59:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29rt07y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 21:59:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZ8BuaKikogMwOgDfnI5rpb4L2UbhobtPyWZ142mFPC2QGkH/hGEn3GQC0TuKl0vZ8Fo14RH8wE08zzBmTSt/FDpu1Q5Vst+5IjOaIc4g72Qbi+xSvOLtYDiZB3GKyjFTtEowoJOTiH6WFSfIwCJiKm5L+iamD5A9XnCSJiyw2K4uU5GARqAsANuTS/FlUyP/qsfan378zDkWOcAf19km59hb8EdvtfbCtZMSTPK+jDZunShm7AyOt89SLYgwMoMbgQnfLPwbn2URsZvhYYh+8ssQ6xEtos423oMGmSm0PEk8PwiLc5olv4ygO2Nu8T9OBohnxbnra1vWuKYXAHjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9F6Y+tHx3ZHdAvncBoD6eUIxwTMNbF4DEpsgYH5SUM=;
 b=sTyPvecoRBDpkSianQfzmojJQ5UzxJdSaiaRZLemUZi4tOeZuU2BZvr2ocV71/tQAzDkMzO8627HAXRg300p+04rIHVWL58HD1lFTIYxbmB77FC5sSbH0q/mI7pyRvfox788qcQ45+hpYqjhP4I8Fus2RRAjs+E1ot7XcpzRj3Tdm6Tn8tJ3i6vwmmK2xxuxxsW0loMEVr6z9pYlM5G50HU24KCC2UE7jozgRVLyiNPYMt+000gzPbXEwXStCk4FlZlpQLG5NCOVYI/RfwXdfLA2frs4fX0p/zafuCSNuWWmqzQTBJz/PlH/AWrY/cwOgcAh0tMYpmY4rfYyCmNY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9F6Y+tHx3ZHdAvncBoD6eUIxwTMNbF4DEpsgYH5SUM=;
 b=RsqpFswLrh1/tu3qxbqoSbyQZAgP9cAjj4HPwLqV7J51R3nAhgpt0HK7vW0mc42756Y0yw1m9jGyFz14pTcizaE7ZWih5Mf1HiT8kUooMYAclYD8mgYR4duJnG5yykPwxrs1MCCeFmniY/n2KUDj9sPNn14cy6PeoISWAX6+2Hc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB5643.namprd10.prod.outlook.com (2603:10b6:510:fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 21:59:19 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 21:59:19 +0000
Date: Tue, 23 Jul 2024 22:59:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>, david.laight@aculab.com
Cc: Arnd Bergmann <arnd@kernel.org>, willy@infradead.org,
        torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
        andriy.shevchenko@linux.intel.com, pedro.falcato@gmail.com,
        Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Build performance regressions originating from min()/max() macros
Message-ID: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: efa17ab7-e458-4815-33cf-08dcab62b3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vyzzA6h+gKSpCr7eUwl+CS4HIYVcGjswlt47FypB6qTuXlVZ9AdKAyK/0C0+?=
 =?us-ascii?Q?CIy5p/CX028DF0D3GEBlPunmpC6sj+Oh5ivlmK2uB+2D+UuHoXQ8CbzmzK8k?=
 =?us-ascii?Q?Q7zbu0KKjrV/i8Rg3tL5kXpVhThN2fKNjnYIZVEsVt5bp36/c7WJhCFAMS6+?=
 =?us-ascii?Q?13rNrT2QvKZ/QdZbhxa2CaciOmGALE2kRZkICVsNtXDumPMwlXa3auBtd3BK?=
 =?us-ascii?Q?z/QGHxGZodMX+b1nPG6bMIp+SnuR97OLXU253cyl8tJ9ahiklO7vbsaioUlb?=
 =?us-ascii?Q?FBpIUBPRrelmN7n8FfmFx5x244dd810QJIJrgxAb7JFxGymjvYPIPQDHAPzX?=
 =?us-ascii?Q?6yhSyq8UmYUrQxaTRYZYlMHw8J5XlRuuIoiSxm09/cofUwqn38saxya6VTkK?=
 =?us-ascii?Q?A7heCh8cV7keYLLKWzmQaN4BbatkduH0KfFUpsTW8cjrILPOQq7PKO7Q6TiU?=
 =?us-ascii?Q?pwewrm9FUm36w9+sXrNaW/1NpVLrxFaIMt+8bDd9CCAk42k7ET1NZQ6/CHy3?=
 =?us-ascii?Q?5tA+ibzbA46odUAP1WqIqBG4wTOorLZrSYP8VQqGrSya9XFnQ6GiCRIgqGns?=
 =?us-ascii?Q?PM/+b7nPhjzuS6qNntBSHv639ucnTWrik4CUBb1UmWBi3/IMj2FJzS+Tz78N?=
 =?us-ascii?Q?9Kp0rEvdZGo/zDoBPdDQOwVbotNFYC5S2ZVTc56qwPz+SM+kcxzuofQYAZ5O?=
 =?us-ascii?Q?ZqeIDfMRS7jT7vwg7eCn9CpTht453T5+xdkaHEMZ0FIM2bc9k/MX4KqsPBqL?=
 =?us-ascii?Q?ePkBV632GEj/RxBvjif4j0Hrh6PIyuAKqpRVoVVXxUYu3h5jgiSF64qh49qh?=
 =?us-ascii?Q?IirToGdQjFIi+ej6KUor8EnsWD7ubPySCTSA1C8lXdOALfhqygDRqJEwMpyF?=
 =?us-ascii?Q?e3LywGB2GmMQO0XUAg08DiDIC70hn5hoXQd5/6HCyPo5g1gLYOvusxSVafoe?=
 =?us-ascii?Q?A8LV4FaSslzfPB3asl1hKKZmCigBh7ml3Jpr15MIFToocCnTrv0R8ODRbZOz?=
 =?us-ascii?Q?8gLBh3l8Yum4J2ipLktUOAGWhL9wmjOoLqVBV/ySs9NGl8Yt9lPmNT26NKvZ?=
 =?us-ascii?Q?iZDafn4WpuQUCh/tkGBu14Z7JzLZ0ejJEdujWegbEc+kKf0CFuDR3DoYryYL?=
 =?us-ascii?Q?JNYEFmwAuqgLAsNnMyuzdVsjvS4UGLCwd+g5rNIITVslS7WIolpJlmwnabZJ?=
 =?us-ascii?Q?vz2m6Xwp0zaXHcj4adTxiYRKOSzCTdal5ACvvridBcCNvOacj0zwOk/Fa70h?=
 =?us-ascii?Q?xTAAVt8VaGjLtk7pTkn5ns7+lDaWS/XVK0+sYZGNup5OdZk2CXOiYvRLNrZv?=
 =?us-ascii?Q?kno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrREHIxmfJF6fJ9Hoa2ztrfo1XiHUsYtkhAghaUjM9pOhj1TMQiA6K6TNuaR?=
 =?us-ascii?Q?7ERma7Z+z5IVCwwQpTjCfDJlKQjG0arQY5GLb87MKZ9sj4PGiHKLo6qGYath?=
 =?us-ascii?Q?fIC9wQpSztRT/WDlGHzz/nWDPCKI9IlVVZxHxiXH8nrpkqFRXak4yA4Tb9LB?=
 =?us-ascii?Q?D7Xe9exEq3tUYjjSm/XjC2D+QqeaVRcVpQR2H/VadEjvMX9d/StBY5YFHR/w?=
 =?us-ascii?Q?SDlwdEeK7KyqMPz3yHfAd7BuZzupbHJvHY+Ys/lVN1Dv/1/RapQZI5j9qKeL?=
 =?us-ascii?Q?fHRfHYG205vI1563Ca1gDKkbYV/ctpd0faH/NX14Zu2FUiQzT/GXelMHJWpw?=
 =?us-ascii?Q?/l66rUuIOQcFMA4N18tmfxxW3a+zw+Fvwd95PjcB7Ucw+1diedID4nmpd/vj?=
 =?us-ascii?Q?tikVEsNhetRMB9rbDFrWMxF+mFoPolkqGbRzjgQ4LMaVJsjsUOr0MmUZ29nE?=
 =?us-ascii?Q?431txzlQzw+1bqgRN1grrpRJ3w8X0GSyFA189gvbzJK02/rDhbOgpgHw/Wy+?=
 =?us-ascii?Q?DR5LXgn1A3iyADD2/6tdJJWdX8NrHXqN1leRzZYdCxFvLNoAKc1ZG2ZscnBE?=
 =?us-ascii?Q?+4ddt0nWf4BRx4O+HF5dHztcIQCr4DHxwQlr/9rTbaY4v3KH3SNjJCYDka4u?=
 =?us-ascii?Q?Wran9nrAXkFpQsveO9IQduScv591hfQf4RbY9ZfgqkrV/k+fNmtClv8jhbEc?=
 =?us-ascii?Q?6GODdQgFzKEx/AkAvGOxQI8RJg9GaHXVJ9CHjsC7kdP3YF1aW9ilUJPBV8AQ?=
 =?us-ascii?Q?NfaQSY85BR3Fxs+NAIqlaso+zSUtKlsIe3o6BO3MCUV1n5IMTeLhRjhrVHF3?=
 =?us-ascii?Q?fVCM1ZS4wFQ+XSFYfa7ehp2r2eYdfMOFd429FMPXmIgTjhfGoPXerA/wTjEU?=
 =?us-ascii?Q?Z+g5ZyYHG6upWtjpMhn8KgClPehciwJqQGFGj2iwtmI2gb3/BRC4tyAhH3Jp?=
 =?us-ascii?Q?ZZCNI0AnsytLiOcEQ+OvPmZ3Hz1v/8mJFCl/MKuOU3ahRXBvUF8QGzEcI7YD?=
 =?us-ascii?Q?1tzo8KXOOO/FcsYwBkMy7+jh6ru1rtldJNxTGe1+5L8+bz4BrYOYbkmWJbag?=
 =?us-ascii?Q?zkubyBaIUr8zkKUqhxKe3GlGKcM6NCMPY5DXM7bRfk+Cduu80fOfMXsQkSi9?=
 =?us-ascii?Q?WctF7olAtW1IRNHC4czthKV1vL4gfAqd0XMQ/PrYv79gO8Unex7ZRN3+zbDI?=
 =?us-ascii?Q?6u5Ivh8jxVzX7QHZ1ng4K5My6kSIBxiVIpoMMhrwk9j0AyEdfAIF29rLBWWS?=
 =?us-ascii?Q?pngv0xjBw0uu+FMhunXRdoO2kzsQi4HhZwhcEhLb022OrOdRy02vV6daCSG5?=
 =?us-ascii?Q?j9rTvauyblPBYJplvJV4a+h0gImwhBG2AHWHBCyfMratfzkxii81YHrl9axz?=
 =?us-ascii?Q?Pjl/O6qHRlMktpaRB0rAmGnJD/Dx11BI+8XOFM4QiniRB+ePIsrPxFNFqmOW?=
 =?us-ascii?Q?G9Lz841r6u9OMTNBDr3mtDGkqICFZ9187fuNeQ7yzshLI1wQ+ozLoPVWOxyv?=
 =?us-ascii?Q?t578zSTXwGlvOXPVO+bj1Ry1yBj/uqvZ3iJTqlpOPcHAk1+Qjt9rtd+/gCPe?=
 =?us-ascii?Q?vU7y7+KvXLfrmYgXBKHXZI5GC9RamV+mfdHukB5EmFMGoa3a/Rg97/sIOEj0?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0MVUMn2S/Q9n9ljFsdeKZ64WWTHYDhtOMBkB+2eZCtvgZlDhpqaivwae2L7DaE7XSnOPqXNQlCeZhj4CnAuYxywsabcCp81zLqEFyDmtotGTOD4c3n/q7BfeQY1l69SCXoapddFeLSPzhqA4Hs0/538Si9A4DH2L5SkVKW8K0/Jaxpk8F4XSPfXnVx11mYmrM55xzMy6fJULrzvdPaHNLZSgJkPRbrGg9eNxBdlIwiXnjrvWVBR46l74eebsvP/5kpo8KB/X8yuiPuzw7ZSAkSli9i+8q52kTb5Qfs/6lFKlaboVZG6tJ53/gyTIZWkBySH4nqD28eeZMahthQrM+1rrRUZsWiGYbWr6c4NNkZ3QkWeDgbP/sv0U9+B6HnX5dOcbnHKG9uRkRHSV4zS8V3RhKXbqtLxoB3UC4tkCVhFHE5MIe6va8IVQfyyrzLhW0BepmfVsAoOHys0/SJlgP+Afa+ECt07cvrx5Y33kgZ/hKvgF9J1SuSvS6dIYLDn/R3nahMqdd9eM/31VLY3bYy5AfQ7jJoftB3DW1FBRhwfscaVhSxsKuZ6x9FjTOy1/OR5fXIXC5O+JZNDhgkxFAlXsb+AOiJ/KqHuBg56AlIw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa17ab7-e458-4815-33cf-08dcab62b3bc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 21:59:19.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT4IpnLGbPJihaXcZ4brCB0U8tvfissSjrElO+RiCFNgp4Nxl9WRVC6R9s4uh2Gfed5iqSzFsnY6WyZf8KEKN2ADPGnBl3km370f5UJBsFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_13,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=939 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230154
X-Proofpoint-GUID: HlMcnca916AJiI3MuHOxOh2WzkbzwQaB
X-Proofpoint-ORIG-GUID: HlMcnca916AJiI3MuHOxOh2WzkbzwQaB

Arnd reported a significant build slowdown [0], which was bisected to the
series spanning commit 80fcac55385c ("minmax: relax check to allow
comparison between unsigned arguments and signed constants") to commit
867046cc70277 ("minmax: relax check to allow comparison between unsigned
arguments and signed constants"), originating from the series "minmax:
Relax type checks in min() and max()." [1].

I have reproduced this locally, reverting this series and manually fixing
up all call sites that invoke min()/max() for a simple x86-64 defconfig (+
some other debug flags I use for debug kernels, I can provide the .config
if needed).

Arnd noted that the arch/x86/xen/setup.c file was particularly problematic,
taking 15 (!) seconds to pre-process on his machine, so I also enabled
CONFIG_XEN to test this and obtained performance numbers with this set/not
set.

I was able to reproduce this very significant pre-processor time on this
file, noting that with the series reverted compile time for the file is
0.79s, with it in place, it takes 6.90s for a 873.4% slowdown.

I also checked total build times (32-core intel i9-14900KF box):

## With CONFIG_XEN

### Reverted minmax code

make 1588.46s user 92.33s system 2430% cpu 1:09.16 total
make 1598.57s user 93.49s system 2419% cpu 1:09.94 total
make 1598.99s user 92.49s system 2419% cpu 1:09.91 total

### Not reverted

make 1639.25s user 96.34s system 2433% cpu 1:11.32 total
make 1640.34s user 96.01s system 2427% cpu 1:11.54 total
make 1639.98s user 96.76s system 2436% cpu 1:11.27 total

## Without CONFIG_XEN

### Reverted minmax code

make 1524.97s user 89.84s system 2399% cpu 1:07.31 total
make 1521.01s user 88.99s system 2391% cpu 1:07.32 total
make 1530.75s user 89.65s system 2389% cpu 1:07.83 total

### Not reverted

make 1570.64s user 94.09s system 2398% cpu 1:09.41 total
make 1571.25s user 94.36s system 2401% cpu 1:09.36 total
make 1568.25s user 93.83s system 2396% cpu 1:09.35 total

Which suggests a worryingly significant slowdown of ~45s with CONFIG_XEN
enabled and ~35s even without it.

The underlying problems seems to be very large macro expansions, which Arnd
noted in the xen case originated from the line:

extra_pages = min3(EXTRA_MEM_RATIO * min(max_pfn, PFN_DOWN(MAXMEM)),
		extra_pages, max_pages - max_pfn);

And resulted in the generation of 47 MB (!) of pre-processor output.

It seems a lot of code now relies on the relaxed conditions of the newly
changed min/max() macros, so the question is - what can we do to address
these regressions?

[0]:https://social.kernel.org/notice/AkDuGHsn0WuA1g1uD2
[1]:https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/

