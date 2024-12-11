Return-Path: <linux-kernel+bounces-441086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D59EC938
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC041285FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579F1A83E5;
	Wed, 11 Dec 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ED+zTymh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T2OR/pPc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43B86338
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909746; cv=fail; b=S7rTEYMYOvFriGuVAEwe5z6pGgX2dr4qKVi8ZiRsm5/jG+ukPfhLSSP+HZRTWQr+8wb6hrEh7jktkdkQ7X4FMUxlI8heygbvRDG8zmpbe9pWOqDl3RRoKYi8NQKskaC9zONz4BFpyUbctFxsqAiMPc83KDpj8b1n8YGEp1vEJHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909746; c=relaxed/simple;
	bh=p2bNVLI4rWiF+fY4jo/t9BF8uKaDnMoVVIuOExUcIMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uRF2sjUW5AADnA8xGPVe4s1nGJcJWwyDd4fSPOMtZxcG2vXvIsGHtyC8VZPPmzEJv6wL5u6Nxv7Bi+19eb9cmsSswXursWyOD06DRXtuS/png6mlep2CPLBheCf/lsW+YPyyJJQqDIy+HFGc3KZwGUPmJG2HpncDV/yZW/gdKpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ED+zTymh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T2OR/pPc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB8RSdd019116;
	Wed, 11 Dec 2024 09:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=PzDWuJmWu5j8zSsYCR
	C3ATpVDDUf8Dw2nRZNXHnWeA8=; b=ED+zTymhrhVdUt7iqVIwPRy0mb19WewOXw
	TcXsczSu2XGYij276YXDE4AAcxNhun9eS9XqitAbfft+FzzQgdaL8QHD3Y/bX9rm
	fLrtQVL92h+VO8l/SoGrBnB/kZOzd8i4LKrVsuDMS4QRE0/Negjx7yJ42JWX09J6
	Ay80kIltSbl5TiSUa2efbjCFKfIS6cp2QDV0+apbuExn3IOKfSUP3I2IlzoElK0e
	4Ho3S2jjTSHENj5KY23CYXN8wc09l3PS5ZFhXxysZjZ1yrKmXGEdJwC1mipNeaAN
	9AiDYYa61FYM96H/bLixLNDk21vkSQWpd/J+dEmythgGlou22tpQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9ar61h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 09:35:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB83XGM035590;
	Wed, 11 Dec 2024 09:35:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct9s70s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 09:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyII4IzekfJg8wvhwV8FWNIoZ+G682qh0qz7mKUgAw66PpTxTh0voCMfOZXQkTURAkwgvPX6De5GwSrtedccSC2VOOwxtm92YdqJTK/uCnWwSdIEHnaDL1+snpAKFi8WiR4nhvJiQS4vSVBWKUr5kf9WFSxNPYsdTKqyKEF33Bm7ydSN/ZJr9ZYBNeqJ8JwHgFTBfLz8GULjETLurHngBj4Yjk1vi+6w3PrrBoVwWiTL1E5TINeHmm3yiZ5Qko5ZH6O6/985D6G8Li5aFsgQElQ67a/RoyWZeb3+vWNPgOu00roqhRJWliQkjd6hYm9+M8oKgIx/mIcUA2D0iTfdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzDWuJmWu5j8zSsYCRC3ATpVDDUf8Dw2nRZNXHnWeA8=;
 b=jNEpyRAMhCKl8cp0THJAeXTekUqHUR+ZC2wZtwSUpgFoRPLx/FSTOVraOoYbAkHnOsKGBQhvC7l3vHWlCiQ7va2p3X7L20Bu5Uh76+6IEeNNoG3YKgEz6cjbgwlDURBYB6YBtk7fsCAN5hbBGiadj1VRinM5z2jRylbwZvGTQxr1YO5ZTrQwczzmnNyt+e0CcQMdT0g5gjX+X9m5euwT6Xz1rxPUff+Ki2ExROUnSur/7xzXl0gx9Oe64dH/eTvPSDIdo5ifOZVE9IlfBn9S+8Bh5f2lf4mFEs2OBEZZ0TxK+qh4LAQLb0Ng7csqVbenPgRmVIh9Y0e07x51dz7rDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzDWuJmWu5j8zSsYCRC3ATpVDDUf8Dw2nRZNXHnWeA8=;
 b=T2OR/pPcv6F6sEvJ9T1IlI/B0W2o3zH8qa9eaDZGWIQayNfhbRgxjVU7BkvanBX6afT0XTyaKAer3SN7Ad4iWLy4Zpf/duQ68MK40+3/0bAaiZnAqNpGFwtZlT55IZFIE79apUAhzqDrtyjmB4Hro77YCJ8uip7y8dM3R3e5fQU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4871.namprd10.prod.outlook.com (2603:10b6:408:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 09:35:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:35:29 +0000
Date: Wed, 11 Dec 2024 09:35:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <bd0ebc49-e5ce-4cb2-a7a1-14e864c5888e@lucifer.local>
References: <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
 <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
 <dfe6b339-a742-4adc-9a53-c653510428d8@lucifer.local>
 <50e194c2-914d-43eb-bff8-47c4a1119dce@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e194c2-914d-43eb-bff8-47c4a1119dce@redhat.com>
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdfa949-23ac-46e7-cc93-08dd19c72682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flmt89uorgP9WwGMXTRJNP8mcsEO4lJAyTs7+VGiktAvgoH0O13kJLQ6cnZB?=
 =?us-ascii?Q?HAanWMCdKdFGCnYq71KBq2hXW88R78Svn8PMimMwnQjK2RCXptqnNsXz89s/?=
 =?us-ascii?Q?Vf3eJMxS01Ql74GlT3G04wdjMnl4eIFOE+j2mxFNy2qi8v8Quye5gcAoM1XU?=
 =?us-ascii?Q?QxpidVVWpyGYkCTO7V6HpDs+Dum2D7x7Je7m+Vx/YXmasFkuQBzP9ADJpjPY?=
 =?us-ascii?Q?LBa1CkwshcnJWJpT0DxHn2R5Bp27ZohoMcAyb7lIP0qNsGil5stpYo/rqGbh?=
 =?us-ascii?Q?tLCXPQcPb1Zk3m9S8eRmkFB3A9kn+dG7LJGG+m5auvb7xerziHy/dG43MSGi?=
 =?us-ascii?Q?bPm8fHganobce4rH2M5sQgx9CUsMUDxhvLSxFkwbxF7CwJ8gR/xpyfQRoC/+?=
 =?us-ascii?Q?ApdXzgNt4l55cAFH92wWSokUBDkheBdMIbrg82v3Ia6BRaGcdiRs0zCFXnpN?=
 =?us-ascii?Q?I58xkdj70y342A1FYusJaiVcmsmR/gmiOXgXaNArphqBlvNOwffoup+PrNNK?=
 =?us-ascii?Q?Gj7wXJiLB8FuR5UN9CPyiy+xGiVCCcNcKXJou89fykBSMTDHWjGUOKKn0OnM?=
 =?us-ascii?Q?rXqrScwBpF5OKwEPS4juwaQ2k//+9s9uHVh4NLqKRWvGKxHALHzyHzCKSTYP?=
 =?us-ascii?Q?L7Z+1Oiayl1ZNGJcGInhW7VQLquu93s/zmPEzs3prjKNlO0DYYo+bBGrRGqp?=
 =?us-ascii?Q?dxd3E+H1md3k5xgPjWYZBEgHsJeP4lJiFDoc5kDnlDBhD5g1C1B7uAsJTBMd?=
 =?us-ascii?Q?qj15+f9rHasNbNJC0LP3hxOwrz6SzF4BoUh5rqmdnND6/GjU7+MUUoxP0QT1?=
 =?us-ascii?Q?BfSTL2ZIhTxE0v72CBePKPkIoxa79H59981w844ms3X6Vy8AzORoD2OhT8y/?=
 =?us-ascii?Q?MT7CuP922rr9dT2uNjlyEKOWtNFgiTqAmTckp5uKDBEdUJ5GEH+0RoeG2Tvq?=
 =?us-ascii?Q?UCImgAZ0VKWlgKKDtTwB3PSJ/GFtByuBysJFQmDhBH62ud7o3A9N2QgsDuH1?=
 =?us-ascii?Q?8gDSDm74JNB0qdLUt8C0x79m84HjMyFkG3d37g+qX2a+6+/Ei+zdKpjUmDVV?=
 =?us-ascii?Q?UpEK5i4o2Zsj4eP9uNMQG81ftYJS1x9kf4qIQaSsCCA88UPjCIyRyx1mF+q/?=
 =?us-ascii?Q?3gpw/XO609Aet/PvDELY0TIzM5MY9BvG+DNYgVeMvB0kN7xz8gMSnTGURH5O?=
 =?us-ascii?Q?8+fZkVGzjZjYo0tDyTy6vmERFXzf6yYNlqTbWITO97AdwbL9riXGGMhdjCx+?=
 =?us-ascii?Q?Vy7nj2qIF2EaBxclcOJhzdzHsp7vMEX7JvN+i6iiY3q+/wBJdV9LxchS925G?=
 =?us-ascii?Q?xK+XcjxsAG/h/+jzmGOI8FKCO15nrjzQyUs59Bdv1cCWAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xYAA9dTJQ7FP71vlOYYaDLmytiCA/UmYjzDgg1XrthcUqpvUsF9P65DI6J7v?=
 =?us-ascii?Q?oru9dS58hrQ2K7tuQIoq1Pz82gOpuhAwMQ9CpMFfG+atF9hMOS3Qwsabv8Yk?=
 =?us-ascii?Q?8cmJl6Y67r3L8nJOzGtAAFmSV0SBSgn0Ik9xHho6UfsBhUWrNbQ52ZgkvecE?=
 =?us-ascii?Q?x+ekOTI0fXsWNrK0PElc5JblXzJxM3IT39DD+VGQUfsbjUdNbGYgkmcFVRni?=
 =?us-ascii?Q?7tLTFvPFORR7dOCISocgpD8+9hfabT8Muogg5OCbIbGnIQB9QA/0JNS9U2b/?=
 =?us-ascii?Q?tRhtO+fneoyrp8n0mEhSgdX4zkdFowL4rOLoAQz5+Z89SWHFulys0KDNsBdY?=
 =?us-ascii?Q?TrJnePp6QTOaKPlj07yvNEXcGdN7/rmNUjSK30mYkVSseDxv1JjAMl0ru9bo?=
 =?us-ascii?Q?VDyS5Gw9QvmG6CxwmE8th7F0ox9Pin14zupiFYVsGLUoDjR+tO8X9VbB/izV?=
 =?us-ascii?Q?87jk2hM8O+XKqEbigdZ2PXj8eD4QOawkl13Uee2diHE2MXzGdwsH93+DZE5s?=
 =?us-ascii?Q?U35SrOj9oXNroTncWCJYtrRs2QHS4pipxowfiap0z6ircgMbZuSX/1ybBfJv?=
 =?us-ascii?Q?KVNh9+1RcdSYVlOaVIq7PwAv1S/ZmxyTFSkG/SUa2TVIiZaMs80t9bal6bDV?=
 =?us-ascii?Q?yZ2EEUwh1UjSTVPEv4Shvo6cPpWkm8AhUYLvIuWVQA6uE1nF7rrMvx+LPfDU?=
 =?us-ascii?Q?dHQSD43PrAmtwojVXG7On1EssUUEg6P6+FRGTCyd1Z/wrcpmPCqr4bovGw0E?=
 =?us-ascii?Q?Qws27VKGyVmbP3gfiFi3CVv+GPdLbElawL5/AO2Ob7tlwsbc+Im6FPl1tIgP?=
 =?us-ascii?Q?L23kavDlb/bhAFU2ti9t1YBFTmNFlyzOJlaig12BN4Lds/8hmgGj5yX+dsrM?=
 =?us-ascii?Q?H1cZ47KndgVTrdlMBuMaSZMN0PFtFQC+hvLOXDqVVj4ulfvUW2XDMne7gzw1?=
 =?us-ascii?Q?hwCty6xIZ1KLKH7wCtR3BcF/pyiCRMLC7QvxH2YInbi97mChu/dErtTHxsQD?=
 =?us-ascii?Q?v73yiX2t2PTiKHZRcs8Pjirj9FOvPj/CeNnnkh0DBtuxwO0exPV61UyV8bpY?=
 =?us-ascii?Q?orO6i3PoMuQUy37W53MEiPSX8Dp9iDsX3KQ1FMh0uNyiieLdLHwMyhp86C4w?=
 =?us-ascii?Q?YgqPB1RRs5HLWMZx/iKTwWNffvIOC6Hjiq5BzeIh7+SdfTMDO8GzBgeg3qgp?=
 =?us-ascii?Q?FOVhO71b3M+xj9d36hxE6vLkwE0Sb4Z37nrJTpGyG+CZh61aIOVKCx/5W28T?=
 =?us-ascii?Q?MXxdZGFmxhZ6zHZKefqP6yKzhO9KJCIbeB9ijzN1DjKYYuoi1RrDBnIWp1Re?=
 =?us-ascii?Q?sEo3SHOX6OoZobcwLgJ7GnM4Ozx+K8zdF98txI8cNxXPNedAI2guq1fPO7g8?=
 =?us-ascii?Q?9l78uPRliPIu84ISpPTc98CCBHrRVmmGx6/fdj6GIPP8b2ctr8rwdJYdIMOq?=
 =?us-ascii?Q?f2yGP5BgkuzDpo3uBz2qAGM7lAyMvNEjRQM/6SIDeplpCHIaJOjHt8tmCCus?=
 =?us-ascii?Q?+OlcIMwLUyy0qZWgRTsER6s1RDAi72I4GWnXRJB+0qOdMd77E33aGvkIfStp?=
 =?us-ascii?Q?Vr6YU5KpvgaVEbIsIBQ8G3hMgKXQGUcBzohr1IV18hZwjYbRL6APlhYpFZZn?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	smlvH5qFZrVDQqvq3lh0d8O6kRuvHya2388QoypfwfhzGR9xpM3JjH6mt16jtcqaoNz3jZIVKi0eo7ostmgiSuwOKY3uim+9XzEZLDckylJFu67969UD8i54stVo+CzEEyK/EsT/MHu+lR44LAncUaBafZe9dSiWVDBA/CBrhQ1zdrUd+QdsiIdvFIJ1ZbGDKXhWmEr3lKlzb8bO7DeQBAdY9angM1Qwnhnj/84de7eHVH6kbppV+cPi+7RvKrKgy43dsA96rB76OlpiVN0x76/Kmx4Buv5HV8qvnoO+QhszXIISr+hVuY/HIz2maxMhNaYkKBA3+KnCtlOPW40C76zbg3PxQrt7wlTR5OYtHsjQDLOaJ8yQTYq7wrPbSBUnvn8MoRRdcFxDEc8nTzXbavFcmdQ5qE4bwCrCAhA4A6PwsPwJesQDrOH4zshAVIMjzj4TEM45xl6vyhoP6qW2LUicN7q8GJm9z1Ur3qGR+fYhVpUOPZfu2XEyjm5Nd4BMhMY5sFMcsQf1IPCRhUYG9e1oIePUim1RaDN1c0Rr4fyxRhNKmj6aRTaCIIt8O7TAlNtluGb26N8s5whr+g1AKIw+BTbB+ovjXJAi8VB7/08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdfa949-23ac-46e7-cc93-08dd19c72682
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:35:29.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiDzZBRrHkBGK6pAVOUfGCQpFRX1bTxnB9DEqn66nh5ZsRFUsmeNtXxVo+2+pfyziuPCnbSlVT+zcFb4C8N/uKOLD+FNlUaYelH4xxCaXgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_09,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=938 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412110072
X-Proofpoint-GUID: Fm7EkY3CMlcNBfePxiiXuIde7shEQUF3
X-Proofpoint-ORIG-GUID: Fm7EkY3CMlcNBfePxiiXuIde7shEQUF3

On Tue, Dec 10, 2024 at 05:59:08PM +0100, David Hildenbrand wrote:
> On 10.12.24 10:51, Lorenzo Stoakes wrote:
> > David,
>
> Hi Lorenzo,
>
> sorry for the late reply.
>

No worries, we're all busy. I'm off on holiday after the end of this week
also so if I disappear after then this is why :)

> >
> > To avoid an infinite back-and-forth...
> >
> > I think you're stuck on the idea that we are sat in a VMA 'vacuum', perhaps
> > because I put so much effort into separating out the VMA logic, for the
> > purpose of being able to userland test it, it's almost given the wrong
> > impression (I should perhaps have put less effort into this? :)
>
> Yes, that nicely summarizes it.
>
> In particular, because the patch description says "group all VMA-related
> files", and I am having a hard time to even identify *what* a "VMA-related"
> file is, really.

Yeah I definitely misgrouped this.

>
> For example, why not mempolicy.c->mbind()? Not that I would suggest that,
> because the file is filled with non-vma-related stuff.

Right, we have a lot of this 'mixing'.

>
> See below of what might make sense to me.
>
> >
> > But we have for quite some time now de facto been expected to maintain all
> > aspects of mapping, remapping, etc. INCLUDING page table considerations.
> > > We are more or less de facto maintaining all that (modulo madvise.c - I
> > grant you this is the odd one out).
> >
> > So you can imagine it's a bit frustrating, when that's the case, to be told
> > in effect - no this isn't for you - right?
>
> It isn't "VMA" group for me, independent of "who" is currently listed there.
> And maybe we now agree on that, maybe not.

Yes absolutely agreed.

>
> Talking about things that are frustrating: being called a "senior member of
> the kernel". :)

Haha well, I still see myself as a raw "junior" if that helps ;) or maybe
makes it worse? I don't know :P

I am at least certainly senior in the sense of wrinkles...

>
> > > For instance, as I said before, we have spent large parts of the 6.12
> cycle
> > dealing with practical concerns specifically around page table
> > manipulation.
> > > Maintainership is more than setting up lei rules, obviously. One can set
> > lei rules for anything. It means that our say has more impact, and it also
> > means that we are (co-)responsible for the listed files, and that's acked
> > rather than disregarded.
> > > So, again, I politely disagree with your assessment re: page tables.
> > > I think their manipulation under circumstances where you
> > map/remap/mprotect/mlock is -inseparable- from memory mapping/VMA
> > logic. Otherwise, what's the point right?
>
> We'll likely have to agree to disagree. :) But again, my main point is that
> the VMA group is misleading.

Yes and civil disagreement is fine! But yes agreed on structure.

>
> As a side note, I believe the code can be structures accordingly (call that
> separating it). mmap/munmap handling is the prime example right now for me.
>
> For example, I really enjoy how:
>
> munmap() (mmap.c) routes to __vm_munmap (vma.c) makes use of abstracted page
> table logic like free_pgtables() and unmap_vmas() (memory.c).
>
> This way it is clear what the rather high-level MM syscall implementation is
> (mmap.c), what the VMA handling is (vma.c) and what the abstracted page
> table handling logic is (memory.c). I don't think that page table handling
> code should be moved to either mmap.c or vma.c.
>
>
> I would enjoy if we would handle e.g., mprotect.c in a similar way, such
> that the helper like change_protection() -- again, used by completely
> mprotect()-unrelated code outside of mprotect.c -- would not reside in
> mprotect.c. But that code just evolved naturally after we kept reusing
> change_protection() outside of the file.

Yeah, so I think another step forward is to start actually moving some of
the more obviously general stuff like this to other files, I will look at
this in the new year.

>
> Regarding mremap logic there once was a discussion about merging it with the
> uffdio_move logic, but not sure if that really makes sense.
>
> >
> > My suggestion is that:
> >
> > a. we put everything in MEMORY MAPPING
> > b. We drop mm/madvise.c from the list
>
> Sounds better, although I am still fuzzy on what is supposed to be in there
> and what not. See my mbind() example above ..
>
> I see how mmap/munmap/mprotect/mremap fall into the same category of MM
> syscalls that mainly affect the /proc/self/maps output (in contrast to a
> bunch of others). Which make sense to me to group in such a way.
>
> mseal.c and mlock.c likely as well.

Yes this is why I think these belong together, and under 'memory mapping'
makes sense if one sees it from this point of view.

>
> msync.c is a simple VMA walker ... not sure if it belongs in there, but who
> am I to tell.

Will drop, was a tenuous one, just seemed like a tiny vaguely VMA-adjacent
thing but agreed it's a bit out of place.

>
> --
> Cheers,
>
> David / dhildenb
>

OK so I think we're (probably?) now agreed, I will submit a patch shortly
that:

a. puts everything in MEMORY MAPPING
b. Drops mm/madvise.c, mm/msync.c from the list
c. I commit to moving things out of the various files that truly belongs
   elsewhere

I mean there's stuff that's weirdly used for page table moving in mremap.c
that should probably live in memory.c as well for instance.

