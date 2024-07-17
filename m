Return-Path: <linux-kernel+bounces-255613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594759342EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9101F22041
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EC71836F3;
	Wed, 17 Jul 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fL5IL6r9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DBwalxUQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC3179AD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246855; cv=fail; b=rzVzSPeZimSXwkyNmqbSrDAwILulKJZnmm9+WR/8XOeNkLxnaYpJZnftpARMzJW/joqPSXXkg/6HXa0BxS+tvPBv0ju95D74M7NDCPg2hq+NMXPBW4auCafa9vFqfdx9Cs+Sf5zxeEDC8UcB2G6nyZ7saEGQsNYNdz09sw3fCSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246855; c=relaxed/simple;
	bh=63PVr3MED1ZXO9tdRgfXsrgMXd6+KSbQeBlRw2Dwfig=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RADMpEAlHj3FhNtoqdA0Gf3ZGgeJeAeG/g3q8WvVXbP5bA96O13YQoxtDOVWcPbwUTB+ghCMsNc2vrk57xNaTUpJf1Epk9U/AJhcpm9pdyw9Cbt3K/qXB1JFNgoTfLqR0L3X/YdlQx+bNOQiRBYNWtIBkxVQKQd83WM0uGKORYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fL5IL6r9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DBwalxUQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJtmfe031588;
	Wed, 17 Jul 2024 20:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=zM+ZcfcI1/W/iw
	JL/DRKFeE/ijBASNw1rbaQIlYapWA=; b=fL5IL6r9QhHr+neMjSsbhIZbJaoJBf
	nH//51xkj7yr+vukw6a80oe/KESqUP8DSYBIwh74IcivzGgyaH3PS87lC94wqceC
	9m4NZRcpFmvjnHjznhx4faSD+FE52uvtz9YsX0zhMtHjZxK8qxhv4uoc96adT8At
	xO/xw3umuBnM8ep27uRM7hD53me61VpRWBJmzymbq/QP42UcMJF+6REqWVJepNcV
	jg3QoMXIkKSShvgt0ASKPIFJDs+LQSw7OKlU1IraVDn3W8ZvOlak+g4uAR2pIV8m
	Ewdv51QFsCjlfZnOzGEmlmcj5rf5DAsJdDHtFVmyMeYl4YmpJdkKLvrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhpr0q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJ2AaZ039525;
	Wed, 17 Jul 2024 20:07:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwevghs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4RKIeRj+PGAZHNMQBhAh0NVaf85p7tlexTI0Zim4PERk2TFfZ/7ppErtT+TX63pxMBjDd/lU8wv57dOjYjr6+BLuUuL8zF6x3Z5hBDlNnf4RNbeYbNFwSJrHvg72zhKmwN0wO4z1ckJo3jNflO5v0liynA7tBIpzxVnQB2F6bNG5VGkNhkrCJj4ql2fr3YsDLhGa9FecSSV5jXyWIlJ5IE+BUnVYAkWP07+o52pQCHhf2/r7IUna8uceTVP3WPgg/r+hW1H4HQaML2d1dQKBSuFNhnK1/qSDmyXdCOiRRR1CAPfqq76gPeUsJ9dwIRqpr3UM0GvoX6ow0lK9HqQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM+ZcfcI1/W/iwJL/DRKFeE/ijBASNw1rbaQIlYapWA=;
 b=uTFRJWPbpG3/qVeTOlni3jBz+IGjG/ffa4CKL6kgABDt4Ob766LRXUd2AvnDA1e+q1B6bLv8sp1lCCgyOJrZtqSlV1HVN1lqYUXqMoperanx6GcBQh+JPZR3mrjl2pnVgIJsxwPvOpEm8b9Q0UDklsbdDoeZPtoHMh1ZhJtQiJ4g5oXPSG/YY8uNRRf8NaHhPoiDa0xbhATkojXTE5GHPDbcc1MwAy92FpUAkHVbRmPQ8vfFaSTZDG6Vx5JK+jQGHeQ9JnMg/6W2XWfBlUtyCcxdkn2epuTMhG/sSQU3xxUelTKXg5AzaQBbOYqf70blhD5ltDDJZt45M/CVEpaCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM+ZcfcI1/W/iwJL/DRKFeE/ijBASNw1rbaQIlYapWA=;
 b=DBwalxUQolHjTttzf3pLmqo+D3XcreqRim3jaQav3W7secEWBS+xB5ryepNMY/oT8HgyhZSA3/HaB3kgpM2AQK8krFzBpB/frGRwO8pN1+1FIdLl2VGMNZnCO/NvQCZe4tWkxrw1lMnw0otAeWYnT4yTPh55cpIexsJ5eKcRe9g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:13 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:13 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v5 00/21] Avoid MAP_FIXED gap exposure
Date: Wed, 17 Jul 2024 16:06:48 -0400
Message-ID: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 2157cff7-4992-46b5-ef5f-08dca69c0c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lDk21RplKTegMuakdCWBO1Qp77+pvbtqFAHuS9cvxMGAAR/vCZfNOTF5J0EX?=
 =?us-ascii?Q?KsoHmuBwnAwLtCVF+GtP2SSFUyMgUO9AmYauDqM8biC6SWGjdD7osQ5Xl74g?=
 =?us-ascii?Q?weXuyWsVyxlm809rBgQiV6ibHSvjMcKoTt92XAxfoUzX9hTu190Y3TeNCpsB?=
 =?us-ascii?Q?1jR0XwVIOn9Nm3H9nCBrj0hPXzmUW0EyIEzUMcV4waNxw87STUOtzvVlE0YO?=
 =?us-ascii?Q?RJNbY20K00o7hr2GkfMZH04RK59zbyZ7hztnfqw4OL1HUNatvmBYJ1FhNvkr?=
 =?us-ascii?Q?7LY+P3hRtKa2X3dbvs7EYqo3NeZRrQ7LcyZfFeVW9Q2Cuky9xS0MEENfpVDF?=
 =?us-ascii?Q?K40pfBwFsri0+2ArY+CmcFcQvCRJzHAIOnADRMoGlmQVR6Abc7ntWT4mcxcr?=
 =?us-ascii?Q?d1hzPnTQi0iz1PV8RqgMSFpu5uj/xDLH/ailh9zKbVw66d3Bsg+8zw3wIy4M?=
 =?us-ascii?Q?coE/IFk/kb8/DDc+SmXQfI9OgG3V92BoyI+wj/R/Xay5iQa21RL+jh6yjenu?=
 =?us-ascii?Q?aogtDg2JzNUUWLBYT8UT0Si3kVXNdGwf/twmMFtsaKaS5wJ905rmMKfnmsPh?=
 =?us-ascii?Q?ICH2nyKKKLnj16FRZxH5l/CQfy4KMqiwY7LIww6vQ+B08W4DeGMwldnCFUWw?=
 =?us-ascii?Q?xaXk7WVlmAUqcASwSzb/pH5eqcfrPKwDdLHPKpOBSvSi/Y8kpWZHvDALdOJG?=
 =?us-ascii?Q?BO91f4eXMkOrc041YBtaZ3Nzyxp/+fRfPAIIoG6ViDHEIkKr59vAMUCpXOb4?=
 =?us-ascii?Q?W7uZGF/8hYhadfNgKDqlqIq93YE1OeposzxFKaURdrpyAbKNJlyJ/NWotA0t?=
 =?us-ascii?Q?qm1XyyMT1q6VI27LSo57TkMFOFsezm88wQ/l8znLBnWDmLevs2NKjwLD9nJa?=
 =?us-ascii?Q?gxWVxbGlfUo9ztJ/vOiVrhgZXI6Cg4o969v6iSpsKCbriNULNMKebBnn8GSx?=
 =?us-ascii?Q?Vc5pp3IdRjfBFtBFN2DTtbGfzWY6ZD930Pcw33GFCX3Tw+otbPGLiN7xKZNv?=
 =?us-ascii?Q?Lh0RZ8I9hkDOssMJJ5GtE83sRrYliwAJuuZplphziCT7zsQ7GiaFCk5Fpt6s?=
 =?us-ascii?Q?jfN3FS9Y7P8GMcOXXlXXLzhocT/ASuhdROaEDZtFPGgKGpUTkuu3JVbivpnG?=
 =?us-ascii?Q?j/t34g383dQ/t+u1ThyXdtvnK+IEfOGQCH69tMkGn68am2BEOoxdKNLhjJg4?=
 =?us-ascii?Q?FMBq6ZZovC1FVxeeYJGe9qZm7CqcVOCfQM999sTJuEPA9fQ6QDK0CcUQ5phl?=
 =?us-ascii?Q?mJI303scRpXAC29gPSqNcdhVi7hL76DPBW/I2p6/ueSexNTf35CwvOWqnmWg?=
 =?us-ascii?Q?ZWEmc8u4Pcr8jo5NYiBwZZ4I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MMUq4drGwmhimGREw+XdeuY4AFW9SmR+oCHprkpseg7b6CxPqvHiyHbtW+zK?=
 =?us-ascii?Q?dfSKnajiNj1fy+IhetrroAkVuqYwtmlsk9tDuTpEf5a93JPkD2K8pt8GabZF?=
 =?us-ascii?Q?pEXE3ylH/hDJRRTgnpinGn4wuxiIfrqQOs4Y8AaqoS6ncHs7Uu8NHRT6dmaT?=
 =?us-ascii?Q?AGMokgyMIwdP6tEdmo775dv4FpQKjIC9UryVM3OtBhoHjoIl9M5v4cauXN67?=
 =?us-ascii?Q?vk7ZugGIPX3gQ3CFaeIXhIfsjSsk5yTgYGeGWVJC4Vsln61jvSjtR9O4OjZO?=
 =?us-ascii?Q?jFD/rxEO170pWovFBNIv6tas+dV3vmgqJQ8t1vsWH3xR1dcOPHF00kOMgHXh?=
 =?us-ascii?Q?MtLelxEWUsqejomGkq35sy5hP9otIRZLw2XOUItP3B5cadOqnxRNchXCPnPj?=
 =?us-ascii?Q?c/aEfsDkn9ZghNSPkdQrFCRpIS/wIWNvOLPN5Z5qlTqwHD+tOdR6qr5TdANC?=
 =?us-ascii?Q?4MOT15XSYjus24PrBT+w0A2JvhdsGPW5oSeyS5y7joD9PbGBAjksgGWyOdL0?=
 =?us-ascii?Q?0cfPAX2hLtiEj7mhTSt7ulYoWPKd5Ln7HhgiHY3+MDcTLRdEH8wknjJTxou9?=
 =?us-ascii?Q?U1YAG9Tez8h4IDs+Tnznqb5cXMIo3QV/KZ8jfOpUb4YwbJG83bJYpmNT3Dl6?=
 =?us-ascii?Q?hiouZ1QxuTWFSuqCQYtZMHUr7qtftsteutBaHwxNto3TzK+GU6T+yboAD2S0?=
 =?us-ascii?Q?fArguo9PIFFC5aVRyk+klE+e9otG+OS2KhoG3X5MhOWNgHUTp9YL4vaqRRym?=
 =?us-ascii?Q?jF03DJPM7j0SGoURLi7oOtixv0fYd3ta20mmF7/E7YsKZErlCqeWsCKFk6nn?=
 =?us-ascii?Q?HdQHU9WsBEos37oSF2ShkrQVMs/NrMWjdhHTml2260HswjKk1uamR8r+UJzc?=
 =?us-ascii?Q?rH+Ms2ceBIgo6OhMeoo/h1Fy6weKGBYaeYx2wA0w+77R/J/GM2Vi01l2+MwY?=
 =?us-ascii?Q?jdyDuoQznRCs7lRzyotH1U5O/nMb7w7/zPehoURVfG8oGGGu/Ns3HtBS1LAO?=
 =?us-ascii?Q?vHFt530eW2QxATbUAxJ8NO3fqS7Bi/Eknt7faGEQCkececQ2B1Bp0TcS+DIf?=
 =?us-ascii?Q?BCa8BgsN0Ivzb55F+er16rMpoI6BosVF52JLMmhBYEkzbJPfhTgXjUE1Pz37?=
 =?us-ascii?Q?oE2E+0RCsV0ReMktGlOivlK4Zi+e4N7/LsjNGA4n4V57QXya5dibDpCaJ2r3?=
 =?us-ascii?Q?xKsTIA94b81nZhLRXcPa3eJpJk9VO0vr1KSeHDd2oVOWuHiHUIzdRtcL6884?=
 =?us-ascii?Q?N4fST5+1pZh2FxL0Oc2TJ1QKEjbY3yueq1vUynItvItyYxVandWo2tQdwJsy?=
 =?us-ascii?Q?q7FPhI3cOqfkj41nzmXWESSL0KLFC1bt81m5qL57kX752Am1pfkmNjR+Tjq1?=
 =?us-ascii?Q?3SNi8FHha44KxVygUje1WYqIAN8JVvqfYQnO0v+KgFyj7PNbm8xLumrJD8Eq?=
 =?us-ascii?Q?a/BHzvWQqMXyfh0QZj7JApW4jdchVaYB6b6pjDjbt6vHbs2LfINop2ilTXHd?=
 =?us-ascii?Q?s0s9lH5f4UT3anZRULnH624sGE5TaVNl3GyIpaojp26ATOZzEhiT331z1D/m?=
 =?us-ascii?Q?gxlzDcol445D2HS73q9TtI94Ac/bxPX3pMXQ1b+x?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Att3OP5s2N1KQuRfvhW307vwR4lsOD1p8Fs0K2wYtpICeAbRyaXWVIIzUfz4SKq7Fd5DhY1kadF+vg8CkDCRoqHBFsOMfiXsjYzQpZp3sez2lVp4HWexo2Yy+9XU0TK+gNk3+QitcW6o6Th0AcfLq3A5B8xRurawASh6Rw/Q4MQYYwGzFTqZFu9pUxDGOHdy7OB92DAYcUtAU+ig2N5Se7d1yvWAkG0VThkiAp8lpEpB3Hf3ty3U001qUpaqVrmZeT1mgnZ5aaAnrVThyhBdo0zwgeDKLgAzGy7iIai0nW9AxKIh1QU/xpCDXEexWAg3XDOeIckVCpfG91x+hCrDpi7YwRMaLHUqozRQIYQIXu/iPGe97EI+o03cBZdNHFPA0HMt+D+3Y8+8YcxsBBvQsqCbUMnAfUQ1GsWvVS8amDRsMI8VM6ml34/fRg0nPtS+mqAsrhyME6/5DezEDeVL+FBtES3p1roPWC0mmW6Qjlb/X99Qa/wfWhQyn3YRgezBkfKQqBRwgfuKUrXgTzHTMCjT8iEW9fDQvcsZhJP6xgGRwltuZhr+9MLs+YfthuqHXozofWBkGiZ57ZI+5UANb8orcCnapHjSPxyR0yCyzb0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2157cff7-4992-46b5-ef5f-08dca69c0c5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:13.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srvhUx9fwqR8VM89P849Fj7Rq1iqw1k4Hbc1W9y63Xgi7aVphlDL5mQQWZ1F3rBIrjFmsrVeVbRVMijUvxsnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170152
X-Proofpoint-GUID: 2vMXHqMolQce-5w_9vzvLV8l3auM0RwB
X-Proofpoint-ORIG-GUID: 2vMXHqMolQce-5w_9vzvLV8l3auM0RwB

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
v2: https://lore.kernel.org/all/20240625191145.3382793-1-Liam.Howlett@oracle.com/
v3: https://lore.kernel.org/linux-mm/20240704182718.2653918-1-Liam.Howlett@oracle.com/
v4: https://lore.kernel.org/linux-mm/20240710192250.4114783-1-Liam.Howlett@oracle.com/

Changes since v4:
 - rebase on akpm/mm-unstable
 - init_vma_munmap() has an else statement to set start/end to 0 and mm
   to NULL.
 - Don't drop unmap_arch() as powerpc needs it.  Relocate it instead.
 - Call vma->vm_ops->close() before completing the removal of vmas, call
   vma->vm_ops->open() on abort.  This fixes ltp hugemmap06 test.

Liam R. Howlett (21):
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
  mm/mmap: Support vma == NULL in init_vma_munmap()
  mm/mmap: Reposition vma iterator in mmap_region()
  mm/mmap: Track start and end of munmap in vma_munmap_struct
  mm/mmap: Clean up unmap_region() argument list
  mm/mmap: Avoid zeroing vma tree in mmap_region()
  mm/mmap: Use PHYS_PFN in mmap_region()
  mm/mmap: Use vms accounted pages in mmap_region()
  mm/mmap: Relocate arch_unmap() to vms_complete_munmap_vmas()
  mm/mmap: Move can_modify_mm() check down the stack
  ipc/shm, mm: Drop do_vma_munmap()
  mm/mmap: Move may_expand_vm() check in mmap_region()
  mm/mmap: Drop incorrect comment from vms_gather_munmap_vmas()

 include/linux/mm.h |   6 +-
 ipc/shm.c          |   8 +-
 mm/internal.h      |  26 ++
 mm/mmap.c          | 580 ++++++++++++++++++++++++++-------------------
 4 files changed, 375 insertions(+), 245 deletions(-)

-- 
2.43.0


