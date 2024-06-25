Return-Path: <linux-kernel+bounces-229569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852FE9170F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908EA1C21C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1E17CA1A;
	Tue, 25 Jun 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPNhXfD2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lEiifg/T"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776017994D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342739; cv=fail; b=TE8zToFWPvHAfkG0DNmVGRPvrcnOL/ULBKFeOu+TYtZk+TrjTwm5TpiEP2fKAS5lGI2Oicy1bPvxiE2frITfcNALchDDttQ1W5IToSo5sE9ozIxACwFCDDffox74FBtDHAB5nWkRGAXd6U8NKlM+vFYcDB2OOWlr/PJ3hDBiYlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342739; c=relaxed/simple;
	bh=ZPESTzeh8XvfaDK583IP69YPpytuZWpRLgai7JM9aKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFQzGpc/J+DhRFD6ilogl7oMyd4hZ5d35Ff7nH/jFQMTdX8hbMd5sgq3+EylXv2TaLO1iiWF03f0LM3BwmIj1HPs5TxHCliLiQg5TFFX+RNiLPrVPLDCrSti1hCS6GyagcSC7Lb9E0ohmRfZwPKT3gRNMxQkPMLKbyqdx03tq2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPNhXfD2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lEiifg/T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfTXT012777;
	Tue, 25 Jun 2024 19:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=; b=
	mPNhXfD2YyCu1QIjCFq1gutp9o7z/wM2W289Gzuz+bqYxQ6Crv9PsTN+DN+bIhR/
	3kV1FgF80boAM3+/SWBueFViWUqiZmvawdFLH8YIqiEEpyCU98KUW3OL9nIxTURe
	yR483TYCp0mqvCeWDCTRzeK1kMHxyj+X1iUlBvWUZS32chO6cTSma0akcMQ3VbtQ
	SLd96eMr6mosG2hrHceyBgBnIVpmlaSMZa1O9gJu9FV2v1gTRElXIaGUS+eKgpEy
	HCiVPbBQA+qPdAzRyMCJsbV4J4y7BDYvA8OObhJLIWJ+j8QgSkk7BCF4MYCUX82l
	Ni3kfs9bkwdOHcPEi85vTQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc9uan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:11:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIqmFc010741;
	Tue, 25 Jun 2024 19:11:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egt33-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:11:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEHpOtHErB8DakbB8jrEBO+fZjcvBeag8XHhfItckG090HVNw31TsV19UG6wYN/PeF7yk0XdZBUNevZmSb74JuTrAEwB5MTgX1ZZ/enadeKldZglSvJFP3ahSlxA8K5iNRu2EtRM1VnqHuSSAOUZFZMQrAZFJ0i1Ywh/XjoV7sWR4GvBMcqxRuGoqgB+j/RWAAEMMe8InV3GLT57sgdicPvTyBtZqZFbj1j0kJjkvAjTZstxdgXGYqUz0WimUiR5+ZpBC4c0aMX3cIes2zhokiOxG79ngNxfrAGrDrfNILnjgPCcMk5HzK0kwOFg5bQ6qZn6BU+kpwiWHsbUaQVA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=H+d9WVsjwI9R8RKiXC3XJWSXos+N5UhqCL+hxhpTScTrkqQPh0xdZXO2+JbRv0ws4FLZd77o45BS2TGp4qIzOs7dGwhiEuu+uR3BD3lfxDwqOWXXYTChA8m6VP/aDfw1LG4lA2o/WwF4cq7kHtpYZUGXCauVkBKwxkl9KlmUO+KW9HPoObKvooIG2ha8m1RhJSn6CslVq1OXsJ1Cy3Um3iHyWrJ6FiRM590ceQk10luzyJkZy1AS2KHG2MAjaVdZ7sdVsY1U3EpBWkStFgTqjT4hW265ylHt/op96sycPvZGgH7ts41HDo0J27FyxsETdw5g852b9Mo4IyUeKBqZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBrw4cpyDlw0oCxrS1NpsHrvh6il04b/OpjjP2KEzV4=;
 b=lEiifg/T1c4VAYIPkFZJVXwjAHlnz+oQD2jcS7CVsqEsW+htt/xdGt5eh1c80LmwygYPzImYU6/oaeZHrEri4/yQnS74hIYVtpu+QCALyrSLvYtHqgmeY0zQTIfHmXXG3ainwl/2m1v87I6HKEz/ajmtKzhc1SeBYMK+UtS7upc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:11:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:11:55 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 01/15] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Tue, 25 Jun 2024 15:11:31 -0400
Message-ID: <20240625191145.3382793-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0058.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 6265a5bf-9856-440c-4431-08dc954aad83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fGy679aj1+cegQynxq9ggpzb00Y6VPByi1kssyyONJwE71PtdaOvSQuO7vmX?=
 =?us-ascii?Q?PdcGD8IOtbBawB/HCv3EJ1rK7nM8X+Ue/M0l3NueHADkcBZ+Jwmcvswnfm04?=
 =?us-ascii?Q?cLlkYhXS3mkoOup1K8RqjMlNo2lsGfPHh/XSAfMTF4lM924FFpHxDayKYmgP?=
 =?us-ascii?Q?5zpZ/N/srJNJ2Y1wDNv38JAwq6Vnsxe6KClD5cKv4j6HLSzRUj2KuFy3Qq6a?=
 =?us-ascii?Q?/ZLFoGfPV09W9g3v50XJlX2diBchyodIvEy5PdsbDyIkm8ik+rzzCbb70ym6?=
 =?us-ascii?Q?KXBp/xh3loD6RjO4YaENv0oXu4dGx9iryNQlMEUHcJIrYXPJ7qzjs9a2gcSM?=
 =?us-ascii?Q?KyQ7g09MnJkT6t3IHDqzORVcSRBX7KSWzT0BMsSSKYMxDeiAw5KreBTxqgaL?=
 =?us-ascii?Q?5SYQmJJnutueBuezajvCZVaUwg/Sd7tzLjbNfLXIjat/G/f4SAUZ/GBuJAWE?=
 =?us-ascii?Q?XD8rLxcjphldyP4jkwm7bftX+uh4rrXBU30EwiZhOT49eAL644+TdB94yYQB?=
 =?us-ascii?Q?tCQD1d1TOcuNh+3TkyfP6iAQT8AJ+Qd6GyaL4i1tJNgANwD01LVX4X6/q89i?=
 =?us-ascii?Q?WhSSLsfde1g2Ozp3dWf+TgcxajBvXzx+L3K07yYScLxNTjMkMSE3E2NEdlwq?=
 =?us-ascii?Q?8U+rB2btC0zPTM/QTAaMRguaX82yjXCu3eRMAod9UBtgIZWWJxS6+k9uM8ke?=
 =?us-ascii?Q?apKSEUVNIkefj1tzSPTc4fd+9U3gME77oFsOx80cfLolN4IagrDyaAYpSgvL?=
 =?us-ascii?Q?wTxAV73g3qHyUa2g8pJ+NrsTbdslRVmygBkyd26iurjx9iZ8pubTZd2zEtLT?=
 =?us-ascii?Q?u7u4TCu+nTaCi2GutyZx9CG3WAwzZwztuIYqbVvHt70WbTxCKp/fhD9/iqJG?=
 =?us-ascii?Q?PSFR5ZRvLoRwOVfNYefbejNA0LW3SUkUNRxnV9CZbLtRFmw5Ww9jHX8E6wuu?=
 =?us-ascii?Q?59BGRTeN6dQppDbZJCYOzvCRlp/FMz9Am4pioSacaKd1Hm9Sn0bJOJZOJile?=
 =?us-ascii?Q?yfnm0NjPMjwjgkDWmsBt1bAVDchp4Ajlk7fvCRRvagN8xVxG2kld4p1TepvI?=
 =?us-ascii?Q?6RTJTMuTyF9TzmFs4tg9akthxEnNs5HQwj6hmdNyEgYJE2MP1MHInebtDjFl?=
 =?us-ascii?Q?wiWa/fPbWlw2hvJ2owqpQnb17IgWVEvuTLSNpGqo25SlfldGrMFztrgpt0eT?=
 =?us-ascii?Q?xme+k/ok62tsZ0A7AntM3Vass++uQDf2tcIQGNEGBBHKy6ULk1N0FwmcP8IG?=
 =?us-ascii?Q?4cxGKNeTE3w62esOnRkHubvX9EHN2M9GYdpdbvINL7TjL9GoBeAm5x3kxDRd?=
 =?us-ascii?Q?2ZXHlwKMk9jurz71LkXL8U1Q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+WvB7CrGT6+VIuwdJdz0RX4/UtsTVdPYzyptIeTgnxvtwzqMRg35ucQFjn+m?=
 =?us-ascii?Q?5jg14AOsNULAA4Ce6hVFtMWJI4JliMOYcHOTNaLnSKP6gLHmcGd+J4sSXubc?=
 =?us-ascii?Q?iguHog1Y8wNyins3xzVsO9Hf+q/mMxq1oy+CKkUaHWs6g1B22WHCo4LUwJQl?=
 =?us-ascii?Q?oDVQQ34Udq689smDjJ/rtrusA2dYTsdwV3buOTI4K9msF4JU4iFhJYX5ROXr?=
 =?us-ascii?Q?+aKRGfSRPuF55Di/q/TOuHU2UsT1IECbQCNiQuhbIe4bZA2OVXxv53r4kIZf?=
 =?us-ascii?Q?zIn3luK6T142bZSERb6Lhg00PUTsJGkWPVKhu20k44Cep7Wtp2N8zVd7CXQG?=
 =?us-ascii?Q?z61HxBEEY984+04bHhm+p//jXUiYTfkN5P4qbmST4tlI1mp6n6K20tCR+rk5?=
 =?us-ascii?Q?r8LFtg4MpnusQnYEXnFiR/gVn5rRSDFgSabJIR5cj9Pb9JjfQHj6vT4vAk9L?=
 =?us-ascii?Q?mhZ5SNwjsGNF4aZ73GCD1bh0EDQU1TfgiVwIKThkZxWwQ+l0KZYUMeSDMkCl?=
 =?us-ascii?Q?2FPbLhkmLontYyspDZ2j+/xuu8v/dcb7GnTfy5LshV41iOZRaNgvac31vDYP?=
 =?us-ascii?Q?08UtwWHPyG7ZxudYicD+mU/WVma/fBTCkZJLsMMiYKbjzFYTQLdhVnANuYFi?=
 =?us-ascii?Q?15b03yzRyNUXAA8W/3kJHoxyrgxORWmIdZyLWnsjeRdCfBPdjP5jDyWhoDkY?=
 =?us-ascii?Q?lV3EQaYwJ/IWNcbpKBqrQ+4BMBfQ809rhRXGb8inlkrM/mLmNScwJUG1FwL2?=
 =?us-ascii?Q?DpKsot9aNxao8TuMs11swfDxkNP7vHH+eMGYJ1XjE9YbnSMH+k0dc7nAwODv?=
 =?us-ascii?Q?ejWRvQJBH5GS9lcrXeHpyVSeJpTvo9CVUWJ/NiQmlsq5ZLJfC4LqpEQIOzhk?=
 =?us-ascii?Q?2XNrVpnGZ2bDtme7eMBsNeLVLKkgY+ihuw7vzELYgA4TkOQ4ttwPYBijRTIN?=
 =?us-ascii?Q?ojT8IVGbTGt1hN2UCoR/MSMc1lxXaJkjdMTmoWmvtJfb7AXrgpiL8lxX7ZMv?=
 =?us-ascii?Q?wesN913+2QjtgtdQHpqT94ITaxF03mx9MFeQIefGzPjSZvehrnGiyYuOUslr?=
 =?us-ascii?Q?2rmwgvQ6seoIKAMkpIevqj54ySV51TW0QcdZ39YN/HIY+OgrT+wJhqCAGthZ?=
 =?us-ascii?Q?Kxu/S/EJokpr1NK135/MiJdeZrHAAeviPiKBdxHQoPgPad0atx2GLywjsMSH?=
 =?us-ascii?Q?Y3gksPZUouV1ECmIgP6Wf3lfzprSi7miF5N6GooeCdPr1NQtwtG14+4NqH0r?=
 =?us-ascii?Q?bTKhaX9lrvcq1lM1O2+GcbR4E6DWT9Tav3LMAUK9PC0aEmDdAm3iU2XvDukf?=
 =?us-ascii?Q?iS3L3JNnc8DEgK8uMqM2Fy+U7+Zz/4gD6CqWCoup+2kpLrB/En0vU74/KN3w?=
 =?us-ascii?Q?yGTl/yIgRXvTB8vvF9lj6Qz3zrnhA6WuGO/PSyH7zurfa/4gEN+Efhi+idgy?=
 =?us-ascii?Q?qXPNvz1cOIVvC4aZkb54DSjQaNjY0LGZdxQMTt8Fy9nqv+TfLvIv97Zgvp9a?=
 =?us-ascii?Q?VRvfqZzb0EhdpcLpgK85FADMOslbAg/PiUyCO1SHXOJx8vRdIcoC8eQCM3cK?=
 =?us-ascii?Q?fdOuQRapzfuX/4fF+gyAboIwLPGHmWntFUnahKeL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	55LF2vGPax14wf6hiMqCHwaCXf6D2hSzzKOPnyoxVcWQ/RXnUQ8SdxrhediNHsD2axM/bBB9wkPjH/H1JCiQirTlRyLtoNMgIaG8YbswbwR5ZBX31UMzT8upyQKcRk0gOByGR7i+c5QhavPEFl3mbBIjJXCNmSh2NgE/OD7fGwDWkwkfT+SDIhLzeE0ZUi9mZHaapJulspq41cRmgmhrWBog/qan0oYEc0Uu+b8ZbV6x8rclXstxGSLbeLSorKGbsoCQLYIj58U+P4oNp1Sz6hhVxnUlYeDyMkjL0LDXM0gepaJcyhxWtPMzjG9BhNSQIgPZ7bv+0vuP+q7FR6Rf1n/CgeNCP9z6unbxyptVhiYvKqSOMeBP7Ww/ANTWUpd6uiuv56hfXFVo+6TH2q9dzEawcP22FY3/M305ZqUZO9Im/wB5iAUtUQ8g8gVi5xKnJjB80zmxmEAfT0r257CE0HtXLof4tTep6xlGOI78bJ9Td/ZUVzqXXHbpLZHs0pu99kBO3WfrUGaOqi4WYKfsc8XzObr2Gt4DRDjYezXypP4vRT05X15t9xRROIuWTzygrdAdGu6B9QjcRN2uD0g66CXcuOiUbfHF1lWNcBHfFBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6265a5bf-9856-440c-4431-08dc954aad83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:11:55.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hrm945YIyWRIJ5/dWHA0UmQ/X6F/bUQIb++DVHwkX52j4w5Kw3Rp4db6vsXycDMmC+uFoCVZMnOXvr0Mt8fw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-GUID: _NQkidzSuWG8KZKS_Xw_eGL4S8d_6KHA
X-Proofpoint-ORIG-GUID: _NQkidzSuWG8KZKS_Xw_eGL4S8d_6KHA

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..28a46d9ddde0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2414,7 +2414,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original vma.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -2483,6 +2483,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


