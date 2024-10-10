Return-Path: <linux-kernel+bounces-358102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B24997A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654E21F235BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F732AF17;
	Thu, 10 Oct 2024 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+CxxQLW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vBtEzUs+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB342CCB7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523793; cv=fail; b=mSxiltGAjk/XbhNzMhKBRo5PDntAYMom4waQE934Jo42NdtGH2pfmw0SOf5fYDyvzm0Grjb5+es1HePdUNNO0aUTJZKBr/vHgDWSOOKy9x//96WLaERKjwlXCnuyF9aHa2+Pyrw5Gx6UHcQSxoLvjVMv2BNvcpkrCNzhjVBMXq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523793; c=relaxed/simple;
	bh=wSZdrsf7C9Blm+1E5lYgSnreeRk54Nlq44j72PzQx1c=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eJkghnVE00rF31tjiXj041U+uGZOtDjSEkhGTrZdH9foMUhkprzBbor/5uyZbtqyW8yT0mvuMTfjpxZ+QG6GQAjO7QIrF/ywWTAbrq/nEXptASfwq1lgn74mwPVIh4pCjFDH5la/6j3NPhMFykXgSRpxuqYpleqUSiiJuYtCXqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+CxxQLW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vBtEzUs+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499LtfGL013834;
	Thu, 10 Oct 2024 01:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FoovJ6n+exxjJDU82x
	s8hvSvVOfMUj6eaaEvKwVZb6I=; b=Z+CxxQLWBhDC9WW5oNWjhcbLgIzCg7TL66
	uJTHcbqAFktdyzXOgNdFFj2nYCuHwwU2YBVfHhFXJA4cyAtITpOSzVcDyALu9BQD
	dS/zTKBY8AGvXOSdS5d8TjH15QyPEP+wS/4y/gGMBfEYppj5V33XBzXsc3yvgppS
	YqjZRgR+lI02sjp1N5zLSaVycfTRbNAn2AdewHzO+yv9euWGeBN5a2GlIy1RvaZb
	1xB/btVKBqKuDR4As7w5IVuzDyMSL2E8g49oFAcKxhwKEVQIVK0bNxUJhMp2ADLZ
	8fxh4TbAaFDLjfhCytDU2Q7A4UT3PkaIuS2M2JRrJbpwR8bmDRuw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063sqjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 01:29:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0tpBu038335;
	Thu, 10 Oct 2024 01:29:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw9f3rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 01:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMhX+mzbN7bmTPY/T5h5O4369BkfIG0WaTETK38DE95dsU9GiXzqexROxO/nbg8hjUiBMFhc/xvFRwUHum00bBUdk/EOOj6uXkyB8C9yVFEqbFPGmiXhWRJgBmHxal8GqJLVS9zOKvQwOjMLuashpCvMhoolqvMh7JdUu5ZBZ1YH4RByW03DyBa3LVgCENK5gLUAzUifKZ/G4ueGAx3p+kgDVKqJqeJtRAHdYrsaBlxszTRSAP9xMT0HoRlUAEdFOOWDXkcNlNnHZGtAXWspQBKMtL9ywtdTEXjsOjeRAEYkA6JBfGt2M3LTURdyJiPo+LNc6b63m5RMzY5briecnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoovJ6n+exxjJDU82xs8hvSvVOfMUj6eaaEvKwVZb6I=;
 b=AlJS+xScl900Zhj+Ebk5vwFRmBmB97CnjQ9Eq8CpTcPYX0W3QJNhtijHIaQIOH7gRV11gNRfu7e8LXlfwxT0AmKXKSByVE+yiUCIUfS0HxzlUEbRkaJp1oRyPYpkYgLBp9+1HZQVmbGb9RGtxdgJNZmnuMhjwwo8sxblgOyVON0d/yIiu1mjsXRvqVBaSu+Po6wmoSqptmSUnplvhgRAWrw18aHAKKBSF/aiy3+tQE6V+FPjKM5yledTVMf2mUBYeMU5KMPjQRrZZzgB563odSDJ+wETIluC29rtAZy0xoci60klTS7HZa6mo2tk1lB6/69aQmyMoJ2SoHSA5/4q6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoovJ6n+exxjJDU82xs8hvSvVOfMUj6eaaEvKwVZb6I=;
 b=vBtEzUs+XaZe4OwW2vyWWRq1xPcmFm5WFIDXjB1mdgOcXxwas2h6Gs014cl8XkA/fV3Cf715KZ+A0AKfBw1oFrzmel8FAWNUR1TJP1/zvAsjJl4bkjbvrhoImsuxuXY3jjYhRX7+FyzmtiidIutlT3L2vZLEAYEWVw5HB6elN8o=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 01:29:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 01:29:24 +0000
Date: Wed, 9 Oct 2024 21:29:22 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH] maple_tree: remove conditionals to detect wr_node_store
Message-ID: <jjncaumvurhacujkoryn4jcgqlvnyoctlow6nc4oubkrr6yjvx@ymnfisz526v4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org, 
	richard.weiyang@gmail.com
References: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
 <qevigth7doscc2kqdnrcagh4klgruehp3x4mwo2lc5c3qrey72@6omxfs7qhk45>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qevigth7doscc2kqdnrcagh4klgruehp3x4mwo2lc5c3qrey72@6omxfs7qhk45>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0462.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 293577b0-54f5-488d-6345-08dce8caf96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwY6cISA5FypMyCxo5fnPukAyk3+IiyU5Rhflp5RYDb3cyVOVsbbuKelUNQ1?=
 =?us-ascii?Q?cchqyMPa1URRUkl355rzahcRxoeQCOlhrGk8jtOPipazKvhVqnxglF8uYMMd?=
 =?us-ascii?Q?Nkjm/+Rg6NLMMYCzndHEe8/X/4WgFC+M7gDPDkLSLvu0ItLveJGFLM/iG2rG?=
 =?us-ascii?Q?EvshxWX0LzbWMrvIUu4v9BcEWYLCxXm/w++3ZxUtcvq+pqbFA3EUIvCfHDzO?=
 =?us-ascii?Q?RgPk+envTYCcQ4iGH6hZFKM/1wMKkO/T3DA3tN7CPg3rw+VuwkI4RlJF3DGe?=
 =?us-ascii?Q?ZQPCfREb9illIN9vVhfxcgWgKGPtFzJZmjIAJeqvi3sQSljm17+Gb6tgNN7P?=
 =?us-ascii?Q?aquReu272vOp/m85fRC01qAensoKiBgFX9YxeX7FxujVqLj0WjXa+3BMXvS5?=
 =?us-ascii?Q?B4TW0QJww8Iv+aq5UwjebchhiqmjMEj81M8s/ew6z0Suawthhkp42cGS7/cp?=
 =?us-ascii?Q?Gnu1ik9PfEDM7vWFPIrCsAp0BldG2cIkn2kO6vZDXdiaLP8QyYzmvJ5r7a8S?=
 =?us-ascii?Q?TrZU8I6LlL7U/h0gs7bz5/3t8tC6VCkn89dGOV3rL7nXvfHsSdoleuhF2zif?=
 =?us-ascii?Q?KLGNUTqGtM9wHZEzwOlK4/V2ZsIPfA+x73bmG2GAg9uRgEHggUywl4CI71Ju?=
 =?us-ascii?Q?ECKQjDORDnHCmVrdD24xiukajKLga/3DXB6rQ+9OPOPP8sowhNoHhbbRFUH1?=
 =?us-ascii?Q?Hk1yHbECbnQdT03sGAmyBMT7mn+3Qy8KyLenY7O35q92kTokiapba89b6GMQ?=
 =?us-ascii?Q?sqrWy218i9G6Jhfo+xHIFbIXgQ8PeX6tvJzwyvTPwromc2F64GpdMuXFdsjX?=
 =?us-ascii?Q?dGMuWY1tLvdC/HLTASWg5Lt9R/bGLvV2v806O7l4iNjUk9sCm05QjGwCiFmG?=
 =?us-ascii?Q?QPvQ7eAOynjkQmve3eX/KHnSX3tDdUt4SJP1nX/9qKQQqlM3Yr0yI7hPd6v+?=
 =?us-ascii?Q?WGPKrgMXVqeqhg2sofv7dP9PkLRivJWnIZYlc4Uqm0zzmF4u671+wfidvqvI?=
 =?us-ascii?Q?R925Q3ujP7tdFZ5OGH6YYQs/zuJrRqshrg0W5pKNfFMBUQXHFiHVjC14f15x?=
 =?us-ascii?Q?GGKfxQobKG5ZaSfLRiRFP5dqQSL3frPyC6ipuaUGKygpSFmiq+pAA+uQvgLZ?=
 =?us-ascii?Q?4Bv2JeHotS+eltA3bG15Yi9622aMonDHzc1qTPruFtaf2lddxCPPVlAUOVdC?=
 =?us-ascii?Q?1/rcc/8++Xf8vUXPJjWC6E40o3c3wGxeP45QjhdFRhIAzTOqpA/Y3Lzqcvo?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e6NHv75MWP/b4rw+9rso+sIkNN3Ft9kjSlQPgSxmQcx/l9+GCvFm/lb+em5w?=
 =?us-ascii?Q?quWiYHOWhUIPB5waDFHTX/UmQ47eZ9rFNXXzqbbC5KTrMgzgnMll+8zK57PR?=
 =?us-ascii?Q?zDx5DWVIFJQTQRF7+pn73XsWnYk/r38GoqYf0OoXBaEGakYIIQoTWlyLB1Ho?=
 =?us-ascii?Q?wLE74k9OeKDVlcyCgUhw45D6NwwWS+ET5/wYCzGES9Ze41MgLGcN0dhW5d2M?=
 =?us-ascii?Q?PxNx2ww90TPm/e7q+CZPLtmNeGH+DGGeXMbCxWIGyonYDsiMfPK3muXY6KxJ?=
 =?us-ascii?Q?pWzxSL9hEEVJBnMqtIHw0dac3dAx7Ty791x4qGUKn/36eLuZaeYo9EJ88yPA?=
 =?us-ascii?Q?pxjAQ0CFMf4m3dxS98Gc2OdI4LiXieG1GKfDoqbcgYtXvVvJuVy80e9y3Xlb?=
 =?us-ascii?Q?DctzmaOrL3rWfgx4N1G2UMLAefS2mqBETE8gDFSzlUAItgcjJrIl/3CMSXtA?=
 =?us-ascii?Q?TY9zKejoM1voIPSIY0fKCn8QdRMDBWYi2LgsblM+gbDBRbpMJgDuD/5MiaJ0?=
 =?us-ascii?Q?vhAWIJJYcR2zf1/5ululk6USH4i46gXnnytECRVV4EewVcO6wFPgwTtdkHoF?=
 =?us-ascii?Q?CVugtB+wbG58+yZEpGaeGQzrztTXPAw/ZtoqYjkiy3A8YzZ2VyGHWczeGhje?=
 =?us-ascii?Q?wsK38quVFrY2ooqATvvo/r8ABfdgeuXbI+sFZbnog8lo2Yieb+j4F+4iew4A?=
 =?us-ascii?Q?iUiIfWnjHSUXACunfbkYaEOaGV6EUNtidDA8BEWqWucxY0a8LhEOIxsx8Bcd?=
 =?us-ascii?Q?dr3K9dQ7TECOjyq2UiOo0LQouL/o+wh1j8lCW50er61cWHJN9OJzSr0KoQ0V?=
 =?us-ascii?Q?vQolvlYWL/Q0+rEc272D9C4XLNRoCRBwuQ9HxI1WlxdPYhqvq2QuI+Mm++sw?=
 =?us-ascii?Q?cFjVP06kv0tdbpXjTyb5E0H1I8PJc4jIj5jrq1jjSzPWlNjyte/w739VmOFG?=
 =?us-ascii?Q?CNOTXSf1cZn3odWbL7BwZa9w0IbLUlufeclJb83HmKNo3EizfvYmZZs8yzuv?=
 =?us-ascii?Q?RI7shXDvDiJWFTQQY1QFXeXv86YFURRxwvj7Xs15pdt08wLQhgIxtg45Uwdx?=
 =?us-ascii?Q?ly44kqmakm9uJ//8ebhWFysh0n6Tj+PSo5QckjBBGK0/1CRfH2+HrCXZQegc?=
 =?us-ascii?Q?IsZrnDIvzx+QbfmOudOCKxWsMwItvW49cyo1A1PwO6GQuvv2IQFELoaVWW1G?=
 =?us-ascii?Q?SQoVqXYsIuvUyLvaQYTE4puMFQr4ZNg7AKJdWSY9VkrbJeB7ohdd0/DrRXP9?=
 =?us-ascii?Q?fxE1vmFUor+iJx61DnaGXSjyQisC/OBJlGfEnlhzmy/e7FMu8i+U25WMAZxl?=
 =?us-ascii?Q?r4S7nX5sUthjWqYRcp7GSUgsWP0BNqNPx7TIPWVBk1GlWz0Jz2bbS+sTzGBH?=
 =?us-ascii?Q?AjVT2qt9iBD/rKHxx2cCX5Hlvu2mCetOpv0Fc5oL9fb0/UJZHKDQQ9x0pFr+?=
 =?us-ascii?Q?t0P35iHjfvmuxTrEfz2CJCaGoBclZ7oeEhHzFp+k5UY63wXSauH8YdIEWov4?=
 =?us-ascii?Q?MaGU7e97J8a7VxLffevEMmS/qTNQ0F0lsj3snglngk/S9sPPiuzWLvk8j1uP?=
 =?us-ascii?Q?NNwjmY4dN34mgnEabjqEfIFsoUbvZRWmTBUUwxd9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9RSItVNneZZ/aJAcmPDAku7koovCgnlsoUUUEs3neG3Vw1AqJQ7HbJES7BUeP15QQyKsIcSelk7qomsG95xHnRP1hRWLYFhCvPmCGW3eEKpMmG+axGCTKJ33jAK7c/QAQDvpam0h7DJURH0Khlx9KlOjTq946jfGbwE6AHFVoV0hVdCeMBy69j1mbQL58r9aVCGeP60zwOVOP5bWMdOGTkqTmuSphSxMDazX/byTvg1mFMoo1x0QnzhADqrgQazCzyxk1Ct6bJRpK8xcB+u1RwVvxtc1arLNgn7X7LKz45Wf9nogRWbwZaqNZwIAdYtvOWFGz576VPGRPRGhYsMiWaKqqU9lS2FMHsYSzcdyL+RkjY0FnXARXKeIyXGtBcLRELardzQcvbnYYtWssUod7Vo2LujlatHJ6kTQytx6v4wa5StdlSnc0mZ0i/Pu/HbLw1s5vqsXHQoRxGTkFEswt3+Y3lu7pk0AwU/2Io2c++XX1afSvkJMSo5QkVnV33LZ9GkazpkOZiHLUAkQLsg9gqQxFPUqaRMDOVCWe4KeJ60YvYGB3giF3Ng61Q2ff7QXTHM2zpvvQHbhXKP8mux13fByzrh8lYDkVUzTCtjUvQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293577b0-54f5-488d-6345-08dce8caf96d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 01:29:24.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZS1ZWQPXvMQfkrSG1sgqTp4cU60xIWkF7aBflV+4XeIRgP/s5TKzUK/mvaIR0VLQmxEBaFKOObDDI/7APjWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_22,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100007
X-Proofpoint-ORIG-GUID: p8FSq9oatNueu0jLwfPMK6HW1ES5Mlq-
X-Proofpoint-GUID: p8FSq9oatNueu0jLwfPMK6HW1ES5Mlq-

* Liam R. Howlett <Liam.Howlett@oracle.com> [241009 20:02]:
> * Sidhartha Kumar <sidhartha.kumar@oracle.com> [241009 11:20]:
> > From: Sidhartha <sidhartha.kumar@oracle.com>
> > 
> > In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
> > this check fails, we know that ,after this, new_end is >= mt_min_slots.
> > Checking this again when we detect a wr_node_store later in the function
> > is reduntant. Because this check is part of an OR statement, the statement
> > will always evaluate to true, therefore we can just get rid of it.
> > 
> > Suggested-by; Wei Yang <richard.weiyang@gmail.com>
> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > ---
> >  lib/maple_tree.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 4b423330d83c..f5a12d37b352 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -4252,14 +4252,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
> >  		return;
> >  	}
> >  
> > -	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
> > -		(mas->mas_flags & MA_STATE_BULK)) {
> 
> Although this will be evaluated as true due to the new_end having at
> least the minimum data, it points out that MA_STATE_BULK is not being
> evaluated correctly in the new_end < min case.
> 
> That is, we will rebalance if we are in MA_STATE_BULK mode without
> meeting the sufficient data mark - which is not correct.

Reading through this function, it would be much cleaner to return the
enum from the function and assign it in the caller.

> 
> > -		mas->store_type = wr_node_store;
> > -		return;
> > -	}
> > -
> > -	mas->store_type = wr_invalid;
> > -	MAS_WARN_ON(mas, 1);
> > +	mas->store_type = wr_node_store;
> >  }
> >  
> >  /**
> > -- 
> > 2.43.0
> > 
> 
> -- 
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree

