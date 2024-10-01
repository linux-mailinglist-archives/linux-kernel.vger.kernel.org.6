Return-Path: <linux-kernel+bounces-345837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430798BBA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 759A1B237C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29081C174F;
	Tue,  1 Oct 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxkUF1UV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hen2cgT1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE31C1733
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783786; cv=fail; b=WFWnGyt31e/fl1wNOwIkaVeMowgqbe4U1h01E2/RbkL+Yf8ONQP5P1HzqVs/4pZXwaQCMMvkkX6f4VJKWmtBY7bY7zPInP+Fr7LhvbperKKrHwkKgkSyUuqopeBHHYFdCU7+hi1+Ll3aylyYAlqBjwUhz/Gu6DUBa2Q4i//XDLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783786; c=relaxed/simple;
	bh=svnQ3ilEn0tl2MDOFqD/vDt8Ujuo3cmG1H+jogs94hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q9rr6l8OBialv8GSZqd56Tir735K9+h4g1cpkZRo7snfgAUclZIm/tNC/O1JXd6O+N2mdbHpXG14KwILDjcDry31k5KB626t+giB9YBRPDeSl2hfxv1rDfNCx4vpWHD5NohMo0aS5RvH/cyuEhZlg+kboSXcV87v66TyP+zvF4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UxkUF1UV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hen2cgT1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911trkT031841;
	Tue, 1 Oct 2024 11:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=vcDENHBTHljQETy
	YJ8ch6ZP4WaRm9243PnpMO5Q8VY8=; b=UxkUF1UVmO3k7OiDxqqJaZtt90/hQEd
	f2h905j618+MqI39gT7GRWkUf+bXm2Lo+eT8khsDue2U+Kwrez+SkYohX3qobTdM
	128Q1wWe/I0AYW7jKyRQrwp80jDokXU1enqK9gEzTpRv2ITbOC9CwmUcKg7MvsAh
	29QwqjMX9TJP5OCjHLxBWZtb3BDk6RXqLJSlUCel7+opA3G7sDhY+2AfihcvYRRU
	3TUADOMJfBunvmnqM9hOGe4RTL1UBLndRV5+m1Zv6XLF3td6SfQnH6BHVR3GLpAS
	5UgJ/LZfnkJbmBvicRiQVnZSG4Y9P4f+BmpdLhFpVnOjYLAaedZliHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb61fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:56:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491AUIZG012510;
	Tue, 1 Oct 2024 11:56:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8875xnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsPeIBEoKx4opgpSFWJyl1qCUzXlKTcZjWVSLRx0spqCzzklWoVw1738WL2zHaJVtD4pkvNR+CamdklIJWZhqyXB4MxcTpr6oDmyY97ntJenF3VfqnUGbXUn0tcR1nyFm53D+xVHtuUslevehCF0GmrngQ+8eKWZvyvf2gp4itmYOGT+Fl/EAyLLtJasmPqNduIAhH0USSKZwml39afCNfhEjVH4EYqmI3Bw/G5/YeenRCZRYHTxNeq6ZOufs9qsvv//QkH4bp4yFxBEXQICk92R+GhVMDnxQMiD3SSQC4ImSSXCi/cPrcDDTlGAGYqRFppViPw8ndS/HhOjiiMO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcDENHBTHljQETyYJ8ch6ZP4WaRm9243PnpMO5Q8VY8=;
 b=uZoz80DLC3EtfV4DZQHia08CbXEYIj3RajoeoPzWxR4TVstaziyAoSvdsOs0dFLPZVyQuRHsoJAdWXwCEXY1L3R9JM2PZ6zTigmnrUb9FYZ5Ce1MO3sYu4bcBvqjh2dSvW1dyhECVvCd2B4Tnf/V8facyLl8QgyMwKCR/GAfu01jNTis1+m268pzTU6agBpfoApCR1NxKbRsjnB8ZUyFbIGS1c9h/tU0N7yCDYXm4TgpnBic4A1BTMe9iFuoeqBe/rUxWzfCyREJop8PYJXz8lA0L5DDhfq4AdqQ93/qM6GYI3Pefc0kZn5AIbv7Vcd2WMIb+dz7nknwcC8l4M8Qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcDENHBTHljQETyYJ8ch6ZP4WaRm9243PnpMO5Q8VY8=;
 b=hen2cgT1theBdYvpCFwP1SQ6CQ9/v7RSxN75kBlhwMQok6cBbgS1NFaWG9uFbb9USJkkX5ygYNKKa5Ilpb1J7F328jrwcQ62DcgmN39bgMSY3F+sDZx4QXXQjl/TE3tDrKnpssLwDHkV5VuYEoHKk85hs8Gj7DCtHSHW8qwCIlc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB7527.namprd10.prod.outlook.com (2603:10b6:8:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 11:56:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 11:56:12 +0000
Date: Tue, 1 Oct 2024 12:56:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <44271477-0789-4fac-a649-75420d0c403a@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001023402.3374-1-spasswolf@web.de>
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 2042fe7a-6297-4c01-6200-08dce2100b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g5ou/8T0NVhGWhh824ePoRtJIKd6MptbssfnqcIobjhdPHFPyyyg11kCLJbA?=
 =?us-ascii?Q?UK2wJDwxO94KR9bSQ8O/N6774vpQN2mtJOJj9TpJ7aoPWjer0BLeu3+smOX0?=
 =?us-ascii?Q?lvg0X/p+K8u2mDP9vN70qLg7DYJEqqT7cr0wpC79VlZIAn3a+yuMgOAH0Cb8?=
 =?us-ascii?Q?6qGnBDPtrY3ixwCRVO+yxzX+iRzvMUmaNmuwvJzbLBNnLuVLpxenLCkVJKmH?=
 =?us-ascii?Q?P/J9Pn+zlFkdE9dm2QAnMdYbkIhUNgMP2OgDovMu5sF/7dWmOxso0vhhiptC?=
 =?us-ascii?Q?C8BvPzVqPcP8KbV71G4e3fInO5xvXEA8ksH8/8m6Rv8AgU3FXtfOF5ov9UWG?=
 =?us-ascii?Q?fJnnMy/6UOklys7kTiM4hpA60QAvaPqx4aXEMLEC0On42FD+unIKOT4i/U++?=
 =?us-ascii?Q?7rJUGgCcZ9L38WGsXx34pFGPziJh6xv4PMbLUjcGXepMrvZgxkbYAtZoN3mi?=
 =?us-ascii?Q?mJOdhdd64oR/hpyVK8317Yv2ImJLUeu+1tMgh785aFU1jSHx/vL9QL5KMfzy?=
 =?us-ascii?Q?Ifsa4HASove5AUAYey8MqcQnKFuMFegsYzG3GQRpN/FjnvccdsJ3j4S1nu4y?=
 =?us-ascii?Q?XADD09K8S/g1IsvgUG7x7ofCq0yX/G7GJp8puyNtjLKHRWMJXWKiZo26ZYNy?=
 =?us-ascii?Q?nxyvzTgOzkghGQYgtHFF9N7uKMVO5POGNimLsqfZyJAwM5bdf/ViFS2WaN5F?=
 =?us-ascii?Q?idIajLmqeE9X5OmT6zd/0wxWpJ213ugs6Hxb82VKQqZ9Qe3KAIzl3G2tygTT?=
 =?us-ascii?Q?qBqcEQiVYzexoBkmLhm51hAOieyp1230IkBEJV0N53KrzBRRStMLfegDscPk?=
 =?us-ascii?Q?DcTEk3ZtkcHA518mY5lh4xauhHJkAo+Rgel/FBeZ8PoHkNPcxr4h/lLooIrr?=
 =?us-ascii?Q?TUg/IZU4o33WDMghrpHKzEYbBaPsb2B0KAdgPcNoN+CGt5nGxQFlYNRd+ZcB?=
 =?us-ascii?Q?jN0S4FHxet+PKCYtZl2keEYpN6wt0/TtXTHAVm2hdTu3y5jBDo1ELFHzfz9R?=
 =?us-ascii?Q?MeZtDC51AY/THmJrfRQbdZSYPkAiY3ognsQSeISEURURhb4cSJnwgrmpLg2U?=
 =?us-ascii?Q?5getKVRRiAh/z3MJJPOGl5RGF2RyFu80x+3/BvrHWQAotZpZWi6XttqxOXwe?=
 =?us-ascii?Q?hMBBCAI8xYy72n+exOY4BDsvz35zArTdbkk00DzrMdQLyr/d0g6HzONocNK4?=
 =?us-ascii?Q?Y1gHUJGOPS6avOitOpYWxcwt9/2f/eJqDwxNhpT1tAjBSV0y8pUWON+wtBHb?=
 =?us-ascii?Q?tE6VeNxXAGI/SH2xB43DUH/nbwfClf3M2ZTBCP/mEpADP/ZsH5uokJOGQCIZ?=
 =?us-ascii?Q?3c/GBq78ICO/w33AMK465xABS9HK8Qu7VZ85whY+YLQPeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ds7Q6K1us0giC622k6jPh/ZbKpSfWDOpYMMC55lqms5McXy2c4wPp9ouWrUo?=
 =?us-ascii?Q?W+CvTVWu/7Ls7ovBCRhXiy2Rnmnkxc4Hicmby7cvc1Ityh2mrPED4ScSzI+Y?=
 =?us-ascii?Q?hOnJU6JSBfaitkuns/j9yrYHhkxv4+5dlxaPDPTtcg9W+dAMEZyhmk0E+iA8?=
 =?us-ascii?Q?euVrbphS3KwoWwJM7wi8jhQ1GI9712GtzLVhEIV58SQuD8u6Xkn87IyBlKB9?=
 =?us-ascii?Q?fk7uhm5bczeiD9MzRbxDKYM57ghu05u/1BTIGO2jzp7T/+FCLzysKWZKiS2h?=
 =?us-ascii?Q?X1B5sasx51qYCnI7BglL1U1KdHMEIWuPMPDWLvte2nsX2I7aLzw1jMaTSN1S?=
 =?us-ascii?Q?3kmMcpw85lAAE03rp30T2GxuwXp0++UPC+7d0wD3Cu/UrQp2kxim1PrKPIWa?=
 =?us-ascii?Q?B6DM9sZnamOo3zhkJmhRVXr8hvUn9TovWgL3+Vx2+ELP+IBFtf1kvNX5DBS9?=
 =?us-ascii?Q?YCuwh0NxlrFBUsUX39rC4FTgRR4bowPFOuqajYoc4o+BIyUgrezli39MQmdG?=
 =?us-ascii?Q?G5ZF+Yskkta1x463HBrXrWRXHy419pnPZCTtdCgJ8OE6iE9KfoGKAcVYbU1X?=
 =?us-ascii?Q?QVJHrrhYODbtPZ2LueUUXSnd9b7VErHaoaD36HVEeWQ1SMRoCCiLPYQz9O3e?=
 =?us-ascii?Q?s8vFWzDp5op8zBZ/xtgDrP19OoB1Ah0Gg0OMR23MF2V+Jp5A9QLh0IUrh6TO?=
 =?us-ascii?Q?MSsdZp2gBh4dzE31w6OZd9sHhnoSaPlYG6UXng1WyTmtnZ4sxt4a5mH3rwAd?=
 =?us-ascii?Q?tpETuicMfkitsZvGU5AtGTC7HkIC7iN0IibzIbrUu5X/PNqEgG50atUSWu3m?=
 =?us-ascii?Q?AaUd3zi/g/u+2seJAsL2jmMbXoeJ7EdNL7/tFDYUQVBdCwHnu0pYGQ8B27l6?=
 =?us-ascii?Q?ixyP/0dBOjxExhmyqciihEmNhW31Iz8w0FK36CqiQvwd4163aYDb0+y/aa2J?=
 =?us-ascii?Q?1BQ/VQf0JFGUNPS/p4oiwQWJPEAJN5SAInUFWvIQGa0n5Rl5OTBUjiP0JsYb?=
 =?us-ascii?Q?C8d3XgjqozTkHmMn4sbq3wrd5TK9iB63vLSu8Ng7eTWEFsI7PwgaAaZ+5Mb3?=
 =?us-ascii?Q?ujMSRGyrUWKviQoo549vqQwtI6XYv81nvZLPLxvTc8G6CfLqzl8rh5PfNqVy?=
 =?us-ascii?Q?Zg+jRBDDTJhP5c8R4YlbdOsz6Nd5BruII0HkYvy8JQsYuUzptrBih5hvMNcC?=
 =?us-ascii?Q?mSkaCGQbsVnJKXRPtPFyDxhrNrYzlpRHjPkaUuK3cnjxhDV3VYu0vFLgU0cM?=
 =?us-ascii?Q?ZMsmnEtvpMpMckAQc69Z4BtQrsUPwopdWIDwOj1lU+sFD0OnmQgvcuN3cIdS?=
 =?us-ascii?Q?fpdqpgxPZQ6za0NPcQ34yk3BBT3bzUbYHSdOnvlr38I2nuK232VGt3qiPecF?=
 =?us-ascii?Q?4uyFVlQ9ea9L+cbJMyNmROX3nvvsiqsEUM5lcxOJrac74ENs2lEodWq/pgKx?=
 =?us-ascii?Q?1sxR7D2Vc1Rel1BUgosK6b9c8XtWjO52+/2fscxjfZyitL9pkp9nb4kkjh1Z?=
 =?us-ascii?Q?XpzjfuelcyW2MW3gG0aPz9tT1rDEi+TdNRJJXpQ3AVu1dYz5mzYOVw0b6cAi?=
 =?us-ascii?Q?vRvFqiJSVzBWXxdg6xRStSy2P9PcEVRFqo2ht1DhjY8CRUtJ9ZVQZZ+xaMTA?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9IkZnLzzdxy1OOuC3JP29H4GTzQRb0FgnKk4CrizjsmIu+8aBYyiKxY0XkLG7fBDx/Gyc0d5TP8Ul4waixWw8AfuvuQmdPk0KHMzwAeXO1IFsxINmy1/LBNTlr7ifsAvv27gH/t581v5TcLJ64+jIGFsfvlW/zdVVa/UAl0gR8XMAttAy/3vL+1+apvifnHCz5Tdf5Rl4cMiJE0aXMRm3dsSypHqT1zxpM77VM2Yn4WRMynoMC1+8qQ9zew76aXiDcu4frz+W884Z2umhz+oQysNZrnnkcuqj1UHABNEs1bJMJawi3KKpFi36pjrDkt1Di6ZSbook1bJ1LEUNfkP3t1SRL6YhxM5bPuucpoDpPiGPra+y4NBtJCqtyefRdefPMoSfmfkQGkP0lWTptyQjAR0gptmw1lENHz1PifMQPi65vZGY3ZO3WnVqcwdXyGAhLhSxRg+bO5jYQVTVTpBS2uz3OLVI9wjxbNkGBdyryuOoNlHjOLRf2r4JKduZ8CzBXvqEI3sKdBxY0YlGDszSxaEq/ElMuehH0rn1pzooBngpyvEYyY4RV1BSxg/cEFF8kiYZU5rHMLn3d/xIuBHIdUS8Rp4BMAiyYAyWAeHOqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2042fe7a-6297-4c01-6200-08dce2100b86
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 11:56:12.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRKSDc9Y+tl72QxMtteUUfbXj+YeRfe85GuqLoBeKDt46C1u8h9ZHK6MbdT+tnyeHI7dMbKV/QPMRfaf8j9vxaMOJ4RoqMaQwwW254hbPkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010077
X-Proofpoint-GUID: dOYTBq9GlotSeXNLfNC_-HYV-vIhvSwx
X-Proofpoint-ORIG-GUID: dOYTBq9GlotSeXNLfNC_-HYV-vIhvSwx

On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> (commit f8d112a4e657 in linux-next tree) leads to a severe memory corruption
> error under these (rather rare) circumstances:
> 1. Start a 32bit windows game via steam (which uses proton, steam's version of wine)
> 2. When starting the game you the proton version used has to be updated
>
> The effect is the following: The updating process of proton hangs and the game does
> not start and even after an exit from steam two processes remain, one of them at
> 100% CPU:
> $ ps aux | grep rundll
> bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf
> bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\windows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimental\files\share\wine\wine.inf

[snip]

Replying to head of thread so we don't get too lost in the mail thread.

Could you try this patch on latest next or mm-unstable and see if it fixes
the issue?

The theory is that perhaps an error is arising and being masked by this
incorrect error handling.

Regardless I'll upstream this fix, but be good if it also resolved the bug
you've found!

Thanks, Lorenzo

----8<----
From 39e7dd7d6d548adb36c928e1bf6e367fb38beab1 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 1 Oct 2024 12:44:50 +0100
Subject: [PATCH] mm: correct error handling in mmap_region()

Commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
changed how error handling is performed in mmap_region(), defaulting to
-ENOMEM but then potentially clearing this state when invoking
vms_gather_munmap_vmas().

Later calls which have abort cases, such as the check against
may_expand_vm() and vm_area_alloc() do not update error, meaning that we
may report the operation is successful when in fact it failed.

Correct this and avoid future confusion by strictly setting error on each
and every occasion we jump to the error handling logic, and set the error
code immediately prior to doing so.

This way we can see at a glance that the error code is always correct

Thanks to Vegard Nossum who spotted this issue in discussion around this
problem.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dd4b35a25aeb..9c0fb43064b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1371,7 +1371,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	bool writable_file_mapping = false;
-	int error = -ENOMEM;
+	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);

@@ -1396,8 +1396,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
+		error = -ENOMEM;
 		goto abort_munmap;
+	}

 	/*
 	 * Private writable mapping: check memory availability
@@ -1405,8 +1407,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (accountable_mapping(file, vm_flags)) {
 		charged = pglen;
 		charged -= vms.nr_accounted;
-		if (charged && security_vm_enough_memory_mm(mm, charged))
-			goto abort_munmap;
+		if (charged) {
+			error = security_vm_enough_memory_mm(mm, charged);
+			if (error)
+				goto abort_munmap;
+		}

 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
@@ -1422,8 +1427,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma)
+	if (!vma) {
+		error = -ENOMEM;
 		goto unacct_error;
+	}

 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -1453,9 +1460,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
 		 */
-		error = -EINVAL;
-		if (WARN_ON((addr != vma->vm_start)))
+		if (WARN_ON((addr != vma->vm_start))) {
+			error = -EINVAL;
 			goto close_and_free_vma;
+		}

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1500,13 +1508,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}

 	/* Allow architectures to sanity-check the vm_flags */
-	error = -EINVAL;
-	if (!arch_validate_flags(vma->vm_flags))
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error = -EINVAL;
 		goto close_and_free_vma;
+	}

-	error = -ENOMEM;
-	if (vma_iter_prealloc(&vmi, vma))
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
 		goto close_and_free_vma;
+	}

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
--
2.46.2

