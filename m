Return-Path: <linux-kernel+bounces-177003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71828C385E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 22:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136FA1C20E66
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF52E3F2;
	Sun, 12 May 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0Ygmhm2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHTP2OVI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591128F5
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715546498; cv=fail; b=bmI2dNE4BQbwqYEUDH/XJQYjCklarNIyXuiYDZr2Hd8mzmGoO4AocYRnmiJsOTFFY6QZ9ONotN9HS+Qku+WqluVafCCWoxwnkZ2VMEK2bOVozUSR3lA71bMtsgLtrYAa/iW416kjRFoz20YmOeHL8U3MzNnUE2IoIu/bTlrjOlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715546498; c=relaxed/simple;
	bh=UyS9erzTcQrfQIDIeqtuOD4uE2i9+naJOfOea5jJh8c=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IP1Okh1GAksH/989etQ4Rq4uMGB7DlgyGyk0B04JTgqONRlnhgnjVEqSOQqxPy3L0c5McEK0piE9tYA0uhgiiO9s6IHeEvm8H8RZKb9gkgCw75TarDfCtBlEZQ2R9tKjjoXJB/jKXINal+uTVi0Y++sChq/aJCU8KzKvEbWhfNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0Ygmhm2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHTP2OVI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44CKOE8P012469;
	Sun, 12 May 2024 20:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7TBQIGN4/1VyAdMPXB7jBAquEDkreAUqTZ6Nv3CaPiI=;
 b=Q0Ygmhm2B7nAkPl5hF4NQwwr82VTAF7VtqBO8Ia+z/Tmtjut9NOrOORjQKEPyYI0A51P
 fubeQVIF0zWLb3f0mbnWTRwEetdMXCwjKst8Cv+TJN1AuAI0j18p0uwnE1qPKCJa500O
 y6pNilqzLmkCaNcC9a83oxVR3XlrPRhvYzjt3UpalCAa5+nnzJ84ziv5gsmp9d1fsMYB
 go4weMrlK2BZRha4ZdJd1tFvkd2NgWTxpgZ1eSNxqTz2huJ4OWNFxHzu7p3qvo7bkORm
 0RsftTUd6GeIx79kwQo+qXrAq5GYa/i5GRPew6CWJAvO7as1EE+bY0mYRMc2kRj43RZn Hg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3300r1wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2024 20:41:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44CFClRc002196;
	Sun, 12 May 2024 20:41:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24ptxfdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 May 2024 20:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGyZzyGkRsI9Ix+nM0a17cKE4zFK7aIKw6zu8vX+y266bUsjTXauITWcDxgZhoWeLaU6a11WfiwCNX8c3Xh/rPyxt/NB0nVNP/qi7Mx1F6iCU3Vxu+fXMlilE9tCyledauTTJAibavZGRfxKmSTUT1fuTwfnW7FRdmtxBq24NlqizYYI36E8pwa0gVAw4gyt1qw4wpRK9NEbRm0Y1LpqWJIhl+7VE7yMk2JEgGAKzVPDZNVU+/u4wbDXTTh1NpRZDiJVycqfZqJy1oAf1mFLPS8tZHFGKh2texyCa33ZOSoHjV15m1WwQmFjBrZnZpeMPVbC7RezmX8gEWkd1NoPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TBQIGN4/1VyAdMPXB7jBAquEDkreAUqTZ6Nv3CaPiI=;
 b=ieVxfOBEHGNnatnHW+E5MubVh345tbxBnAkc9I/4FdryGh84+XhBjOji2NJTSgDo/R0/oPJr3HKJCal9TnlEKirV9yeyiZxcf55ez0S8QYFYSaNSHHXHIPHaHXNRgIReIgGsblxvSYRJ5kTQevlYTNxrFEYJoaVf5WnpMo62mo8ZXJ+f3vvNwnXkqast4p921TK4F5cdKLsxXHAcWyWxa4o7diJRhpBdvXYKOaUWVWVf1ZynFRyQoShisC3OqxxZ/COx+KN/k7LPHzGJYirb8nBXsTjrpgEjW/DKpby34hFNR3pChtHEMS8k7Hh82PSbweyAyJgHor4Q4vqp2E3lyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TBQIGN4/1VyAdMPXB7jBAquEDkreAUqTZ6Nv3CaPiI=;
 b=nHTP2OVI4kAJsK/d76VwniiKe2Szv/iiO39F1izVfc8HIUWPGXAgMlT//7J9g7XHtWwvf+sILZ0tPE3j7mDD9Ve504gw/uoZGWO0xb9oYzI0j6dHf61QnU+kxtUhzfPCqPGsZ7U6llj+ye0uzb48ADhVv+P2PAUndrCTHyusWXs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 20:41:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 20:41:14 +0000
Date: Sun, 12 May 2024 16:41:11 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lstoakes@gmail.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in validate_mm (3)
Message-ID: <bywi4rrt2iyjrpdxuyg4tqi3byrchydi42mkfpxsbv6n62inlz@xeswhf7ftekb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <0000000000000a13ee06183e4464@google.com>
 <q7omtpah3byvo5p3szra7kln63gtas35ml3kksltgj525pyezl@cn7v2o6qf2vc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q7omtpah3byvo5p3szra7kln63gtas35ml3kksltgj525pyezl@cn7v2o6qf2vc>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: SJ0PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f147aa-d00c-4476-8203-08dc72c3dd87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YUfDU3VmxLU+L4mehO5fSJUq1PNJkb77mRTKNKlXussdIS7iu3sFfSQja4DU?=
 =?us-ascii?Q?SlAz1fRk5vTaoYxIZiwucFpyS4PeQnOfzXxFQr7hZuQn1VeRxpPHGwwcEfRM?=
 =?us-ascii?Q?wDSn1ZimBCkRskRPtlEBhEWTw6emytqPWyhk01jfKAAsPk9RNeCaSjsSnu7W?=
 =?us-ascii?Q?8emSeAfFGvl7ufcKeafxl2nof5kpwBJ27NsSpaPapQO5iN5Jx8pEZKDZpzQO?=
 =?us-ascii?Q?hoGGbkPm3EzzfIX6/jrzxo7eKz2CBR+X6HdzPI7X34xjbI7LLwG8c/nSaIII?=
 =?us-ascii?Q?njL/qa/gwC2gwIYrpkdfEvkO/KfI/4b+MryJU9A33DGGktagaoBINAYfy+lH?=
 =?us-ascii?Q?cZlT1l9i90maACYUS2fb6KSl987+Pdgx0Bli0K+eOnu7GWJiUcSCz9uKGrzT?=
 =?us-ascii?Q?xWvVANJREFNJCSh7GmNqWJOl+9q7PhItV1GbTFCDvHCyuDwW0dOw+77Wszwr?=
 =?us-ascii?Q?tAF6d8DGZ5aFhSNGBbHDwp7/OZL+NPX5nh5vhKntoT0RcAVzQQPyRG1/Mgme?=
 =?us-ascii?Q?VIDBZwthJG/vMs+KAeKSbEvg0D72i5o0IgXh1M4OoIFplmPsXmKlRxwL8TlZ?=
 =?us-ascii?Q?FCmuZ0XP2TlX7qmYR2lIBcqzx4FcMoBPyV6Ob9Txow6mJSJ2ks9W0DMRFg8Y?=
 =?us-ascii?Q?R7FjUUsZtTli5moNMQSeClHgg/nixPa7aX4zk5mQlNncaB5IgD8q+45BpYXa?=
 =?us-ascii?Q?MV+S18xY21UkaNql4m1PmULAv5BJ4TXwmrNfUeheuM2ZK19GCwAtexoxeqPt?=
 =?us-ascii?Q?LelNy1Go3R+MimkZkR3Co6V/EFtLljd4WxN/C82xf/LjHe278ir/kmr5v+jw?=
 =?us-ascii?Q?j/VwhVl+YDklOuVc2S219qtcxyjDBAz1vCLTQBpZa1Lk+qlSfjwcsUKQsISx?=
 =?us-ascii?Q?94X0eID45brm66lQp87bmikos0fB6IkUz8zezb9lCy2mFEN//FLrFkINqrSW?=
 =?us-ascii?Q?N8UL0SEC8g/Poahwr6th3acRR/c3kHRWLUHHzmIQijcj7AV6/IWtJihvAWp0?=
 =?us-ascii?Q?Yt7FoHWmKfLfsXE5X7W2x9mf4ME7xLqo8gPHMgiidRfkk0iO8CA1D0U4bzu9?=
 =?us-ascii?Q?H1A+Y9PR3GBFVfJPY1pdv3q9fIYXuryn4fOq/WpiRdl0mPpJStU0K9qXep96?=
 =?us-ascii?Q?lVYCxtQKokAzNDZqxoWj36OoPxSVVG69TRgacyN6+pmEQ51Wcst3EXRaIRDF?=
 =?us-ascii?Q?GT7z4K/D++FqBxWImqU3MiFSqthemaekYGYvo7+OXJnq81VNEwfvfILLT4U?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?45hqmhhoTUlOys9k2vpEtQW5l1CxVphwzO0eHV+s9c+HG4ML6PzTJH0sGCxA?=
 =?us-ascii?Q?2AcJsNF7R5XWN5TXnpYgUB3Y8UrkwggsQuBFGuKWsDBfZm0n+xsF412ve/pf?=
 =?us-ascii?Q?7EgQpMokg/C+BrsbXfbW2QvTbPlWeYmdOsoBAZcfsjsWdv7FVm/Vl0Sumnb/?=
 =?us-ascii?Q?RFVrtMkR79OnGmgCUD7tWQSwyoz5NAdqvqy7nm4e+ACtH1J5dg7bIeok1yS1?=
 =?us-ascii?Q?IzYkLFnSimpM+OwWG1Y+XJ7FhexZm5q5mupyPC4OfKbrwqSnWlyQlgXJaCpL?=
 =?us-ascii?Q?99O2ZrDDieSM+zWzzyXXY4ZeYhul8URBRmybENa8+QWZrApu7hzRnhpMarOG?=
 =?us-ascii?Q?AJBayacyDT0XnQ1TlHnM+2TJK21VtgLga1Sf+IwSYCG2h3inLkjdYOFj1MPh?=
 =?us-ascii?Q?cfdadaWQrHewgYAqlunel9OzHaJHAzLPOOTiCTiel5VbR6gWB8ZuO/LlyLkS?=
 =?us-ascii?Q?aTZimqG1LQSiB9/StTT7QHtrUenWvVn4SZy0l5k1ug6ykZVrRMK4vqCXtvCN?=
 =?us-ascii?Q?fm36QGHhSCCI6PW1FvfYKi+0C7m37Y7T+PQ6IGvKbokaK/WnmHQ3jpI2/Psc?=
 =?us-ascii?Q?119re0L7DmRuRFr7eFlY5tuUOZbtVUGp7ThN6V/S1Is45W0g858UUKRHY54B?=
 =?us-ascii?Q?8ssFSL6YhM3Cs2PxEeWyBmL6+6/KTgREj6LjNwv0j6dMZXqldOvM0oS/8MJF?=
 =?us-ascii?Q?J+LFlyrd4nWl7uA6IFjgAomWNd+G3vGZPJ3/800scM0LJ32HvAKQIQXL38K4?=
 =?us-ascii?Q?EvXsCzdMINR719py++yDHn3ikYAN7u45N1qFDtl179QAPoIZbSulVStQUWZb?=
 =?us-ascii?Q?XImmeze5vpgCWKdU91+HX3Qsx5ddZIkW2FRNzRgKJz6PM9wijzl3berRUBN8?=
 =?us-ascii?Q?xsylzWbcntofAOOin0KpSxwXLZVwRi5EqwRmOVsaVmccVRIab7gm942JbiPc?=
 =?us-ascii?Q?I6Yicb4JEdK5OyHNlM0mjJ3TJBJA7dNWiTpOb6qvFRfc4zVYYOQ07yZ6QzeB?=
 =?us-ascii?Q?Xt2BBDY3GyYMwePSUyamneweucO0lLtzywGeKlOB2ugW0oOaYiYyewKG20UD?=
 =?us-ascii?Q?mMZ26D2uWnbh9V83n430+h98gAtxqLXPOWke9A5rKa03H9BoLurns7X3ESl7?=
 =?us-ascii?Q?KgXE2S1/IP/oMpkkoV0MzFR7eIi18QFGotDMHZXK7Euz44wNdAqchim0nafF?=
 =?us-ascii?Q?8P4VDwOr8qxFTs1NYO/d7TsepUoInQlTNXyxClEIR7F4Qfn/2+66RFovwdt/?=
 =?us-ascii?Q?XYh5K4VGjHk4LJpdYwJQlSGuhKZzyhaHOQw3bgJuXmqwXzvyx5qTZ69OvZbh?=
 =?us-ascii?Q?gUkf1KidkjCIbeXq6+Ri9BVCNr7BUE6CeGq8JHjcwdKRaYrborlxHYOCYzTX?=
 =?us-ascii?Q?Hil/j4+wn/R4+mlmrB/pbiTQOh95tB4HIvpLjnBQyAIWS3ApPFVh5gDFqkvF?=
 =?us-ascii?Q?1GngVKQyJJIwsUZCA6U8vbBaEMtp+3h4tpY214OFgrtnTKRsc1fmBigTPfS1?=
 =?us-ascii?Q?6pzjcmZgsqY5IX+HcnFtzN+TmDvZe308/FtY+pkXpYBACqwn9wMpThJHG5Ki?=
 =?us-ascii?Q?qX0UtUywdYOTX63PH7A0p4RUzwWHxe7jFSNmOQ/7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QCwX4XYeTjRM5TpYP2t215tH/Jf6YQfitxjJ28XQGTlGpKBuXrO8ye+GS28C0pBYIgFjvE/+841+Dl5cocR8cSS/npCEn6YzrmNDK4YnWegKjzyeP2/QCzlpy8HQuy9vi/aNuTXDOGPwt/t9OdJxNOGL2IFUYRKbuOywOiF/HiqchJxWjhs0mXVd4w4/Tjx6lyk+NayBafi2avtHP/AFC/b65Y1N0K1UJkY3OI5WEgM31Ezw5gsv4+hzd/vNGvO17hyOa9I0RmhQF/DxXyi37tTUo1tHIoOV4jZmVHCUXQnhh6PDcCKrR4HNlf1DzUcmQnthxQ7HnWMer/zzASFcgeOEg42v+qJpkqcvHYkaaFXLu6BOcO/snC0TH4/LWcpGHe5LbEtjd8pJJIXgJQ2b5QspoPHBOHd7p8cMwa+l53q0Hexpkktl7cfGp4By68RGbJamSeULv+rJhOEXe7HryYccPkhH0HrAKq9ILrJ7p03kAwCW6AlmuO3BGaZ5u7qfsFlG5LnFf0ApQqld2bSCMirTNSp6sIHWbOchEWDsFFPgWPr7q0MorTHp0/gGnqypUqGn50bYFVRuFYRMVOiPKpa5gUSSEiRlyQy6vA8oAHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f147aa-d00c-4476-8203-08dc72c3dd87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 20:41:14.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouVd9Td2CTRuR1nz+mEpceeYmt1Un9m5mKdIvaJhwFW+nIbsbrnkoh1V6t+B3AHR2jJ95mUWh2yd9ZeY8TvXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-12_15,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405120154
X-Proofpoint-ORIG-GUID: lWzhkavAP-kRz4GscSTFUjQLrZrqrQuC
X-Proofpoint-GUID: lWzhkavAP-kRz4GscSTFUjQLrZrqrQuC

* Liam R. Howlett <Liam.Howlett@oracle.com> [240512 13:28]:
> * syzbot <syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com> [240512 05:19]:
> > Hello,
> > 
> > syzbot found the following issue on:
> 
> First, excellent timing of this report - Sunday on an -rc7 release the
> day before LSF/MM/BPF.
> 
> > 
> > HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13f6734c980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a941018a091f1a1f9546
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10306760980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138c8970980000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/e1fea5a49470/disk-dccb07f2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/5f7d53577fef/vmlinux-dccb07f2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/430b18473a18/bzImage-dccb07f2.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a941018a091f1a1f9546@syzkaller.appspotmail.com
> > 
> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P17678/1:b..l
> > rcu: 	(detected by 1, t=10502 jiffies, g=36541, q=38 ncpus=2)
> > task:syz-executor952 state:R  running task     stack:28968 pid:17678 tgid:17678 ppid:5114   flags:0x00000002
..

> 
> I cannot say that this isn't the maple tree in an infinite loop, but I
> don't think it is given the information above.  Considering the infinite
> loop scenario would produce the same crash on reproduction but this is
> not what syzbot sees on the git bisect, I think it is not an issue in
> the tree but an issue somewhere else - and probably a corruption issue
> that wasn't detected by kasan (is this possible?).

I was able to recreate this with the provided config and reproducer (but
not my own config).  My trace has no maple tree calls at all:

[  866.380945][    C1] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  866.381464][    C1] rcu:     (detected by 1, t=10502 jiffies, g=161409, q=149 ncpus=2)
[  866.382152][    C1] rcu: All QSes seen, last rcu_preempt kthread activity 10500 (4295023801-4295013301), jiffies_till_next_fqs=1, root ->qsmask 0x0
[  866.383324][    C1] rcu: rcu_preempt kthread starved for 10500 jiffies! g161409 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[  866.384952][    C1] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  866.385972][    C1] rcu: RCU grace-period kthread stack dump:
[  866.386582][    C1] task:rcu_preempt     state:R  running task     stack:27648 pid:16    tgid:16    ppid:2      flags:0x00004000
[  866.387811][    C1] Call Trace:
[  866.388164][    C1]  <TASK>
[  866.388475][    C1]  __schedule+0xf06/0x5cb0
[  866.388961][    C1]  ? __pfx___lock_acquire+0x10/0x10
[  866.389528][    C1]  ? __pfx___schedule+0x10/0x10
[  866.390065][    C1]  ? schedule+0x298/0x350
[  866.390541][    C1]  ? __pfx_lock_release+0x10/0x10
[  866.391090][    C1]  ? __pfx___mod_timer+0x10/0x10
[  866.391633][    C1]  ? lock_acquire+0x1b1/0x560
[  866.392133][    C1]  ? lockdep_init_map_type+0x16d/0x7e0
[  866.392709][    C1]  schedule+0xe7/0x350
[  866.393139][    C1]  schedule_timeout+0x136/0x2a0
[  866.393654][    C1]  ? __pfx_schedule_timeout+0x10/0x10
[  866.394142][    C1]  ? __pfx_process_timeout+0x10/0x10
[  866.394596][    C1]  ? _raw_spin_unlock_irqrestore+0x3b/0x80
[  866.395137][    C1]  ? prepare_to_swait_event+0xf0/0x470
[  866.395714][    C1]  rcu_gp_fqs_loop+0x1ab/0xbd0
[  866.396246][    C1]  ? __pfx_rcu_gp_fqs_loop+0x10/0x10
[  866.396852][    C1]  ? rcu_gp_init+0xbdb/0x1480
[  866.397393][    C1]  ? __pfx_rcu_gp_cleanup+0x10/0x10
[  866.397988][    C1]  rcu_gp_kthread+0x271/0x380
[  866.398493][    C1]  ? __pfx_rcu_gp_kthread+0x10/0x10
[  866.399063][    C1]  ? lockdep_hardirqs_on+0x7c/0x110
[  866.399570][    C1]  ? __kthread_parkme+0x143/0x220
[  866.400045][    C1]  ? __pfx_rcu_gp_kthread+0x10/0x10
[  866.400535][    C1]  kthread+0x2c1/0x3a0
[  866.400916][    C1]  ? _raw_spin_unlock_irq+0x23/0x50
[  866.401409][    C1]  ? __pfx_kthread+0x10/0x10
[  866.401854][    C1]  ret_from_fork+0x45/0x80
[  866.402284][    C1]  ? __pfx_kthread+0x10/0x10
[  866.402718][    C1]  ret_from_fork_asm+0x1a/0x30
[  866.403167][    C1]  </TASK>

I'm going to see if I can hit the corrupted stack version with kasan enabled.

Thanks,
Liam

