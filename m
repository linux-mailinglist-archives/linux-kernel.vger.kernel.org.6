Return-Path: <linux-kernel+bounces-572018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E751A6C57D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BF47A69FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA8232786;
	Fri, 21 Mar 2025 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6tBkjfj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S5J87htm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBD231CB0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594104; cv=fail; b=m45FS3F/iMHQR4I+YaPTDN4LjV9SJJemiGnhLF3pQ3UYI4ewaW3SfvQ4QEs918XOM/cILCjFB587srfOY5EJRSadCmFdAC8cCSijxzjEfZoxjwd4qM7wRsNl/P7astzzkdaocmriw95lCUwn0gz8fyQzRjFvHOxNgMB4MNjcnsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594104; c=relaxed/simple;
	bh=9nyoCI+V7/Xv9LeCkUG4M078vRzQRnj2FmFEuF0lEEc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YlkWbsI0ikMyQNlsyVapSx9ZmNMtZb8gwQo22NsnSFCrnf8jR3Y+oN7AxsK2rhNg11X+nPkA9CzaddWkG/OD3HAAaD6I28DLzF1Lq8Dt8X22U2KNvbfJ4/iFIXxPYreLNbcIZw92LuilZ6ZjtSBktaSL6OC7O5+1ogWpYjLSngI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y6tBkjfj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S5J87htm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKfu7q019316;
	Fri, 21 Mar 2025 21:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=i0z+DYbwTbSc/cvc
	2OIhFJKQuERm9lLGDIOCKFsdmlM=; b=Y6tBkjfjhNRvq7MU8NW03MlOt6qwGBob
	e22B26k9tnqcM9P4On3RFgxQTkaDTSdbCSUpltWspB9k8fCc0M7JyiwkSy9r1Sn4
	YxMOo2KnJdFE99fZ0F7hPnXuSSwHgQWNQ1q9RLPUR/m4otGnRMUpAviP/wBtsjRD
	5gCwpVZfElc0rDFLXCEJabKQ5GHgAnnK2dd/PbAVSKIQ6YoBh3PN4/HMXVlwcwr4
	XwX4kgo6/wvRmZLQudHw52qG3zYYKi9Lf0T2OQdCf5d4YcsJoeiPDJs1arVegLx6
	SvCvf17tJS8+Xa9A2+LOCp4whUOL1r5ZN9vbv/3R3FeoPw8M/Lwlvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23sa1sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LLW4uR019469;
	Fri, 21 Mar 2025 21:54:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdr1823-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5eStnpONqZZlYfdrhoSG4FZCY3QCAvSSjiWOVI60UHBZy090ntgFttZq1BMUuJe6jWyOn96HDzV7+dU4SDgSQC5GnfWgYVv6bUHzx6IC7pi3mz/PyiPUYF4CPW8JjrDCrIOmQmXd9eWXzZm37knwi2nvkpniOl635LMq81rMqxubQ9Sd2h+EufT0yzIg18VoDOLYrg46Xkk6d8nrpFS5WuAgpv1vYN6D1olz9NKRJfCgG0Fey3qghszdqGJVr4Vb4lWWjuRgWTR3VqhrgCgDGcVzEQKc2qiG48nroSiLhSYYWhc5U2ynOFmEu0Z8MISThIocZ3RJaCL5W2VcrbIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0z+DYbwTbSc/cvc2OIhFJKQuERm9lLGDIOCKFsdmlM=;
 b=VxlRsybxaKLvWFyxGCZ56ZOkOrrvIMUBjCjLx7hS4R+6eaMMiH0Ef04nkb+TRQtb3FGkeMcxTOMZL9MwxVN2QwuiAG9a/ZChQizCzCEQm/XtCG/xOOjGqyurG8lQPvoXGB30iEtoUQmOWiTWuE4Or4SHuO7XXJJoyEHhObHfIZh/n8mOdt/Tiszthf5Mit1riqbhzVMIU8PiMJrrG1/pI7LH/E+TBADqgCamANHDp6FvCK4ezY7Scx8H0vi7JydcBvjguSvCT7wY4gxSkm6NZy0HFLjxnv6Aeuor+21mHnealN/V+fwdOogStKZ2ZbyhbckOEMCt9b8qJ483j/EOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0z+DYbwTbSc/cvc2OIhFJKQuERm9lLGDIOCKFsdmlM=;
 b=S5J87htmIMGW1GZQmje+H/YKJHw24qJbsr4YeqNnVVuHtPAv2jmuvtW+Db+9A84i0vAypk7+iJsev1nK47ghyA9jJMISTV6gmdt2TdXq6W58C6VlcEboOfYXRv8zD6SJ4H+wYbml3zftFBZ2zWaGaNWmC8bxdvE5vA96oCJa6BA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] mm/mremap: introduce more mergeable mremap via MREMAP_RELOCATE_ANON
Date: Fri, 21 Mar 2025 21:54:29 +0000
Message-ID: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: a4af5956-28dc-4143-91aa-08dd68c2fc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/H02udFz2nR7K6cpoMxxGQXnSaFD1hq/Q9LOCBk+REnaka5wmCzbwx/Q7wga?=
 =?us-ascii?Q?2btuZ2ZWJ8Mkh3wux3x8/giX8uLF7tqv7n0GBmpO3oXO8DPsi4drGWPgptm1?=
 =?us-ascii?Q?ks/BU//XjsUF0OXnnV4fEWEOQV4+vX0WJ/DDG887sT6nUrwKeI1pdNXeMekz?=
 =?us-ascii?Q?qxlp7Z7dT15Sd9sIy84m1e+7wLVXfykv/br6l8kaXcohzwDoHhOBTXAm0Qo3?=
 =?us-ascii?Q?4NaWO8sxEVQ46FEOabLCncus1Wl0erzYC0kh0KQSSfIXRR246at4qyaBdwZe?=
 =?us-ascii?Q?yaC2qJ7lTPxSMaTSAjRsFAeRmZD4/2+op0HuZcXZK1C9jwRglp0U6NZDyalO?=
 =?us-ascii?Q?EauNIe9jlJYkGoy+rU44cCReVs9beT9Q+e1AZgXjrtNE1EK2ZRAJKujpPnIA?=
 =?us-ascii?Q?N8l0dHE2iE3oUynARw2E8Z3Yz9aciuY4pOPFPmx+pI2YQLd8tM/BAJQkXyWf?=
 =?us-ascii?Q?IbTk8u/21QAWiUpNtHNgmlk/ecjqksiXcKFSswXw3Mi05cRMoVlC1QJCSJUW?=
 =?us-ascii?Q?YDQIa9evXGa4aDDhMVLEkfSh1JcnL9ENAlMemQTJkMtQS711aHI0+Eu061IU?=
 =?us-ascii?Q?MbGfJCpVJlQ6e/z1Ljlu7ZZGA8VqcHffSuZ1fuzUi71UtFhyy9dybT8s3Cty?=
 =?us-ascii?Q?L2P0IWbj59Zfz/InESL+UkOzpnjRfZbBpBgqqX1Np4YvT+MqiTJHkA7ROhiK?=
 =?us-ascii?Q?Rfcx5grGAOcchxvA0SgafBbxnXZD3DqM1CQSQnO7SdNLxk+KUow2+UcLRiQ3?=
 =?us-ascii?Q?c3W31+MhUoDu3lMmIpAtybj2Y67/g2GJdKhuTYRs9iWffmgcBETCLp9qWIBU?=
 =?us-ascii?Q?CXc0Gi7WEIemgAmusu7m+RDuLwxEu0IjEXjA7s3S66/y8DT7v3YRLKtBVdmp?=
 =?us-ascii?Q?GWOV4loPLuskAvO06G9U1E+dU6kIvOanvMtwN9crqGD3/wJ+sqZHPaHZdg/v?=
 =?us-ascii?Q?0alfcvGhZkiR0h5l7cFxyEyQaP+zalfA4dUK/HI/VoMF+ZMNeNozTXT3ioH2?=
 =?us-ascii?Q?DB7A9AfQVczvRHZJDgYwdd+mMei2zK7aqonBO/VVU8TsTzx8JFATiqlZ5MjB?=
 =?us-ascii?Q?e/roRgAmr53lUEpUtFe8SHiPSWvKTlAyAvBZHtzWp4WK2LzA0pEqeLG61bDd?=
 =?us-ascii?Q?Fa/ETUsbcaMbhBd1xv6Syi12qyDHM9l+6wGQSXljOBsRLIPfZqzcGZMtj5DK?=
 =?us-ascii?Q?GFmSuj/JvKOuJtEPdG2g9M0aFmljg1HMB6yFcqXjcuSIsx9UpwoUDhP/MXtU?=
 =?us-ascii?Q?N/SEaypOJjS40sNXQgC7VjrI3Eqyt1hQ+eP7RIof3baMUKsXpVYNFlUIHY7h?=
 =?us-ascii?Q?GmZYHITHQ+ZqRWp+UrGkbtWbsiFHmMoS1h6+n7Ym8CfDKfMxhuVv1whw3Rth?=
 =?us-ascii?Q?ixu+ruiGIfL3HEmlX/+z9+Sqyful?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U2xscM2HlJLAu3iNsCX0oycqrrAGBdxAb/ERDdHR9Fy/GD8a1KEsV5k2NxUz?=
 =?us-ascii?Q?2wky+SZIlASCWTTddcybP3yo6EeXPQqNFtm7z7A1wUrrko7nC1LRiZDIsRTc?=
 =?us-ascii?Q?ecjGT5plJjW3ZnFL1EWlFJYNk5CUfwX9uhx16SZ6CcEbX/avqhTQXQrsQ3VS?=
 =?us-ascii?Q?OJw2WdSUypKWaRNlO0AuYB12Py6Aye3FV1Doect0ehPk2mZXTArhPoqKrgit?=
 =?us-ascii?Q?uqtKfDJ7sHhXr6mFOwsypym0W1tD2s0n0N6ei7nf4UHdghocV//B4cXWeBFv?=
 =?us-ascii?Q?gyqKl7UE4pTmr4e0UuJ7/7Hiz6YShGDCdkZ43eTErdKypy2tLkOydOTRqxjo?=
 =?us-ascii?Q?FiGc1MR7Cj5ONwY7oxcXYePQ2hxRhxRgmlCj+PmmOxpD5SHNJWKH4ZoyZ91B?=
 =?us-ascii?Q?PuS2llrBNJs6HOy6CiI+0/XK15d2h6tivi/ZoLKj7HtUWZa+kdCNY4YtyJrV?=
 =?us-ascii?Q?lOKXJjKxYQ2bSUJ69uSu6ArAdEbXSoYBqAuRSUs4MChcgZrJgkVb8/dQaS22?=
 =?us-ascii?Q?HJbVj3qLX6pKG7tyYVDSXLDdn3g+3/Of66zDQaP2sbUEE8E1Y7ZjKpUihtyN?=
 =?us-ascii?Q?8IbU/K5p8I7f7j8CsjNrRNT8FUevB+098EsO1zrQOs5ChF+j8UVS2bdeXW06?=
 =?us-ascii?Q?pkenW5DeoRC6Va3pyryMgBZAt9c8tCdTMsF5E8VWoSvTzzj62yD+DfqANRBg?=
 =?us-ascii?Q?QmX21FLN9vpts+ZBlO9HB90n2dWh39uqqDjB5buzYzBHyMcIG8jpiY6H7k7p?=
 =?us-ascii?Q?6An/GfKvQPuRGqZiEGxmPAHshgYpfV7PPyqqnE7z7mrZIEpwgdPg8WzBP/An?=
 =?us-ascii?Q?jISkzdYS93IGsJkocSm8uFE+cfhPLW4OtGAE81DRXHq86cWFXHotePdSgKMU?=
 =?us-ascii?Q?rcD/IjZDVe4W1d24wwvYVhUeC6IdkF9Arf5BrIGQAHXXDIvlSCxfCqAdubJr?=
 =?us-ascii?Q?ww/xR/lvLb0cidP83GZlso9wi7gibp1Nnkkorit4EgECOiEmh+b0dA9mIM2U?=
 =?us-ascii?Q?DjsJm3Bm77l5GAvoUD+sJRq1Q0R5F/+OOQ/vB3RBUUbAYcLN5dwansuChB4G?=
 =?us-ascii?Q?zjbejKD8Fs7D+XUe8oWxJN2yR71d5gXDwQypEum9B1/ngndx4Dwrc7rKpZpZ?=
 =?us-ascii?Q?7/ruX/rYvKzARBG0cZaskS8TmcPy4KIpdPJTV3UCOLJ/B9ecLyYAIVA6FR1v?=
 =?us-ascii?Q?tu2nzFSFNlXWLSRK/XlkUqE03bMG1ei8Y6Wtg8ziB8czxPsUaTOHR8/NRSH7?=
 =?us-ascii?Q?ZwspMr2z5X4+j96luoJVAuGQuHpNdGkbbg4HpPS+kfvlzZxoc5kZhFH+wlde?=
 =?us-ascii?Q?0+3i4hsGC8pxQPT72CODK8J2EF+Densjb0zDChGUqtqHP+6toRkuEGJuZNeJ?=
 =?us-ascii?Q?bh9qSsjn0L2Aaqnq9YJf3l/Wk2qIBwTA19wDRzA1LNrbJY7bBLeaT5rKKDpG?=
 =?us-ascii?Q?+/6Nyt+8lT2kr40jGuL7EXGXe9hZT2h6f4jUK+EjgPxjwRJnKVWkxe6dlt2L?=
 =?us-ascii?Q?pk+PhwydoO7Xy/pUqvJnY8ouoxH/op4mPjIfJI5P3UPURen0YUxM45HtSR/C?=
 =?us-ascii?Q?mmQY+9pd5w7DPU4TuZ1snHjdPN9d8+2nTTGXvXLf85qozb0HGEUVImNbhbvT?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k+YV6rLCR1BVR1DXKI79EpIUcmLpc47GBZQHKDZjlefubo43kmyu1dLgGXiMBoOupJ040ftBfMZutSVU7lFmC/zcVm6HoTvG4/GtGQ9ZoWqNlig7LL79tKQ4xEgpslhPk48Jgj9Dlrqy+9Lr6GkYho9SMT2obU+R6cSWA985fkwDRl8CZrnyo+02ZrYT0UzMgSm0VItVgGOcg609syejM6rsiHbymuup/oIBX70mP0vn/M1XJnJZPDKb5GO4h4NcDEWGegUzubj58BjuVhMIfswG2PQB1khasmN5P/TKkPjgESF/MLvamOoTFNGOHhS97KjKnFr4c2Yntm8yPa3Na5nMfPWf8Yg229iHimDrxNI1jCf/Wg34n4sN1pX6Sr22ymHTdplGepetIsQwuLCxiZVM69ojj3Lf5FZwmGaqBDTC+/mpQooDGXP8p6a/FBIq+Cx8NntgRFBzLK+99qvaQRrLcS5EPw6OVJ4c4gkQGnebGC69rQ8JZHteOTLQJ2c3vccSkJgtse+tjvhwIi4gLedhr7td1v5qXbozeSEkG5tB+cs7l4SqVUZuBhFXtcb74bCQvtOFlbk+KP5DuyXeuvKdhksRh2EE2iMXk4+L+zk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4af5956-28dc-4143-91aa-08dd68c2fc9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:42.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft4MXWQf7STqZBy4wc+72KgKVrL8jeQLs3CUltLC8cavPlamClBozlfQB1w3DqzYqzunVDTmv8TWuM9YTZKIPvFQxgXlxe33If3GuixR1eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210160
X-Proofpoint-GUID: jLUYux2q4E38A9zifiw20_ohufWcmud6
X-Proofpoint-ORIG-GUID: jLUYux2q4E38A9zifiw20_ohufWcmud6

REVIEWERS NOTES:

This relies upon the series sent in
https://lore.kernel.org/all/cover.1742245056.git.lorenzo.stoakes@oracle.com/
and must be rebased against this.

This RFC has been thoroughly tested but could do with a little further
stress testing, especially under heavy reclaim load, so consider this a
fairly early version, uploaded in advance of my LSF/MM/BPF topic in
relation to this work :)

~~

A long standing issue with VMA merging of anonymous VMAs is the requirement
to maintain both vma->vm_pgoff and anon_vma compatibility between merge
candidates.

For anonymous mappings, vma->vm_pgoff (and consequently, folio->index)
refer to virtual page offsets, that is, va >> PAGE_SHIFT.

However upon mremap() of an anonymous mapping that has been faulted (that
is, where vma->anon_vma != NULL), we would then need to walk page tables to
be able to access let alone manipulate folio->index, mapping fields to
permit an update of this virtual page offset.

Therefore in these instances, we do not do so, instead retaining the
virtual page offset the VMA was first faulted in at as it's vma->vm_pgoff
field, and of course consequently folio->index.

On each occasion we use linear_page_index() to determine the appropriate
offset, cleverly offset the vma->vm_pgoff field by the difference between
the virtual address and actual VMA start.

Doing so in effect fragments the virtual address space, meaning that we are
no longer able to merge these VMAs with adjacent ones that could, at least
theoretically, be merged.

This also creates a difference in behaviour, often surprising to users,
between mappings which are faulted and those which are not - as for the
latter we adjust vma->vm_pgoff upon mremap() to aid mergeability.

This is problematic firstly because this proliferates kernel allocations
that are pure memory pressure - unreclaimable and unmovable -
i.e. vm_area_struct, anon_vma, anon_vma_chain objects that need not exist.

Secondly, mremap() exhibits an implicit uAPI in that it does not permit
remaps which span multiple VMAs (though it does permit remaps that
constitute a part of a single VMA).

This means that a user must concern themselves with whether merges succeed
or not should they wish to use mremap() in such a way which causes multiple
mremap() calls to be performed upon mappings.

This series provides users with an option to accept the overhead of
actually updating the VMA and underlying folios via the
MREMAP_RELOCATE_ANON flag.

If MREMAP_RELOCATE_ANON is specified, but an ordinary merge would result in
the mremap() succeeding, then no attempt is made at relocation of folios as
this is not required.

Even if no merge is possible upon moving of the region, vma->vm_pgoff and
folio->index fields are appropriately updated in order that subsequent
mremap() or mprotect() calls will succeed in merging.

This flag falls back to the ordinary means of mremap() should the operation
not be feasible. It also transparently undoes the operation, carefully
holding rmap locks such that no racing rmap operation encounters incorrect
or missing VMAs.

In addition, the MREMAP_MUST_RELOCATE_ANON flag is supplied in case the
user needs to know whether or not the operation succeeded - this flag is
identical to MREMAP_RELOCATE_ANON, only if the operation cannot succeed,
the mremap() fails with -EFAULT.

Note that no-op mremap() operations (such as an unpopulated range, or a
merge that would trivially succeed already) will succeed under
MREMAP_MUST_RELOCATE_ANON.

mremap() already walks page tables, so it isn't an order of magntitude
increase in workload, but constitutes the need to walk to page table leaf
level and manipulate folios.

The operations all succeed under THP and in general are compatible with
underlying large folios of any size. In fact, the larger the folio, the
more efficient the operation is.

Performance testing indicate that time taken using MREMAP_RELOCATE_ANON is
on the same order of magnitude of ordinary mremap() operations, with both
exhibiting time to the proportion of the mapping which is populated.

Of course, mremap() operations that are entirely aligned are significantly
faster as they need only move a VMA and a smaller number of higher order
page tables, but this is unavoidable.

Lorenzo Stoakes (7):
  mm/mremap: introduce more mergeable mremap via MREMAP_RELOCATE_ANON
  mm/mremap: add MREMAP_MUST_RELOCATE_ANON
  mm/mremap: add MREMAP[_MUST]_RELOCATE_ANON support for THP folios
  tools UAPI: Update copy of linux/mman.h from the kernel sources
  tools/testing/selftests: add mremap() cases that merge normally
  tools/testing/selftests: add MREMAP_RELOCATE_ANON merge test cases
  tools/testing/selftests: expand mremap() tests for
    MREMAP_RELOCATE_ANON

 include/uapi/linux/mman.h                |    8 +-
 mm/internal.h                            |    1 +
 mm/mremap.c                              |  610 +++++++++-
 mm/vma.c                                 |   29 +-
 mm/vma.h                                 |    5 +-
 tools/include/uapi/linux/mman.h          |    8 +-
 tools/testing/selftests/mm/merge.c       | 1338 +++++++++++++++++++++-
 tools/testing/selftests/mm/mremap_test.c |  270 +++--
 tools/testing/vma/vma.c                  |    5 +-
 9 files changed, 2128 insertions(+), 146 deletions(-)

--
2.48.1

