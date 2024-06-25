Return-Path: <linux-kernel+bounces-229567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E59170F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC56B24B50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511217C9F7;
	Tue, 25 Jun 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OY3geeWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fRofTEhe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C817C7B5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342737; cv=fail; b=Fco7t8OtnWNAVKHwhXFKRsd7Cz9rS2xumHX1tFDyE4MI8cBld0DasOQ/Ko3HM34onOZwxg9aNB8HT90fwDAHNyfgWBKryCdgtdxt7RYmCocMPkZ+m54y4FdBJ7FQMwPcUDl/bou39ma5mqlkkMwuWN4SwuwYw8r2riYEuO6kvL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342737; c=relaxed/simple;
	bh=wm0SF6MfSxKgwH4cyLxn2gV6Ha60nG/wNK7j99laoo4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aAVhaLH6MoB65uu294LPdZIsUdye9EPfH3i6o7qfXnPPbIobpwyN9aIiCKX4q4g1pGR2ZtcmpR6FofmHKKZxKeQ+ZetnkhtEja8QO1shXFTJMvqFeQRP8IeStSM8XKSxxVAcAFxNxk34yDbdI61IXxPjGJjJNXRbrJ/3x5j7Vmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OY3geeWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fRofTEhe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfUcb023007;
	Tue, 25 Jun 2024 19:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=on40vABfccR0uU
	I0f8JNktSsLrbHYeVABeQ6SBw2F1g=; b=OY3geeWcM8sESRzfmOJ5h54HP/GPpT
	ui57Ogw/PHKy8ZAKCK2XAKVki3GxPFqdAaAFkPlKJb2ekKKdrGSQP/q7soOMnFH3
	b7g50p9skr9cB5N4lxwMlrMo+k8JAd23IgZcza2yKs8XsLJ6/FpXTOBcimUkkV1r
	uKBJhY6dAGPy5Tv+jf96j8AJqUWb3CtdyXpWs6NB4Bw3joPfCxU/LYv/V7c+LLcP
	LgH0oAmrEbqIZhHoGUM5laDki0jbM2H+Dy+yO2XI5BuE17vwL+f+wQffyvt/kysG
	TvlmPAqYwkwcbPcVZjQvyGV4TUJixeofZ6SYQD3i7mYY9f24t15XlwOA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t1k2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:11:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIqmFb010741;
	Tue, 25 Jun 2024 19:11:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egt33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:11:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIVYlZtnppikRSCBSJvFmavMUFLp1nfdUkMXCDg/N7wMxErwjLTYH46tyuJMWq9KrHM1AhKHsmf52VFUpqloTh4GlTu1SILLIcQ8jUIVw3DyaJfcSPxPhUIEiHwNVo0l88osqK84hD4rtk/4EW5eeYeHVinArw4AqKm7aIZx0LNpD3z84TuZWwTNpTMt1vtq/rmx6dlewowMhXtvRDouHZnD1Dhn8ONdO7NayAhHQE+learDEsnkaG8Ji8vKfasbcghWRh7iwHm7VONUT8LnmVHaNampzNlzuuWEKmx/Jsxdm2hYM7Vv/4mRAPIsKDEj45J3IrMA4S1IV0xTXtQE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on40vABfccR0uUI0f8JNktSsLrbHYeVABeQ6SBw2F1g=;
 b=Y7RQSe38UucYhN2mFo0Eq+vayldys+MpSD8O9adC5IffD5Z5rx7rQGPQPKfHe7RlB+AS2GBsekF0y+N57xx+uWVjJTDdKi6Y2OJE6hBKkWWzACcCGrObAV/g2iUO2ap5q9kySad8YwaU6YbIWTgz9rngnsi4nVRaGSbxf7uyzGunj5ay/sAum1HOAUjKinuKP5rZKruT1+UjfJsy47Ih/+bstYB4+hs8W1wQdkNfWGjVJasu5P0USiJzsr4ht7sfJlk05cX4IdsujZh9GMVJnsndTy4fPR1Z8Da4aBp0xOioI9MlJp/MugQHyA7ap4HXFSaHKd9ZD74FRb33c1oCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on40vABfccR0uUI0f8JNktSsLrbHYeVABeQ6SBw2F1g=;
 b=fRofTEhegtvz+cquB2fmSAT2eGdcU8iZTNqsK9mR/lZrfxRtMt7cq4TfcllhgQTGscak/UjMIsNXQ2uCkfbnKzDshU9Qrr9boVWy90rpwMMeUwVyH045sWmOWVTqmG37nUpGWXluvHwnLwCc+VgfAKDGDdNChsag4pD/x7sXCv0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:11:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:11:53 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 00/15] Avoid MAP_FIXED gap exposure
Date: Tue, 25 Jun 2024 15:11:30 -0400
Message-ID: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 211251bb-4f22-457f-3f31-08dc954aac4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zv4RHnd3+6PaNbZHhU6Iipez7ungC2CGPSYkbTTnEo/u6bPtT+FfPusO5E3T?=
 =?us-ascii?Q?epHSkketD5343UdIlzxuJmK3XpcP1f4iNv0gJAxSmiWhvmYuQQJtPni+zwDt?=
 =?us-ascii?Q?pXrwvnU36kNlZEL8YseEX8a51D3+iN/GKaVnq1ZTo2qGvw6YfVM/tgeYsMrb?=
 =?us-ascii?Q?fTUf9xivoFlydPKpcUZMZ2JNmwZVyJG48d2QVxSuBA/vKUKut3kQ4dS9eQ95?=
 =?us-ascii?Q?ePh6WfahPEk6E4gFZmywb0Bl43Eg/JwS0x+Np+KLK/V2r9Zx0vtaOtOBUWML?=
 =?us-ascii?Q?xfOQx9t9BO4BI6qH7vrpOO9n7PmTcgzTfGbUNAvC3KlwfDLHlaJ5yCA6n+VS?=
 =?us-ascii?Q?0UEDTSuyQTwqM6YKcyyov8wT7y+hHEtGJfnizJW0pS8UOMtcVuowpT+07UB7?=
 =?us-ascii?Q?sbhYKr9J5GGQmO5DQavhZq6nkEUWQpDurqqqQOcP7aPwl3QTJ5S+fctJngFV?=
 =?us-ascii?Q?aRi07s0JozZkoHelAo3G3QLlVqkAM0WX+O1fZT0miRvapRlsOOb9KPpZ1dSh?=
 =?us-ascii?Q?AUH+4WJ1M4ANHcveGcDFEkYIt3SBHezwNh5WXOrMG06o6PE1IzW9bS8dh5LL?=
 =?us-ascii?Q?6dCvWnc8yY12ShcKmbiL/VUscZZRi3kEphQLmjXbIzxDWQqvoeWLAY8JQ1P3?=
 =?us-ascii?Q?bkykPzB3wkxbn/xh3wN6PnlkhO9m1FNJKy2AZPD4zhtWp8OPDO+ivrgv8Y1Q?=
 =?us-ascii?Q?IOfjayd0Lf8RdOOkv+anSNNJhl3BUeGDshYp3LmmNSvWKXDNwFNgMb4pbWNc?=
 =?us-ascii?Q?cLXPymuuE4L5SnuI+TWZ89O6g1tV9uR2JyvrCAy3U2GCQ7dblGqr5xINggj1?=
 =?us-ascii?Q?slN+ewxAE1vfwdWWL5Uoo8dYspQ54mk0ou45970c8w2GC9ot8bEmxdNk4xkS?=
 =?us-ascii?Q?Xkf5rJPg8eh8wPSiFABHp+QZOI7X0onJRrElgBrNatAqoatK9efdlZLvkdBN?=
 =?us-ascii?Q?tMBkQcUseF0cUEKBIFT7yK6YtvpQX0bCbhjF3y1uDFRhF7PNkiwSu6afcaEZ?=
 =?us-ascii?Q?8Fxe2ASWPEuPej0NXa93mI5Kxx2S7D6UzPd4k7mtHKaQsm/V8culUc8qzvLO?=
 =?us-ascii?Q?pdubbH+rNIVJp3E3dYyb/AEH4Ug0suvSCfzP8EThbegDQrseXbaOvt0BeDb5?=
 =?us-ascii?Q?iRC0JVnIAct+35eamBq62DWZTFax0LeMy8UDNKrK6XZmAYfm9nmqZlrrn39X?=
 =?us-ascii?Q?59hP4psU3jwthSE1CnMCaQ9PO7vuj9QTb04sVubVVGOaabdh2P139b+uKKWw?=
 =?us-ascii?Q?q+dCV6+/bjwPeIXqYdGVjpYPT6r6Tcuilsk2afzglg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dxEDrazloH1x7H/NUQEBk7P6l1Qd8T2LGCu6ph1WgZ4jpmTt9v/iVjUQ/kXW?=
 =?us-ascii?Q?DAItOFEfssJLIFAQa2cO6ZF/pAKHLX4ozCxNCdqrjQU1YYl60DkWkQW13zzO?=
 =?us-ascii?Q?OWNIQIurc/obrXmfm5mJ3tzd71Ue+y6E5Io6DxxN8JnBi2QW2SB2rgmKrBKO?=
 =?us-ascii?Q?z1KCtBKhIfK14zTzQZD8ZhHrcCIqwZycFJ7DXo5LY4wSfR8jwYAhVFB7OT9B?=
 =?us-ascii?Q?PYE1Q6ddAv3HP1DK2ICFyzoVMy30dvFMUP+88iqeEMO9y33DpvzOuwQXG9lu?=
 =?us-ascii?Q?WM0FOpKF+CQ71/NHljjEQMvFpycfvi0V4JWiBiehJ6r6f/wrh1Odnn/P8bY0?=
 =?us-ascii?Q?UcAEQBbz6Jd/le+EMAVv5fkeYVpBeQIwbrRjJOb7XY1zCJK4xHoaQWzBjE8r?=
 =?us-ascii?Q?WDhzhJwk+bgDLNpsCdgbCZdPtSZQ8xrJffCF3D8rMRVsqAHpJUul2tuO0On1?=
 =?us-ascii?Q?YCzBKZ2aKsxOCewZcogGOxSYUy+E+ugw3TwOAoo2nOba5lKJUAr6FPR23TcG?=
 =?us-ascii?Q?ZO8NabqV5KMYhK2rcFNrecdFAIdOXdoj1Nh5t0CZz+Svtp1UEa7ldlFXbzBi?=
 =?us-ascii?Q?11Ix1N7JvZtkYw3ANS4md2/bMXgAlE3CELsvO6oHHF80PnLQmxCisvSowzSC?=
 =?us-ascii?Q?lzNslKJPmSoQJcx33bSh+TVbQrrm7jCgb1oA9J5S4BWP2Tdk5WKJYzOv9xd7?=
 =?us-ascii?Q?aw26ST7Nlxr3uqbMOHuNb0CNORwmUjfBuFRV0xkPKCobqGCOUEB7PMaQBoV7?=
 =?us-ascii?Q?0l1ruG4FYtT/9wOMlif+rIf49lj+ibzMRnzjGFfVZ7jcNLtsEh679rcThMsq?=
 =?us-ascii?Q?u7NIsZ3YBi1Fhsns8CgOkeW9l1d0AiV9M2ih9aBz/GKbT771kYznqXuAnwt6?=
 =?us-ascii?Q?BT2kGmFLL8AyKE+aeO9lhHVZN59sfousQajF06pldjnNh2QXYG9Tpr4/ioVG?=
 =?us-ascii?Q?dIpOmTp0g+LnF3t9FP1ZA6qz17SiTatRbfr2zk/V0w5USQTN8ioHUnRpWucQ?=
 =?us-ascii?Q?oohTKQqKDkW/PampiDPfhULBsRkkEa+30aurfwhWQtAPLCwcvZ1rDA+dVvrt?=
 =?us-ascii?Q?+Xc363MKtXvl1LRr+zzBcV3sjAEioeI9+8TiAn4o2rtS3FODNqvaqKhEMAm2?=
 =?us-ascii?Q?07+x3W/8cmQUz3acQD2uXqpnwT8pyWlQtQ2BklyHsObCrigDXxUNygkwfufp?=
 =?us-ascii?Q?6Sn3xz7cVhukryRkPFdwEvMGanP2tH4jvcY8eTB06bB2jflycmH2rUeRk2yT?=
 =?us-ascii?Q?hw6Dx/LEIWxve4IeIfxaBU8e6PxSC4510cyQJ0fn+NgtQZ0EkXG0nh9bfqm/?=
 =?us-ascii?Q?zF42+ZoMFVItdGph9VO+pqJdbel9obwVa0DpTAebqlvG9BQrxEuRCFStkCEa?=
 =?us-ascii?Q?cTBCOSsBIh3rnCLpzXpE5hOaZsVdNU5c+o6j5jes2WnVNUkitAYgwKouu80b?=
 =?us-ascii?Q?O2pvRjj97Atsrsa/hVuazq8KYnxPnegBOySw5M/vK7ek3yq4XU6vzATFOms7?=
 =?us-ascii?Q?uR5MP25jSD1UGfWIp/V6KBh8GTx8PQ/wi3glZNQaumtkARgO8W5IUUN/r9j/?=
 =?us-ascii?Q?QEbrFSa55iifKI27Afxtvl+lkuy20dj8ME8ho6ka?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YqHVSSEjOufcdu4HxsL1ddy4c9zGmmh8EZYZPfzRIDzOjI9yJzvfPXLFEmmTAg22jaA/y+l4W3mR4B0+nQ4VNbvibeUsOhug/l9JNYteu8RChfNhueLnje4GkPcvYic2eXXzuXT/WGXrF9Mqbc9vKG/ok64lDkmP7M08e23SQ5PK7tiWTWkPd4FjApUcX21tNq1E4R++McBQJjN9O5vP+7cuaQIGPZIMNKcQNaKrrgPHdT7ymuMScqHMbLCOsA6gNu2RVjBCcha4pKaZ3GLGTrlS3e71ONrEH/5C51HwczL+/N+h7+9+yq/A8BkSKYAIaxZmUs/p9SX0Fy7aGGjukSXZ2zKlK5ZQ1ppugetFHAmkGDB/sn1Snkm7zTtr1/5/TH11HjwYmhu9XWG/1fSH4gmFCX90JN9YL9Toow19TgrZaB8yjDp09z+8OBn0VptKcMCJXl5EEz3PLYabkkDeKoxWvztX9xiQJdPW8q7Lk0XS294DRuB/SpBg5PyJIG9Au8Y/O+AHxymMRwmtCkrJrErWjog/aL6f4rD2lDr6fhwZkbFR23Hg1DFDQh67bvH46cpr4tUViCAMBErbuPs/aSTv6tHMZDFiSBwDGdD4snI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211251bb-4f22-457f-3f31-08dc954aac4e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:11:53.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayE1mJy3Ud4Cnilxzk3HCUbMzaP2y6i2bo+4uEFKsSWMnVaMhsel6gNwSBFNd5lzXmsacmbIAWlu0GYS0Vohfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-GUID: gVuOyXb9PDBSrbbrkDoHMRKAfUnc8ZGz
X-Proofpoint-ORIG-GUID: gVuOyXb9PDBSrbbrkDoHMRKAfUnc8ZGz

It is now possible to walk the vma tree using the rcu read locks and is
beneficial to do so to reduce lock contention.  Doing so while a
MAP_FIXED mapping is executing means that a reader may see a gap in the
vma tree that should never logically exist - and does not when using the
mmap lock in read mode.  The temporal gap exists because mmap_region()
calls munmap() prior to installing the new mapping.

This patch set stops rcu readers from seeing the temporal gap by
splitting up the munmap() function into two parts.  The first part
prepares the vma tree for modifications by doing the necessary splits
and tracks the vmas marked for removal in a side tree.  The second part
completes the munmapping of the vmas after the vma tree has been
overwritten (either by a MAP_FIXED replacement vma or by a NULL in the
munmap() case).

Please note that rcu walkers will still be able to see a temporary state
of split vmas that may be in the process of being removed, but the
temporal gap will not be exposed.  vma_start_write() are called on both
parts of the split vma, so this state is detectable.

RFC: https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/
v1: https://lore.kernel.org/linux-mm/20240611180200.711239-1-Liam.Howlett@oracle.com/

Changes since v1:
- Fixed issue with expanding vmas clearing the incorrect PTE range,
  Thanks Bert Karwatzki and Jiri Olsa for testing linux-next
- Separated patches into smaller portions for easier reviewing
- Replaced open coded shifting of length with PHYS_PFN()
- Changed security calculation (Cc Kees on this change)
- Changed the vma iterator use to point to the targeted area instead of
  the previous vma
- Remove page table entries prior to fully removing the vmas, if a
  driver may do mappings
- Tested with stress-ng and split/joining of VMA at the start, end, and
  middle of a vma.

Liam R. Howlett (15):
  mm/mmap: Correctly position vma_iterator in __split_vma()
  mm/mmap: Introduce abort_munmap_vmas()
  mm/mmap: Introduce vmi_complete_munmap_vmas()
  mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
  mm/mmap: Introduce vma_munmap_struct for use in munmap operations
  mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
    surrounding vmas
  mm/mmap: Extract validate_mm() from vma_complete()
  mm/mmap: Inline munmap operation in mmap_region()
  mm/mmap: Expand mmap_region() munmap call
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/mmap: Track start and end of munmap in vma_munmap_struct
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  mm/mmap: Move may_expand_vm() check in mmap_region()

 mm/internal.h |  25 +++
 mm/mmap.c     | 449 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 304 insertions(+), 170 deletions(-)

-- 
2.43.0


