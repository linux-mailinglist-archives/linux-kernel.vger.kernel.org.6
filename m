Return-Path: <linux-kernel+bounces-259608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A932E939958
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371781F22830
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D691E4AB;
	Tue, 23 Jul 2024 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PW029ZTk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KpDFX4TA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FD8634
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714126; cv=fail; b=k7ucMeRSc9RsPUQL+8UYlqY1HCmJ+73AMj4h7TFr9j/s48WXtNX98zd47Y/9Wm1Zj+mL8N5+1D3c+KZGbe0l0dxT4fGJCe/5+VlR4ATBUYlOfkXCF3yWSjkQrar+rQtItmrf887wH9CDeeebFWOEXsMtszHBGqFzgqw3htd09gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714126; c=relaxed/simple;
	bh=ID+CigqbOFLC3n9x0N5l0tqTnTdyKoNZvA6nTnVceDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V0qvcCjwLbaKse+2tO3yalVslV5uv7yRRRQH+srf82DxS8meJuHyZ+TR8TgAiywktBKTFNrMuI/SdHxMSmiJRokKe3FR7UBKPeIqfyxNGYSIBDO4FS2ep4cjS/AJnBdiFkAB0x+XNP25zX9kibUEFYTLUAwGW6AKuOo+OuRAXXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PW029ZTk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KpDFX4TA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N2Odij001922;
	Tue, 23 Jul 2024 05:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=hT7mvVlNktvs2NV
	J+beXZFQSWHDGARKLivx2M43hNsc=; b=PW029ZTkTlCl+gAwCA77nvm/k9lc0pR
	TengbDvACvfavT7YbYgSUepuuZzVNnAEnezhTOb2ZLmBrq8IqTkEvKHo6+Hu21YI
	tdaoq0msOhL7pGeHjOlHjH6TUw9CEkGSDdYARWIY8E4CnPVkghLNf9E8mU3GqIen
	0E045kgFUUGWf6qCCHUXxEaP8o0py8ZHx20kYVRavaoJF0MPBfNH/N3mV57hYgZF
	TL/tRHThHOH/tnIO1AOPtjornT0T5hpO39CjDbIrVlStkdb+gbr7CMiOlEuQ0NY5
	kKEEKP5gMDOt/1ErZzqteGwR0ZoJ1WxBnqgm7Oj+2qT0jIRdtBDR2fA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hghcmy83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 05:54:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46N3vFSk010953;
	Tue, 23 Jul 2024 05:54:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29qqj7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 05:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN4IZf2N7uCkR2T/5QWkyprt3rAJNM0zKoqPWW8TCW3na2/C1KIUXuUpge5mmD1HK03VE0nLShJxoBWw+RXnc3ElTkVyfEUmIuNgO8t3zg4IOoZlAfN0bBEVzs7VW/GYLWv8Yked+YnjUY+M6FJ24yReRg1vHzAy/njLpJXp90/gIJvlo1kWUDvIhZV1Lpwfee0zVMXWEiypNuKWEnfj1ebRVk9/Ulb0+E3G64KTs3gGQg0Dw5NAdMLrP7zsUpY42wXE73Hu5v+fsDEpwjELtz0T2w/LuldoYB4VHgLPMXn4KgEropAcs3RfFF5P/j5Wru3LEF3nBC+iku566E0HDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hT7mvVlNktvs2NVJ+beXZFQSWHDGARKLivx2M43hNsc=;
 b=AqZYjnMt16Hkavw2lf2UGrECLgfkDhIwgWk0VC2cVNCllowl3ju1lMuQ+OHUBa2IfeLm00hk8qYaEgqSPMrZJPTd5hfk3J3XsRSCZPXAjedDKLqhQIO2N9fVcdKQcfDAlaM3nbEuGqKS2D0rlb8XA+bUG3I51vnXcKgj8ZLW9ryrZuSF4AdnMQHpy1Js/UkP3YlTHRXkYsJztGysvjX9pW+GqWAZ4t6IwZv4e6D+Dlj75tR75DIejONt48YHGtGIB9si9iuDI1O6ey2UYhr6MZb+/yB+zcklw5yVTBxnLP7gntybh3+uC/UgNmO9HP/G7f/0HGLlAtGM3sTbsI+fRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT7mvVlNktvs2NVJ+beXZFQSWHDGARKLivx2M43hNsc=;
 b=KpDFX4TA58Uunynqyln55SuvG8fjIwvcs+JV1zO+3ZbkodHrI9koC/+AofTC5qesP1NFj1eJlz/vtV/YWssTaoaBrj0g+7lY6BpAddJbujPDSfi01F77PL4CtPN81yfM03bAWGvKeWjeNu7NLHk1Y24sKZahh/Fi2Y4SGYVTo3s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 05:54:53 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 05:54:53 +0000
Date: Tue, 23 Jul 2024 06:54:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] memory tiering: introduce folio_has_cpupid() check
Message-ID: <6effd690-3cf2-46bc-8061-2d19922ad4fa@lucifer.local>
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-2-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722172917.503370-2-ziy@nvidia.com>
X-ClientProxiedBy: LO4P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 5725c8ef-6b4d-41a6-9921-08dcaadbf8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?foUr9bM2pzwSARdZO7G3UfiP4Q7NwYF3P6C+A4ngXUMS0vAqx1r1lsoDS06L?=
 =?us-ascii?Q?ixjFTDl4e9vbsvzuRrIKneG5o90h8xVTGykzFL8ryGpDRKgz6+3zdaLAaPfq?=
 =?us-ascii?Q?d0REmbgkbwUxeZTCnlrh16Zhn6hJC0Z8IaUF6My9p6jbcD+yQTu/pe9ARMKK?=
 =?us-ascii?Q?5tijOEY2ASMO6JVoDpMJMh9bEQb4FuE2s2NLkoU9d0UKlxsZuUp5IcH04Hvf?=
 =?us-ascii?Q?1D1qaMVR2y0PaXCmDRitLQurZPXlvGvnUPXBZNZHgjl0Qj1O0Fg0kapIA7Yb?=
 =?us-ascii?Q?SVLm1hUnUHJY0tQPJucdCiubNesiEowgfmDnExDc3TkknNunajhG03fKbBQY?=
 =?us-ascii?Q?mV9EsdCr+tKDj9pfaE6Jy9ljpsazC36klnYOUu0IUGilqz4xwLbPwwDAlJ1G?=
 =?us-ascii?Q?5XTAgr6FvrIHzkJFXksl4Jd1jWJyGPyiJ1rabGeCoP1LL0gWwRxCJ2pTHEmR?=
 =?us-ascii?Q?wYFwb70kYV7+6GAJPF33/PfNmeHofAZNwLTQ9FOGCkxPh2qbvPLdmw8g5MbJ?=
 =?us-ascii?Q?CsC80/Qd0kHK/He5rbdaktask1mbDa+YraN90p2zFM6R6jVr2yQoNzYOxVaD?=
 =?us-ascii?Q?Ug8/0FoEDy5Bc8fY+s6H3GvxDhPSO4iW8bELHJnCqoWGhWg5xtcqFbrUV+Ez?=
 =?us-ascii?Q?C+JVU2Effv3ZeqGOMagCw4F8aMHK+Z8WT0A7ljqopEtmLLmTNKDoKrzUr55w?=
 =?us-ascii?Q?MGEf2SnHjTUXRbSZncndshJ7UJTfR/L8PJGbO1/3Zd3AmOox92PWI1tDIHpB?=
 =?us-ascii?Q?FDRGf+Ax8ABKsXyJjovX3jGxolnyUOm6y2ld29hryEzfF7gO+3nR6pKqLi1Y?=
 =?us-ascii?Q?LRTbL2/PjsrDubiUOCnxlZZqC2948kc58jtc2r4TM0lG+5T4qIVlZRbzkTd5?=
 =?us-ascii?Q?rtcLiEzIHCm6tkSJ+E+QaQvogYYseLA7pgceC0d/z+fjezd9218qD+75UDga?=
 =?us-ascii?Q?fovlvEKoAn51ebz/AjZ96SqUkOFBdpkhAKHPL+3OrTKP/5IwEge0RgYYSb33?=
 =?us-ascii?Q?RXbYtV+RICXzXqavXg0ehPo5CDlXULlbHD8mDCDMRUR/CVRJ7RIsncB2DOEY?=
 =?us-ascii?Q?YYHp5ziJ6ogRAZ4hPO5Fje2FHAlAu/2zn4Yn4qyUysYOC1WmAa1t5OX1jGgO?=
 =?us-ascii?Q?68CTX1URUgCwTf6GrID4f1kyKFXYcYB1ExPKpwgtG/LpGsLexrxRRR+jyxOO?=
 =?us-ascii?Q?96ifjRerKA5vPXCzVgU2aTSUxj/wskuxlTEd2d5bpg27uiIzlv/2gNeOQfvx?=
 =?us-ascii?Q?bFZ1cFvPOBtaMSJ878UcVoOn5QePEeyKdlBUqusZEubwWTkNOl4K+w1VRTQo?=
 =?us-ascii?Q?E4HDq2S2W1Viehvw5FpXhEVXsK1MQamvDmx/g4uwlVzjXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FecMBkO3Rgjcw+6K+O0rTW26NfU8FDwqyS61eJ5k4kyhA+HxGe8QthMhgKRb?=
 =?us-ascii?Q?xKO2DTnisNHi+Wo0Yv/bnx6InzNlmxCj1k/ci6SvbtZHA0c1IvWweh4Cnxsc?=
 =?us-ascii?Q?GunvrlsHLXT5JJZxrtSu/Tj3EYHDwiDxK8C8mYgsXoXqS5QfRGjwWhOedUkt?=
 =?us-ascii?Q?oJTWdxIz662vQvyDmA1ZoauwxFU4+zdHDVxqrS75d2YFgjnFs5nDkYbMvQQR?=
 =?us-ascii?Q?X/v1ypaEuR6AudKsaa1+pIw2SvOUDm03OZ5XwqIcfqo8EADhQrF3y64Vev6H?=
 =?us-ascii?Q?FfCwgakD+4nEP7gagcLta48qRdT0DRcO5Y4AvUxBz0QDTJ61EqgyZhv9Bmdi?=
 =?us-ascii?Q?HGNSTLlFGoqc/5YzIdlSAmU8p2r/qJdApYh7oTx/DThNL0rBphR8vaeJKwFf?=
 =?us-ascii?Q?l1qP0sCVatIlwcG9t6P8sUsMM7OYmmqvgJVHj/YMdPaG8So7Oz+I4Dg1582U?=
 =?us-ascii?Q?EdjstyZYxbJbAJH6nXCX1Njm+p1efxB4zwBuThK5tDObNyRamj0j504p4WzB?=
 =?us-ascii?Q?UZxSg+HRZngLi6dLkttD7uIklw6ihNMyW3c8O6Q27OAICpgEA94D+wQYi5oU?=
 =?us-ascii?Q?ALQCrNvwACTaGJIs07aZSO4tncOR0XT63noWnIoZMGP+8sW3zbqdZCoQIsr/?=
 =?us-ascii?Q?b8Do1npgRG7Vv2VuUhAUz6PcaXfRmDkBbTKa75GDfdU9xKENIMe3Qjx56kM+?=
 =?us-ascii?Q?aR6qHQYgJFIrBswhRXEeVfKCD+Bcfrd3yajmkozgdjoR5c/ayK7UcSUEBdE3?=
 =?us-ascii?Q?zw121Hg/xHkgr6PWX7W3bj+IhRrigJYIK91XtrBUqdeExRj55e6Qx9YTT2Io?=
 =?us-ascii?Q?zJtb8Hht+fl1ntH17OGSo+A3Nf+zxO6GoUvki/4hZJTSBIXkMxrxtDBriazM?=
 =?us-ascii?Q?ui9GF7guNVqRcPdKk/+PwiGyaYSbJMY0+O5r7bjj0Vno5cCWhnKqDe92h2jf?=
 =?us-ascii?Q?Mx8+nUs72/EiEPcZaTDDZ+iO0piQH2HctSN+2t5BVQDJRZI3pcoRUqp73xPz?=
 =?us-ascii?Q?e85mDqas5agU44BKk16mGhUWPmt62DzFU4LbXszHbFlEwHMV0FAGQJFMnx2r?=
 =?us-ascii?Q?X4+2xTWm0Ud1DLig3Kd+98hMb5X7J7toQEdXVW8WO6HviUlHHUHXU1yqJ8pe?=
 =?us-ascii?Q?Xsn2Ia8L2QfgnrqWUGOPJqv6oOlZrJNW8G8UI2xLBOw2v9Ii7xtlH2dhcaT7?=
 =?us-ascii?Q?qmkE7n+5ex8nYX1nWwZwiQIQcLxYJAdHMr0Xf+PY5UlXKk+ovYnxVFd3lm2/?=
 =?us-ascii?Q?YCU/Uas4HUKOiUBKOjV/KjDwDRofb6m4qIH2XDRviEabdjB8AicbKsFGTlNF?=
 =?us-ascii?Q?t/PCgIScAOFCqtYg9r+JOLt1EBB4l9vycDB7mmrUFGSVHdbGWLRxXb2BdJCz?=
 =?us-ascii?Q?+kF+AqWIKdhvm1A/VfaxtBUbuwP9J6WYEL8I8MP+Sv+IIjBBU7SZeRnH7rCv?=
 =?us-ascii?Q?cKhwuxM+/K98DQS1x0VRQDNA+y8BAO762sWRkQigD3nGlU72JAw1PAwPHrSa?=
 =?us-ascii?Q?1s1QbuIXiA859fXuP+9gwqjVNFR4IqBliVSffUBefrMg/+CfidjZ6I9wiJP3?=
 =?us-ascii?Q?G6IhQQ8DyvoztM2gTXyhRB4QA53n16c2ChSh4aaBL8MwSy7AOF0dnOwrBVhO?=
 =?us-ascii?Q?N2gy1UmFlE0CaDdSFWqgcNQGu3kZ1EQtsNb/rWA2G+Fwk0EhnqWObMb0e94r?=
 =?us-ascii?Q?dBVmSQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4G0qtK0CteQFY2B42B1UwyGHhfvworyTP+x8uqtbsFtDowK6M+F7PniotmMCJFmiQzHUH8DNJkWzcOuP41ZyhDN6RdfU+0eQl3NyxdWkoSpl+cwmKgUBT603K7hHkvQtVIoHPtr24IfBMfn+RYczvQbWFASpmFetUC6Nu6sSFSRM8qjA5XX9TxYuTlYdZLezkzDifnT4piuAET+z5+gZikn0/NKACXKxT8iv/GfqJ3/RBg39roDvNTAcM5i3vJ6v90Cd6isZ2m1f+aoJC3o7rX+nYL3xVw8kPygJ35KcEnDdzyCuuw8HjHmR+8BI6TBHfdINK2Q/2qcl4cqWTs5pwoidcsHp8jLg1KUyZ6gFaN0BV1I2kSsfpqoJLyvt2s7yEUDgVO2mMrSWrNZZs6E4fGWPLv0EOOgf2ACHVwvkTR1/AvGMJCY0egPLaB8RrXQPyvWGG26Lr3AP+TJjHKjc/HF47bIKWmGv7wsU17T6i1sjlZdThRc4B/LnGaY6oZtiEcgi8/mTt3vp8RLMunxy5FcqbJZh7Ez7ghFTV4ZmLkApGmnQezWacq11yMN4A7LYQZB4toa1x+UYns7rzzKeilWQImNvYunva0JQTq7LiRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5725c8ef-6b4d-41a6-9921-08dcaadbf8f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 05:54:53.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHeC9F2B58pNvSUDHphL8yrVyJZvYbKHOMLD/0hpy2aVgMwSlTGdKscYnAyR6Srgzgh1xOBSDkYDJRA2ZJddl9Bej+kKXKH+uD4yAnS4pIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230042
X-Proofpoint-GUID: cP8PxeNPH3zyiiGb9O8-Rl8FrYqJGLgL
X-Proofpoint-ORIG-GUID: cP8PxeNPH3zyiiGb9O8-Rl8FrYqJGLgL

On Mon, Jul 22, 2024 at 01:29:16PM GMT, Zi Yan wrote:
> Instead of open coded check for if memory tiering mode is on and a folio
> is in the top tier memory, use a function to encapsulate the check.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  include/linux/mm.h  |  6 ++++++
>  kernel/sched/fair.c |  3 +--
>  mm/huge_memory.c    |  6 ++----
>  mm/memory-tiers.c   | 17 +++++++++++++++++
>  mm/memory.c         |  3 +--
>  mm/mprotect.c       |  3 +--
>  6 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c227f22ba810..048b2a56d8a3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1738,6 +1738,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
>  		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
>  	}
>  }
> +
> +bool folio_has_cpupid(struct folio *folio);
>  #else /* !CONFIG_NUMA_BALANCING */
>  static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
>  {
> @@ -1791,6 +1793,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>  static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
>  {
>  }
> +static inline bool folio_has_cpupid(struct folio *folio)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..03de808cb3cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  	 * The pages in slow memory node should be migrated according
>  	 * to hot/cold instead of private/shared.
>  	 */
> -	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -	    !node_is_toptier(src_nid)) {
> +	if (!folio_has_cpupid(folio)) {
>  		struct pglist_data *pgdat;
>  		unsigned long rate_limit;
>  		unsigned int latency, th, def_th;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 825317aee88e..d925a93bb9ed 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1712,8 +1712,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
>  	 */
> -	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> -	    node_is_toptier(nid))
> +	if (folio_has_cpupid(folio))
>  		last_cpupid = folio_last_cpupid(folio);
>  	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>  	if (target_nid == NUMA_NO_NODE)
> @@ -2066,8 +2065,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		    toptier)
>  			goto unlock;
>
> -		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -		    !toptier)
> +		if (!folio_has_cpupid(folio))
>  			folio_xchg_access_time(folio,
>  					       jiffies_to_msecs(jiffies));
>  	}
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 4775b3a3dabe..7f0360d4e3a0 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -6,6 +6,7 @@
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/notifier.h>
> +#include <linux/sched/sysctl.h>
>
>  #include "internal.h"
>
> @@ -50,6 +51,22 @@ static const struct bus_type memory_tier_subsys = {
>  	.dev_name = "memory_tier",
>  };
>
> +/**
> + * folio_has_cpupid - check if a folio has cpupid information
> + * @folio: folio to check
> + *
> + * folio's _last_cpupid field is repurposed by memory tiering. In memory
> + * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
> + * record page access time.
> + *
> + * Return: the folio _last_cpupid is used as cpupid
> + */
> +bool folio_has_cpupid(struct folio *folio)
> +{
> +	return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +	       node_is_toptier(folio_nid(folio));
> +}
> +

The static version of folio_has_cpupid() is defined in include/linux/mm.h
if !CONFIG_NUMA_BALANCING but you define the function in memory-tiers.c
unconditionally, a file that is compiled predicated on CONFIG_NUMA.

So a config with !CONFIG_NUMA_BALANCING but CONFIG_NUMA set results in a
compilation error (I just hit it this morning in mm-unstable).

A minimal fix for this is to wrap the declaration in:

#ifdef CONFIG_NUMA_BALANCING
...
#endif

I've tried this locally and it resolves the issue.

>  #ifdef CONFIG_MIGRATION
>  static int top_tier_adistance;
>  /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 802d0d8a40f9..105e1a0157dd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5337,8 +5337,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	 * For memory tiering mode, cpupid of slow memory page is used
>  	 * to record page access time.  So use default value.
>  	 */
> -	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> -	    !node_is_toptier(nid))
> +	if (!folio_has_cpupid(folio))
>  		last_cpupid = (-1 & LAST_CPUPID_MASK);
>  	else
>  		last_cpupid = folio_last_cpupid(folio);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 222ab434da54..787c3c2bf1b6 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
>  				    toptier)
>  					continue;
> -				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -				    !toptier)
> +				if (!folio_has_cpupid(folio))
>  					folio_xchg_access_time(folio,
>  						jiffies_to_msecs(jiffies));
>  			}
> --
> 2.43.0
>

