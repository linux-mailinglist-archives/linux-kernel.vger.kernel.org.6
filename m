Return-Path: <linux-kernel+bounces-364698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578F099D809
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62A61F222FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571021CACE0;
	Mon, 14 Oct 2024 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WcjuAMuZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CiLLCKqF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591F1B4F24
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936935; cv=fail; b=cyvwt5ROyrcX8s5CVJc3VUVlCBzQgEDTADPVlvFMJLA6j9EQxiRk1QipiUbMDFwMPqyH+EC2QfAUs4rUTa6d3OtpEur0DhNU9bA+fXSF4yItlA1ncOhAGHdM4HPHzAFOTEUbV+Y8pDQmnVSSE7QfoxaRhgkTvDDFsHA1bAbZktQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936935; c=relaxed/simple;
	bh=2drtMMftpyIEX4btBKs2nksJpvuvv6E5ekUH8de/wwQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=gW9edFsO0plFpp6fBOOee3IJue4du9WTff1w2rttEOxs7v4MhTFtodDUpaRoD6NN640WXjyM5aKWp2opN2XqNLX9aFXPC4Baxpc84mSyEKEoqx+8cntdF4Jus3eSuMLs2qb1BKVSZAYsjKipN631qfVAuSd+lfwuazLnDbhdIxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WcjuAMuZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CiLLCKqF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEfeVS021143;
	Mon, 14 Oct 2024 20:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2drtMMftpyIEX4btBK
	s2nksJpvuvv6E5ekUH8de/wwQ=; b=WcjuAMuZmYf4xQEWqPas+w0V5+0Ou4A5sJ
	P46T2BUqi3T1MaOhzc8I4j7ird4yyp1Sbbbh1UDC/vXVEXD2xGBUn3AhlXEkUsCz
	VttU6v8M0JnlJJh4nzzA9tCRnHowGze1EDD5diJttBbDV32UuUfmpkrWkqusBFZ3
	lkRPpNBtsURHnqm+Z9ERrM7TZYiWau8ywQrbgJKC5fs3HPkvwuv6YdYXz5jPDiNJ
	3T1mm13z1VHQQIv3BfRH4zr9qiOgrKDNfRukffr2BimRx+p0N101oNJsqASIhn3p
	1iDvRb6Uixae5PTkVtJTiI92lQvAhmokV4VWxJA/SNmgNmeqzbMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cffby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 20:15:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJr3Hn011105;
	Mon, 14 Oct 2024 20:15:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjcttv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 20:15:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktVCkVuEOf+NoW7OE2r7BYR8y0udaDlAlp12MEN9D/5DIskVU0RjKmHh5fYcf20bGjmIhSaLorn/eN/w8XQj6waBbcC3DpE77hnNEHxf6ZRi4cVit+e+28VCIRl2TsBN3QZU0WytW2Q/BMQi+lHqFfy0pr9qh4pB3H1WXZ1ZkNHWG1uR/qCmcmRNj/MgcBsM9oOtE45oJKAO+FwxGzcD024igXbGEo8yFIbp2/LpLuq0+IEygpzqYi12AfL95MJD72QiLcM33kXBItDdlUzUuj0jdlCjsQb9aOIetWKY1ScTOOcIY39+90Odqd/YDq2c6CXifbPdZqWihfjVzKlEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2drtMMftpyIEX4btBKs2nksJpvuvv6E5ekUH8de/wwQ=;
 b=kR+lxv1tJ0WGfAV57hMSkwS3oMuyK1MFKyWO4t2nUODgFJpiaQrYInOxCmboO5WDg1CfMd5rb7gis7pCEcqJcqL8lyIavpb9hwg6iRBwhVW1jDDexqj2TLKMKKUgrGeI5g2AWrzkpaJr9tPGuYcVqTp+z6xHOzku0ZXJL5DWwPq33/NDcFkndaqa5Z1E34ExUgQzD/fFpSs3I7rOqoScPbn/lHQj14J+a+3MacfNXKzzi09HHCKPpEljiukAocfZEAzGx9P1TGpRxJTVSyhEnY/jG/Pog0XpAhaVMnUlnphA8Un1/9+kvHtY+Pa2EH7rznhwSB9LJOiWpAjQlAc3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2drtMMftpyIEX4btBKs2nksJpvuvv6E5ekUH8de/wwQ=;
 b=CiLLCKqFIP2yhAjQuEVEqZtEUj7pYXGDs+uw07k7nWkq0JuYncU29/GlZcTEEbkdEnPxRt15UdvqJlXobJ0Scrdr+b0RHilda0ssEdfgJq/OFr0D9e4U0cBFpoQgzhEEcpdr8qW+3cAKnd7kJp0Y5UQ15czskn6nlNN0/6nhfI0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:14:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 20:14:58 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-7-ankur.a.arora@oracle.com>
 <20241010065338.sw4zZlbm@linutronix.de> <87plo797a2.fsf@oracle.com>
 <20241011073602.7EmDWFkc@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de
Subject: Re: [PATCH 6/7] osnoise: handle quiescent states for PREEMPT_RCU=n,
 PREEMPTION=y
In-reply-to: <20241011073602.7EmDWFkc@linutronix.de>
Message-ID: <874j5ev3um.fsf@oracle.com>
Date: Mon, 14 Oct 2024 13:14:57 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0249.namprd04.prod.outlook.com
 (2603:10b6:303:88::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a911ff3-8471-421b-7892-08dcec8ce092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gw1H3ebfK5Q5ZCfFHGPLoFsdDxbK9ep1e2iATtPsCYZJZbh0jUObRyEEF9bO?=
 =?us-ascii?Q?oAURP7rqOy6RAW5i+BlEULJwL0ILcwPVyTzrNC0robTIcICkhqN2GDQjbBXR?=
 =?us-ascii?Q?J4nO0XgDKr/j44lTK1BljWOIa++WI5zQJe/6r3nsuiahBgUFwL8OWT94tMZx?=
 =?us-ascii?Q?x4jvtzquvsJeXdUBbjhWVIrkQ3q8dY4fJrARAS+00IdxUBAFhSgsIfuMtU1J?=
 =?us-ascii?Q?vcyYlkxgHl8KJM5nyZXz7dZffdMJCSBl4G2/HGOO2Gi9rioiTtlALhu0eg7m?=
 =?us-ascii?Q?jZ56abfXV7mWjXY6JpOgOUcjtixI9st5MELkYb2YctA01KiH6EjtLtQb30Q0?=
 =?us-ascii?Q?UIAsS872PmSborgNNeGfHJvmwqHMyNrfB2whEEWw78TsitbfFNkfYuqYKAx9?=
 =?us-ascii?Q?ieUwDcyA+6wzE3bwSAlRcwod661jtwhiqS+szBVYIJjP4kiV0ml6o3a2x+N3?=
 =?us-ascii?Q?36R06otTnQX/LNPyonrVUtb3Y1LfBHn4AvK34w31IcsgjJrHuemoiFuY/039?=
 =?us-ascii?Q?pfWnlFid8Bu3rFniNZZ5MZ8KmogkYUBaNNSl6VIJb7OWAm9YCv2grneAs7Ri?=
 =?us-ascii?Q?iZ6169EVf4nGKqOMtcQ53hesKX3GbvhXaw/zb1iP015zb6niECYUiVyDH0jN?=
 =?us-ascii?Q?ZwX1U5qMaLP00/06lxNR03ZlXrPya0mnHVxrEan2n7pggKX3A5Dt9tEqbPO1?=
 =?us-ascii?Q?PO8lcaogIj5MxG1/qNFJdSrjRpJeAnMiqrJ8R006TK4n4iZRgYdSokOkkHRN?=
 =?us-ascii?Q?xerxvW0NC6r+uLXOCY9UYuhW3z/KBkS3G1YM0TfTY25bwrqVfhpPgFn/WNuE?=
 =?us-ascii?Q?PYTjEt4xQ4vSAgvJTucOjdRkVRGXLWJRdiiOotXKTfhiAdXKUkRx6qiQXv3H?=
 =?us-ascii?Q?wsiFVdBVYEM++UrpUwjAQMiYiotxzg6W3HgmbLRMU/pzqmw8+ZnVduATftzt?=
 =?us-ascii?Q?hIiDyDEC/6Wi4IxQV+fg+vmgKyEsSDs0BtkzTvflKsH7yHEkTmhcSW1v2x0N?=
 =?us-ascii?Q?N1Fjj2NJH+60BC114cZP+9l+kUdPDfmQhtCMu6ODMj1qQg8VzGPPAUdGIROc?=
 =?us-ascii?Q?9rKCL9ialwkqhO1rniHD6VM33uN7/f+xQUqeWBaFq4tw8NVnPfmg1AW01WXv?=
 =?us-ascii?Q?It8MnO16m8LhaPfcx0MtstJyhN9Enp+iUY+qvi+sMZgI/gqu/j1o90aQfAp7?=
 =?us-ascii?Q?816XBqcZxFW1GWv8EwmQ3+ryS+CdaIqKl1yjkRmAkgS4sWR+P8bkFh9oam72?=
 =?us-ascii?Q?slXpfkYivz9jawfZJ2i2yfUeX4tpzD2J1zcqAF61Tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yjy6xO7t6JldlfxCLmb0x7tjPXUktVCv9HGT6HeHdtJtbQf5e8JDgAi2MtEL?=
 =?us-ascii?Q?5WqqlYzFCrYGqdpCcr6iFkMRR0ZgqpMsjinDB0PtCRXqDoJTZTu48S8qf0DR?=
 =?us-ascii?Q?3x5gsdnoWdzHYTs/diz8c7w+fPmY+FRy7Hb2kghUc95Vng84TMlh2F1jW72x?=
 =?us-ascii?Q?b2DtmM5OzDTVCIeZwFBhtUSACfIAHKmibB+5CgrHjahDBVlxz+ozOCjyBMPL?=
 =?us-ascii?Q?73AwVI/3cVqBRoQUNUJsmRtNva/KQ0HD+1TeCGWBgXQamtNmjkgJyS6Jh67l?=
 =?us-ascii?Q?2veSsDNLQBK4m/s+F+ep09UJc79vutcEU9etlw5Ff+p7fqcSWowMjaAnRpvI?=
 =?us-ascii?Q?bg4814CwECjvW1GDLhbElV5yBJuqVftOS2X8AiUO19JqKYYfsoXx2QVjMgkr?=
 =?us-ascii?Q?tPAEJqFfsNMwT3mwTt3wJEMxEr3ZJlAx1UErI27Odakq+eF+S+bLZewQ2DDy?=
 =?us-ascii?Q?Geu4oAYMphXsEmjyONhExfNfErl2Qmpi+vIcHvi88Je5Oa8Yuoz6mCmtAVMY?=
 =?us-ascii?Q?IVeoPaQyTw7Z8MFvbMPzR11DlZ78Ud1rKe9o81duiVof/YbP+p47rrMU9TG+?=
 =?us-ascii?Q?bTTPf0wdaslePVkUGbFlGq29C4nZqc3GAy2c5r2f4AlqpihYFhdFJEaUSMyG?=
 =?us-ascii?Q?Z1Yt+7MHkCRx6fOLLDSkO68OquuQ8GIK+XBs09lpNZgpqcd69oMAa3JgA9Tn?=
 =?us-ascii?Q?/lDm3UWn88KrhEYFRq2XkiwxGf2q+dydYP8IOOTpWaq2xxgdSslOAwr6IA25?=
 =?us-ascii?Q?HqcH82BUOXEDD2lg2SzaUIBPlGZJOe65rY4CT/HnN7qKci5qOrsZczEZDTET?=
 =?us-ascii?Q?CYCu74xAqm0f3gPyHpHDByX96BY7kkRbOfS/H2gnK+nA9+mgZN9ETay3Vlsy?=
 =?us-ascii?Q?Mmy5U1E2WMxAJ3UF3U56kNcr/7vXXdPefXxOv5WecpYZgxgpjw0ZrnItx/b7?=
 =?us-ascii?Q?GNtEvMdOJo24mKYBIkyCdVeyxx5D7+hV9RnU5QyJX+6T2BxcznBR/awa20Or?=
 =?us-ascii?Q?qQpwAR346qPZMcx7UmS4kpUX8smj0jRXGtyXab/NmjDtE6quWXOfikSyMN9n?=
 =?us-ascii?Q?L1ttCWlu5jNbPE1SH+Wdii0zfBfwTv6SVrH3O8EQq0Nswf2ybvJ5R+VVBh9N?=
 =?us-ascii?Q?Dl6nFn9ki4kQYDYExHw54dVSLDJkxo+6NQjqUCQYt6rKBUWsOXar51BJ/Lm7?=
 =?us-ascii?Q?qomM+F4mXgU8KuG84HhxByckKpv2p6TxwEEliB1sBnR21xUpxma6ZjhTYpHT?=
 =?us-ascii?Q?ki6PF0LcbdKY6k27K7bRt9JSjWA12qU1rMx6LIe7t25E52YaRnwfsW+haVE/?=
 =?us-ascii?Q?oJ/qgFTNEnh4a9jbRoAXI0ixCAlbWzXz7J0bqgeoNXnRgROC/Z4ICOA7LgkT?=
 =?us-ascii?Q?3Bw42U80kXNqX9AXuNxH5taH4K7wHDVTt3wG/w3ktOD3WEV1I8kHCQNOXS6F?=
 =?us-ascii?Q?mNzFEN+pG9BFfXMSwt1/f2VzG8OJFZ5R2WZ8gvxLNsnMomf47WopFTjrUfl8?=
 =?us-ascii?Q?4yr9EjAwrEb+GXyeSqLTisMA50mSumgqrMCtO8HQovuQ9v3jsBpr7XsOg09X?=
 =?us-ascii?Q?MILY91CkhgrgLM48eSxzmTm2jbpoPRxROS/sRyEZBGpilrtGBmf/bWUPO5Ga?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oRMBBKk+CgVjBZwPCHg7bEIox+fHQ1kN5nCoVdSQBbalvrtE9Xrm4i6O4wy2nPHzpjcPuJIi4xMn2GokLPOuMbH8RTpZmtmwf4h0LeIa2WQmnFx0EJkzGzaWioYDZMWTfpW/DcvEb+TpUpGlv/2TSCKfDaA0rHthx8bFVcBkzYYWhPmFpjeqljCm/RyJSlrMKX+vfKIDiKyO16kHb7GBS4QMLynuyzMC3tatsh2coj4+SQfXouJbUG1kcYDEYiqVzVFLOusXrdMHLaZ7PGuw58EtVX7V2ioxCqMqLSSoKWd255q2XZBl8RCpVAJI69SIpB4j7ap3xVW30OMREQ6PkyUxn1vZY02Cvq0+Q2z+LARYedIUyUc0p8v71BbSdVaouy6VzqZfYXN7zUCppL810kQBQfMI9ZydW4GK5tzIoUsdeQ/ms9qMLBCuGDDLKs6CovkxlPmccPhXbzulr/1pY3jmz5Ibws1gEN+rZDELR7lm7vAkOZvRGFzt7WIs5gHTOEUaLrsJutgLplJoewBV1S5boIKJlNCL0I9nJGLpCEAOwwHKxuct366uhnr2zfQkyfr8vsdOcxb8TVWrAt54JIikdaxpMknO+BaZoEBN4Mw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a911ff3-8471-421b-7892-08dcec8ce092
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:14:58.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EGdfLABWPbj77IHRjPdd5GkmiA+t9DP/G+73XwbOj943j7DMa7fJeI0L5CZCAE64wiC86Quo0crKLzSjK6+CE3rq9CyUeySLnj1hJxoN7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=789 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140143
X-Proofpoint-ORIG-GUID: RSwYUem43eBsbEn5DLDQ3X-jmtvQQZRx
X-Proofpoint-GUID: RSwYUem43eBsbEn5DLDQ3X-jmtvQQZRx


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-10 10:50:29 [-0700], Ankur Arora wrote:
>> > PREEMPTION=y, PREEMPT_RCU=n should not be possible.
>>
>> That's a statement. Is there an argument here?
>
> For my taste you should describe in your cover letter the actual problem
> and what you intend to do about it.

Yes, that's a good point. It has been discussed a few times before but
I clearly didn't make a case for it here.

Thanks
Ankur

