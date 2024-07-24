Return-Path: <linux-kernel+bounces-260765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3948993ADEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 623EEB21EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B9A1428F4;
	Wed, 24 Jul 2024 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IkjtZVbY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ngQNDgZB"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CD17E9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809920; cv=fail; b=n/mcPt++UH8+8+28VBYSQ1T2a4hH2+SnUaHZ87cDnuZ0eIRSgHWL3XOZ2IF00ya6NNlJYsw5GtrkZE8lD6h2Ht2VfPt4+bf5Xe3vy6Iuji2fIsuK7R6bASk1/yOXMR8l5MNax4p1jOXHqjd5U1zYxzeMVeVFknv9/MxYRCrVRno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809920; c=relaxed/simple;
	bh=2mZuyVtoGZlZnVYmrV2flnLfC77IdAQQ/gOwU/i2/cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z5Cv+gbX3TSBlD12DFdzEmUAX0nyJfR6fVo0M5h5TPH6wXDybjmDi8gG3NdwiYMmkYA67H5/NL8BozUR+/wBuQ21q7X/obIoOBFfyPZ6OD1C3uXcCOU42G6ujGVvBMWxpuaUXzhzoM8mvB/ikrZzVkntVt2zEqLqYTX30bFLwH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IkjtZVbY; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ngQNDgZB reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5odYC002811;
	Wed, 24 Jul 2024 08:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=2mZuyVtoGZlZnVYmrV2flnLfC77IdAQQ/gOwU/i2/cM=; b=
	IkjtZVbYqhzB7i8asfLz1z1j85yDffVYylDB5FGt9OmC1SBit5yGnu2ixClS4KlN
	maYA7CEUKFSQVi+XFmis0xeMAzBkcU8xUba2g5Co1LbtDKFP23SzTCh8bOUnC49t
	6NVHu+zKt9YGVp2oUP23m3h5PDUjEiexz4LQuQbgcOER9/9cnlKdlDjWpO9UJZq0
	xyLxCVEWzbbL/I1g0hlsrSrNtNY/GGEHqsyYIHLUSNRmkbKousthF+9FNdYW3NgA
	v4hIofOYve2+UbZXS1PuY4/y5Y/haw2ivIhnn6rySdzLwSjIy+a4rKZZOAyVZD9g
	qtXdC2A3zwQKa5/gkcZ4Hg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg1107d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 08:31:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46O89OdQ040022;
	Wed, 24 Jul 2024 08:31:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26nhs0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 08:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv0RcivcSpR1u/tH1VLv2FMuEeo7PsUkSzHpFNzsHnDM21JbZFzwGEXhOpLKcT7FMxC3lc6h+R/kaqtzgG6yua3IgnNu/0QPKdAjvCBVVoc+BgsbrqF91uGExQ9N72To013MrxDHSg4g0QRTZ2VSyy+UQ+epHk91wxnlvw9JKayqanfli/0qWxT2fEsNc2HPug9rQTF5jZtDCw2LXEbnBlzn3zUJTlEZZSupN4xCyf+rNUpW0+Yn7l0j2tDBvKUI59BzS/qY4vruMtvE4CUPWGuYSDvRT8RpoRU23JSSMiIXRyhT+tr62BuAZoUafqxzJEezF5+dmb7u6o+WgMqtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgvsrDnbd+0rOUuaHQSMNT6pszbVMjDJsb4WrSVrY6s=;
 b=FuZjNs9gPkluHhtj4j35W5GwQNPzRy82WNBYBfutVGXi1JWwefnrlIrrAFcLHaoTrD7iH5mM3p07MDKVKrOVE0VmiV+gbXlrBaXnGoZKhY017CvtVwhfwFSuBpNxOYDdl5T5FbeyEn2ksIZquCWRsxtz9GYnj75Fop6PQYCNqwnUHuIgWoCSBLACXPTJv3zRyDjzlVgYxHoHQkF6maBY5av3md2Vhjhgtdm9xF8wMdjyvzw281EbVYPXeodWpYdaWW8kitQ0WKPaSGIVAefxCwt8T6WXSIv4L4XGKZYlnmc4jQV8ryjLSu706JvocpFAuhgNUDS8f2BuQaYFRqzdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgvsrDnbd+0rOUuaHQSMNT6pszbVMjDJsb4WrSVrY6s=;
 b=ngQNDgZBrKJ1yWc/bo2QTyuDnXhg/Q8sZw35cyx3UgiNae04DgIYa7kf6mSaRqLqrKcp4ACCoUY2s8d9rl+Avll2JfOKjc5rVnUeu5+hY+dO6i65pVyZB2THR1rwcMRhE9IL3saUAU27uES3f4JwixgtwADd+4MIGla0CSXPv7c=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7960.namprd10.prod.outlook.com (2603:10b6:610:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 08:31:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 08:31:31 +0000
Date: Wed, 24 Jul 2024 09:31:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david.laight@aculab.com,
        Arnd Bergmann <arnd@kernel.org>, willy@infradead.org,
        torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
        andriy.shevchenko@linux.intel.com, pedro.falcato@gmail.com,
        Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Build performance regressions originating from min()/max() macros
Message-ID: <9d62cd2d-a00b-4260-8ffb-0e0e4574f222@lucifer.local>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
 <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f51077-f525-4d3c-92ad-8a1ccc02e4ff@suse.com>
X-ClientProxiedBy: LO4P123CA0261.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::14) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: caed73de-8b15-4a3f-eff1-08dcabbb04b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?nk6A5gdu5RnvbeUIEgQr7kIWD7sXf+firWa9yxDLFil1q96Y94AB95/JuM?=
 =?iso-8859-1?Q?BUeWne7/YlTKZIyTFiUG+LlvaeG0kpb5OHhjcYB2ArRRfbp2wqaeEhXEfF?=
 =?iso-8859-1?Q?NWNFhsIPOrasdh4cn3cCYzQvyIfGBomAbbi4Ss/h8lE5MuK13UmMqaIk9G?=
 =?iso-8859-1?Q?feozri2qydn5evLD6ENBmDti8umzFPp8hG6aOuPhnN37ytekT2qfydTqi3?=
 =?iso-8859-1?Q?FBVi2d+qZj13USg3Gk371lTle/0ps/z2ECaN0UtPOzSUwQvSc3ntztavEx?=
 =?iso-8859-1?Q?Ehw5H+628oK8enni3qKARf/ZRM9pvuxhJWBw2cCj7ujOzTSgRH8u63kUux?=
 =?iso-8859-1?Q?j2TbgXhftnrq3HLimv5y+dZ2ZB1q/9/1Q2vAOxVGfw08xMLRyO+DRMLUF4?=
 =?iso-8859-1?Q?M6edmt/wmNqBdIC8NuMfvPqDTEbXFxtEz5yKsiVEEvdT4bHJxYFx+C5pZf?=
 =?iso-8859-1?Q?acufyN8qKGCOWurtXBCu58R7UOVetwjHFC7gdwVHc8r+S6AEh3DSFKjly6?=
 =?iso-8859-1?Q?SFoeQu1OW5jBGMR2MqUcFCW5V/gTWJaBG47lKzAIOxza0ex6PN77T2NbgO?=
 =?iso-8859-1?Q?iYTP99VmhVjV44hMWOpnX7vieL/kX7QbrLmLPldtPKMLRKMqTKsrZj2KEY?=
 =?iso-8859-1?Q?JVf9q7gS4B8bbjYP4ctuWtw+k6Iywe5WocQ0KiyLlMlfdXrOtFwzaisDTO?=
 =?iso-8859-1?Q?GWG8Uq7J8z+22ix+mz8Jyq/mWNXJP7AjR23CCWyYUZENuQfpkWiD6x9Oht?=
 =?iso-8859-1?Q?n8s3V66l6Sd3YpZaePE80Y1EV2PSusFHTi+tOubu2poeAIR6fPEm5Aubmn?=
 =?iso-8859-1?Q?SC3rPpgX0LKLpMGOeGBHkDLU6Ej3OEsC6nva4TytiJ3ru/ua8wUD6uw5H0?=
 =?iso-8859-1?Q?4NoDSLhYVj2c3lwh7/AYYn1/ABUtmBrjJq5jNxY5fC6Fmgb/t9lNf8n1ab?=
 =?iso-8859-1?Q?QctvHtzYvuJ7nzHNYx45c+wy2iNpu2cGGasG8lDxfpYXweptoNwii+d0WL?=
 =?iso-8859-1?Q?dCUKlJx8Z/ig6lg8+Df+XB+gbIh0W5Lmd8BFWZR5DGuJjXSSLeW0BDXUr8?=
 =?iso-8859-1?Q?SLsroqRrh5rzfQj7gvWoICAbJGYmWSNgDAvZURVXeEj/TtarkGRdyk1pNp?=
 =?iso-8859-1?Q?iPpQGsvE+YdQgYweu+a1a0hGuET2i66gBxcQ0xkjlqH3SiT5uHLVI9zRET?=
 =?iso-8859-1?Q?W3fjQkT6Kx4AYL23k3lmKskV4BSUR/TYtLKmq0Yv51Bx5HUMAKMn/y+v9Z?=
 =?iso-8859-1?Q?2n3abjfL6RhR/F+S4t+jDm/qCTpuJsoLRzdCidGXWkt/H9rE88K0MVx795?=
 =?iso-8859-1?Q?j1hOP4e2SYcW/U+ww/Z8k4vdGaeb38qRZK9RvEV9Bgp4QyEvNJveo9YEUO?=
 =?iso-8859-1?Q?ngzN4FdeyTIaB5/ErRBn1kvN6XK9flmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?w3fsiuI6WoilrlP4mcXLz813IXGUB995dWvzwG/09a90cvQLxdYdijGVId?=
 =?iso-8859-1?Q?6KTFQpOkFHsm+95w9EPA0t4BJWRpoUK2gyot/7stiVX6bHuISL8Cl9dkYk?=
 =?iso-8859-1?Q?orx7+3SxZptcb+wmMffZTY0aqzls+4VVFHtyM3TVzAGvsD3lOXqSryVxi6?=
 =?iso-8859-1?Q?dTuemg0CFqIHjDBe9rYQauDPh9LqHkgI3ivn51cR9MxZgZ2YoaZtKoeUp8?=
 =?iso-8859-1?Q?GVvS/xLeKUxcs1wo8futYSmWbJMuZKOvaH0K7N+fqS7rp8jsHBXTuPK24Q?=
 =?iso-8859-1?Q?rqqwD/MmYdBGI9/obE3TX6Hg1Trlu/RWsgVoqnQlbEZKn8sIyGCfoLxxnB?=
 =?iso-8859-1?Q?7EESQd73azAiOjsf7+chN48vl8ioPu3+IqHwMRCbP3dBb5kGu7NTG8FN25?=
 =?iso-8859-1?Q?Tr/ajo0eVxR/SxHQd2u59MWQ9hPNP+esZT0klER+NZOtSKE269wCOuZtmZ?=
 =?iso-8859-1?Q?I3Bxdp3UirjnRg7nn/Wy3FdMl/v5zKnbpQ4/nh0ZRu8fxPhk4mjVclhZOi?=
 =?iso-8859-1?Q?JGtdUStlGNBgIM3Eq0gly6P9QyxzcHemjT2ocJBt24iEiNI7Grwc4Tj9U4?=
 =?iso-8859-1?Q?lvQDHUAXU9NTF09IWWilzvYmnzSlzfG8EiBdy+5jRlG13jeqZnvNcRHO8V?=
 =?iso-8859-1?Q?plmyZUhEH5OaCvkGyQ4daT/ylAT+VhbW6vGLMgYY93IGFFqhRD0YRLJ/ue?=
 =?iso-8859-1?Q?mErrnilU4G9EpnwoNqlqxZYTZA4z+siQ3Jy8G3AAidjEn0YeigChMzs58g?=
 =?iso-8859-1?Q?dSayVv9/CWsaABguN1Voc2ajLldLCQgADtX42qTahoyOFmD8ArxNShVMQJ?=
 =?iso-8859-1?Q?3EihBWbvP+d5Kfd8wtmnF+5Dbkfhcni1ZVsshslwA3G/9tzn9ECsF2V3Yp?=
 =?iso-8859-1?Q?jUeAv4v59YsZK6UOnRyc6lRej8loLy4tfm2u7gMXs/MACvMn56vc5PDuql?=
 =?iso-8859-1?Q?5wzXcTVjEba8TyqCOd632NSPQMITX4HU0dq2m7aLBTZ+YQXp+h1Et1Hea+?=
 =?iso-8859-1?Q?K7G+gwde/TbJlq8qVJgMnmI6g85/SIOjFirPl/H1F4c4rvqocKk3slrP0i?=
 =?iso-8859-1?Q?klw5DBfvhKZzIwC5/+Ea95OjuMQ+C4Y7Yh0mfyjqEwsqFApiCl7ucOqdWb?=
 =?iso-8859-1?Q?fL2cex+ILH8Mb4eg32JyvEK9/BbInzhPJujCWSi7yxu/evChKRplkq3YLc?=
 =?iso-8859-1?Q?ROldAKss3/brL/fktZ7LD9+Xwjuoah6Y0CndXEPfEwTzj1at0HzG4Oin7k?=
 =?iso-8859-1?Q?c0fjTvJqHlG2l/nohckOrCv0TnRwrY16ey3K/deXENqpfRgUbXwrOCIgcg?=
 =?iso-8859-1?Q?sbj8EShWynmy+3niu0nb90O2YlIH5y0FrcWb1v1/YAhe0saBooQaYdmAgW?=
 =?iso-8859-1?Q?Csl/G2nlU3CkgroiYr/XgS40J5hwzbgMOEUXstRCR8XfEZunb94mEtxfpm?=
 =?iso-8859-1?Q?2KogWa44RpCYt2agf1C9sqkrG/CJOCbcnLl2YcfU0MqX+0S6kia4Pt9HlD?=
 =?iso-8859-1?Q?Upoh8aBxm8UCC8K/61o7owMfqXA0IOaFaAUCRV3FUELSX/DfhpjvGdfC8H?=
 =?iso-8859-1?Q?wuqZ6MP7KY9k7ZNK57OKHOY7N5jSOH3i86RzN9Pe/Vwby6Clr1Y8+xS8BK?=
 =?iso-8859-1?Q?Ol/Jhp2xGM4ynKOBY/Bbp7wriKHITRqob35UUZwV+i+5wpQqi92ZcEhPNF?=
 =?iso-8859-1?Q?HtE7I4ZB7tI1Ds7D9VPdPeKg0H4w6G7DmuWfBlXP52yuBf1xwZoCGrDfJb?=
 =?iso-8859-1?Q?22sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I/yJ2CNM4VVw66sNDXESilK3bNwcma5IV2oTk9JcEY8IFpjD/CfnSYV456SIMHCY18xc9CXbVyfqAtaenspJqOTQN9uYGwVdIGFn3pWzhRaPjxNNl08E9MALXGjKOmemrC5BisZWUTeuVz0VTmcQQ/AGGf9HbUuRzdSoxRpxuCwfGbHZc+Oj8uP0zJ77xrmFylaECLtdp66IFsLiOL2fV46IHl1OjeM9TOFo45y/w5W2OpUKD6GHu/QiDKvijhCu3V01gARMkw8lgVWT5NuIkB0KqJRE0AVy1AGBaP72Bf5CE5nErtqvOd9+DgjfjX+6XWkIuTan1EwP7UYl7Q1og/E496SLSs4BRoqgQA4ZVSsWW1vqU7PSjQ4AaHlIhKM+83jsP9wGZ+BZSWHUkPC/XLp5Y4FPJfkFuXSAZYH2KMaNyYv5DMhvRQrPWDODo3315BZt2EOJKQqzY1222BwtRjJ4O6QofzDC+pBFl5Ahaq9SImGkHLNg74Mcewc+z9Gr+hIU2zJruY1dsteEKhLYIY0QFVHCGSgSenEgEBgJKMs94WvWywh23QhYgNsxLjF9yPetQ7qbfhQjrt1lX9DX5rjZNkhICzxUiChRRZeJHbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caed73de-8b15-4a3f-eff1-08dcabbb04b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:31:31.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKGasqR03h+8Jq577/pnDhR188tUz9dGC7W7u7WMYaktqNrBEXOyenC6I1XVtZKCH5L6YQU7akGLpRb0P3rutzFGWe806fPTByj1805zKqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_06,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240062
X-Proofpoint-ORIG-GUID: rphbDhmvX0iKO21R6WPr0gvRQEF3DpQi
X-Proofpoint-GUID: rphbDhmvX0iKO21R6WPr0gvRQEF3DpQi

On Wed, Jul 24, 2024 at 10:14:12AM GMT, Jürgen Groß wrote:
> On 23.07.24 23:59, Lorenzo Stoakes wrote:
> > Arnd reported a significant build slowdown [0], which was bisected to the
> > series spanning commit 80fcac55385c ("minmax: relax check to allow
> > comparison between unsigned arguments and signed constants") to commit
> > 867046cc70277 ("minmax: relax check to allow comparison between unsigned
> > arguments and signed constants"), originating from the series "minmax:
> > Relax type checks in min() and max()." [1].

[snip]

> I can send a patch to simplify the problematic construct, but OTOH this
> will avoid only one particularly bad example.

Thanks, appreciated but I am a little concerned that we might get stuck in
whack-a-mole here a bit. I'm pretty sure we've had previous patches that
have addressed invocation points, but obviously the underlying issue are
these macros which will keep cropping up again and again.

>
>
> Juergen

