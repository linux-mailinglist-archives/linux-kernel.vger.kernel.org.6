Return-Path: <linux-kernel+bounces-220180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C390DDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4821F23A86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2081779A9;
	Tue, 18 Jun 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UHQRfxSM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gupwCIVs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D116D328
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743758; cv=fail; b=XPqbHDX8AGWMQdeW4Eu+iyg84qKt5l32K8JiT7MSC4eTReAoAvAz2RbcXgTHA7TrMHsW5piGuzDfnGLr8I4aZvXx0/rZMV49KFI8XXVT8vnhxUNPClkIxrF8Em8A3HVqy6snl0yTjQHEwjPJPjC5dA+VYRDFBSonPOjhdy5PIVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743758; c=relaxed/simple;
	bh=hyWjt2ypJFN6gAQfrGq1kOrW3s+UAH4GgN9QZBm8VuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jD0WkRRIWmpwWtXAec+MzGWhUA8l7KVtxWh+/iPHCRvLNy5xE5ukkOjEIz7s2PpnW7ZXW4Zm3VfU1RNT9YkzE4dokHAAxydOqYzfCtUR27HJgPehbWQlcDLnseLNESqjhAhkHMApzGOLjeukQdv8+XTl4I8w+q4Kj328KwA6Z50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UHQRfxSM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gupwCIVs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUmOH005328;
	Tue, 18 Jun 2024 20:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=FlmQ+Ohn1bKajxcZtx4NBjWdyayPRi4zWW6jf8dYlsA=; b=
	UHQRfxSMHAdcM7xaTsFJ9BOdNRQ+4muUkUzkV5N8MyePyiEgB77/8+0+b4S+ySFB
	gc4Siw7SipxCqg0WU9YFSiS6I4nlwhMnMDL694esfF2xlp4Zkd6oVC1SpGJRNyEX
	f9vIT3dyUz1dwGyLejX0zjMZYqT4ThfPO0hNIUD38zlKx77FkyvuG6kbt89Fzs+b
	uCbeFEyMjH5+y1I7GaW+tnhbMSqShTSYP7fOMF3Jrd0teTe1xlnqEzUf4NFmKy9z
	hz/n0j4hL6V9p9fH++4G3vtH/6eSViYkFSYM/WJbhpuzrUnSXzU2KFCoBCDiMFi/
	DCctyVUZS5ygtGVx1CloTA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1j05xar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIV034656;
	Tue, 18 Jun 2024 20:48:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aATCMwwDgHu/OgsrESl32IbQ2jJmn+2PPUrc85/6iiZDByp0hW9fzF85I5d49etQ0KlFWe5hfioFRGjVylcE0WpLfEmfuHauX1rPuBdQrgyKe8itlecc1p6CpiiLbDmuI5btz1sYR+jdiOX59+77y7zPEk2Rav3de+WOInVrRQ9Fr9S2da3RpBuibEYFu7utUrq6jgOUg51WfpHyRbt2sgS4aE+XtpIc2nkemZi5x2TJ5x9hDKcUTpaBv+SUM/IwQH8z29uEVCM/zbaHVK9F8r+RcScG4nbtZfZ1mcW8OAUJNwCtnNDWWEkkYodGEmgnVgPcHcFtIiz0cX4kC9+ZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlmQ+Ohn1bKajxcZtx4NBjWdyayPRi4zWW6jf8dYlsA=;
 b=Pbw5N0JeX2L4T3WludlX+L3dKBVfOJcrtazCa+tJypx1SklG5v/ntlib4mreLAx/FLPRBs6wvekSsKOLBwvpQjw+i8j5v42BtY/VzrB8CaZ2M22r8olYSc4PfYaBaP8bvaPtj47BSj/6p/8gABYzeQJOYGlLmcKtL6o0JYmsJuazgzHT3lqnmEkPMRxd23MIBn4fm15b9cvqvGQGDDDDKNIhfO+/9bPjrpIEMBQtzJJnjRcpcfhUO6yq/tv5o5D4/c8gc+yHADC+4o86zNDsUwvn2FlCVtUyDjcaU5uUV8vuseocYcfqn6nU/aSHVu1oyCuNYoQlgl5USmfWySRT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlmQ+Ohn1bKajxcZtx4NBjWdyayPRi4zWW6jf8dYlsA=;
 b=gupwCIVsReAS+ZGS2j/k98FKyD7hCauZHqvYa0jfm8/oIVlabJeYYZ5ZEWXZTF/xy8zvz52F+bYVxudeIHU2kqOk/vOgL3C/XkT5TSzFAMkSf5gnZdxkYzIZ0lEvOwsHzmkDEARhEY0wDx97tEBnFY73sQ2Gjd2JeLcuCkFbaKE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:31 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 15/16] maple_tree: remove repeated sanity checks from mas_wr_append()
Date: Tue, 18 Jun 2024 13:47:49 -0700
Message-ID: <20240618204750.79512-16-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: f6508bdf-3449-4d6c-a005-08dc8fd803a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D8Pf4BLa2wCQWcN3o1QAsk5ZpF6gnKPtWWdm/+qtANVejAtCZKI6qJ9VQ7i6?=
 =?us-ascii?Q?BSZgzjR163geHd9UH2zF4T+Hk9FnJqCfqOjm7nmZ+WduNYbp4gb4xHyZyjml?=
 =?us-ascii?Q?kmyqTDskJNznYLxxKJ3B01EQBL1G0cCmPIiFEWFUF1PFEg6+E+Ti70HM7oaj?=
 =?us-ascii?Q?bvRO1DCxaC+0jK5wzkxxJ+RveksvIJA5uZ8Q0XvTVwLu8O6CwjhGY603nDK/?=
 =?us-ascii?Q?a4Yu/05zbzp3qATszptSCshxqnhjgIHd3ybdop7xr3AyKKGFkTDVo85nxipO?=
 =?us-ascii?Q?FFUYlw7O14XvJ+CkAREBenN+vVc1H9HLFaqX9UtN12+0FOvu77PoicbQadjH?=
 =?us-ascii?Q?nfA9ic7AKWcaByaPOR7FMzE6j/FwRsAqVhOXuVbD+WQZPfw1fAEloRChZkQw?=
 =?us-ascii?Q?RMfvIG9bSdHcKgQHn6euPRl5lVlx1TpbA6MqgUUKekniVhwNYWLMqGUHUHRc?=
 =?us-ascii?Q?F7HBQdq1SJo1ieSnCgsdqdhW/dZnwIwQr1g3rvvf5t1UuDDfpZl0GOpMIvFC?=
 =?us-ascii?Q?QNegRolRGDAevsmvsCF2D8RjvRR/bXujS66R/Lgf4MCwWZHNu7BwnJ76sPtw?=
 =?us-ascii?Q?yf1PTlyJQPmIT9dyM57wMQp+L2zzx2Enzb6gbJvqvh+603dQsO97XrtGWox7?=
 =?us-ascii?Q?2RZ0nq6qlvm+2rZKjZH7x39VPT6y6lPx70u7U+Vy20hds303gKTJI/ZLGjNe?=
 =?us-ascii?Q?nE3geZXhsQhIVGZvNr0mn5mzFOuGXoaNoVbbFaKk106HsnudZwy06Tpcl4km?=
 =?us-ascii?Q?seZBi8L3a+webjN11vK9plG/8rfDprw+9BqGggJ2PK9UBMF5gB1eWtiPC/TT?=
 =?us-ascii?Q?burN3H2rF5rsiNMssA0dMuqStXskzm9Kkl4LwWNWymr2YjZRIy/yqFd1kjjn?=
 =?us-ascii?Q?TwFDDsxDXjakp1mPvaqBnoalP/6lAn2w1KPY0YG0sB0SIjneQfci1SYpSOv2?=
 =?us-ascii?Q?IQKU7WUsJg2ZWZHwc38lapZ4gGdAcTR6N4wyVz1mqwQLUGp4AorryP+Bua6l?=
 =?us-ascii?Q?qJK43Cap2UKaH2mm10lkPMXh4Fkzx4SwEmtSaCV2houNxl0SCLF+RZtPOFzM?=
 =?us-ascii?Q?MJZ90wblnKk2R/khQkV7omRtEI/EJB6h4cED5xDmryEr7a40MI0q7IEiVSsW?=
 =?us-ascii?Q?r0K1eHJyWN8VCjchYUDoVJNd9tZezcHJPOZ9V4UgdIkoz1UmYA8ebmuGNttA?=
 =?us-ascii?Q?usNVsaFKmpoFN87W8gqqnqCLu6CHtzlqJxn5p4S2fBQ3GP0kjSQCq1PKEcFX?=
 =?us-ascii?Q?VliUQqlqMguQGrByRXmNG6hpjms/fRalHA8tjUJl2Mx49rIE5X+0KXTp6H2D?=
 =?us-ascii?Q?hKs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CEi3vc+7NX23qRfYeeIHeDrK1BwsTyx0sR3+PKLATWaFxCps9HAxP7Qcm0oN?=
 =?us-ascii?Q?esM1o0neAOjA7JTaVuvOIU2B/0b8EGXgzrCILP650ILUP8zTe2RTQTjEbkcs?=
 =?us-ascii?Q?m35A/OijCfTgiN3DXfSul4DN5NCshuUWi3WUGBMia2GDTl/VLOPeFUf+M8ET?=
 =?us-ascii?Q?WNa2WyPF/1oOe/GCaimf4+EEpFo9guB+NHV6fKogSqvwJ8iuwK+Tv7dvQTLK?=
 =?us-ascii?Q?5rVQUtjxvyXDFdn0/8+Q0z3OkFnlrkmA86NcN/yGOXKHHdDUpCHOc3TJ66x/?=
 =?us-ascii?Q?5sj3odnGsY8EXunk3iJTEyXgBaQUDYquXbwAcUPq7sDxagD/SccWu+QT/28e?=
 =?us-ascii?Q?5ak3bpdLPYP86l9upquMZlP//fcI6xWQ9SJXWhLukLtTcQgg79nrpFkQPJuQ?=
 =?us-ascii?Q?4V7/XutXp6e+sBP24VGT2xt8sd0L7bxUzgo/l2wR7VTiu0bjlH4ZtXY9E0/8?=
 =?us-ascii?Q?9+lyHgQ8auHgekMcSo8HtBD2q6qzui0bBkcFF3KoXAongL7QW/iRD85XP95z?=
 =?us-ascii?Q?oPXUhlTySIqan7reUeBhB9dv0ye9VT9lyT+423bPXeXDDrLvCOFevyFACORv?=
 =?us-ascii?Q?PiFOCqI5QfPSXPs2HGzVQU1LRLawGEW5VAlA3esgFO2LYzyEpha7aySiU+J8?=
 =?us-ascii?Q?56Oacz43dppEAmvpro7sYCmHM6jpsjvR/AFQUUsq3xaQ376cyJPVsg8yPYN6?=
 =?us-ascii?Q?3VzrGB3r77J++mepUQn9qMN/NENTBq+HBy1Vp43FyIqKWP7z4BQdOcLbnx7V?=
 =?us-ascii?Q?+xHyLCy83yOCmpAbSPvWmfI6qlrV6MU3c/xeZty09/ifuoFA+uSAzWRmHLE5?=
 =?us-ascii?Q?J5uok3ma3qEngtCsOyM3sq3PsmpoFRXej2mc26SfpL7DzxGUS8gNCgQKfStY?=
 =?us-ascii?Q?2CLughWu2dz9tW8jDApLEppPt3RrqwOCl+Qzp8GNCGvroYBLuU06fLNU/ICI?=
 =?us-ascii?Q?KP5ElTzakZYsiHK21daYQkWPJEa7rxMeeQkSBT21NIwNwBoaICP7sM1Rni6R?=
 =?us-ascii?Q?mibS6mSTQEtMNdNDHp5sbtp110UrLqT1sD8aMB5OtX29bLtJJVVIHxtiwxvV?=
 =?us-ascii?Q?770SOwPUP8BYezwSjE6zKtNRAsj63NCdkSnfCWvhW7Q2wa0QXg++L3w0rG+g?=
 =?us-ascii?Q?zO0ROdqvGEYLJWKJhE9amQ9+ucqTzjC/7/hdE1zfwrnwlQDcz093EhSRugX2?=
 =?us-ascii?Q?FStJk6TTiUiFxwGd2Vh5fLpgnf0/ArzlDYSPqvO57VxTHM+jHQD7+NuoUeow?=
 =?us-ascii?Q?e0w0zvZ1XiGQwgEk8lFHH88blp+hxk7Sk33XrRw+Eh/fU4lZ5ErfOFoEalEg?=
 =?us-ascii?Q?ohY06u/HcsidPBYyoF/Y3HWns7twudX3wBPjtkd0qWYYy4gmBAW0bYzzrY9B?=
 =?us-ascii?Q?Iwtf6DhXMUGRUR+w8t8i09YOZfMV/uqra6/AdhPmFa71h8QPdgfWUNiZAq11?=
 =?us-ascii?Q?zw+nfdIKx7Y4HR0nEomGr5jEcXdhkHzNc8EV0WIRNRTmaimPvykSZvLJx3oO?=
 =?us-ascii?Q?et3Bm3ckd+gl/xyIV5m7v2KDgcvfrBmq8915yQP0U9Na0Rn41lOUevUrQc2g?=
 =?us-ascii?Q?rQJGg50mCmH68eorLDmHYb7gVZpfGrO5jL4/vABC+g160WNBp50pfqPc4ftm?=
 =?us-ascii?Q?tD9n4AktQrKVksAJObjS9us=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WMuL2jyibCM+WiKK5QojurPYR+y6nLLiHcHVA0uQLH0tyVecByHMe5jBRryqzCNw3UxmfVyV10F/+iGlYCks+0mY+Pa1MSg4HryJ4HqgeCpvRTIrre1usbHFyJhmdokpxKv7XyMfcNdzizWEAZH/QUHa14Is7WWB/svXLC9eS3ijLWJ0l4MdOmtC2DxdNrT57LyuUNBUuPXP9MRCm6yqraDMz1C+hmhmhgzu7muLNVIVl5PalxU65tHdP55/D1IYqGpZp8+Lk4h79Pw18mkE/pPogT1c2DFH6tgUL8v+xy5vVeUwCQxrz3A8N97iyvTRiVe4ZDkQhXj0xMIV+TPKXW7YLy52qwODAv7BPDGqgse8cVOqZB4OKSBe56EEwvZvP9htsd611vEFWbjLJsNaEqluNuawo99uHN3DfEiCIdXFz8aqSAvccx3EeQ5GTUYvCGBelxlVVDiTFU2c3iqfu0GWqlhqEKRo6+dZOXus3PpkxRp1+EbQNP3FkooXsy4p5ai5PDTMLqBBpRJThcIj8jp2j80Jhhj9136eyMz9fICpuU+6S8jFvZdcVDlbKHqBdvP9ZLQrMypoS5AqqXF9+M5mjXZMy6410TAIPqnusGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6508bdf-3449-4d6c-a005-08dc8fd803a4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:31.7656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugBV+KlxWDAjLpY24zg25xHMZ6DAN1t9FlCmfypCYv1ev+5QtNQ03AYiS1sV83RHb+Yq9KupHphhYH7BJ9uaFFJy6PgDHwB4w9GHU98sY18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-GUID: x6O2Iweo3iN4rOlHPQbIbnF_NbsrsNZz
X-Proofpoint-ORIG-GUID: x6O2Iweo3iN4rOlHPQbIbnF_NbsrsNZz

These sanity checks are now redundant as they are already checked in
mas_wr_store_type(). We can remove them from mas_wr_append().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9ab8a6b6fb0d..f6a09bb7b291 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4061,17 +4061,9 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 		unsigned char new_end)
 {
-	struct ma_state *mas;
+	struct ma_state *mas = wr_mas->mas;
 	void __rcu **slots;
-	unsigned char end;
-
-	mas = wr_mas->mas;
-	if (mt_in_rcu(mas->tree))
-		return false;
-
-	end = mas->end;
-	if (mas->offset != end)
-		return false;
+	unsigned char end = mas->end;
 
 	if (new_end < mt_pivots[wr_mas->type]) {
 		wr_mas->pivots[new_end] = wr_mas->pivots[end];
-- 
2.45.2


