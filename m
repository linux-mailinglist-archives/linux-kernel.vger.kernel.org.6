Return-Path: <linux-kernel+bounces-241598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D7927D00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40313B22525
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285813CFAA;
	Thu,  4 Jul 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H91Euh8s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YPpx8SEu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22B13C693
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117681; cv=fail; b=P/kuemaVP9IfTMyjX2X77CG6YLMJEN3fWYMieoLekOJM+EcEve9XvCF49PVceCQyUFGFYujwQRTwQa5wvfVxBFcyec4OU4aDgPioq8jIP3jxgWNOMlUqqUUTTCreH2M+GyPbyqLVRrCIHz5mSqwIrSbcuxQOfXPm72eqQMJrkp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117681; c=relaxed/simple;
	bh=lMkoTE0UomRncgbXd9RBLVAPkkh1qYs+g/CmVo7H8KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvMDtYogI5c02Ok5nT8xRlR6HkCV7gLXwkwifoL5ccvex1Pnm1I58qUOgNuxN/t5PVtcD1E1JI0B7UnuEI3uhG8s4JYIvkMdnYQp52g2nY2NrqNa+JbafVXq0U3KNxKb1KKIvj777SAN+JY0SyjQSaGgMbH++t7pdgtqk8m2GHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H91Euh8s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YPpx8SEu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DeMQo025863;
	Thu, 4 Jul 2024 18:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=481Re+ATCvAQvWbPAjt9N9MaRrHnR8VIjSEjBs80iUY=; b=
	H91Euh8s/6G/SPZwZYKtADXzq4IjyRkjlZHDD+Tv8tDyziE/O/+qVnBma/kq2dgT
	//Rtu84af5MDpIzOfhXRbmUcw8u/t4R1V3rxFdVPWzd2kyOOgoMT+gTg1v9axtS7
	k3uaFHZVloUst2wr4Sao4wcEPKed1Bw4sjRDo6nMfrqcYaI0rTYFq+vzcxDvw+5w
	yvHmhac+sDvEGwvXaHTQ/fPp6RFUEDo7nYJFcZfIjZkvS4dv5Q5EoPenCwDiBL3j
	f4YUF0Q3oKVHqOEcPBOL1Vd0x0N898Vx3qA5ZGjPjLlACBU09bwfr7qDYvSA3EQi
	H53DvsxpdDrjbBoviVK0mQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296b2q90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464I56kK025028;
	Thu, 4 Jul 2024 18:27:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb2h1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAXi58eHra9XTSLr3jsYPXZYZfZ+3Bje9n/E9m3y8ab+JDQ/+Il3A1nJSTECJYcHgHml47nstnW7fAK8/OtFEXRom07cImeIhsaMu+mBjHJMuECq+jMjMyk3d0bhqmkLAkwOQSG0Nd9yEx7BaeIc4IFVcw7UbqQUT1aSlxw6gVDqA1PAgybX5d1Heilu8obhcZd9Zgwd8bvx6OFplYBcWL+Xl/q9AurIhynonfwDLY99c2zL0QXaUdfxVtXpewLky6M1/JHjuSBFseFwTCPs4bN8w4MRlGZwBFrffc7BucnTIroDOEhTFKhZYsElJQd/czigjpqtsFsUr6HIYNv2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=481Re+ATCvAQvWbPAjt9N9MaRrHnR8VIjSEjBs80iUY=;
 b=VJxVUVPDukRyuAlsqm0kAob/kgxcNc2UxZtGz1uZqo2Nylh9GlGDO3Ko19A3E2SqsQqfvDcRawoHcpoDnU1Ystb4nGIPb7RNhBWFrhx7oWb4VAryKRMcw4ZtfacitF10TiWsNp5KM0LB5YQGWDocQwWqeshNpsZnAS0UYbje/ph+MOP/wr6uLbpRdOcOZkLv890PKIAb1kZOM5LPgQbIiKRjFnK1xAbSkcgaxWhE+r57YL84MDL5s0M0wsq3vd/lHZP1rOMNdDvt6ZXNiPE3WeqfgphYJFMR2H9ILUPURvTkR2MKF9mpovrED0lSRRX1LtXxL/9ifPFkEpKuQPHV6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=481Re+ATCvAQvWbPAjt9N9MaRrHnR8VIjSEjBs80iUY=;
 b=YPpx8SEuwD+Cw9kve/9s7qgCfAPM2Ho7W1P2oxMALKAu7/2WFzaWnVWwnKrMzknloqTvNQlx4TJtW2PVX4wDdvrJ3S4wRQ9SvW3L0ptDGJ89+Top8P7hZOC6WR6FBwEwa84ebNtbb/qDQjI4y3TTl5+Vi1pvPNfUzhaMmoO6Wys=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:44 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in mmap_region()
Date: Thu,  4 Jul 2024 14:27:12 -0400
Message-ID: <20240704182718.2653918-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 49540128-172d-4e3c-7040-08dc9c56fef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PTFWWoZWD1hoA8hnTdMk41POtbxk3G+UYOdCBuPG9gZQM8iqyNGILJkzcbyd?=
 =?us-ascii?Q?yKo1yeGvpZXjBPGBcX/SIhKLkpWNB5a+u3hzED0oid/xHAt0dRGEJGiryF1H?=
 =?us-ascii?Q?tg5ZLcilU8nhBL2wfNaM0T5S0BTKgPhGaU/cFkJ37hrIaMbRye/FGMm+p4sC?=
 =?us-ascii?Q?wV3xoPtR7KKBC1WSDgmFLBqa6XtZAPMHdph24vfxnb2nfEB5VNdB+u/yqeUS?=
 =?us-ascii?Q?zQtm7qh4yUL0n8mtvIE2x9U0HLl3+7A4K7VNdrV4PhvoMnYxUZkgi9w78OeF?=
 =?us-ascii?Q?fAc5KTY/248hFwrwewUfXLdiYtlAyYDqB0fvE8O+Kyh33ZEA/n+h4IK10tLR?=
 =?us-ascii?Q?xJ1/4L4qW6UC6vNpGwoOe/MLJp1nmwOoUpfe3AX2KG8MoJybg4Xdqq42fg1s?=
 =?us-ascii?Q?L+cF3SU2dGkUWmfG70GYqFX6Ff6K6lgrowTFBEwXN9J11/KO5mEDmVNABN8a?=
 =?us-ascii?Q?l/26pEYg7BgzBEVbm6rHHJmh+ikjJKEIPOvVbqDoQBSR7BxTbRsSYgbi65Ki?=
 =?us-ascii?Q?mE6LViLDSjUqZT/E26ySCJ5Kq7maCzA14eDPIC7emqNaLnex5LNEYZ/QZFmE?=
 =?us-ascii?Q?r8mDYtJqYqhFU/MfTSJqorEnhfSyUNwu/hX8tJxxmktug5XkWYnknJjQvjrF?=
 =?us-ascii?Q?ffPzbtkosYxnjm9d04IhVAYo8wMPrPi/MExJcAs5tcJbzH8EQGGj3b70k/Z7?=
 =?us-ascii?Q?SKWN3GZ+M5cflA8gJ4LyRMQxW13M+/T7LPaHSTp8ThR7TRQXYhVPvtqlkQR5?=
 =?us-ascii?Q?DNU9455aRteyP8v5WAGz/CEKQq1qm41mgcbB1KBplGR/Hl8e73XIgRJydfOP?=
 =?us-ascii?Q?FO7K8k+ug5WBmxE3gPfXo7s9/5J2/8K22HWT3tI83oqYHJfP81LockOFsu69?=
 =?us-ascii?Q?5VtbVCbHYm7Glj1lzADi4O0NfAA1kS8iZzHDrUyWZ7h0zqsxlu6l9XFG7RAq?=
 =?us-ascii?Q?zoKC9G6jmnnYNR1pFEnSl0kAnat7jLxSGe58QTw1DG1rer1GGeg2t2+sLB2B?=
 =?us-ascii?Q?BnknTjMffk+ObxialPBiwQ/WvIqxrWqTLINgFI7vCp02A2/i4torp5WSCwEp?=
 =?us-ascii?Q?eBtPX2mDd8cMhfKeha8u0ZrKrGaHrF8IC/7ccMIggoo+gMMJ/oL/jr4xihVb?=
 =?us-ascii?Q?pSuc+9cuCj5JSzAy29Hz2vuQ8H7maWD9610sshzrUKaKq4eHBzYp0blinDJ6?=
 =?us-ascii?Q?IPJGo8VfxG5fT0paOh0D/RKbujL82EchnGb3CafrY3wYafPtIPH4UqI30gZj?=
 =?us-ascii?Q?6+CwM8JLc+TVnc3Ys+L3+T71CsnRyEryxsEyFr/K0WIEeCZnigQIg0fBTo4A?=
 =?us-ascii?Q?n5dtffkD/QNlkwdkjrx2giu8PZs5ScFbuyjhkC8t6UBrkA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NyKB/JEVBK1UCifQMIAnm3Y95rK7XgTdQ7JNMwu14rQo6zOWNFLEAPHkmK8L?=
 =?us-ascii?Q?chy+AVoGXw1PH8JSPGN5YokpoBoXLLsvc9lSe2WvcromHdyYjeeglkEsvCvx?=
 =?us-ascii?Q?KDSbA/o0BUecdOzxLDxnqoBak5zORA83ZxpkNO5WaBo2gUfI168dzK8cX3r8?=
 =?us-ascii?Q?xL3X5WDn9DarB99lavU1bF3qrgzjTFWIYSHy096NJNL3I68+tWjaV9Wk7L4R?=
 =?us-ascii?Q?KrhNx/6+Ky0mjJiStAXjkJ9Qx6L+pAzsHIOwRZenzNSl138rbfnPRAoWbbY4?=
 =?us-ascii?Q?tF/qtL6PhaTPI5tqkKzUaTWpFjMSV+GPdA60r95U6Kf4DBYUQf8BM74qhigF?=
 =?us-ascii?Q?nqS9nT+i3ZeAutkdXSE9MwIzpbo6/J8Y2O05Xstjpr0pLQLZAghAfAJ35ul6?=
 =?us-ascii?Q?RVgp5FJUMqypYI9P/yxg6rhyw411UlDz0ijEUc6lsVfTmDZlmB2B6UvfU1SZ?=
 =?us-ascii?Q?6mPHOoom3lC/6FuJ36WA0gLmP5YkKYYziDQJXJzwYXeORMFXgeoC1i6A3jdH?=
 =?us-ascii?Q?HU4Z9axwR1K8GDvWi2ZrlLQvYMCTifQ8Q39/2Cy3FiwVnhaKeS8N45yyeV78?=
 =?us-ascii?Q?FhkYAACgtStiPoTXe+TqMBNdzXS+KJ+8cXYxSJwZX8bYAbxGTHLJtGBk9RYy?=
 =?us-ascii?Q?/HFOB98uN+EqcZ+5uVB8+Rm30pa9AeNJLYr8dI9lkhT+8A2c7LSYRIDS4svK?=
 =?us-ascii?Q?aj3swEcJtpDySmS8BFpWqlEOKiVdnAQSbA4OJxiq05BDUmGGMAjqrvybtjh2?=
 =?us-ascii?Q?30piEZZx0cA7opSOdI271MqCP5PEezIT24rEqmLc6hU08cMBWSncaqp9I9sv?=
 =?us-ascii?Q?Ms2JvvSkzKVDmY/ruJC420VCzB+Q5P2JQ7PsKrjZlhMl/ceCl9mCS8K9ab5o?=
 =?us-ascii?Q?cqBqU9W9ye3Y2KXOPDYe087hg2olRdSeKbJ+iUDlcsZJMaxngaW5CJkn3X9s?=
 =?us-ascii?Q?itcjY/zfINlnSjmpNA4j4frNi3S3uQqIF+ZvMjM06LIuexsSsU+9dVIYuTqc?=
 =?us-ascii?Q?mf5wep+9IWMp3ll6jJ1ShLG2lz097fEPTh7XN7tG4+uN41l3ER4sCcOCIJD4?=
 =?us-ascii?Q?2OvBHGoE5mjsv1sh6ad842F7ai+dUZPMobzW9sfz6TkdqnVmUExWkDPcisQ7?=
 =?us-ascii?Q?0czMRt53zEvbLpcftW6XO1oMjfqUzHirdxBT0lLdjhtycaRqSNNVjteXKARI?=
 =?us-ascii?Q?dUAAwXlmgWbMU7MMRRyYzCGFPidbJjn4D8vvkfx+urNB3a+0RGG0UHsZqD1H?=
 =?us-ascii?Q?oucU2Rhy10moG5kuA7VqdUFLRFjBcX/qd9OyJaoCa7uAo4HYGsPqPEohSw+q?=
 =?us-ascii?Q?HcstUCyOmKlxjntPAxVMwf6/mMTpDQJGbhPkIDDBZ+oeE42uClX+nSp4vDsR?=
 =?us-ascii?Q?cQE/AxD4AgPwL/tWJhNDdVnUbKiot7M4beoaa+zsZA5lrTyAHAAAP4cIdqZF?=
 =?us-ascii?Q?aeV/UWj96vC1sHMVeCNzgRH4FiZg+Jz+oNAMemir40AYPeeD4lKb6/wGeAKr?=
 =?us-ascii?Q?G//4KTwM6ftJQypyT6FKF/KylzIjMfLQb+v8dBkXYAVvIWcHynIMU+/pSOcl?=
 =?us-ascii?Q?s3MQnhrFk35H/UGB2kPA7l3vVKJsjXF65uMO9v81D7TVsxSmq73CB0DKEW23?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p8jz8eQ7xMZfeMG38J/jv6HsNZVyXnSIklhEFSupRV5m6873cxExf8km5CacasdcucpoWWUyMve668NE+kWvDsQFUKog92nUdqzDHBve3WglyPrQD6XhNZeXIUkdGlEuziCIExTplbQYfP3CELQlqD2Rf8kIblKNbEqeF9r6kAGIO5ASAxHNsHSnJvIaZ72IRXc0ievNrcrbeGoxyRxzq2/g5OOiMvhOo25vAscnnAy4ad8IYvRLKxkJYwZYW/LlPPgLtGMLMdjsdOcNk27xygN+oKc8u5LA2Tu0bxQPH5XM8bW0HqrbZN2c14eLcjOKJJ8SxBDVd8LS2WXn87zZSKV1lA412DgRv0wGOAz2FJVVqRCn/tjQH333pSVRpporZQgFsBPcuLy4+ka22TRxJs1OchdVEH55AB7SQ7/xOJdfFqBO3pvvsev7t1uAn+TrlUbA/xjdroVqPcxWOy3qtGQ4sReg9a54TFBaEYfKWUfRiLxUbohGj7dbF26nihH8qFi2oS4ohLwkP9aVpgx8A6B4+fyH+th7XzOUWnIzlQIQhAaLQgH6WMiO1O8vv9BRgmfB3Zm3bfFJr9C8ihk9wDa37Nl+F+CCKs5s3yi77ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49540128-172d-4e3c-7040-08dc9c56fef5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:43.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmXukzKk2dniENAKAg0ma6n6J1KuvX73aj2bvEMVc5HITQF0udpUy93a8fpL33CYJGl99FYziZWqahzbf59lZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: 9D4pVqlZPk2fLMVlRs7vOwMzUIXr-m4r
X-Proofpoint-ORIG-GUID: 9D4pVqlZPk2fLMVlRs7vOwMzUIXr-m4r

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f5b33de4e717..ecf55d32e804 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi);
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
-- 
2.43.0


