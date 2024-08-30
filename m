Return-Path: <linux-kernel+bounces-309312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0689668C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35636B249C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B71BB6BA;
	Fri, 30 Aug 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hcLMtp8k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q6wKQvlU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522571B8EB3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041626; cv=fail; b=p39LcJk8IU5RKpy/dhlmtFfesh9uux3kcdsE6ZrhDMt/+/Wf3wPYaHUWQlh8U21Vm7YqWnsc2PuoPPfLBca6OrkfYfdy83y/8ehKLbqvB5Pg5DQxlznWSf1YAX4SHpFH0mN0/C13BTMVTNC9oACzKjQgiOOdcpXKv0LeaT7p/uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041626; c=relaxed/simple;
	bh=NumW+9X8GQMbHo0zEB1t9dHKlzwen/B3mfrZRJVZUE0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=faxaIvv1QpNu7gyB7BXjP2b9XqAfACbct89GIapz0YAeM0Vu1kxTDNo7oG90dHEBs9QUGOmP8xLkxw1HFM6OmgC8ywq4J8qu+9IwaYKghALrB6o7fpRkNo3M6+ZmFkITDraV0rn8AYN6kW5A5Tn1ImYs9XN7DxSHj2jDXvBEIh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hcLMtp8k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q6wKQvlU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0Y0K012257;
	Fri, 30 Aug 2024 18:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=hgOaBQLjDHC/qc
	MgPOvvP/PudOLehkstigIWTXlG9hQ=; b=hcLMtp8kqoDviw/D/O2A1Lrq3Z1kRO
	IDhHOR3Wch9J6Hsu74qbtY7ma5nb5mAxLcFd5WQhIfzy1IBP6sCHDcdJo+DxHtju
	C3o5nyuXqH4VqXczn5L7/l5gfKO1CJ+5CeGj/qyxGvLUQpxbded/L+IzTOgwvlUI
	mWBvZdY9t10sBLQGnF/hG4EO2EL1u/c9toQ8gtImF27oj7cQRw30fsTW7c3jhmqL
	fHIorBJBTefKIjVW5mKb5ZGfKByIa/A5KFdOUGqsEOl01cIobA+9Y3VfZhpx2axj
	famfNPZJ364qex/WStcgtGTQdlxV8oVDXiNKwFKa41il98nd3UWa2Ppg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bgf78c25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:13:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UGpicJ020239;
	Fri, 30 Aug 2024 18:10:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8s4f6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAeVu3azpSS9QkHIDOi4RzpSfPS6EfMQBT5DUcMWhqJvW93GnR8CS7JkKPDY5p1l+E/fQCSXiLoaM5DpN3/6vnCFnbjXh26fG/R4kZxLlj6I1i+4AOo0eeq2Nj5Mrb5Z+KbdLAraFCnxqqjza7GbeJb+HH36VbeqZKU6bQWHU/db7ZNPtCW0hvJ4yyQ/kwLItZvfSMZJPyArDthr8ih9rLtf55aYUlxX3Z0PL0Ka1tNxMemqFSnWn4bpduvHzyazm/K8kEqFSrLkULUUtbf8idsHISq6PbGRhRtm01kHJENI00C5CHAGSgCNCXXFGH2v2GoXqJ+mRJ0vq/bMGqzwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgOaBQLjDHC/qcMgPOvvP/PudOLehkstigIWTXlG9hQ=;
 b=ZiHfSrW6ehEUiiP6vZqXlsHnma27zoIEDPs3fmPseLbAFYKpvFIipvkdCJU0XQfVQrkJ9gRoyrK/zXolZvwWpQ8XlmeH8YrTEqU8DfDKdKlwdbIBV1xAv+4SNArpk7UOhcBkYu6cRNKlryqoBGePvcS/7nmHG+c9U2vVURra58YVilAVOZGIAkeIHm1So5q6NXakyXxcKKV3Aq8Qf8CGANUEmwAEfHu/n8YUiYUZWXQxUh84XIp5bxRFydQwrgRDIYuofxVUSFSeRY9tJxcazr+DQ5KZx3FKd+oO3muBIig4sOzNyRN4hzt8K1Om9Nm7y6Ojm3cw+e4DoSQmvOEIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgOaBQLjDHC/qcMgPOvvP/PudOLehkstigIWTXlG9hQ=;
 b=q6wKQvlUB2cOEwdEUzVMBSqO2aN3+2hngGv5MUHJSA4GWlrJ+eBkmad5aM1KNLG4WBUIuHnYBC76nazHvOZcth272JAGIKks8B5AMm0F2jpG214c7+OPsz6ImVeUVM3zWvaKrsMVniwZWee8ghv7aVN37+zoUnzvmlCRS/oPcuo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:27 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 00/10] mm: remove vma_merge()
Date: Fri, 30 Aug 2024 19:10:12 +0100
Message-ID: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0147.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 854bb1d9-61fe-4eda-6744-08dcc91f06e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ol+qkVkzr2iMsEBWTsHYxD5BSnFzrKNAOcrtgXoU8usUt9xLf4qnqkoEu94w?=
 =?us-ascii?Q?7TahlHPk0pqFN1fv3YSQLKcyyhpcZcW/P6Fl8AH6lx05foSDZkv1ePkB9+Yr?=
 =?us-ascii?Q?c32GYu5R4coYx5mT7t2rA9kFQF2UGZ0uHUnA45EjVQnG846b3rwMWwS4O27l?=
 =?us-ascii?Q?0yb2Q/rjv9NztggTtc9Dy/lPC2nx5FllmJGliwKkZmsQK3eeXV/ENH1N+oM+?=
 =?us-ascii?Q?c5e5+0bERbCuvsJIAo4u4b3tsSrJaQ0g7XDv79jEcH4V4xflUnPzLNfquKIb?=
 =?us-ascii?Q?JVCeCdtzps+nGCPHNVuUoHIrF+DegI+K53PW0zQNxvhoug4QvGwhg2apq/R+?=
 =?us-ascii?Q?hj0sC+YAxSj1CnhQ+NMYRB9vCv8ZI9BsUfOQP8EAFR6k4upCOX/ziV7p2pmf?=
 =?us-ascii?Q?TZ4XqeTmEU/7bIeOMBY11lW7qbss7s2aNr1ALGvD8hn+QdS2Df2pczbrBmWg?=
 =?us-ascii?Q?U2JYTajXhsnHtAaAJ1gY2ieTTzaAC79pxSUNZz1GdlP3C0kANRes61qRjEzN?=
 =?us-ascii?Q?9mW/aeAJLlm8fTfmZbDP1ns3rD41tqiUcqkWCn8g5r5OlGK2OaSXPyGwqsqp?=
 =?us-ascii?Q?yNQDWbDIBrCfcT6uxhTraedVbaD85NIJMklzlEm7RSxwsqUav9h7wsvXQsQ/?=
 =?us-ascii?Q?KXobS8/MQtsmAPGJhEln62+Qtk2/4twDGNBT8nbzfFyaG+wCIbrsrVNNIebb?=
 =?us-ascii?Q?zPRDlxdfbpK4P8WsBetwBmPcemmzvOQa+1YTVMjCYIR3HJGs72pf9NRsGLsh?=
 =?us-ascii?Q?LKhpai3WSPj7Ls1moTJAsWJ+6lqIr1SCZ7KZMkWonBao8jKeQKF9r4SHZmAM?=
 =?us-ascii?Q?uHA4zBHtcWEVg4OGI/PJ4J23SdQlC49rApnru7szxb7bU8IC/LBbDaMkK6gb?=
 =?us-ascii?Q?FMHBNUsnZFdSOrrcM4ucr9ICzgbXPXi/125wUGLIOXBJWfjlLyWIx4c0lO/1?=
 =?us-ascii?Q?fYxeOBdRcYirCs7ECw3bYbD0U5etkfzvYePpljzIIMmkHmR5/WSztb2rpMRL?=
 =?us-ascii?Q?ofE0uEk3i49/bjfYlpQa8tnf6Y9XfMu9C2rsRdC10RTOcZ4HNMYE4E1rX3z5?=
 =?us-ascii?Q?S94X3XXlMcAe767+iMe7VF++hXZ9X1c32esYNh1t6jU95qYFb2wDESuBAWJm?=
 =?us-ascii?Q?+pXkeFw6zjSGlpiePcJesbOgX+ZBzrXDPl8xp8Lql65WlLEL834GWuWHzJ8O?=
 =?us-ascii?Q?5gU7tyDvUkSymQ5KFoyKf1pajYbZqJM7DCs4gZ6IoGRlh6f7kKYIZL5Sp3Lv?=
 =?us-ascii?Q?VKz0RxO6iPFtshjsAIRPnKRju8Q804FHxqdbHTbgzSBy6oD0mQHT0Lgja2Mn?=
 =?us-ascii?Q?PiRdVnSM8nZ8d0ikeik4ckiM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5N9oEpBdRdjyfwOS2/bb6Ygrp7TrN2Qo6SLT3AffvIu2n9AsFuul/tnvTms9?=
 =?us-ascii?Q?a6+GGaMTCnJ1aZvMzpUZS4fPJCU3RdlMDOk8iIQQ9WVKXfnhIbF7mwxrh4sa?=
 =?us-ascii?Q?YlF8JXNAS6gZQQuI1h5P6RgW6LItBY2JCtm2enRVtiEsBrCbL4Pcgm9qL9WH?=
 =?us-ascii?Q?hd4v0tKWnzxMnjKkjolZ5QMTFfSDLnMZcUJrP+EH1c50GtDylB9Erbh4boHq?=
 =?us-ascii?Q?4EyZmTFt3QSrjZfjhiylu4duBbawJA/vMqBSsxNwNiqeIlTYeHY+/1W8oYtJ?=
 =?us-ascii?Q?9UworpxVsCExyTyvwJqFetr035KVX60sJHwezrSyediV+5/VGFVNUj5Q9mQl?=
 =?us-ascii?Q?/NMAnTC5npDxQYWQTSsgOboEmMBDA51nMmPaz2yUYlQgcAhDbZUZ3Dqehpts?=
 =?us-ascii?Q?K/WAbT3+wdLlSFFMEoJZL/ZnNkZb4PQDx8WiLrvtLU3YO0gZQd56x+18+Fob?=
 =?us-ascii?Q?zT3Bcj80UNR2diksDnNGUxtv6bQsWA37X7a6XDLKDLO5tLNVylQ3Tx/EGUC3?=
 =?us-ascii?Q?aU+vHdw6L6gkpMwWLS7dzD8AzktwS8iR6kdAa3iYkm/GnfaNrjvyCe+TQCBl?=
 =?us-ascii?Q?13zPkcw2qGmXUXKv1N4xmYqkG2GUCdY5QmMppYrwViD/ghC2ph2xtZgvTfXW?=
 =?us-ascii?Q?BVmf3nooUiW29N8X4OIBH0yNwZochXCAr0rBVorgnWIy4RNQbWdnS5bW7U6M?=
 =?us-ascii?Q?hyRC0UBpl5KQEiCf2vG7FF+6n5nfDDhyax13YlsJAA4hSN1M2BzPubN4nAAV?=
 =?us-ascii?Q?uOlhOQ1BTWjQ7UxpmUTdpFdDiZ62YrKo9aPzpCqAHd8YquUp+kA70HnSEj8P?=
 =?us-ascii?Q?6vozDBeW/D4XiyXY3Jb+BxNuEHPDaoU1KMVOFi7tTvG4tKifGxGXvb6CsXqH?=
 =?us-ascii?Q?r8uGHNm6zKAc92pDI9t/HuYGt7OfveiWkBOFHfRHHaD5CAeU3/Qoj8jxdRaC?=
 =?us-ascii?Q?3mjysQA5MK2ZxxAdLVYMFfO9S3NGeh23N171nn2w0dGiM0k/6kPVVnIdYctK?=
 =?us-ascii?Q?8tvAgeHmfKC4XBw2MBu2i0XG5FNzpUEOQvbE6CQj0ErEpxkiYcLrBaBE+qUa?=
 =?us-ascii?Q?zOtNqhmCsgInUPKpqriF62vrXYPKXzdHvPhLrM4eDUTCB30gF7NxyxZVUW20?=
 =?us-ascii?Q?YG+4icSF5TPv7fApGsdhnG7rEKMbCrZQ1f+jBUDZ3gNjUlmRtkmc84Yp6OAg?=
 =?us-ascii?Q?GFh/lKx4AFSFHveG8VNxjJXb6+2jGrj/gZ7m4tDeOoZRBpDpawAoStyxBuEZ?=
 =?us-ascii?Q?8bicjjOIAMJ79CyBSfqg6bmD5hgX9QfLF0GAh55eNtu8wsIJh/nkXEEJnVZv?=
 =?us-ascii?Q?ySm81Mk/HKtQ7EQYcaLD5kZ/FxkkCaBgi7yBDg7XQJU2GbnD2zFE8RpTiSd8?=
 =?us-ascii?Q?3mn6tLiTDbgPTGqcpeYA6h9evv0xA8EUlBRGmhMcpxlYiJWhgCT/zvrS+uAN?=
 =?us-ascii?Q?8ejQahzBewmyonx0ZUPGUg9jFRdyZRDLpU8bjY1+4X9Q7PzGVaCgU/Xs31MR?=
 =?us-ascii?Q?QPVS4Y/RJAh8Jw5I9it4p1TMgHqICMhUPnUrOacClbYslg6QS9Fy5Sfpe1Ur?=
 =?us-ascii?Q?y1mMo5wfCG6Jqoz9AwrVjjure1csIEUz1lQfCbQwrYSFyY5iz2LZVtTJj9iW?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LZEDrpAietDYHRdX3mOzNNt6edRZq/SvcXDjVzWrtY5D8d6hG2CCSBkedFc15lSXs3gU+PwSIfNI+amAU6K4lxuDyGnYHnusYvjeSWgvhK9d+cgZuuBzfsDcFH6iuNPmhxW0h9DdYHEnh02QKez6kw/CgkqcmINYytjUoVdFovqzuxnFs9BGk7XIidMfu8sGz26PhvF+dmrde+vyUwWfEKWUHQLevvd4qNOJ8BYtazkQGHzJmlhI2P3A/3Yk5PKJ0XkPVF92toz5H926WedsCfsgPLrq0gSS7sMAiH1RtcSuJ3CietoE0Izatm0WmMLZA/AK96BeWLyjJWIjiclF+XS3O6jmQ2V6LKTMNpKS5No/ZvMfyra+hkHrkzu/OO4+GunFB7YUbRCjQcTrd3/PjVH3EnSD7TrCBfTxBSPpW/0pwWv3hCIqlTGQjGKPs4QxW2yjlVlCCzYwZa1I/v1vybQhL/fMJeuYf7Kodam0RlYJ1PhI+8XVAbN2etnvqDMogBSWyGmL+VzJaXrEXOfMMvR2z272fnYoajcT3fOy5pVIX+DIb9CJMZY5SnQq6UE1o/bq0dzOMRDW4+b6mDmOyhEYeo9sg60zRwN9lCNKUTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854bb1d9-61fe-4eda-6744-08dcc91f06e7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:27.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdzTR2syOo9+BSZR3JkgV0KQxTgOkZjSU5mBf4JRMQRRXzI9dkht4VEjGfELqb7jaNnCLr3Vm/vwumdyPyzG9+xE9tZ9Eb8wKc3oKXgP/uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300138
X-Proofpoint-GUID: jjxSHPNf7FOGcthPDAd3aGkJ9GECtRN5
X-Proofpoint-ORIG-GUID: jjxSHPNf7FOGcthPDAd3aGkJ9GECtRN5

Andrew: This is rebased on v8 of Liam's series [4], so the ordering
between our series should be to merge his first and then mine on top of
that. Thanks!


The infamous vma_merge() function has been the cause of a great deal of
pain, bugs and confusion for a very long time.

It is subtle, contains many corner cases, tries to do far too much and is
as a result very fragile.

The fact that the function requires there to be a numbering system to cover
each possible eventuality with references to each in the many branches of
its implementation as to which case you are looking at speaks to all this.

Some of this complexity is inherent - unfortunately there is no getting
away from the need to figure out precisely how to execute the merge,
whether we need to remove VMAs, whether it is safe to do so, what
constitutes a mergeable VMA and so on.

However, a lot of the complexity is not inherent but instead a product of
the function's 'organic' development.

Liam has gone to great lengths to improve the situation as a part of his
maple tree implementation, greatly improving the readability of the code,
and Vlastimil and myself have additionally gone to lengths to try to
improve things further.

However, with the availability of userland VMA testing, it now becomes
possible to perform a rather more significant refactoring while maintaining
confidence in its correct operation.

An attempt was previously made by Vlastimil [0] to eliminate vma_merge(),
however it was rather - brutal - and an astute reader might refer to the
date of that patch for insight as to its intent.

This series instead divides merge operations into two natural kinds -
merges which occur when a NEW vma is being added to the address space, and
merges which occur when a vma is being MODIFIED.

Happily, the vma_expand() function introduced by Liam, which has the
capacity for also deleting a subsequent VMA, covers each of the NEW vma
cases.

By abstracting the actual final commit of changes to a VMA to its own
function, commit_merge() and writing a wrapper around vma_expand() for new
VMA cases vma_merge_new_range(), we can avoid having to use vma_merge() for
these instances altogether.

By doing so we are also able to then de-duplicate all existing merge logic
in mmap_region() and do_brk_flags() and have everything invoke this new
function, so we universally take the same approach to merging new VMAs.

Having done so, we can then completely rework vma_merge() into
vma_merge_existing_range() and use this for the instances where a merge is
proposed for a region of an existing VMA.

This eliminates vma_merge() and its numbered cases and instead divides
things into logical cases - merge both, merge left, merge right (the latter
2 being either partial or full merges).

The code is heavily annotated with ASCII diagrams and greatly simplified in
comparison to the existing vma_merge() function.

Having made this change, we take the opportunity to address an issue with
merging VMAs possessing a vm_ops->close() hook - commit 714965ca8252
("mm/mmap: start distinguishing if vma can be removed in mergeability
test") and commit fc0c8f9089c2 ("mm, mmap: fix vma_merge() case 7 with
vma_ops->close") make efforts to relax how we handle these, making
assumptions about which VMAs might end up deleted (and thus, if possessing
a vm_ops->close() hook, cannot be).

This refactor means we do not need to guess, so instead explicitly only
disallow merge in instances where a VMA with a vm_ops->close() hook would
be deleted (and try a smaller merge in cases where this is possible).

In addition to these changes, we introduce a new vma_merge_struct
abstraction to allow VMA merge state to be threaded through the operation
neatly.

There is heavy unit testing provided for all merge functionality, added
prior to the refactoring, allowing for before/after testing.

The vm_ops->close() change also introduces exhaustive testing to
demonstrate that this functions as expected, and in addition to this the
reproduction code from commit fc0c8f9089c2 ("mm, mmap: fix vma_merge() case
7 with vma_ops->close") was tested and confirmed passing.

[0]:https://lore.kernel.org/linux-mm/20240401192623.18575-2-vbabka@suse.cz/
[1]:https://lore.kernel.org/all/20240830040101.822209-1-Liam.Howlett@oracle.com/
[2]:https://lore.kernel.org/linux-mm/c0ef6b6a-1c9b-4da2-a180-c8e1c73b1c28@lucifer.local/
[3]:https://lore.kernel.org/all/9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local/
[4]:https://lore.kernel.org/all/20240830040101.822209-1-Liam.Howlett@oracle.com/

v3:
* Rebased on Liam's v8 'Avoid MAP_FIXED gap exposure' series [1].
* Fixed issue with copy_vma() vma iterator positioning as per [2] (formerly
  fixed via a fix patch).
* Fixed issue with vma_merge_expand() not correctly obtaining the next VMA as
  per [3] (formerly fixed via a fix patch) - Thanks Mark Brown!
* General whitespace fixes.
* Improved comments.
* Added comments for bool params for clarity.
* Removed unnecessary syntactic change in vma_merge().
* Removed unnecessary else from mmap_region().
* Introduced vma_iter_next_rewind(), are_anon_vmas_compatible(),
  can_vma_merge_left(), can_vma_merge_right().
* Cleaned up logic in vma_merge_new_range().
* Cleaned up logic in vma_merge_existing_range().
* Eliminated vma_lookup() from all VMA merge code.
* Added vma_merge_extend() regression test + confirmed fails before fix + passes
  after.
* Added copy_vma() regression test + confirmed triggers assert before fix +
  doesn't after.
* Confirmed _all_ self-tests passing at same rate before/after changes.
* Confirmed no perf impact.

v2:
* Updated tests to function without the vmg change, and moved earlier in
  series so we can test against the code _exactly_ as it was previously.
* Added vmg->mm to store mm_struct and avoid hacky container_of() in
  vma_merge() prior to refactor. It's logical to thread this through.
* Stopped specifying vmg->vma for vma_merge_new_vma() from the start,
  which was previously removed later in the series.
* Improve vma_modify_flags() to be better formatted for a large number of
  flags.
* Removed if (vma) { ... } logic in mmap_region() and integrated the
  approach from a later commit of putting logic into the if (next &&... )
  block. Improved comment about why we are doing this.
* Introduced VMG_STATE() and VMG_VMA_STATE() macros and use these to avoid
  duplication of initialisation of vmg state.
* Expanded the commit message for abstracting the policy comparison to
  explain the logic.
* Reverted the use of vmg in vma_shrink() and split_vma().
* Reverted the cleanup of __split_vma() int -> bool as at this point fully
  irrelevant to series.
* Reinstated incorrectly removed vmg.uffd_ctx assignment in mmap_region().
* Removed a confusing comment about assignment of vmg.end in early version
  of mmap_region().
* Renamed vma_merge_new_vma() to vma_merge_new_range() and
  vma_merge_modified() to vma_merge_existing_range(). This makes it clearer
  what we're attempting to do.
* Stopped setting vmg parameters in do_brk_flags() that we did not set in
  the original implementation, i.e. vma parameters for things like
  anon_vma, uffd context, etc. which in the original implementation are not
  checked in can_vma_merge_after().
* Moved VM_SPECIAL maple tree rewalk out of if (!prev && !next) { ... }
  block in vma_merge_new_range() (which was changed to !next anyway). This
  should always be done in the VM_SPECIAL case if vmg->prev is specified.
* Updated vma_merge_new_range() to correct the case where prev, next could
  be merged individually with the proposed range, however not
  together.
* Update vma_merge_new_range() to require that the caller sets prev and
  next. This simplifies the logic and avoids unnecessary maple tree walks.
* Updated mmap_region() to update vmg->flags from vma->vm_flags on merge
  reattempt.
* Updated callers of vma_merge_new_range() to ensure we always point the
  iterator at prev if it exists.
* Added new state field to vmg to allow for errors to be returned.
* Adjusted do_brk_flags() to read vmg->state and handle memory allocation
  failures accordingly.
* Do not double-assign VM_SOFTDIRTY in do_brk_flags().
* Separated out move of vma_prepare(), init_vma_prep(), vma_complete(),
  can_vma_merge_before(), can_vma_merge_after() functions to separate
  commit.
* Adjusted commit_merge() change to initially _only_ have parameters
  relevant to vma_expand() to make review easier.
* Reinstated 'vma iterator must be pointing to start' comment in
  commit_merge().
* Adjusted commit_merge() again when introducing vma_merge_existing_range()
  to accept parameters specific to existing range merges.
* Removed unnecessary abstraction of vmg->end in vma_merge_existing_range()
  as only used once.
* Abstract expanded parameter to local variable for clarity in
  vma_merge_existing_range().
* Unlink anon_vma objects if VMA pre-allocation fails on commit_merge() in
  vma_merge_existing_range() if any were duplicated. This was incorrectly
  excluded from the refactor.
* Moved comment from close commit regarding merge_will_delete_both to
  previous commit as unchanged behaviour.
* Corrected failure to assign vmg->flags after applying VM_ACCOUNT in
  map_region() (this had caused a ~5% regression in do_brk_flags()
  incidentally, now resolved).
* Added vmi assumptions and asserts in merge functions.
* Added lock asserts in merge functions.
* Added an assert to vma_merge_new_range() to ensure no VMA within
  [vmg->start, vmg->end).
* Added additional comments describing why we are moving the iterator to
  avoid maple tree re-walks.
* Added new test for the case of prev, next both with vm_ops->close()
  adding a new VMA, which should result in prev being expanded but NOT
  merged with next.
* Adjusted test code to do a mock version of anon_vma duplication, and
  cleanup after itself.
* Adjusted test code to allow vma preallocation to fail so we can test
  how we handle this.
* Added a test to assert correct anon_vma duplication behaviour.
* Added a test to assert that preallocation failure results in anon_vma's
  being unlinked.
* Corrected vma_expand() assumption - we need vma, next not prev.
* Reinstated removed VM_WARN_ON() around vp.anon_vma state in
  commit_merge().
* Rebased over Pedro + Liam's changes.
* Updated test logic to handle current->{mm,pid,comm} fields after rebase
  on Liam's changes which use these. Also added stub for pr_warn_once() for
  the same reason.
* Adjusted logic fundamentals based on rebase - vma_merge_new_range() now
  assumes vmi is pointing at the gap...
https://lore.kernel.org/all/cover.1724441678.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/linux-mm/cover.1722849859.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (10):
  tools: improve vma test Makefile
  tools: add VMA merge tests
  mm: introduce vma_merge_struct and abstract vma_merge(),vma_modify()
  mm: remove duplicated open-coded VMA policy check
  mm: abstract vma_expand() to use vma_merge_struct
  mm: avoid using vma_merge() for new VMAs
  mm: make vma_prepare() and friends static and internal to vma.c
  mm: introduce commit_merge(), abstracting final commit of merge
  mm: refactor vma_merge() into modify-only vma_merge_existing_range()
  mm: rework vm_ops->close() handling on VMA merge

 mm/mmap.c                        |  103 +--
 mm/vma.c                         | 1307 ++++++++++++++++------------
 mm/vma.h                         |  179 ++--
 tools/testing/vma/Makefile       |    6 +-
 tools/testing/vma/vma.c          | 1366 +++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h |   51 +-
 6 files changed, 2316 insertions(+), 696 deletions(-)

--
2.46.0

