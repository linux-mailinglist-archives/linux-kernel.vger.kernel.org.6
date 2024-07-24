Return-Path: <linux-kernel+bounces-261459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23BE93B79D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C405E1C23CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1A16C69D;
	Wed, 24 Jul 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqXKEgcJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e0NpleB5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A86613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849722; cv=fail; b=AtGaMuOOQvOgxljgwB4gUaUgefTUXJGC0nVIR1ydRLsgQb9Kr/LrMVUtcOf8H2EMLRye6U6+DbgRbG4/WVsR9EMsiKdiIpM1x12cZUruW7TpBOrbwY9oC0uFMTaJbhIqrLnCTbaDG5aorrekZakw9XfnXPPbqTm9h991B4OsW7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849722; c=relaxed/simple;
	bh=RDjqtFrUr+LkwjFHiR0gaQSKxjQtfIvhRqDoJPE45S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cwSMHKbbTgaEAPDBPYQzk/am5CNFCKbo2vIa/VskqncwUEzPdxWxhzleksac5sfjp9Clfj7JwNKdrq9pd4rZYbpc0L5rZWUegjrpb+LtV/6E0nN5GMBQhmOohDB72bHIVRLSS6XhRKaSWYFjTSKO7rL9crInNwV6LRl/BXuOdzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RqXKEgcJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e0NpleB5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFXWQu028775;
	Wed, 24 Jul 2024 19:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=v95p2AdFjwGJIwh
	9xt5F627HKtUb6Ov4BiD/sz0Axq8=; b=RqXKEgcJNWx3Bd3Za+myIYJbgEYk8x4
	glEmGS/Y4D/iSzCGfwgMfztZa/2zS86Bl/BFJR+riAdhLzHO2jJNqcI9p0S+Pbi9
	m3k/f5rzeix5fNVbm827teF9L8A4yuwU71EhRYv5JmeXiqaWRlQSgHmIk4q8WJsR
	kkpawoSdFVQVI/NaKf+PT0XcPMyeE9uPdsclFlHQ88BxFmSrqnuNHSa3A0uKM8Pd
	Lq/cZdzHQJ/aVIFi8X+GVmUX7tTLa3v8yETA3F4M9M5W8MIIXgbvWjRTHjd/n4kz
	LD3NXxsI6omp9kKUgT2gQN2GmRO4PM18qR7O0+AHPu+KrocAQByGwkQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt9tss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 19:34:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46OI4nwh040130;
	Wed, 24 Jul 2024 19:34:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26pbjxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 19:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcnRGNT5LQfwtiBDtf3T0FgB3hKoSDvEW40pFlKYmCb7Io0k6D8CDzke2KDa0/y24Ep1SJfeOmWTGxWHdqqo4My5TWihwS3cs61C87+trgCN7HLdfQ/t9KffJ8yHNLGKhEFsnUKY2bB9YgOL9u56iEXINPeiHslO11bAmrg5js2jBMo49zjchOP58P0U/+x/PNqY4Ht2GQb543+UW8y2OjU0BwLJsrrUtsCWutJPR6EXY481rCa8UAYQyVqrVDnConZ9gI2ct7eNEl5VhdSWtZYTXoAnR4uWigoiEaAeivnMoMhSWAaSxsKSkyFBkjdeJLS2hz8sb5Oh4bWAWYKJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v95p2AdFjwGJIwh9xt5F627HKtUb6Ov4BiD/sz0Axq8=;
 b=DKmk76Ex5tBpmqbUUl11H3ZePj8kVZzbAZ8ZYzxi8GMrcbE+ddLvZjOFZBj0Ggy0oMGzbhV9iSL5v7hAIbU7x82RM4zK11l7Q17REhcVTqvUjoK8XAhQkvWSIe0SjqpQJGRKkA4n+CmA4a5+gFmXPXqcxeUKIJqSBU8ZhlyU5gTRgOD9EnZvEPeM/PVwvNEa0POxCtMwOVbTHfvxzPjtXoPcTOSBWdnN08MWj8e5UZ1QG0JhmLH5NhPiUaCqPE+kDofGyt2bkp8VCx0crCGloPjDBApUxnCAT2JPtmOjhnT1uPAldKM4aPIfjHezq8JQtEKAkUBPIw0I8qrtxnSxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v95p2AdFjwGJIwh9xt5F627HKtUb6Ov4BiD/sz0Axq8=;
 b=e0NpleB5gOuUOoJY5bKUl7cfhomviTT5XvqnB4I8vBSCMObZ24uTH0LsjoN+xetd1TQxtODyrANSyH3AtskSp410d42bODmOFWWpBGGTgPUJhKHt8tAlYJRussdvwdV1cOPFLeGMj88MxvwQexvQW5+yk/t74Djlyxv5vwy1eII=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Wed, 24 Jul
 2024 19:34:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 19:34:55 +0000
Date: Wed, 24 Jul 2024 20:34:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Dan Carpenter' <dan.carpenter@linaro.org>,
        'Arnd Bergmann' <arnd@kernel.org>,
        "'Jason@zx2c4.com'" <Jason@zx2c4.com>,
        "'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>,
        'Mateusz Guzik' <mjguzik@gmail.com>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
X-ClientProxiedBy: LO4P123CA0146.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 81811666-1331-43c3-fa1a-08dcac17b1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lanOgNSRsvs4Q9WMKu/O//m3vZXhfvCcB2ceniMQ2Jh3FNR+jtQZLVTykpj6?=
 =?us-ascii?Q?Nk/aS6RtuJGhBYYvjXANrTKI1ItO/JTCk5GE27xK1ZQ7ERPrWHGkCBg/EanR?=
 =?us-ascii?Q?0ZuXCgL68XtJRjRcig3Y/kTt6E9F7LHR0T2lqujeR7Pb3E0A0zW890ftyUJ8?=
 =?us-ascii?Q?dHVrGzAbNPPG7Fml/mphmV+TlW3xtgp2aa+0fqPXh11/WHtrtMXEubjwgW42?=
 =?us-ascii?Q?OIoxwXxNArXxdmX42PX1pVovSM8uSEj4YA351guSGTvjc6pRUGZctzJzoqvz?=
 =?us-ascii?Q?JT3a1j0ClfKdttIfpH6Qa4yAYRFzzqWsp8O8D6vBMesqfKV2OMInFrlpvMlI?=
 =?us-ascii?Q?hlb0h8UjJdUYjS4w9AEZb5T2PuBVaAdqbZkSsarKeCLPiyfEJQxSP8+C+B7K?=
 =?us-ascii?Q?0Sa1GS3GxYZSowR48Knf4yJb5ciYAwQsKjaXn5tCNW7ndZcKbbg8+vnLfE9R?=
 =?us-ascii?Q?SwaHGmr9rsm2hNkX6mCIBAtJnawfSB5ZmgP1fTIgDiKReYPlPf7iR3zCIQsy?=
 =?us-ascii?Q?YW+jgm7Bs7ueNxypaSx1/yVKBMpH4p/XkSYEtP32WLZz7v7ip+Tct0XJ2Vax?=
 =?us-ascii?Q?OUiYMmwKYLh2JeLzljwaoQeOJbqo/bw1vZLzsNEK+LZuYvfki9uv+LwO3dRV?=
 =?us-ascii?Q?UxjkzmQB5HZK5ZoqjyzjAQ9B1M9XbfsRMNQlo+AnZoZhHD6eB4CgUMjtwlgs?=
 =?us-ascii?Q?UaLjNamzkntPOMIYl1JNHDB3el8sG/raSO+KtMcoslow80n0jXxtmxDJ0sKZ?=
 =?us-ascii?Q?bivUlYLiegOoq4mQdTq+/1GwOlNXxIHEvRsSVeh069LIMmtXUKUj62d0SI3R?=
 =?us-ascii?Q?HHDK4YSUezilC5lwSYQNgs3AU/yhwKRk4l7ls5FQI4X7IpHSNRJwkwqDbdA5?=
 =?us-ascii?Q?q3sVuh1H0F8fMiPCA9NEtydewV0AJP+QxxaOytJOYAkSiLzJosFtGP7ze5HL?=
 =?us-ascii?Q?PFsFugsFsJYxzZrz5VsaR9m72W1SSSYaMVm23wOtzHauwObz91FId5ZkCtTO?=
 =?us-ascii?Q?OEfi5u8sm8GmHtp35MAMFb2vKNyKIZu7p7ezfVWen1Ge/yNE76+JskBB94dN?=
 =?us-ascii?Q?wZIQvIpe2//EoTkJ2EtHZEGEutIENRXFkHZQYaOsY4e/GgAwubLrP9HmNb/m?=
 =?us-ascii?Q?fiY85D3tPe9WfC65DbmdOQ79RfnvZJapdaNZVpVwYBQ12uEozvidx/Z/jJjh?=
 =?us-ascii?Q?PHNTWRESnvcmPj02oUsCpUZGyJ+NN6XxgvYYwGBmMya1qCOSoHdf9hqePTle?=
 =?us-ascii?Q?vV4x4eCI8Tbb4E//HAiw5El/jqNeLG4G1PUoWk5fdVBji+ImJ7ii39OqBYbP?=
 =?us-ascii?Q?q5xPd6z/BHW6zSgRyM6a2EDRBWNs+ymQDxANpd4QyLDCSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8OMErQh6Xd+oDiybg8AhDCJtscjVKvE1/fn+4zkvMuFL3s4HEsHiGTT+BlZ?=
 =?us-ascii?Q?IptaPSLN7B4aL0vaMDckA0MiwlbAujKsqgTxOX59JaNFDgXAyYixsi7nR4c8?=
 =?us-ascii?Q?lVAuyfrTsfxRzkOZ/NkqSRJmaP+cJ4hEmo79aq72pH4oFkoLd5EhwvVRHea7?=
 =?us-ascii?Q?xD2K2IXocDvgf/IsHwU/wKNSyJGkPJLr0VnWqDNx0+lAQWBA11mKdyVhmAqQ?=
 =?us-ascii?Q?7Su9Bftk8TgQu21Uo21zeN0SBCFNXIbbHukwra/Hwa+8qGupt+W+T5nPWJso?=
 =?us-ascii?Q?SI67+r/10W7RqEmTcMR0TQDJ3Mmm8fSUu7RMydIssBO64MQ9vdcM2ZZ553OV?=
 =?us-ascii?Q?SlgOoYDvQnOA2qwm3M3C/QL+xkIBfL6ftMIRARs3i0ihyBLj496MPlejEREF?=
 =?us-ascii?Q?pjIink7hQJ7nfMk72vGfAvB3BAzqsUWly22dN07BiA/N+F4Sd2CCaKf6nVmH?=
 =?us-ascii?Q?dm+1wnyZR6Ak6K1KNKMXnddfsYMX5jfeOrfUQPBKSMqhM5BiCE+SlBnsk07o?=
 =?us-ascii?Q?cwLEOQpBw9He+YOWpbaMblcLVcKMlmT/u7dKoiOIU3FWMAbCghePLcmCteTY?=
 =?us-ascii?Q?pxmf3EQxsH7JOZAok4usdeh2jyV0r2azWUczWSknRJOd6uhvf5Eg+AFUykTc?=
 =?us-ascii?Q?LsTGoIX6kSu8O6rEXEUR+2zo1DDXKY9FX+fTKh/lvaE+oONBoMCnLn2CBU53?=
 =?us-ascii?Q?VBrbl9lSXzEH4SdZsqkbWfDAk+3mhH8ma1LhkpvqFGmVZsXWmKxGmoyK+X9t?=
 =?us-ascii?Q?hCMhANyNV0W4ZydIfkX/kDBARv7GbZsSN3urA8yU4UFEH9tlJixJllz8+RSW?=
 =?us-ascii?Q?yFsoif45lJkgLTTMLJp2rTQv8XamhK5+2LlTT4/T8AseeJtpDt70wB87CcKV?=
 =?us-ascii?Q?nApLFPRv6G8whlLQhYlTKHS5NHjiAaE2wy7b6Rm3tu69H90J50emohauYD4m?=
 =?us-ascii?Q?bJau4PvfxSOzwkCevIXoaol68kGzpxGqFMT6gkYZMAVvG/dXt+xyCjaWaiWx?=
 =?us-ascii?Q?n3K2sypbOHr5cRLyyfEeYwkvuiC3HymJk0Ujv5ea9uXqQMIzJgr2LHLrGTdn?=
 =?us-ascii?Q?XVAlfMu5mc+MwVWqfHz7vGwB80JJo8XtgmJEr8g0KgGQRQznip+HggYINJRC?=
 =?us-ascii?Q?OrMfc6LfFCOjfz4BADiyOJW9OG4XluBnJjVkeDXOnz7F48ttXgvuUvb5Fjaf?=
 =?us-ascii?Q?j3cZoOCngMqm2k1f7y4FJVLJmuq82BZheHBZVXh6MFB4QBj/j0vXHub1byHj?=
 =?us-ascii?Q?+N6iZR9urKt9CLQh+1W+yRJ31d70bC1ttk3LSn/6ye3F1NY/UrK425xIcyqb?=
 =?us-ascii?Q?KopEzUbQcV4OP86W+2Q906dpyemE/WKXWPtd/xxhyojVBHRLvtst1MTAXhKo?=
 =?us-ascii?Q?aZAMi3euccQ2PivDefazIXYA5MUZGGRvXEgZnOf2k32QaSfi/6YXmcii+KuE?=
 =?us-ascii?Q?zN1d3h2mgU9dIJp4v7qL5YLis/yfZ1GEFv0akMsyY+yyQMG2dDg86kzzrMuQ?=
 =?us-ascii?Q?64+Vp7261WmZtSWoiVm7239d4AOfrKLWmjV1JczhdwpAdMIK0OV1Agvqnx6P?=
 =?us-ascii?Q?VIcbT+3a609Vrk3EtBOdsFSmn2KSuTkCefXfj3EgQ3ab3WYDuXrI6Nk8OkvA?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q0AEFpSWMRLsXtE40rejIRakIoZZRDUtfq+bqV3fVn7MRKdGkUWuRrLTBJJGW6yCnkauEMZk/QYbwwknOUBl8t+bAw9dhrtLkf10IprYcwm7oTM0e32oOCdVNuNIY1R45hMOiqpB4s5Bb8NCUy/ev0LqWXM40efZLQhgJh+jA8CszKgNw2v5wVLKxbYgWe2kGpExCnyJjMYpl0e3Z73unE1ZQZgPrsstssaPYp42SwKNkW27Bk5KSMs/LZAHKbanNmEJAt3Rri+9vIoUAcdBUjBtX3fesLM4XliKguP1eduOyn9neK5d1zpE9JBctKXv8kCRBuLZYaPRdxMl7dlJZFUpEuynFOmd5h66U4C5f8Hb23uLIET0BM3CNycQZ3nb4pKb3mah2xCTK+GC1xRZ0DVg/h9l5XX3URRhMDudraYh/IGhp3JdzXRmQF2kvT7sgx1SvIdOdv/mYdRW2chjvhnpWfPRfAerPe0DAahW9+W1GPgRjuqMKVOGXJmZgz6ENiO0yxu+RiFiHjxmNnGLVXQ+qfpS5T5vowI7xJdVdOdmBZv9bBX9jjJNZU/2xaWo737WusEqD4qBQ9DwjvWxUn0MMcvUxUSlztFtJjwWf0I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81811666-1331-43c3-fa1a-08dcac17b1f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 19:34:55.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ml1dZ80nfszHaxVA6ai0+XAFeYdED8R5x5Wf9iKIQclaZN9nXdytUwTEDr/q8FvMqZOa17ji8ZUTzpib3sygrWKKMaTBta3Wrj/dl4Iq3/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_21,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=627 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240140
X-Proofpoint-GUID: 9tCDq-7-dtkD9uFh_8tKwrLquBl_HKmo
X-Proofpoint-ORIG-GUID: 9tCDq-7-dtkD9uFh_8tKwrLquBl_HKmo

On Wed, Jul 24, 2024 at 02:26:32PM GMT, David Laight wrote:
> The changes to minmax.h that changed the type check to a signedness
> check significantly increased the length of the expansion.
> In some cases it has also significantly increased compile type.
> This is particularly noticeable for nested expansions.
>
> These changes reduce the expansions somewhat.
> The biggest change is the last patch that directly implements
> min3() and max3() rather than using a nested expansion.
>
> Further significant improvements can be made by removing the
> requirement that min(1,2) be 'constant enough' for an array size.
> Instead supporting MIN() and MAX() for constants only with a result
> that is valid for a static initialiser.
> However that needs an initial change to the few files that have
> local versions of MIN() or MAX().
>
>
> David Laight (7):
>   minmax: Put all the clamp() definitions together
>   minmax: Use _Static_assert() instead of static_assert()
>   compiler.h: Add __if_constexpr(expr, if_const, if_not_const)
>   minmax: Simplify signedness check
>   minmax: Factor out the zero-extension logic from umin/umax.
>   minmax: Optimise _Static_assert() check in clamp().
>   minmax: minmax: Add __types_ok3() and optimise defines with 3
>     arguments
>
>  include/linux/compiler.h |  65 +++++----------
>  include/linux/minmax.h   | 176 ++++++++++++++++++++-------------------
>  2 files changed, 113 insertions(+), 128 deletions(-)
>
> --
> 2.17.1
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

FWIW, I measured ~26.7s user time improvement with CONFIG_XEN set, leaving
another ~15.9s vs. reverted case.

It reduces the time taken on the egregious arch/x86/xen/setup.c down to .7s
which is comparable to the reverted case.

If CONFIG_XEN is not set, we see a ~32.5s user time improvement, leaving
another ~15.8s vs. reverted case.

So this series definitely improves things, but there is still more that
could be done.

I share Arnd's concerns about the need to be _very_ careful about very
sensitive and complicated logic in these macros so we need to be very sure
we're not breaking anything here before we proceed.

Be good to really kick the tyres if we can.

My rough numbers below, on a 32-core intel i9-14900KF box using defconfig +
a small number of debug flags I use for compiler development:

## CONFIG_XEN enabled with original min()/max() impl

make 1639.84s user 95.25s system 2358% cpu 1:13.58 total
make 1638.79s user 96.40s system 2366% cpu 1:13.33 total
make 1635.00s user 96.44s system 2359% cpu 1:13.37 total

## CONFIG_XEN enabled with this patch series

make 1609.13s user 92.71s system 2321% cpu 1:13.30 total
make 1611.94s user 92.45s system 2366% cpu 1:12.01 total
make 1612.51s user 92.35s system 2368% cpu 1:11.99 total

## CONFIG_XEN enabled with original min()/max() changes reverted

make 1588.46s user 92.33s system 2430% cpu 1:09.16 total
make 1598.57s user 93.49s system 2419% cpu 1:09.94 total
make 1598.99s user 92.49s system 2419% cpu 1:09.91 total

## No CONFIG_XEN with original min/max() impl

make 1570.76s user 91.62s system 2365% cpu 1:10.28 total
make 1573.93s user 92.74s system 2367% cpu 1:10.40 total
make 1576.97s user 92.33s system 2363% cpu 1:10.62 total

## No CONFIG_XEN with this patch series

make 1539.13s user 88.16s system 2347% cpu 1:09.31 total
make 1541.55s user 88.84s system 2355% cpu 1:09.22 total
make 1543.44s user 89.76s system 2355% cpu 1:09.34 total

## No CONFIG_XEN with original min()/max() changes reverted

make 1524.97s user 89.84s system 2399% cpu 1:07.31 total
make 1521.01s user 88.99s system 2391% cpu 1:07.32 total
make 1530.75s user 89.65s system 2389% cpu 1:07.83 total

