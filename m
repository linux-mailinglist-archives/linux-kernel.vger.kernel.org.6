Return-Path: <linux-kernel+bounces-260775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BD93AE03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F4C2859E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19A13AA3C;
	Wed, 24 Jul 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VORYlWJX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C2mBt0wk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBD1C2AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810721; cv=fail; b=nd/G/FLY0EaeGRPwqXbHlAxf8Q/ecKHCWMTYMAOff4xWxUn8e8xKBQJISq242Nhrbeh2rlry6ZMNNyVVkAc2f40wydM49DFBDYGsDU7Qzq3DGhrIFYOoFTRdCocMgwjJ4o79NQcSiUNZplHlb49Cm4qcFuPhPlxErjdUbW7MfGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810721; c=relaxed/simple;
	bh=n5CDLwhAE7n4BdKnCem3y/iQvSLUcdq0P5s3VveR+t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HXJ416PSpal3coSwOV60hW0mYsTBa/bURJIL5sb/iWdoURTeoSTeupZOyBrV+hm0dcUmzRWdlfbo+GamUDfLA0dN3/2GEuBJfS40AvlSRjajKBz/BjZLP5y4/EeJLnbDuYZxTnxYBMu4jodtAQsnrb+gk0ZZCL0Wkjqye7fVrZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VORYlWJX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C2mBt0wk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O5ofPG005099;
	Wed, 24 Jul 2024 08:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=HeF4k2SQY3/h+pk
	U1KZzyInh2mwRAzjo0PznuFF72/s=; b=VORYlWJXTBxtm+x87p3QdmE+b/Frk6x
	CBDbdHNFxU+q+wU2WxORDDfIIzCMbEfJi7NGOK08IOmOGJ97EKnI7ja0C6VgXSiQ
	ViV8T4Xjo5ELnw+DtDNzeGaAH4ES0cxyXruKDSRLxovbQvmtfVe3YpAOTNCu1Bg4
	dL88QPcjI9MdCAR7yKMXc/0bNheETlnxBMUWKtMCH4sxLf5Iw/AAGbCuKRglTS6D
	ic+RZOicf5OHHYdR39/nVA38HZplrJb3IiwtvtaoZdX/N8f4q/talna3v0G2hCY/
	Hx8TjkKcmruSKZhdYu8uwuzGjY4v7wWFURug/hpiNQ3EkavhCSvUOWA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpgnx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 08:45:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46O7wbLD033649;
	Wed, 24 Jul 2024 08:45:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h26agegb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jul 2024 08:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHFQCEGc7vm74tvWyRjQR8eosdNKaQk/v1UBaYF2+Ta2nYIl/GQ64b7VFno/bAoIJDFo3Dp+S1hbhP7nyswtiwXsNHm8sdPgkyrStLGfPBJT9Iq6KHqVV8FKqtySDG2wA1rBk6V6m1CZP23l81RSSPEF794JvGcXQd6KyYZMpODVSQ3pf9Bwt+r79m916KWdT1d01/momZBMKJ4em4rQhbblblVJOjT97qq1YlZiFPClhigc5GMZ0aCDdFwxcuW3VTcwwSdf2w0cmdcqdpj0nbK6GPa2KWeL4UOCdUnTtEuWgybPzk/3B45s9V6/+tQ03Rvw4+VsB4iLUN0F21KGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeF4k2SQY3/h+pkU1KZzyInh2mwRAzjo0PznuFF72/s=;
 b=hUTCwgsVRpDAu8WtNUbrXn2TbUS301EBK3IguyAUJOdlJnz6Qfp2Q6kJsy5sOw++tLI22mYZyPp2JZ4QGIglAh9ZTi09OxhFqGs2duN3kguLDV31YogYbHWoOH3Ti/lbW1T8ib3+BcW7OWsOGAKv61O3zxqcWsPlAe0ygfj0a1SofieHJtSoKfumPpNZ500I7UysmcszDyQyjeKOfFtqDz4QXBKdlHBrE42wBTIxDYfWTb0N8CXdQv302cyeEvh59cooE8m3IdmxwJFlfgw4pqvh2ws5eX0IMtWPdl8MMU2d9E73Ps/pF746RMezakcxp9G8cN9JEDP3rag2/R4+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeF4k2SQY3/h+pkU1KZzyInh2mwRAzjo0PznuFF72/s=;
 b=C2mBt0wk4DCXJqfDJRhco5CRqnCz/nLDNbu10dD/ieMfY3sGRLwr17wh89AOcg0TNorihqpRUR/zd7m6GuuYKCMa4DckAHJRCkAvokNUniauVeAUH0DJzxYfV4f9XvZVdJ75Wfi7GyuPnJjMP80HUsJbXNLTgyUGGQrpELfATUA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7296.namprd10.prod.outlook.com (2603:10b6:8:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 08:45:00 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 08:44:59 +0000
Date: Wed, 24 Jul 2024 09:44:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>, david.laight@aculab.com
Cc: Arnd Bergmann <arnd@kernel.org>, willy@infradead.org,
        torvalds@linux-foundation.org, Jason@zx2c4.com, hch@infradead.org,
        andriy.shevchenko@linux.intel.com, pedro.falcato@gmail.com,
        Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Build performance regressions originating from min()/max() macros
Message-ID: <3ad33eb6-49d7-4e67-8fa5-1beec8d4af4f@lucifer.local>
References: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c83c17bb-be75-4c67-979d-54eee38774c6@lucifer.local>
X-ClientProxiedBy: LO2P265CA0458.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a4f25c-9ce2-449b-7b8b-08dcabbce6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQ60kudlnxwPbu1xaNVnmsBkegBycTzkvw3vG0wnV4qG/pdK9b0FImxdqsUE?=
 =?us-ascii?Q?iM3GpPFWP2Std2lDu9Hm9Rbs13xnrsjYsVuN48g7O5N1Ak0uz86OFpL9w6hz?=
 =?us-ascii?Q?0Fk+aTk4QjpksX9v8ZMutCjh2KA6snU5xTizSlwrIr6pqBds1YQWOUhlOZ7h?=
 =?us-ascii?Q?+z1OnMPFsJ42Kv6KgLKRw5q+aR3cuFPKoUoOye9h26qqh/mD51kesTfrBu9X?=
 =?us-ascii?Q?TpCLJTVQ3dWtgt3vj4YAXZLXbD7fgUNAxljtIoU1iCvv0ZfWcgqPZycQjDoW?=
 =?us-ascii?Q?z0NHYUkgUreIg1Rx7J7RGlPAJzXi8lOq7LYF9Ufx7jNlvNbGR9vUznuHKHUX?=
 =?us-ascii?Q?oZZQkMTXF8oG/UT26Ohzy1EgXueQ8cWqzqAGT+Lkx46bsqp3z7PkXedAXLUk?=
 =?us-ascii?Q?i8TBVfyNdQ/n9yrMd3s8Axy1bDaij+VWFTlc4Vis2+mhnwj7tpUSNXBVGHqd?=
 =?us-ascii?Q?U6W6We+ITiRXpHdUCAvMo65bRCxbuy8JUyVipRixWQO6jxw8q4RDZ1JjBdkR?=
 =?us-ascii?Q?T5W/mEYyZC2VnmuNX2uJ3Mmyy1IbjuQFm7YaDYUosA5YrJGI3uDJQH+fJJYE?=
 =?us-ascii?Q?i3Bd44aPmdJtFmoU5+UmAOBBDP1t5gHXcPFDz5bAVmRQTY62Af2v48vMUT3M?=
 =?us-ascii?Q?aser8TEfAMSxfgbGkpZKqZRm4lPoB/E8bqyMyCHCeH9LSMoW+O0tF7wF26UY?=
 =?us-ascii?Q?KWdI2cZpvJFNo0rzjJVy4AAM4chH35BvnnXikQHpf/920mKA7mPcPLV+zcnx?=
 =?us-ascii?Q?GBOb02J+DfpPPCuPCXES20d9Eo12hZ/2L0jrofdyyuzsxA7pRJRej09qwiQj?=
 =?us-ascii?Q?wIOcNU1TYH2YQSugRPlonRWS99GHdV0p8YZSsBjzOTjWU6weqp+lqkuq7bc3?=
 =?us-ascii?Q?KHTeDrivAmhuavAYO3+w4VYA+5tP6redgEdWZt5JVuz6M4gGVxSVUFNcQyum?=
 =?us-ascii?Q?K7wiXGDIMvm88RARoG513sCVnNZc/81hNishGoM9fEHSVLQaZ4Zj4a87hrwu?=
 =?us-ascii?Q?NjDxcXajYYZTlceCJRrj/Zj3jngBtE8EGyeplsKFtza2o0KMOzcRfT8ycSbL?=
 =?us-ascii?Q?WRHlPMYcoet04Z20muWgTn3Txs8EhhwUe4i7AJZ+UaN6b1GmrTnfRFTrcgX4?=
 =?us-ascii?Q?oj+SXinzlBLgZCGqWV2FPPNZbBHnWIAKof/6XCjzDCXdQlGeDCLqyE/PnIoP?=
 =?us-ascii?Q?fMvdyhlBQPxMUAtblO1EdEV4SBLv15MtgprXuMt1Ox7s2KqccApJEVOwlsLx?=
 =?us-ascii?Q?0o0mvAmBErw/Tobf6IXq97+GCZaC2Tn9+WGJvvXFwUmwiqdMHqJyc4kBJZES?=
 =?us-ascii?Q?Q3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1V6FKojuMKgu3TlKEFBXfKnelJgIG005cFXKQWyjOd+kGAt3DUbYNcepu//c?=
 =?us-ascii?Q?5nmKzYw5NCV9Vhm3471PlI+rwD+1im01C5yeGoJFApu/Jw9olrfZfIEW1YG3?=
 =?us-ascii?Q?RupStSsRRkSaYGeqKChB+DOLT/vUu3Sk4bdZ7Y/hzeUsYU/JPgwX2qtncgqw?=
 =?us-ascii?Q?2Nxe/rxoDrl2tOI84Upi+DaADVjIBhfkKfgJd5WIM1quich5m24V2WvfZBj9?=
 =?us-ascii?Q?O3olyG1qgDNiamklPc0suRyfJNAUHYD0h/zV4SyXYmeQZwO9q5no1wta7Yhu?=
 =?us-ascii?Q?PMV7ggWQYvfNTP1HF+4WAL3DJ4F5e1pbr4yeB/Y6MMY3p5GPHg40ZbEXfm3G?=
 =?us-ascii?Q?+iRCQ1E2ADy7KNf22fZ7rd8KFPQ4lnMDKpgmwF504rqjdyzK6FLI1AstNK1S?=
 =?us-ascii?Q?qcuoC6Y+QvAH9bBBdhIYEnxF0iSuvfWnwf8t7XxR8FHV/PN9nSj/lrgGcREQ?=
 =?us-ascii?Q?zy5mn3hcfiI84R7ar6njXwjLuOSvuKaXWQLPw4WuWa+ea9u3DsJIv6FvHDNO?=
 =?us-ascii?Q?lWbO2vkBQHYMUXpcKQ/elA04keTUrgt1Jet1mud0mkaUDN0J0nUokooUhvEx?=
 =?us-ascii?Q?XocezykOTyi1LSH4Nwr8/T9LFx30AZBBrnyQv1heVQ+4Lx0URhGlHDCWGyE1?=
 =?us-ascii?Q?9ybjCNE5rXp/qrTrrDs7mPjYwrw6q31pGDoyxViMH455oNh7aOktFMHCx5D4?=
 =?us-ascii?Q?OxBxoVzBvjvk08omL1EPlxik34M9/4LHno6NxTBAJVFNYKdV4AxYD503gS9U?=
 =?us-ascii?Q?dqiGN14Wp3WhZFZrtAOFOegyLHT8y7hhLAvfOxcqSS1kRgZgVJ0/6Z00EQQ0?=
 =?us-ascii?Q?r8hpVmtIX4FsH6VBBNhRInqpjYAz8JRu/yJmIF4Ti1Lw4aCCEJlufxtYajYI?=
 =?us-ascii?Q?PpjpohVbRAjHDe4k7KDlB9hGoaQydN6e/PgTAmof+eJGqNUatyA68RknVn+2?=
 =?us-ascii?Q?jYDTh+vEHnkRZ/MM4NpCYv5+8r+ExUVUctBVzMAoSFre6WdpQJKoBFKDJ2KE?=
 =?us-ascii?Q?R7ViRDD1Td0QrHOPB/d+1vZ9P/1orFoGUaWxJoKV70Xso9fOO9wlge6lqrv3?=
 =?us-ascii?Q?DZAfXDlFJbNAJSw12SDB5UbZW/Wv7G4eaMBmZnzaIGBD8Fn10d2QxVwwrzet?=
 =?us-ascii?Q?EK1Bw8dcXI/bzj2HO8V+do9QVTgIcPvEiWUOHgjxfvh4QOdbE7YySG/6WVQM?=
 =?us-ascii?Q?Lj7stZd5FNDSkzUkPZ514DV6nZnB3xp4S+MUqkjaxVmqiVKXNNcT1B4VTPTA?=
 =?us-ascii?Q?FA/y9DGK+tdM+uhUGmq7M0dxWFIRkBRo9Y6BRYvPi+Kobkq3AhziDLdPxzMr?=
 =?us-ascii?Q?pou3HDiLPy5V9ALmmt4cRzYh1s++D6QE5N18LDRRlMgILQYel5WlUO+M4uyP?=
 =?us-ascii?Q?9RdLh+7C8pEMX2YTtZpPCbwDQFBYX4OjNw7G5GAx6FAPqhh+LoQUkSsBVzui?=
 =?us-ascii?Q?TnO1pzpDqzm5ZI5jvjKHq5ZPYa4A9TuKeqqBQp+6WDOfUZ8dJC496rtXpKpy?=
 =?us-ascii?Q?pyTRl6x9ix6xIeUpb8CzDi9NmEdHCVy5/JGwMXdxITQY3yBIJcmgajmWdE4/?=
 =?us-ascii?Q?NImBkgxhkrPeSsLhsetUpvqEMo2YFNLeRhilHeQMWVj1qORl8GjK6+ohfBVO?=
 =?us-ascii?Q?osilkjEti9CEqWTEDSAK9h/PDiCIB//WWr1qmp/dcmKdv8FcyEwmuVOAqrK1?=
 =?us-ascii?Q?LtQMiA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vIOeDXSc4nTitxhfgvFqAd7uFH9L38bdcKo6V6tDoq4JiD3nCg+8aAzUtFThAgF9yO6W07nyh6YBdhTw907gnJQOF/mobnbfjYw1pjSbvexIa1sBepxKz9rLT3qa7O8if5hn2AXGbBGE7Uhx3RzAIBRaLFQvNdfgFXhhdpy/n7E4ZJV+uWo0ZG2ko3BEK6DWlVFfgKPxHj0z0FO/SeycZUogLwUM/L/mOolIWO7CdMGvg2wa/m84kGz3/pTyEzSaydBtMyK1XZ5SgZ4YNtIUd/CWTwmLmd0aHDnvclT178VBvqZTdKwOoDqMAC6/Ls15bmbxNycgQyqCrzhoH9zu0vTHUO9FLl8tiuZba1LJ2/3Em278UOS4kcJEAdWMYxHjOg4m5M5jtb2mHYWSXFXmPH17j3+oMbEoVjmbvAfj3dD8bqnnEcWFHNWomL0bdgxi4i6hPTRxliJHfwN/KLB3K3a0mgLp7C71yr91S8Vgl+o5+SZmrmtkH8/2QkVJDAZPG/sB+hXFXHLRH0/MfiheHt+Mx7e05JZ4CPCKR6+bwSK+hnZiRKOkt34DgIQTX/RrF4XKKj285a9k3NndeYF1ZHraqCdOi93JuM7We53xNEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a4f25c-9ce2-449b-7b8b-08dcabbce6f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:44:59.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EFhHBM7PkQXtk4Qp0XmL/jdZJbTnjKMQiaS9J05HuS1BI5+F5I5etN38rk5CmYwWIRuN+Sgmx+ynQp05LBW0uWWzWU5bGIPC5hk/Tvtnss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_06,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407240063
X-Proofpoint-GUID: AmkEbvFt6-w9fnkkp1l7zKCgfQ-LiBgg
X-Proofpoint-ORIG-GUID: AmkEbvFt6-w9fnkkp1l7zKCgfQ-LiBgg

On Tue, Jul 23, 2024 at 10:59:15PM GMT, Lorenzo Stoakes wrote:
> Arnd reported a significant build slowdown [0], which was bisected to the
> series spanning commit 80fcac55385c ("minmax: relax check to allow
> comparison between unsigned arguments and signed constants") to commit
> 867046cc70277 ("minmax: relax check to allow comparison between unsigned
> arguments and signed constants"), originating from the series "minmax:
> Relax type checks in min() and max()." [1].
>
> I have reproduced this locally, reverting this series and manually fixing
> up all call sites that invoke min()/max() for a simple x86-64 defconfig (+
> some other debug flags I use for debug kernels, I can provide the .config
> if needed).
>
> Arnd noted that the arch/x86/xen/setup.c file was particularly problematic,
> taking 15 (!) seconds to pre-process on his machine, so I also enabled
> CONFIG_XEN to test this and obtained performance numbers with this set/not
> set.
>
> I was able to reproduce this very significant pre-processor time on this
> file, noting that with the series reverted compile time for the file is
> 0.79s, with it in place, it takes 6.90s for a 873.4% slowdown.
>
> I also checked total build times (32-core intel i9-14900KF box):
>
> ## With CONFIG_XEN
>
> ### Reverted minmax code
>
> make 1588.46s user 92.33s system 2430% cpu 1:09.16 total
> make 1598.57s user 93.49s system 2419% cpu 1:09.94 total
> make 1598.99s user 92.49s system 2419% cpu 1:09.91 total
>
> ### Not reverted
>
> make 1639.25s user 96.34s system 2433% cpu 1:11.32 total
> make 1640.34s user 96.01s system 2427% cpu 1:11.54 total
> make 1639.98s user 96.76s system 2436% cpu 1:11.27 total
>
> ## Without CONFIG_XEN
>
> ### Reverted minmax code
>
> make 1524.97s user 89.84s system 2399% cpu 1:07.31 total
> make 1521.01s user 88.99s system 2391% cpu 1:07.32 total
> make 1530.75s user 89.65s system 2389% cpu 1:07.83 total
>
> ### Not reverted
>
> make 1570.64s user 94.09s system 2398% cpu 1:09.41 total
> make 1571.25s user 94.36s system 2401% cpu 1:09.36 total
> make 1568.25s user 93.83s system 2396% cpu 1:09.35 total
>
> Which suggests a worryingly significant slowdown of ~45s with CONFIG_XEN
> enabled and ~35s even without it.
>
> The underlying problems seems to be very large macro expansions, which Arnd
> noted in the xen case originated from the line:
>
> extra_pages = min3(EXTRA_MEM_RATIO * min(max_pfn, PFN_DOWN(MAXMEM)),
> 		extra_pages, max_pages - max_pfn);
>
> And resulted in the generation of 47 MB (!) of pre-processor output.
>
> It seems a lot of code now relies on the relaxed conditions of the newly
> changed min/max() macros, so the question is - what can we do to address
> these regressions?
>
> [0]:https://social.kernel.org/notice/AkDuGHsn0WuA1g1uD2
> [1]:https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/

It seems that (again, all credit to Arnd for his thorough analysis here) a
lot of the underyling issue revolves around the macros need to function
both in scenarios where we absolutely must have a constant value (for
instance, array size) as well as in scenarios where this is not the case.

Arnd also discovered [0] there _relatively_ few call sites that require
this, so maybe a way forward might be to create specific min()/max() macros
for the strictly const case and to fix up the core ones to reduce expansion
at the cost of not being able to use these in these scenarios?

Does this seem viable? Perhaps David you might have thoughts on this?

[0]:https://social.kernel.org/notice/AkFSGxnKlr6Fc5vpuS

