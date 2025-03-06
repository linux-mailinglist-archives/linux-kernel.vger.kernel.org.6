Return-Path: <linux-kernel+bounces-548669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D26A547D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8795F3AD2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2C2045A1;
	Thu,  6 Mar 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9JjmPOx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oT0QYJnH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B518A6B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257269; cv=fail; b=aMljdyEejGF+iH5vqR17Z+onWTH2p9WT3mSB3acOdqCE3YkegTo6xMpmNjk4hjrfsn59kKamB6wFdtuM8TxLbt19/yFarND4Uk/7ISTpytS++MjM7ugPq2yrgXYS0Qj5J3zOcdzE3FdWlOcpLEGAp0cxjQnfcl3W2mMljBHztrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257269; c=relaxed/simple;
	bh=Z6kv9oaejv8aabo3xuqLSnkQ0nO5I446n1lQ7OETv2I=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lft9kou8ZQ10L/8XZ0ngZwbXm/OMpn/4VNO3OCAmGf/cHYdEvVeyv/on40lpLN/8hGvp1LTanSiP1a7HRfh7LyRBTD+RfGKGBkVJVxEkJaYlIY2jCP/rZb1al2gunm2cW0HtPHKH361uGrz5F042S+JSl8Ud/ShfjASsjEsH+0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T9JjmPOx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oT0QYJnH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526ABfla003723;
	Thu, 6 Mar 2025 10:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=n38uv6SWby4BLhp8
	hL1FAddgjf0Y6BsNo5G/5ut2LHQ=; b=T9JjmPOxaKYmBmyt5r2rzJYdn06n7915
	AOBRt+otnerE1AIueCfB/mF2LB+Y1739P1DmbRRPa3+dYhpdT6K3smLfClHsXieF
	TupHlaqZ9+qKO+Rj5ZeGavwrdmoob1kalSCMX3k7OQOSXzyVMFL7O/MAn3Lkb6wl
	wNLj2Z79RCOqi5K/F/9pWRn1m8Fn7J9U2i+zOkDsNCyW/9fWpvFPDafGIwCbSPOC
	A4F3JijQjOsli4z9D6aWfEfWYbfnB+koYK1t+WYMy0zWt+wJCYRObmqS//F/kPg3
	XlaP6hCt25ZXR/iUF0hZKArT8t6DUuDgiJJn11OQi8I54TW2TgsvUw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wspbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5268kset003178;
	Thu, 6 Mar 2025 10:34:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbvhn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Shi6tQiHlPz1S7Uve1qb0n9gaqT6TO6HJVacTNT2ZJ1n83CSfcOFWBaZt48kQjmcxAdmAnMmj0OI9KfUl8lvDpZbAQ7t7nCojmP0VmmFWg/Y2wog6bobUXwIoJA48nmhVnpJbwtODLA85BblhyUO9QRb2p/CVtpVIPXQkhh6VUBANuXf39i3pIVKx5wUsA/PWHpVwyzQO9IIVYiKTlQxuRipW7dNXthvxbxWL8psevCHpwl06+pBUGZa7lQhQy0HX7dHwS2E5izXTMoU3w8FZsdiU5h50/+hP4LnPiZuIaEUh5TQyc88paP9gc3O/Bl2sv+1YSjeqY1ZmuW0JWu5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n38uv6SWby4BLhp8hL1FAddgjf0Y6BsNo5G/5ut2LHQ=;
 b=Fl7yw4lHKzPCT68fxas0LuuvE5byJOenviKx7t9qS/y3Y1FoiB1GT5pgnxEJesFFsouy5jAWl2T6i36MYBp8LXv3gEOGVsxaCmn/bWy0wJI4D7/npHjMTRpiFyZZxnDfheQZAGtFaDMEf3qRKrazqMQgbozhLoet2oJlHdGonP3eYjeKPiL4GieCM6gzhKH2VUQ4iX3c0efyzFtfqiAn+bqLfILd40220M6jMAijumiDtxUxw23t8ZfYrNIFQjr/JdLw828z1yI+zGpdw9KyDoyZUr7eOh1bL2zsUJifuryXWlPx35Ak8K9/a4mSNHIMvQG5gusG5C0uwt/7zTN9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n38uv6SWby4BLhp8hL1FAddgjf0Y6BsNo5G/5ut2LHQ=;
 b=oT0QYJnHWanefxXOm2xWN15bTRJ892FTzvJ3msVJ9VxzSPGAZVLbEIsYKIuFDwwG7p52xOC3w/O2KKgOSSvclVSBOo+/PPVihqbgCXnfDSXn5rTon4zqiqLxOGUpSUwEQQTc0QbefFJLrGXSFfls6pIJX5D873wtR9W6OKUrVhQ=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 10:34:08 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 10:34:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 0/7] refactor mremap and fix bug
Date: Thu,  6 Mar 2025 10:33:56 +0000
Message-ID: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a84392-79f6-48fe-c022-08dd5c9a6ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I0SJnbGlsCSks9wuzBuK9bwccw6jKuf9IB/WgPEcBFwKLSlLMec5CibNma0a?=
 =?us-ascii?Q?lzWHjt+w9CydViGaHTTi2aVbzf8+w/etH+CFKNgO6vPdm8n0oIUuBCoWkfQV?=
 =?us-ascii?Q?K8pw0IkKHOCBXU2Wdi8D8ZzVGk8SkFecN1pkyf1kTpC+GnipjyGAeJYVwMCV?=
 =?us-ascii?Q?qqvi78kY+a+7drw03WX/++kq8sqEh1ZdfERgaCoH6aMTKOXI50/MbpqUUmaS?=
 =?us-ascii?Q?eD3akfHgnsPimUU6/9EjRnOwQ7TK7cE7mAoZQG1CFRcom0ZD95sa7AHBN+fr?=
 =?us-ascii?Q?fGJxkmGdP6BzNVoaJ/taO2Nee5xaRaWUXr+Sk2RHNtEw3KeC+fgnY3w9qlk9?=
 =?us-ascii?Q?3/fFn+FY8Wxu99hYMLQYF/xSCheVR+Ho7i7I7qfjiJg9d1TCDQqgnO8sQm3B?=
 =?us-ascii?Q?TBkNR2MkUk76HcgZ5ONy+SxC8QllCuEvaP5QOdevZS2rO3W2HwYVGeIsh7vE?=
 =?us-ascii?Q?1HUPr9jRlpBXQpq5GfCco9WQoXCwmY8Vq4e/H8ptPY2Rdq2HvHR6zhPeId4r?=
 =?us-ascii?Q?E6i20SguNwBJCbrjVwTLQRa+3kuyIZXk56arZSwR4E7+dvKvV87JgmZvZ4MB?=
 =?us-ascii?Q?7yRqlPxc6zaWPpgBRTh6q/ilXY++oOYKEdLJ3uv6kHlG0+fPxzKRn4U6iJnd?=
 =?us-ascii?Q?4WakpUcEhBPceXlBSbFLcywOsSoalz3dhhEPJvdjtXxn9tjxw2Ki/kcNd5S9?=
 =?us-ascii?Q?2f4u+S5Am7JioQeNczIHgWBPa2o68K3WKkvNRrpNi45ZkYTSLPAJ7WY8VmsV?=
 =?us-ascii?Q?RkgaYw6/gbDNcnqsjcQwIOym02iGMoEtBI5LkZNBrGHXscBAsHeCH+eu9kBl?=
 =?us-ascii?Q?Kh2RkUSWn3d24xZz8N6p0DIWx81e/Tgpkb8tOB+2q5My2Wnk7PDWY/+Olf+h?=
 =?us-ascii?Q?sdRrYDyPK/M2XlTh//HN/2yOrAmwrzx/YpLq2KivzZMJ1Cmf4vy3wMoAi32n?=
 =?us-ascii?Q?3iSPvNaUfTkLyS90MJS2Qb6fe5Ebj7+gWQS3gfWg/2/x/splZgOttNpfLEGB?=
 =?us-ascii?Q?rYYVaulX2GwIoHduRhwoC2A2F4FFePTKR+lniFvvtep0UGvnsDsYC3XwU3ib?=
 =?us-ascii?Q?yy3XbfrmRvyNvkNLDqfhMjTdvEsn340kNMCa3pfCMlmvu6bNPC0C6xiM2BnX?=
 =?us-ascii?Q?bcndXOkWTi836pXZPQPeI/oYtcc2ZkgJ8YAlD3jM9QiuG0RRPkLu1ynz/qve?=
 =?us-ascii?Q?QSYqWwZZ41joqsRfn1u+6sSbI+x4DmTBkrWKtdra+PskGb38DwqhUKzfccje?=
 =?us-ascii?Q?7gc/Uw/E9kXijHHgWQ8zE1dCz1NDl6dpXcxHJVvFKQ76oDAYhxzpzOgrRbzo?=
 =?us-ascii?Q?1M2lKSycfpGae/fXCl6bBFiD/ipaURjXTeupfQfIvXWzr0Mjmi2BfPE5Nb2C?=
 =?us-ascii?Q?33glS54xiWhEVB0u/1OqoabBLpXc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFGOCRA+XFpnkDlantUHQXlXs3u00QhSBvI6a/nk7SkH/pjddB/UEC7m/V2D?=
 =?us-ascii?Q?K/n5AtdhK1QwlLGFqgFUvPF9Eq4KBapUhQ+V0GI/sq1TDKsI3BWyeHHEfFRX?=
 =?us-ascii?Q?JXTTQ2EU4B76jwHscfoOMKeaZeCZHZ9Bzw6sP6LDmEbYAyvQM/YE44/cQoUF?=
 =?us-ascii?Q?YkNMmLD95Hpi4lpwXSbr+rBys0TAVdK9F4layC3SWVvZ6GbqZM0HHzXGVvva?=
 =?us-ascii?Q?fP9VtVPiWQXMYr0rR7DaQ7SfWnEEqdI9SP61pPyubDzeXCxWE5y5nMaF5nBF?=
 =?us-ascii?Q?v989nh7lVUn/qjz58nWEyHmi569ef5usTqIpPX+0PuiI7gvc40M1G2YS/AW5?=
 =?us-ascii?Q?h0YAp0g16P3g3B/tSwbxRO/9OrVsbngg3nDHqs6ABhIyKI62thrcKDBM2Rg5?=
 =?us-ascii?Q?++XUeAygQD5LdSMBzXTZStPIE9/dLKhbMyaxmLRziUszbpjKUQXFo/rL99fx?=
 =?us-ascii?Q?yZx+joxTCRCjm/MJ44+pYXoYiAdaw5TiiPn4ENju21OSw+DT9IpX4AdkKd6N?=
 =?us-ascii?Q?NbmSkymYzlrrreTwlX0XpC5ssKZflaYo9xvBe8m+WJZj+EZI9+H/bIwJCE2E?=
 =?us-ascii?Q?3zjuYaA+d5G8kiHQKqWMDR2a4EvCE6F/h9wkK1d0cAmrkveVNvcF/knixamy?=
 =?us-ascii?Q?WNVbmJl5o/6hfZd+s4kQfj8d6NYuzHHlngzE8XyTug6QGiGuzhLCkP66sEJ1?=
 =?us-ascii?Q?ZPQ1kx5VTPy/KBEYEEwhuAyNwakXfql9aQYGwrC6PrSEYctsrAS4CAAhzCao?=
 =?us-ascii?Q?gjCsVnb7o6k2ai5mdNvlnNgYPTfT+2iTx9KtEoabQ9QY9TARmtsORvX/xmpL?=
 =?us-ascii?Q?6C2TOQ1o8dfjaxCDSKKXl8N+XnMQ/z5FKjiQiCcbV59OnqA1an3k7FtpdOXS?=
 =?us-ascii?Q?U1/JWvrXMwUHES5qDrdmX4m8OVR4ZCzW7gYvumIVYFSB1eEHJCuOtAaPoImI?=
 =?us-ascii?Q?sCsB18Khg2Rhh3LB3BCnWrZdrEVZ+XIeD2uMB6mcyyBfP5PD5DvTTy9Ra7EA?=
 =?us-ascii?Q?HtXNj9GdFzOdf7pNmJeIMY8eWvOKOaj897LCEp8uHz2Vo+lzT1OuwuGVVzqY?=
 =?us-ascii?Q?HpKqiUyp2SFhjC6+ZcFEqXs4qqMU3tnJbEtSswKf3ZzuRMmPxKqcJk4fFGca?=
 =?us-ascii?Q?RfI2JAVHf/FgMxS2NJ6YP68uY6hX6TMGwgFykH1ZHu5ieibohTok4ZsgqwqA?=
 =?us-ascii?Q?+pJ0ElnmFgm4NT+7BTmF5Am2vvBFTlsznO2o2EWw+JXpmP0xDKd7p5kJ4yD+?=
 =?us-ascii?Q?KZCUCIjErkXinA59F/BNcUPWo53dfU3oXNqyRZU4ZfU9SMTERDxk+Ut5btPE?=
 =?us-ascii?Q?1KdWKRxBUpnHvOUVkv7nGz2lO9gvXkvtaXe4CXtL+AoGKHdCmaQm1AHJjv7I?=
 =?us-ascii?Q?+2VQy9QQTWVfrkfk6znk5yfoDHSNp7PjbXHLkCAZhX/GxHsD82hEunP66xDO?=
 =?us-ascii?Q?EYvG3dj2Pmfwtwtigow5TYUAj64UmiEjsCsrWmAMjolves4e+lpCQP3uobg+?=
 =?us-ascii?Q?PpaQuPKmj+n3YQUmLS057OtgSGf+g/1VMycgo9DkDIsxzD6FcS8qW34B+njm?=
 =?us-ascii?Q?eoU7+VktGgAild0n/hpnH6/Ara+M6uku59ESkpdvfUW2Dk6yznOrPtJLpIjU?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MdflIBvHK7wDaiIFnInw3JAj5G8/YTTUCDyDMAJmOgn1KxAFHu9V2E5QsJbbtx6ZP9Q04fcWlUDUqinYodDRXiP4ddg8tB2TwH4ug6pMg8IUjTW0akFIofyjrmI8xam0JPyUtGV9aRrAw0k0s/dzqqWdXn4mqyHPiIMvNyGpXfmDY8HcIffGjUbEgoa9wjtuO+d7Lt775zG4WjRqeBmbI/hQefI5u0p5I+GN41KG1FPdZS8Gtz1YOE+APl1CH0SqaMkGhRTc4GmBPvJjcTM9HzO0KQpEPL/UimIP1eJkSWM6/VfhCpR77LrVxYF7vjHdJfHeyMws2N45AL6wHeYmU1zO0sSqoHywBD3+Jz6ykfM0GdF+CXyYctzKI1ZFg5dQZyCMHDLIYry01S7qme4ly7GsaIvssKb3nL9LNDLR0ZqlTUp15Yk2HNYzxZq3qF2X94Jw/0DkN1kIyjBrohow2E/HRj49zTkfZROvTXfCKgRm1I2FkYtLVMG1/Kv52m6nhK22v3hlh9MOfnvnIM42zIOZrhwAIDMy93GpnOJUZ4xICPFx8K5hgiv+n+nBPKZ0Qe6AW8TTIDbF0DtgHIgA+fnB//AWqvz3rVs+t/A77AA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a84392-79f6-48fe-c022-08dd5c9a6ce4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:34:07.9272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dw5ZlhYUClEeLH0W9xSaAmtnKBfmIRS89QLWsMDRa7P1yWLaqrdKyf9kfbJRnWZSr2WsD1fTAbgDBX2/9MJib3rpUsIS9Tpk63rfAy9EfkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060079
X-Proofpoint-ORIG-GUID: Q4lrSrAqW2ZmLRn7sfsxWYxOIrCL3sHx
X-Proofpoint-GUID: Q4lrSrAqW2ZmLRn7sfsxWYxOIrCL3sHx

The existing mremap() logic has grown organically over a very long period
of time, resulting in code that is in many parts, very difficult to follow
and full of subtleties and sources of confusion.

In addition, it is difficult to thread state through the operation
correctly, as function arguments have expanded, some parameters are
expected to be temporarily altered during the operation, others are
intended to remain static and some can be overridden.

This series completely refactors the mremap implementation, sensibly
separating functions, adding comments to explain the more subtle aspects of
the implementation and making use of small structs to thread state through
everything.

The reason for doing so is to lay the groundwork for planned future changes
to the mremap logic, changes which require the ability to easily pass
around state.

Additionally, it would be unhelpful to add yet more logic to code that is
already difficult to follow without first refactoring it like this.

The first patch in this series additionally fixes a bug when a VMA with
start address zero is partially remapped.

Tested on real hardware under heavy workload and all self tests are
passing.

v2:
* Folded Andrew's fix for move_huge_pud() stub that I missed in v1.
* Folded Andrew's fix for err initialisation in prep_move_vma() that I
  missed in v1.
* Propagated tags (thanks everyone!)
* Aligned comments vertically as per Liam, tidied them up a bit.
* Renamed mremap_operation to mremap_type for consistency.
* Added MREMAP_INVALID as default mremap operation state, and set on
  initialisation as per Liam.
* Renamed 'locked' to 'mlocked' whenever referring to mlock state as per
  Liam.
* Dropped unnecessary vrm_set_remap_type() function as per Liam.
* Corrected redundant comment about iterator invalidation as per Liam.
* Corrected confusing vertical alignment on may_expand_vm() invocation
  as per Liam.

v1:
https://lore.kernel.org/all/cover.1740911247.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (7):
  mm/mremap: correctly handle partial mremap() of VMA starting at 0
  mm/mremap: refactor mremap() system call implementation
  mm/mremap: introduce and use vma_remap_struct threaded state
  mm/mremap: initial refactor of move_vma()
  mm/mremap: complete refactor of move_vma()
  mm/mremap: refactor move_page_tables(), abstracting state
  mm/mremap: thread state through move page table operation

 mm/internal.h |   49 +-
 mm/mmap.c     |    5 +-
 mm/mremap.c   | 1445 +++++++++++++++++++++++++++++++++----------------
 3 files changed, 1037 insertions(+), 462 deletions(-)

--
2.48.1

