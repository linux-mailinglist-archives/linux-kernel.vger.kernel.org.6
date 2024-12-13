Return-Path: <linux-kernel+bounces-444260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2509F0368
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D6416A2AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170318BC3B;
	Fri, 13 Dec 2024 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U1CkzAv/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xOkSJQMp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379217DFF1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062869; cv=fail; b=JoaJJjsmzN9T+V1h+wVam/9xZJvtHPn2oUxF213iCGCEAYJobQwi6NYQOVIwUEEvN5iI6IM4mZ+DIZP1mCcPONT6EB7vOsOpZIgo46pw1t584yCWpFnvDZbkgnhNRdgQF0mxV9+HLzR+6ojRI9IUZYZbFyz8atX/8bvJouFZV5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062869; c=relaxed/simple;
	bh=IFl2rDm8v4t2sbfihdWUSAuVKrgGTZy3JFz0tCeRkkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3W0Fqcr2EBZn0lxYQMqhHamUW1EPFmBfI+ue/UVpH5palYR9j2OhIBpx+p9E3HbubmpL1d+8H0ZJahsK6pmgXKc1jFfsitcE2XlilBtSXfI7Y5VBvgJIy/peeL3mKfuR6XEfsSgiHQb/qPlOViOen3DIGcLll+EjCnIlfBYB4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U1CkzAv/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xOkSJQMp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1fpfL025936;
	Fri, 13 Dec 2024 04:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1Oru8PLdzRt/Dutd8LYJDaTQupJhbeh1U+zjFGTNK9M=; b=
	U1CkzAv/Rms/Hkd0kdRw4qh58U7thzTKV8IdSElvKrC5hn4uYxJxby79YIhNZL8q
	OA1hWAA4ObzwNVCTD/OIybBauslRvMHEY8hdWfRsZo5TdV9IbAUEQqMULt4c6IMv
	ThZfk/o7daKNL4M1VCsGzU69o2bUqDnGXmsByOtixFkxdUsWqK8maD29B4HjaEfq
	aY+5m1gcywRtCfQv86f9dhfLA38guXlHgo8/mx5nR5bX6k0oWdUVAguahQ+DE3kg
	lUSr6FetLrS65wke89zgxZ9Su5RETj07daeq2whO5RYGQ9op1LHLlL7iReLd5gsQ
	hZe/g5s7iVey9bnIjG3pEg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce89cesc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1Z7mm034893;
	Fri, 13 Dec 2024 04:07:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctkhjgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjxFdBJvUL1PkRHBOgcyVvy6eplNjA6edR/bdgOBsqPUzWch3Y0R1DJueIFKUHAil1vGH3kzDZKIVyZsv5uBhtftLu7kpeB3prBxGIXtni61DGLi9tYoK/6u9rNsOkYXEDJo0hJABiLTOjQEBHXGgOWHfxVszkcf26SzGdhMK/FrWlmEDW+rRH0YkSpIhhPnNBDEGJWnagUNUe08+nEEmX0CGvC14hETVy3JTYuo1/vSp7tDpVMTC+OZGSjT1nW6jMV52Y6H8bxfrcppWc5OekjoOj0R0tPkW6ZEfmWzDR9qYbI2NIhqGfDMiFM9bISbibQ/XETWWoWTXcrShuT9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Oru8PLdzRt/Dutd8LYJDaTQupJhbeh1U+zjFGTNK9M=;
 b=qpjvqQeSD1BxfVqQtPqVvTcZU6ZfPM+Bqxk0LuNPJCnTj2RDVt6BpTGysiIboCC72Qsd+JDWdb+xkZSGPP6b4SNSDroTzsvdKXgkDcxNXkQZBkCurXWKTZlAQW9lmRiQJYkNv5DSN4Oks2RUPbMM1veIMmiNFWsQLfPSZdEbopA4KOp8MO9VQAAu9XEZn2goeng2Gxq4kCi/EEinNJFcPs1klKSTpqpVp+JlImRDBv1nfScy9XSxFAUeSyULKHgjhbCivFF16RJptomxp6j7EZMe4EYKOmVE1aJRVsRngDw8/FJhfdryPHjnw9Wq1hFfxKTweMqwKEPzrghltr2PHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Oru8PLdzRt/Dutd8LYJDaTQupJhbeh1U+zjFGTNK9M=;
 b=xOkSJQMpVQsn8Gk3E0AC7rc3dph8dzZFMYfAtu2ILOYa5mGNWxDC8xb9/AYnNETKfUtWsixp+v5BUF90ihlOR008h9Z+L03iCdmsVIusJkRo0EwVYOSZ9he8sTE1p9ArwCc2pHnp9dPgpCraC/vv8GEIBY3pGtHViDLbSJWqMCI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:23 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH v3 6/7] osnoise: provide quiescent states
Date: Thu, 12 Dec 2024 20:06:57 -0800
Message-Id: <20241213040658.2282640-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:303:b5::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b33521f-0a5d-4648-af3a-08dd1b2ba5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ODKMotKdsmBMfKnU6DCye/sMs7inBwC055WlsYO03/A+IB8gDyzT56jhEt2?=
 =?us-ascii?Q?v5YoeP1mzhOeYMFA7dWJ/hjjmvvGfIpopOkcbIiWa09Zazx9DaCp3SHzF9QS?=
 =?us-ascii?Q?Mw+nVnxul80zZhCg+XcWinbYA2sd4lqmzenLSbkZrOi8FNIQJWBJ5/NjDKC7?=
 =?us-ascii?Q?M1xDILsSMOt8and3oT8z9mtU1j6wrzCat4/iW/f8+CdxUzIThpH4KeAmnz91?=
 =?us-ascii?Q?RMuEW8pMLnn6ZTrp3vveQE61NTPb5wO8nuRZLNSNNRzepQR052cyAirk+Re3?=
 =?us-ascii?Q?S3nVRsFUcFJrMpObc8bATG06vM/LUb9O3Kdhwna5pgeHBtflDGeftqH1VWAy?=
 =?us-ascii?Q?7IEZijumv+Ef0h5vTjmSluOSdABJXjx6/tKcKzOqwu3CpTaHvm2TZOcMEw9y?=
 =?us-ascii?Q?nifyYWi6p8S0i0WWtwCELPAgfF4i1kXdQpW6Xey9ILdO02uiiPuIjrDFhS6B?=
 =?us-ascii?Q?Eq+oMS3NO45S6cQ1sreZEoQSPmDtRMR+6zYRQB3LHCpv68/40dgWFGbgp7Ra?=
 =?us-ascii?Q?Pr3nQovF0eoWcsNA1yf3Omx0kqynI0PsVGpW7AdS7V+rSgPv99RJnN5yNXXp?=
 =?us-ascii?Q?RZ1Dqjh0JB7UDdpPHlzPN62F7Fux7ZcpJbPYa1WmOzix0g2F4lejCabm4FzE?=
 =?us-ascii?Q?aT1hTnkg4BiMT5aIjUztfQpfkWDRlMH2G7bYC4jI5adFKga2V13DWay+rcZJ?=
 =?us-ascii?Q?PrdQOdNpDe76wkScm3k6bo0F3Pf4Wn8QyW2/2bdOMjsjzjB9Wc2DQRpksFgh?=
 =?us-ascii?Q?sW9cJkUk5Kx3AS3vYjP0iRO44pmNiLeBL/1VIKSL3S1YOznl3WP4ot+PwfMC?=
 =?us-ascii?Q?uaJmXG1OhMu94npVIY/ignJncpzqwfUfcMJulLwdEPrj3pCldvRMdighZvbJ?=
 =?us-ascii?Q?brBsn0dozMRgBJWB8BnhSVZltWm+0ZhdC8Wze6LZPTWhG2NJTCS8wkuA8qaV?=
 =?us-ascii?Q?ptS3rHfYkQoTU8dQ/OyfXc7lPMNoP3FWEZRgv+mNJVlacmC9yFP6Ll/pwQbJ?=
 =?us-ascii?Q?Bik21O6Q09dCY7Aw4oWP05wUtW9MzF0X0AkMCI256FaR5tCceyuDD+d3SdIN?=
 =?us-ascii?Q?xAvLxLRNn3MZ75DPmOEi5aoaeOXqfjLXpLnoQxxtO1IiN/8WXOKIBNC+FW6Y?=
 =?us-ascii?Q?+fBBICIFTHhGhqeNzXamkAQKXL3Ox12ZWyXaK9/AFNv0v0fQ/iM6mUUtkU/5?=
 =?us-ascii?Q?GR8lPgF6ANINyd6JgoY7BugYsbvaPt77jcHeuYgWvVVUJ0tXEBhfAzzE4n0m?=
 =?us-ascii?Q?QndDYpHm1LSkPgt6UwvUfYe9TSshPNlOOPnZKDYv772WNRr6SrEooZD946BU?=
 =?us-ascii?Q?9pR1S77edZsv21X3UpiZi3/AD9VjttJhzmvlhSEJEZ9TwPfP1D63RXNC/teJ?=
 =?us-ascii?Q?vFW8VEKU84YloxZYux+Hmnxmg3Zy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G04NcEYkihR9CDhen7dzu8R51bXIVr4l5iAokB8ut4BXPBn8SFn/u5BpKeSX?=
 =?us-ascii?Q?39UlDLu8pekhlZMMDbWqE6q/aOeQgNhmUx/J91MJK0pLCofd7kygXwmLta7+?=
 =?us-ascii?Q?SOsrRK45RsHz6O/dWoWuzpwo7FAnqN5mdIq7WQrl910UmEtTw6zOVcpTbcdr?=
 =?us-ascii?Q?Sh8nDeDpzmZkp1a5tBBAsumuE2H2BeuoGfB3HGgQBLEkJCkbrNrWTp75KtYE?=
 =?us-ascii?Q?AAPO5RZv5AIq2F8JHCM9c1OX/hrwlqq3/b5174GlvqgrY3/HEYc9HiTxSU3G?=
 =?us-ascii?Q?RUX+02ur+PQIypCus3Xqmb0fXs4+ZLdtb5Nq2VP8XcaHTssECnHVSDXUUZD6?=
 =?us-ascii?Q?5i8Tl2tNHCOMp4uE+i/Y/4MI87WaER2b2HeaDKJC7VGi3XddeMSrTMZZQhm3?=
 =?us-ascii?Q?DMGVbXUNJdT6ARkgFocS1nCqbscQk/BJPpmO3uMDQZKWjwaIFbr6+03dRdoH?=
 =?us-ascii?Q?72KO/c7P2i79q0n+Hy4XOcwnLZXNM8oClSbmNR122oqHqz0Z3Fbq/YOH7hdp?=
 =?us-ascii?Q?qi+c7odjbDEJlKaCZbZ63Q1TOzfE4cbXK9E4cOvBZj2+VfI9V7x2hXJNBywV?=
 =?us-ascii?Q?CZzfPREDxDan1oM6a7sB0AHDf7GV4sucFhIalIDCuA+59XrvrdTy0KIJyVUy?=
 =?us-ascii?Q?PXcrj92DABY0fZxvtadaQtu4FnKtedYa3fO2FO71U66IPH0/sVOj3/eXYN4E?=
 =?us-ascii?Q?5NDeVJUabmEShL5GZe1WDNLQAJhFN8gGhPNLCt1e/Sn6mhnoLskp8fT05djM?=
 =?us-ascii?Q?gKhjK4uLzoEUj/EQHr0EMfxzjHcjfsCh4Ctje+MrcvHxr0lZGRIsUaHBOgdS?=
 =?us-ascii?Q?260VlG+gexQ2nFbxBmhlUR192MAnd57ZNMsu6upTt3pv6aZOfTY3Ri6s1Db1?=
 =?us-ascii?Q?NbBHw+WAyJI3ORqokPJ+6LMXPfmtIag5GNVCKqbygAzfeu587IAuv6PAqVUc?=
 =?us-ascii?Q?f+vHSWTHgJQKPgIwnGsmf5HYYY8IcAQXVGQPBN7tWOo2ekOYYs+dPgtnjy54?=
 =?us-ascii?Q?x0TZv42KnBnwibJfp2tp5E6C5RLV5jxVWvJwbti2P8/SAKCL4US/k/k4+m/O?=
 =?us-ascii?Q?0mx7p2qlROCBAvqCpfkCNTKHurLssFM8z/Cgk4YemzCDyP4DWm4FetnAJxvy?=
 =?us-ascii?Q?JEcAsVZ5zCS6I/JO4v0CLSJZceBsWGhCL0SyKIprqvjif+pvZFpP+Sjpvq4C?=
 =?us-ascii?Q?zCjV6I+VJhh0Z+aoht5V1RTkFBoH/TeCojxXORs1H77A3+Owbp88WiuWXLP+?=
 =?us-ascii?Q?b0m22PdQ8j4sXaytcoptdlrsiQ9R8mdazdjEdNDKFmnUHyENpQBtX0YwzoZr?=
 =?us-ascii?Q?HAH4HQ9Ms3fkAgzwqIpqQoJcNQktfFiMaupNBuKxzbQ0iF6mcvnDXvuJJPGU?=
 =?us-ascii?Q?7HgYSKx5jPw9a8zm28qLK1Utf3zczSEqrOht8lOoWSQfYqFScZzNiUvCb6NF?=
 =?us-ascii?Q?nEhctStdacdTToPJJrYuX1mYeiPPbdToSWscuBJuzernOX+6mIM64uqcqxqG?=
 =?us-ascii?Q?/cyypz+56QbrCRnYdsX61Ugwlf6kNjGdJ7rtKZStwIz9c325AVbSkUqQwxCf?=
 =?us-ascii?Q?gVT6nZqXakBgCKSQ59mLUdRNkA1jn8GYwNpIRlnEScn3BpNEwm+tRM0a8KIn?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZcSmqnr8YeEu+botk2yuf06PnKOchBjgYpSuZxZwohTZj2D3yTTphSsLd1lY34Cce05HCV6Dw/dsP1Uv6KhY1DSuOLiQA5QtZlIN64p/tdV7lKuh0zdvooa/NhOG7Xxlcjm+XbpInK8RpTv0RDbcnHNcFDl3MHA59kz6H67BkfoTqqECkgHQug7DTdbhOE4XPC7XVjPWvAyRR2AKxvnXHL7eCYwq5conEtpTSaW78d2m2UTdEIr8PFrVbJ3gnVxbnn5Egg9X0E1BsgjHVEBZry/KghuwXGPjAEgdDXxPbqhZZP4CkDMFE0NP6BXKlcVooW9RKeDaDrWrsGsUwVKraYkv2rPNl+rG1/1E0rfQAAhIbF3OO2F1pWoVdHdOH+CvBO1TJxi3mwFuuo+7QnyvRSs7npijXRtY+Lons/jzZl7uLEdf7xvvW4a4gmQqmr0G/gfkdnMkOeOiOUhyveh71AFjkhEAq6csZwQHDBt+M21zRwudB0d2EtpGw/eXnmcmqrfdsoZ8qAFxjUA8Tbi+Qe6hpHppBKYl1TFiKd6fXlAnFMNQ9KRwexOZlfGdYloXFPcEYJbPEroprcJleci2WIAGN8AiA1TpfDghJBnbDfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b33521f-0a5d-4648-af3a-08dd1b2ba5c7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:23.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VHZbebmjgQ/M7Iy1bu8CUmE/qvT+dPAGeoUKXrckCfHgjOVQ+lmsSPbTEtRlBC2T3FpDt7USpRXKrAdDKHkr058lgaIAOOoGYcc1szzHyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130029
X-Proofpoint-GUID: r5Zhfhg0TFzFTiu4JL6sSMcZM1mPZwsB
X-Proofpoint-ORIG-GUID: r5Zhfhg0TFzFTiu4JL6sSMcZM1mPZwsB

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. For PREEMPT_RCU=y configurations -- where
cond_resched() is a stub -- we do this by directly calling
rcu_momentary_eqs().

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), however, we have a
configuration with (PREEMPTION=y, PREEMPT_RCU=n) where neither
of the above can help.

Handle that by providing an explicit quiescent state here for all
configurations.

As mentioned above this is not needed for non-stubbed cond_resched(),
but, providing a quiescent state here just pulls in one that a future
cond_resched() would provide, so doesn't cause any extra work for
this configuration.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace_osnoise.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b9f96c77527d..2340ffcefb9d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1531,27 +1531,25 @@ static int run_osnoise(void)
 
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
-		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_eqs(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * a stopped tick PREEMPT_RCU or PREEMPT_LAZY have no way to
+		 * account for QSs. This will eventually cause unwarranted
+		 * noise as RCU forces preemption as the means of ending the
+		 * current grace period.  We avoid this by calling
+		 * rcu_momentary_eqs(), which performs a zero duration EQS
+		 * allowing RCU to end the current grace period. This call
+		 * shouldn't be wrapped inside an RCU critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * Normally QSs for other cases are handled through cond_resched().
+		 * For simplicity, however, we call rcu_momentary_eqs() for all
+		 * configurations here.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-			if (!disable_irq)
-				local_irq_disable();
+		if (!disable_irq)
+			local_irq_disable();
 
-			rcu_momentary_eqs();
+		rcu_momentary_eqs();
 
-			if (!disable_irq)
-				local_irq_enable();
-		}
+		if (!disable_irq)
+			local_irq_enable();
 
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
-- 
2.43.5


