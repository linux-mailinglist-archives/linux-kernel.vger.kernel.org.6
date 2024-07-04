Return-Path: <linux-kernel+bounces-241599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60526927D01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A471F21D18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C813CFBB;
	Thu,  4 Jul 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jv2QmOvr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OG/tycNO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD0136E28
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117681; cv=fail; b=IrY0mdhA9TfyRfjtBnQHwlEC49pGFpXgIQGEwsBeXhmIOVtp42sjIvNti9eXw2H+NY1sE86tZ6241n+NmiQoxaGSeVHyqgOtY54miXpLTsUInHhqGkmO+yIy548gCnG7UYfSl7H4deGSTyxyRc6Mt5c5suoBAOdDVoY9zxreJqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117681; c=relaxed/simple;
	bh=KtmXlntIJsZ9aAv69msPttljIXKTSd//sRXT/DaVm2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tn71ibrMjDooJmVN3L8HtQWiqurAVIEmLvkhIBF77FX+NT1PxiM5jCChSG9gU7WwMtah9RIlaXjhmTAAxwlqq/AR1FfDDm2NKeJqPGuEBuHFOD/Ijy8fBEC8tY/H1/xagSbnZskTH1MkQA2jIdlDYhXEZUiPw4LH3Bbq4jILJ4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jv2QmOvr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OG/tycNO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DvgbR013101;
	Thu, 4 Jul 2024 18:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=VUB1loQelfJZLcP06vr/xQr10Kh4VR4vNOsmdqiWGcU=; b=
	Jv2QmOvr8UYOsBVns76ATreLrrS8H81QzlC8hL4cR/h5DbE4np3sypNtT/CqmLaP
	Hif3a/8EzhX4yZqYHJiil/ecUQWWtL3VLPcCmtqoqV5rT+zlfzU8sOp6TFC+Spot
	XqbpDGCIyf2eyo4AD2kJCTJooV8JJ6spdrdY7j3ex2yomgOVl7nWfUn59k4ZxoHn
	FRnm16AgE7SmR91H4D7J11h7P+l/xPOmH9Yl15OUToggYEsG//iZIAh9E7LkVdl9
	YRIMH0tbUijZSVJWQK/9hTaiuRBudeglvm7QHlpZw5qeGTn2wS0zD5AX7FhP8H+V
	iOqiAFSK9I0n3R1witTv1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgm8b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FnbR8021479;
	Thu, 4 Jul 2024 18:27:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qgqaqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4ffWk5h4F8eLQu9mr9WAK2uEGZGGID7tBsGgExObGv1Kf8V9KTRsOtcZtAHKMdLI5c0YmN/rVCYy0OClsFIZV+q3262+3nJqGh/El0x2CZNX7ubwfz+yN/bXTrENZAM/PaAWiPzAzCLrIKrgHfCNTeedCLYTHewPh5+8tu4EgAkgJUhbx+kcWtHupBq9/8pb5Cd1hclHZnyQdkjeKJSr0aTKN1WqyXz8ixOHYf080k9PcxiqtXEjsG6vaFDIRHDwmLSv2ixdhnELQdrsK5L8K+FaTT9tkUh1nDx4RujwgBW8zprQXb3v5lv97tkOcXGrl2C+Jyd4QoYgFEwfQCTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUB1loQelfJZLcP06vr/xQr10Kh4VR4vNOsmdqiWGcU=;
 b=OmN1cElriIPSzKy/Q0XL4XEiO+CDdVP2Fi8xylUTEeb1o34nxjnhdzTr+FQdWHPqJS9CZTga0GmSnUdizCjgCPk1HrMuWhSXh8On9rpYju8JvWsUhREF8fVLbKzpvy4oURrNRLHVX2wHh0zLv28NeQYpeYlRNKRsnbxWhvlOjDxhQ508Iskq0ugpJKxAonpdsn57mhqtnx2980uZ0BbuGH2n9RhxtQOLK2bSI4tq/BuvlCo3ro6SmlKAZ1lmrsrXHFGVpHZdGcDGTxK7fRTkDfW5Ym6+Q29lwsWAgHrTpk/g+D+PyaTMathd8cfAelDK9125VD5kOsXstDbvdc5zfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUB1loQelfJZLcP06vr/xQr10Kh4VR4vNOsmdqiWGcU=;
 b=OG/tycNOE5Vn51mPf1K+LvdmJUuKoRrg5p0a4NT1HFwUBEqtZTcfTClrJKDUoYoNYP3uZTucpDMrqaU5gkvIaAppjy9OAlmXTApO20WKieLG2wBsIpjCJSdGAiyzKcHupFA34Ug00WgAkZkKIY/QDo5nfNZpvfS9xKgmooiHr0c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:47 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 12/16] mm/mmap: Clean up unmap_region() argument list
Date: Thu,  4 Jul 2024 14:27:14 -0400
Message-ID: <20240704182718.2653918-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0454.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 3153aabb-8ecc-414b-c180-08dc9c570141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZPXH82L8iBpZtMTTCipKeqr1c8BGwG+slEGsj5VkBw5c7mCtby0nQTcQs0oY?=
 =?us-ascii?Q?JFGAvVuj3sxgstdtNI4UkzJLRHy1U3abwJcwqj6OY8XUCo5yWtSi1574JpdB?=
 =?us-ascii?Q?Nrso6R6sT1eI4aNFJeA0RIU1l7T4pXTTOYNMk+KbZed+0qfo1ZB2ZHviIeeh?=
 =?us-ascii?Q?nETfHMYq3ErK5f45uuUwd058sXgXM3YUw1qNY10o50edS2HsSlBB0xERyxML?=
 =?us-ascii?Q?a73MJQWt4hWQ5wwKKRDqZAEjILSyFx7ClOtDx1ho9bo4kmTqImNovawroGM0?=
 =?us-ascii?Q?nJbWGefZFccpFrA9GvWeOgIFw8HfMBnc/om4UFXv0FiWbK6fZ8kUuiRehd3q?=
 =?us-ascii?Q?/bejBBNaSsJOnQRWU6mlyD/NcyvzzSW9V6+sK2QwTUxfiNsbzqcj5KjbtfYe?=
 =?us-ascii?Q?g0xaBfo+Gt2AWg4o7NZ1IIjD7FJWxDxQcK9s5u/uJRbo2RhrTMhZSoy72xmC?=
 =?us-ascii?Q?r6rbK1ruopJ4YRHF5G78Gvg/nnZtz4BUTGddyoYbwsJfsAPZD2fo3OqYhDxI?=
 =?us-ascii?Q?OYxnz/OBq1zEbwt3Aaym2gwhyMTuV7Adr6iCbWVDxjl5HoUM/rbJ/SSIFBQ2?=
 =?us-ascii?Q?8Tx/0XjPf5XhiEEJzSLgzgeBvHvIZU8VIgA4Ycf2niJGNihj/liMkMb0k4Dw?=
 =?us-ascii?Q?I01orRmOn+sZGkTDeD5hOK6nLIhZ3SjIy04g08D9ngaAHMq1w32Zs6hSjFWB?=
 =?us-ascii?Q?8WXwEJFWw7iobu5WFukAiHQJt4GolZtpW0gCVLidYTaKz/kGxGYzPdu+KbSY?=
 =?us-ascii?Q?VpXeToAtMEjGWwueRQQS91XANiZq41Q/EVI2VRBDh422lLmY/zH718XYEt90?=
 =?us-ascii?Q?/BWOgT7WnJq46omH8D8QeYcpo2+P293yyv0VWppLKi4xKvZDbX/iNs/WxRIb?=
 =?us-ascii?Q?vE6WLA9aweXa5FknG5rB82YjAILD5c8oM1JcVm4QzcjnuPpB4vi+oIs/NrRr?=
 =?us-ascii?Q?j0g4TTiM+DNHx2ABzjdVsl025z/JhwGTf46chzKKrPKVGgUUqEUwbq87jAoN?=
 =?us-ascii?Q?FLENn0+dB8J2lGFjRkQRZw/AI9y3p+qeRSh6ofTIZkYvunw1uq1ZNzXJgUCR?=
 =?us-ascii?Q?IZ3HG3oAB9uoOKhGioaDueRKEAo0QKs6r3J//P4ttrHoemGon31vYnoVUeQv?=
 =?us-ascii?Q?hJQRhBzkbME3Fxpo+SknDlHV4++hvjSNGDulq2iODJL1nPb9qb2yo9wo/ogb?=
 =?us-ascii?Q?utmpdBayZbcEOsnmBHT6EJNsHIAMd8mqx7J26pgL3IFH+gR4IF+itpqIab8e?=
 =?us-ascii?Q?TcNLplHRF+F8untPq6Pal4btKx+uRq4Bdw0a6u0XdzC8N/7fr1hfJ4xZMBGn?=
 =?us-ascii?Q?bgRlrozZkqbKwTAo7W7v+v43qhTpPj3xvidOuhDKptKB6A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DQkpoYiTTU7r65oIaEoKFOYhkACNr7iSc58l1Olw5hoQ5t+NuPLiXz0pCDEv?=
 =?us-ascii?Q?bpjf/pY4XjpBLlyLZOqU3WAWVS/SI2VjnxNRr699flLiDPfRfu3nOqxeDOZc?=
 =?us-ascii?Q?WkBchGky/3hwcIgvhKI+lAQSmieGqNRZ4tF239LYeHN+6kgt8YK1JJN8sDW8?=
 =?us-ascii?Q?LZilwZvFf+SQlIowqdTUeLING3TvdEpMLjLV1D/BqKa19SoT/89KXKq9qb4l?=
 =?us-ascii?Q?/PXk/JoAdM2BLKfeEs81vC8P2IJkpXpQxIT09jcP9SAzukTWBSQkOqUvma6E?=
 =?us-ascii?Q?1/j8eRQFztSqLKi3v4c5AX+sgUKeTj160E3xPvqljYkShn7bl2oeHiRIZ0Y9?=
 =?us-ascii?Q?4NRjUQfo4myEqkxTG7AAGnIIMN3p/RIFAeNoMSMw/e+SdoykIx8UU14eLj5p?=
 =?us-ascii?Q?O7PbBUbjMgrPOrpKqvFQpmhmgZs1/zWu5/ehlQhxNhGTDw6QdyGktQUuX8ke?=
 =?us-ascii?Q?g8pOj53iqqZjDIOd2cezp1ZiSw5I/LBOur8PEhe7DnUoailWxVP1TUmpqsCk?=
 =?us-ascii?Q?FAtSO5OS6QkIK7+F59e3jkobnBsEdzldOYjyljrXNwKhG8FatPGZMH52K71i?=
 =?us-ascii?Q?XVGvFu5RJhc59QTWp1jGJcIJfK5foAIONT6fJcOeo57ro9NDSlHRVUFvGGIc?=
 =?us-ascii?Q?QaU6QWpBr5Vny3c0nJdTWG9affVRwvwyfu+qx1vFmwU0hTerIEjLzvUu/l4x?=
 =?us-ascii?Q?VDQQd59Ete64kUgJIolOVqVI0ZJ7od1cxFnW2o3FGzN0JnY/T93jSFfvTydB?=
 =?us-ascii?Q?LOQsWQTYS1/uM+vLYHp9fyrWW60DTFnEJ2/PNwV4DcFieEiN19c8WnSBRAmZ?=
 =?us-ascii?Q?8q2DNkcfklO1JUeYiJ9NOHEgLgkKapsB7MbJitCsxqBWJGi/xqFmocN7ScVg?=
 =?us-ascii?Q?fc60PkI6HtqKNTUkFJ2qH6LlZc07+lAl0dbonrpwf+xICWVCXcgm23Ysh8yr?=
 =?us-ascii?Q?C5rL+U8Df++v1ffmF8IOtZ2qBvWLbAoKZeosI/QfYqORBG8OHHAhpv8sb7Ns?=
 =?us-ascii?Q?B8ICSZt357K9nJWhhn+QF2fEEomEmDLJm9qzZuxSrdQYA83b72kq5LDab347?=
 =?us-ascii?Q?YxmfguTbtAN6afRHla5+a4+wxkGeR9zFHxzo/9rXSNIGM6A+hB6zDPRJ9+Jq?=
 =?us-ascii?Q?gLtJEL28bf2Z8I2R1GZSvfoqnufB3PTIUCjSM53/xXPZ0L6LOwYvI6bLG+/H?=
 =?us-ascii?Q?2diHh0vPnOYSxMxavnJtID4Uo9xs3o341r1Vel08BjpfSFnzkYnt4tMyZB0J?=
 =?us-ascii?Q?39jtHVHcQ1ODQIo9uUMu8EP8qLpJ/Zo5cxEubXDJ/M0gNVxsYt66nIkvsczN?=
 =?us-ascii?Q?TZMfXKG9/gxZIzePk6rioykBTKXyltKOEwvWcZpJDmCsqgoPGMG4bHp/UGSd?=
 =?us-ascii?Q?nK7qifH66YOcEznVQFDczfC5AuDKUb73NB+HEMg1cmrCIcC8TKGChG7LDOGE?=
 =?us-ascii?Q?voWmp/cj7yOpvAFSxok1PaPC650+H81eNuDIavPds4xcuX1Nk9AsO0kVYKcD?=
 =?us-ascii?Q?hUsYUPhTtXWA8B0yR1WKlzHaaMtRfTYo39EWMyleiwQL/1Pht63t5Xt41PdL?=
 =?us-ascii?Q?cL0sFSIh5uvQC0PU7otmH5ELuVVazVkybeh8VkmyvbK2TCV/pO8bp2ECw04n?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IGvc/NFocsSEPd+JRFpBQs1sbrEMpKDJD85MvEjYIUvlX/XoDsLHIAEXTG8MoRdPimucJ0R2gWOw3GcrICGBX7/aw//ef5Bm7CAUfCU13MUcgEGg/BWDIgY7QCYb8rne9Au1PZ7AdwmTnBj7hlWM5BxSDdWsua2v3FHhPfyFiPjeqgn0WnEAfwuckik9hDIzqyujYERe062PfbsVXyl+5HzZ6zvg1tud+9+blIvgA17IO2nuiTDZeEUQeSfjl8NnWhNKtBIySFant2LQmX3IBVdQPW5vX6IlW1GKY305iyIg25asHSlx2ZJapoy2dPx6ZUnqtOLCQl/0l+/YRsfGR6E5aZkxSQBY6NjTwo4Wkg8yZtejgLMfQgIjamEELfH5s3aNMAB9C5HlwqyxW0Aw5Y58YOZFAJTV0YbzN9kxWlLPleCOOih+tt6asoaRlsJCFdhT1HVOJQFA0NozAxdNIQbNY/w54m244iXbR/M1dxZx7nF+MCrnqP5QETZsRray1gF+cHkH37xYWVMsuon4M3XOvkHnVgJx6N4U/7odL10fLFTriOgF7N9BexwSqBzStWZr4GNFYvYa7Tqz1hzgJsyFhcwS7j8Z2YxtuDf/5ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3153aabb-8ecc-414b-c180-08dc9c570141
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:47.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn9aICq0eNIZNFTS3FmfTPezlHJUqN7z3vkYXHoZvWkHasFnztovQly+RA0sl67pH3+Fw1QH4BDwNMU0LDFuXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040134
X-Proofpoint-GUID: lH9ouwsfx-iDhe7qV8cNLJBeMeDRpijq
X-Proofpoint-ORIG-GUID: lH9ouwsfx-iDhe7qV8cNLJBeMeDRpijq

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

There is also no need to forward declare the static function any
longer.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 45443a53be76..5d458c5f080e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,11 +76,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
-
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
 	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
@@ -2398,22 +2393,21 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+static void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked = */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3186,8 +3180,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
-- 
2.43.0


