Return-Path: <linux-kernel+bounces-348806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F2498EC08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2854528212D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31B13E8AE;
	Thu,  3 Oct 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hTHlk2rf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mzkro1O/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C010C12CD89
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946285; cv=fail; b=mNbBv4jMMNapgV1O38do0cPEQ2YPMCtM1sn4nwj1JI1fWdkiso9icqNPF299UqHxP1qU6tO9c7x35gRks0ANzfo7QFU3oSTuLeyKQ9Rx1a+POwpvh/ehIekD012Aog0Ibe/69+Vy268Dt/dq6sAalfYuSXIRADBS0W0Iam6ER08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946285; c=relaxed/simple;
	bh=FGUYoaS+aSrUAUrO2npqjdIxd0iKmarpg8D/w8HOB6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uLWpIKSGP2k2d+867WsqFbR2M57oFyk+dGEjvPHnN3TNUwt+3bjAav41NLH2sPlkja8aZEVUB58ElcdOaDLDlo2IJHGo6hCt19uGIG/sppWxcj3CJG4j8+j1LrZHZWOoVMAxUdLXM+wmYnRO/mvFtavnO6uym52Uq2gZNFrEB8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hTHlk2rf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mzkro1O/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4938tdH3024125;
	Thu, 3 Oct 2024 09:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4UchYWgCkx9b4eQ
	JWXSz+vBtDsOdJfQZG1W3ghSJUpc=; b=hTHlk2rfGGzUYTyko5fOeoF5lShzyzy
	FbFpQT1aDzq6dcO8iuJB3DgQOKSMJrdVQoLnY2BTAYDhMKbRWJwfVFcjk5RjN6Ny
	Xq3cUgwoMBN6igwveQJlOm8NN6FUSkJTMgSJ46C/E5bgcgQZRgQ4uAuhNhSr3K41
	CN8YVPJV6hK+6OZRUGwPnzrsxIiMB+FebIkKF9p/Vic6DrbHo2x83jxoEJoQL/gY
	ej5IGP3lnKc1K4EBpoqlG6wIX7Onj5gseQZ+pK2H9tfxg+u8bAxw8rQRKo/k/UBu
	z3y81G5UPwm8bWKw8GyzFiwXfNEZuWi7VHxUxLmqfhAg7HMekt7M5bg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbbhac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 09:04:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4938DWsZ040479;
	Thu, 3 Oct 2024 09:04:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889ws62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 09:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diSe1JTsHC98jCDkHPuVLmRjaHgpl7ihvGDySX190VGzvxK8hM4x3XcW+FrtBg6LEf9EqC1GnittZylBQuyM7K0wzDrq0IB5obdVqGuOMrmDWhr2x0UdQQedM/I+WRii5aC1VnD7JBoJBg3702IHP1xkq0q+wAFnnou9gADOKg3L2VokBdLIqQNtSem60rD5gYQyL1g+fr1jKpPv6ZgZexy6JWk0IaBhxZB0ZwSxRANJpMzHf07zHSmrqEZOTSFgpG7Hvg6bCIUNlZHE5kEFD4+l3CUJk/8vjWNRlCQW4WnqBkWFmUvYHPeXo4pvdESDlNebgj5Wz04EaI4pZGqJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UchYWgCkx9b4eQJWXSz+vBtDsOdJfQZG1W3ghSJUpc=;
 b=iq4vZmfBvGAyB7vK+QONwLQd354ZPQ+YBJZlENWThuos0UQjVpS5i0x7mfU6xSMgHdebvztGRXEatMbhF80lKwUHY/Ba0OYIfX/P9goL78Mhth8KTGuHaFkIkoBgmcYly+AUQZM5jJqal1tq3MfQnIEjCEfUY7ZkaoXEOdoPrVMKJiexoj8YrdA/G24rJRiqdz51LKut19SkfefTpufUZn7bNKNcjkEYDYjeyanO1/xdeZjknmEVnd/Uz/cqTX1QD5EBDVRaAzJpFFozfXq8QEV1Df+Jeq4Fx8zMcYqkmeigF1N0FVNap1aZm6OElnLqxy0CQK9SnHB2BrOe7QgdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UchYWgCkx9b4eQJWXSz+vBtDsOdJfQZG1W3ghSJUpc=;
 b=Mzkro1O/1stICBLE2ybgoF35CQaAYtXjfldBpBKh8pyVHNsjrzypucyyJ2RavSNN1XqoxVMBcyCKz5+kxkVWVuQeBkthLhqseGD68Nixd7ivRgiZx7b+aGc9GMOt6aZ0w7AerKH3ZTpR/zEy7sjr715EgOfHaMQLoY+zivQJKQs=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 09:04:33 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 09:04:33 +0000
Date: Thu, 3 Oct 2024 10:04:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <a8c8886d-e911-4357-92ff-26290e89e0e9@lucifer.local>
References: <20241003085914.2957-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003085914.2957-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 722f6582-1f8b-4084-d7cc-08dce38a6564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3G2KfRu9NjfABH6iZMO0a3f7cBNox8/ftTw17Li/oRWKfNDW8edwDo+caw4?=
 =?us-ascii?Q?g1Bnk1U7dexVE16FQtu8aDi7f/b6rSfTXfl8mye1qhCTwQGTqNh7P/YgkaAh?=
 =?us-ascii?Q?0Encx0KHXrQ/V9dZipK8vJz7CrXwHR3NEk8VUfMLLxd62tZCpnqkUrI50+Ms?=
 =?us-ascii?Q?3c8BUoeCsTCJtLTTdcqUWM4v/rBR9NRNnTCs16g9V/x9UYkHy5JLPyGiRb0L?=
 =?us-ascii?Q?8hAVp+CGs5ZNuLj6dTTqCMLhWdkrAC4AU+Wu694Mn66RsbLNrZ7/BcAxskyV?=
 =?us-ascii?Q?f6X7YKyYzvZVW/R24S0SCMAhPEnLluQjh78WeKOMjKqcV780WVROlULIAsHG?=
 =?us-ascii?Q?l83EIIdIW1oAYqqsZpLn86LmbLOd9fWlBbjv5DZguMR9Wd4UM8pwk5WuimSI?=
 =?us-ascii?Q?PTuBOnQRjbAkmqx2FScuB6VWiVZ241ir1WB7/L+uS6EwgfhM7C/FrG3kWZZH?=
 =?us-ascii?Q?MA3nxHvovaZgVlszHU4AIft6juiFaw/sGk5Vn7/WqLkulzkBNDto4crO+JQB?=
 =?us-ascii?Q?FWcQKhwnEFK4uIIZF2Kgf6QRmZxkiqr/YBAN6cKRS+IagpWJ4u3VMq1IK+QL?=
 =?us-ascii?Q?Uhc0wnFKyZABl7czM6oTmRMonlp/Kn2wuRSKRDPREiIJfbiKn/E2wWniHBNd?=
 =?us-ascii?Q?J5e2FrzEdx/cHIDn6wpEsxltNigNDlMPFi3N09OXrb0ymUqNU0E2dpPzvtOF?=
 =?us-ascii?Q?di1GT9clmrqZZHzCZq4Le1x05O1uYWRY2eY2+WCYeVz//KUNidKviGcaZMWF?=
 =?us-ascii?Q?s5B5JSKMN8BgRJO+q13q/H5b8vIjXmsfpBhru0yvwagXj6wqU2au9Pdsnc6F?=
 =?us-ascii?Q?O9PZIJo5RuiG1hS8Cvluy5zNtspgNC3xSlTXX8L90u7rHTaobLppTCJfNHWP?=
 =?us-ascii?Q?7irT86wnbm2vsI4R8UiHrUKbN+h5/T3CO+RFOnl3/Jl91NbF5x0bKDD6Gh8/?=
 =?us-ascii?Q?MIg6MkVM6GlnyxbvcnRFx9HciiOFwuirXgDKNwhM+uQ9v5Ps4o2wAkV60JIm?=
 =?us-ascii?Q?hYxG/7nN+ViF8EYxOoXgxre4hr/KZ95XWyStyapK9Pnp9YJBu2qhHRVN2m0T?=
 =?us-ascii?Q?dQ3gPZ1U1TBPqxM3esWdsYiLpIl4/Z82rOKJZ9QRQlSQKHEtCEsJCy790sXD?=
 =?us-ascii?Q?8MSyOZGlPjX6+or+tgSjXn5wChcZJwoS/XbR5Gd8DWwUdzWWDFvmrSbwASDF?=
 =?us-ascii?Q?uz13EVWHwdL8LIuKatDlgZTPHl5rFqOwLGomdTSCfU9gAfExcgDJBAIbIBE7?=
 =?us-ascii?Q?yGwujb1YlKr1v+BJEQNYZgo9YP55irh7HdWvm1oP5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oSUrH0XgTNpHINPQMrJc2MOs4B57z+QGmNRGlwzFNQAcRRFBzE5XbaagwUzp?=
 =?us-ascii?Q?owuHGqSpn+EWsejGUBevhSdk2A0DqjYD+/PNQFNNu4Ql0cgHKCA8U0oHs8EB?=
 =?us-ascii?Q?6WWIlrnnqYKToiL3CRGnaqLiJ9dN4/V5FIlo9ZJPiKVz9EBHI2xQs0+/Fczk?=
 =?us-ascii?Q?ROY9g1wNepQLhaBCeP/troFhEyeAa4QuphG9LANt12EKMKHdFYRcvGNFBPim?=
 =?us-ascii?Q?Q4YpqhvP4zaQwrSX+5IA77C0Gymn+SqfYWnCwaRdkPBxll0jeg91v+O8RvFw?=
 =?us-ascii?Q?oPdbM27oNlpJDGxWxxeekH8bV+IvPRsCq1Zo9kBjt2QMMQzs/goFEj+G1CCS?=
 =?us-ascii?Q?HER6rmgdRTgX5r/GO8pX3pMhxQAbMFOxKgamxxqmPnwB5e9MM4Trr3nhNN2q?=
 =?us-ascii?Q?KwS+I+hUW2S1ZSODtPlrCZkXTHLYQtVlAVR0HfhKa3DGbTYyAdVYYEjhN2aY?=
 =?us-ascii?Q?x6uSRjdvm2NlOGjNcYBZHrhRO8RL5l4qN5J/yb34xJYpDJ7P4Xzjr7kDowlo?=
 =?us-ascii?Q?Z2+IjxNp/5kB9O5flV4jo5McL8135gbpGNSXTHuTC8ySw2g4VWHDkRP2Kpwb?=
 =?us-ascii?Q?DeX9DI7s7bU8mUcjB59Z++tOOcd871eJFpnttdyI0MbVHJVlX3lQ7Epk92jm?=
 =?us-ascii?Q?L2tNq9d58FEwu8QxoI7EfNYIr2zairfjs5hS9XHUtndApjHaaTcPZM5+XrEA?=
 =?us-ascii?Q?xD26d/p8kka0O/mEit48rg5WZYx2Ukrnxt+54fMjjH6RMu/DnAKTOCWFGUIH?=
 =?us-ascii?Q?LDiStmt2FBoFA2vwiQugAO1kX9UM1fvpSJbuJB8P4sCh8wMa4iYvKAsCt4bV?=
 =?us-ascii?Q?yMCosIfvF5aG6vjgPHEH5GGPzJdBj9zBFsztZt5hdhQa3XZ77dPH/T2Cmvgi?=
 =?us-ascii?Q?9VpxosMBvUiJQnuMTl0A+39Cp1p7bOamE9sWDvIU1bqmCTl6prLrKA0X7aKa?=
 =?us-ascii?Q?y0ypVXSNPsuofTLCHaB9nsX0Od6aeOzNUSn68LgPuSJ2MMGrqofYZnmXMIRL?=
 =?us-ascii?Q?YIsALTNvlF+ivv6r5p9nGyNk2C9H94sbqSaiGJXnQfRCkH61G46eOOCYtJ47?=
 =?us-ascii?Q?GMM4HL/obmqfDwHct2t8ANKb9tEVwdKW0AjfKlI4PcPF0OpQI9KDMs//tknE?=
 =?us-ascii?Q?z/x5BV3aHUbFZyyb5sjZZc0Rx1KDh7rlTCs/ChfFk62R8E5YPOpuRWK4fub5?=
 =?us-ascii?Q?tSMVnu+UIcmSay2WaMufOh62Zynj5DmUgjSKnmc1e/plz6zs1b2VWjGxM1EU?=
 =?us-ascii?Q?WuITF/P4BlOjClTFLg39SR5VcqSX4QO/aOu73RZt5ITJED50Fbak5OE9+D05?=
 =?us-ascii?Q?xlVBlO9NgKhhG1xQAMoKc8wPTrB4eYOsA4gswkMiU9GldKPVzEATJTSHvpJg?=
 =?us-ascii?Q?QRk6fwqSFAnsw0NvYDj84+4+osEJtGXD4AL9QRQq4h5Aob0aoXsI8biOToSs?=
 =?us-ascii?Q?rZv5rxp7zX1WPwde9o6Ofz9qCDlSqugpkNj/2Xu3/M38/weCYmzIbeXVauyo?=
 =?us-ascii?Q?k/4cPoI+7Elr6jZDMgIC8GDp2s8SUz25nQ9PZOmj0si6pqRSGDHqyj2Ri88K?=
 =?us-ascii?Q?7P20zl2HfX8kUGoijOJMoayYy3EvLp6l93JcY849uX3XN8YVAtmdr3doFQFQ?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c6+s+5E+xwBM0J2Dp6RDcaLk2xEGc/mUxaf/HzPQFtPF584yK8VVCHaAE7Zb9UGHejcG0YhQApMr/YvYe81OrgZ/53Yui9igB/CrMXKW3ZZPa5SZcSXpXI7XPIKAWGYC7KKUoulMgiMBwuNA9DFVdZurP5hiXNOGTSVTKFKSu3HE2FBtsjC6mkdvIZa6s2Lfb71k2Qe2kNCaDLSimH+UTxrXeoSM++wNVOYMT8DI2j9gvVG9IJvBJcPos3FOBNekRqPYnq3eO9vBXLdRC3eLHjq+n+0uXsNEq8D8a1+giR1QR3oMZRIpZaJRLO7YhrK+TNU5957tQ2fSE7xMpOh2uXa1HtWs4mIEzhyzhYXKNZR4JfrzkP5NNyAEfp2V3z2NTClqgLFN6G5Sepwb+cdfe2RV/C2ct5nTudYocbiHGzAD6KbwGjDgDSwv1u4Ega3PgcGWBI7uooQNcMak9D/evdiT6x9rM2MmdOiplvWsgU5KUfv7D88sSNS3LIQD3e6ButCYpE1fR050xAomgo4bAgWT9xg6MPgoufCkwBg+Qxg9RcnigD4CBUWZ8SBhWlbOi/UUtKun9hAH14MofXrhanqJl43SlBAmBlGJNUJk7gw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722f6582-1f8b-4084-d7cc-08dce38a6564
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 09:04:33.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvWBjFecpg61H3xxSNdHSlQQgan3DhJcIB9yYLeRXNX6KC6tO3kubwIxqntXdKqM+36zKdGBOzSIoMT9OshcybqX6I1odXgjed7j8Bk3r/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410030064
X-Proofpoint-GUID: i7umsIW6ywlkZzfaAT70cUpolyhtbw4A
X-Proofpoint-ORIG-GUID: i7umsIW6ywlkZzfaAT70cUpolyhtbw4A

On Thu, Oct 03, 2024 at 10:59:12AM +0200, Bert Karwatzki wrote:
> Here's the latest log.
>
> Top three commits:
> db8adf7c0a23 (HEAD -> maple_tree_debug) hack: mm: see if we can get some more information 2
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> Bert Karwatzki
>

[snip]

Thanks!

Could you try this patch and see if you can repro the same bug?

----8<----
From 291eb64273dbafa4823a2b21bdae714ea1f021ac Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 3 Oct 2024 10:02:04 +0100
Subject: [PATCH] maybe fix

---
 mm/vma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 6abeef9bc2c8..38f69c656825 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -598,13 +598,13 @@ static int commit_merge(struct vma_merge_struct *vmg,
 				adjust->vm_end);
 	}

-	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
-		return -ENOMEM;
-
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
 	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);

+	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
+		return -ENOMEM;
+
 	if (expanded)
 		vma_iter_store(vmg->vmi, vmg->vma);

--
2.46.2

