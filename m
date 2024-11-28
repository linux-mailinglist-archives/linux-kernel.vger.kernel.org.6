Return-Path: <linux-kernel+bounces-424837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A289DBA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D09B22286
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB71B393F;
	Thu, 28 Nov 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C3+mEOjy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i3P7zyPb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C11AF0A5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806402; cv=fail; b=ps8EHwH88+9N+xXkXpWEvfqtkXsr/z/zWNFC6Qe1S8parx8S+xpcbjxZ32kioEV2dLDG4ZYBFDPj+DEVuDFQLccHA8UEgafecA6cH57wjUbbQFsC435qZPcu91gd/PdbVZEb3F8LBPJhKP8UsbYlgKQ8St4ho322z9/0uudw9QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806402; c=relaxed/simple;
	bh=vHj/PeU0zD4YtNf+zugdUgGVJOwHJG+Ov35QSZDtHdE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K1wSuVoIv4NSJ9PbfOVmIShAlZ62tUR6DvZPqYCqERpgH/s3r7IauTWDazp+KWHa4LDMk0YcQEFMKhNxEyWZyVVpsoj6QFHdf3DzRV22SEzJEscqfWTKMajeh/fzZhmRNwt6NfS6cIMGXWDe+ZQjgfMFMNYa+Mk1ZkGg8QcxyoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C3+mEOjy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i3P7zyPb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEJLsT008736;
	Thu, 28 Nov 2024 15:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=n3CwzOcaWdaAxTdw
	yl2JG+yATq1+pcWBHJHBSmhu9gw=; b=C3+mEOjysYRSvKJgRI4w9joy4F9hmmcT
	F99n4l7Uid9lsNbYOsKvkeuARXIBSrIy+jz5DC83KK2B2X0U3KUZVHAWGdMSJ9ER
	inTPmYkBoO18As71jCahjAEgbJTAMpKIYSWNnjJSbfSs/eHFSve3+gjoFUdlJ1Qr
	yvld0itZC48BoatgepS0YYPuryGZEmu2qwU67of2QswI5Qy/UfahpDeOz46fNhbD
	LvckyrZwlmAyk4T9k8hDhRCjECJwjHiJlT68iBiVa3GSTUZEFrozb/GGwaiS4Fzz
	rp5KNGxIBVhTFoC++s8knV+xb8Oo2gJuBmNVOraErgX8tsAzyKGakw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xy9yf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 15:06:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASDGemm039701;
	Thu, 28 Nov 2024 15:06:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4367067ram-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 15:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmrJDlpWifO4kXKGxWEK2Z9SKyVeY/niMMPDInntfV+ObiX+sWw3VeXHvU4dwzKF+5jxKcXWEQh/cgoDF4tGHJD2VjeBmOWb2J7ZH7I5BTONqVc+NbWEPmHVAnfKIDR5mEeRysdE5HwAboVGWl8ZplAcm0DXiaZPMm101UdZ1948WrcrcvtiB/ZbPzZ4CLefzchtIafsoYK+LTvhnAgUMXCCVRsc6Ykx9AXjl9tjsVkUUocBLuoHUnTA+7W8BrxHZeM1Zj+Hk4lJC6fv4IrxQ3rxhXnmugT402ZzGhWVdoHgYPpqXKQD0P8b/AAqTx4XgvxTPlXtKm/5Z7rt7bPzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3CwzOcaWdaAxTdwyl2JG+yATq1+pcWBHJHBSmhu9gw=;
 b=Cmzt0l4tk2DB3X3zAQ0lQdbiB6W1oKem9KrDiGB57K97CkIY6iWqTZ2x9Sf/xjhLlbgM29b18ap0aQjKyO8ITc0xvxzjDkjulTb6XOky+qn7wm9EeXIe4HoHG0LD5Eadbk+u8tLzb4N6eu/Pwhs71Q7lZcCYcOy0Wg2tbSDXEFzxrzkY5mPmLn6/VLIaoM4R9CtAVWyfiSi9yQ/lHf/JjF66v0SZe/nxmnU3Ynm7U8WM5Mf/kQ5ILqyrLZRMUKx/kU9ZPLwX+cqNWCPkHk4wnKqSwl6g1oklIVq/rp1nIVaSLLm/In4q7xpzf1MK8JEKLiucLNaSxWh3Sw5XCPg8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3CwzOcaWdaAxTdwyl2JG+yATq1+pcWBHJHBSmhu9gw=;
 b=i3P7zyPbwjDWyOpEcDjFAtSZYtDA5F5f3UqNWUC+AiezLga2YInKt4NlMWbT1k7OBe61aUoaOKPz5OaWnKhlj8mrRfPfwNsga/lgMYzUrA561xT1RgPsArtV5HDldF+tfqLJxrUu+5oGz4gGY0WN6rgFhtgb7u+IPXDVPWqtvZY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7958.namprd10.prod.outlook.com (2603:10b6:610:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 15:06:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 15:06:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, Julian Orth <ju.orth@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Thu, 28 Nov 2024 15:06:16 +0000
Message-ID: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: d0879540-c0a8-4852-676a-08dd0fbe3a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WHLsYwVflgGj2NuwXVGKvlQTrnSASR1g3m8fOJ7/1VQrgFKgPRItciEVoYC7?=
 =?us-ascii?Q?5HzkTd49BJkvJcXXbBL+dtalzAx7NZJEYbfkel8hH57rksAIzQMCFNJZNBzU?=
 =?us-ascii?Q?z93RNcdzjx/QCyBTV2JfPdn0YPgR8yD0kVOqM/J6LJg4KObOvZ0qDvXVDJ+I?=
 =?us-ascii?Q?kAU1mLjlf0wuBP1H2xZEpkPptEjePXaDI2U4avZyK5fsqZM30BYvcyg8mods?=
 =?us-ascii?Q?tu8ozd6zO844JtcIcKXwFkIMXCHyzOcEXHqb7p3oZhXMvSbrZMVnKXuarS8o?=
 =?us-ascii?Q?u6sTP/1aIzjg2zZc/pPw+7MBhHFF7gM2AWRod/RZanT/cRetLN5+qs3/08E1?=
 =?us-ascii?Q?3Tn2zTghXeWXgUN/EC/mSIOkt0mqj0p6kmkKkbfvHCbfiOU6fwfYw01pscgp?=
 =?us-ascii?Q?TOI2zupEC5r7RoMFj3WDqVy8j1Zdaz/ZcPeWGCYKQagXe85HEpYHPso2egr3?=
 =?us-ascii?Q?eeZZDWKWiqEB70wbYvJJHBtfru0+Ps/8gId0hmJVZf4kkNPwfQk1lnAyBefD?=
 =?us-ascii?Q?ENkMPseADMF9UAfocGPfREk4Iurp6rZHNfie0J7GO6LT18GJQAruqaenc4xp?=
 =?us-ascii?Q?EpjdDChENCtf4u5elPZcm0QRT5die3X4M+b6KQYSPJ8mYv5XYi/oB3/bu6WE?=
 =?us-ascii?Q?qtwjQ6LSnpJKSNgnrtjtrJXqw9kSFiXF6TauUrltuv1mWC2y5VHE1h9kcRHB?=
 =?us-ascii?Q?5hJaNKHiG4Tj8OGCXF0ji29gmI2eke/FnyxCSYeutgBkiDJ5vTrBuVTBs5JS?=
 =?us-ascii?Q?EZ0xKCRoq0R22jF/rTBvtmwxqDUmU5bR6vl0/dRmk7EvGfZlJ36mhIJXFLt3?=
 =?us-ascii?Q?lAZs62Bz/w/eIdCTpuHWHKeAsH7e6KPgo7DlzQiowD3/cUGe9yro8Uswqdgo?=
 =?us-ascii?Q?OqjyI1ddtsIyiYBzTdMqF+XdCnLm9AtvgHS/4WNHuVD69rpVsXkA3Fm1Oj1L?=
 =?us-ascii?Q?e54sBdQk52QotQ434ykAdDhPccyuT0liVWYmGMD/jlcJUGnTdJ7+u3sleyU6?=
 =?us-ascii?Q?3ePnInG39YIkzAOrNgR3334syOfCvZUaEqmfiWnlFPWhS5ngFVtcIzuAhzvj?=
 =?us-ascii?Q?n16pZXJFgm/ROkOXTK2+BHR/k9oyZUyygAMQB3rDr5qnxMoCZlcfffwM5E1B?=
 =?us-ascii?Q?/54lXxew1lQ2QYHF8mjqGVT+juNiIe/cCjvzfuZfuSjXDwh76j0VTX/bUILf?=
 =?us-ascii?Q?ViAp0E5/ZQUX2Tt4nWxdo3A2wd091LGHZhmLBunKtEFjkWnkQSc1ye4Qzdd+?=
 =?us-ascii?Q?x7qzobir6PZJ5PSqR/dUv2qKdKY16/IqqmF7m1bvqaOt0Wk/DZ6zLHNcxFsD?=
 =?us-ascii?Q?ACF1kJAHsT2lTreA24AgV8L8pj0oYOyUpWl46qKuD0okEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rg/EL3eUo+xXQ917TJbnMUlEbyWLLbxhqNW+x0QaqTD5GReKDBO55D+I5qCb?=
 =?us-ascii?Q?7lct9ODPwyf0JKrYB2Ds6lVVFvlkOkNjNA7+6gMyPYlReNAs+I2KbFI/JX9G?=
 =?us-ascii?Q?FjV+k7ORDeaFd9hQpSdzUmEjhlMBYkY7y7pFIEWxDz4sPmvMUqzSzycWysk7?=
 =?us-ascii?Q?nuidVhakyKiC3JqmJd6uTH9naau7sFjAB56gZ4ulyrbFgk7GfAOtbjLzXWjd?=
 =?us-ascii?Q?CIhSn2biEx87x46MFBGCRwsAaxuCUyWf71w5TObOasbiespXiWIZx2BBDhvM?=
 =?us-ascii?Q?7ppDS/H9W/vcz5wqizyIP8ecdGGDn88PbtKMB6lO77DZkyZQMYJwt7tVJXKh?=
 =?us-ascii?Q?PAW6u8l8t7sLDw2653B5E1exnyXpTX86kC862LAL8vv/znY1HTTv3HBTBRx8?=
 =?us-ascii?Q?MBENIbw+PG8uRJZ7/rVlr1VA83P6VlDrwCOR0uW8sRrabRG3RkGH1oeW2zfF?=
 =?us-ascii?Q?2jm7j0Xi8xmGsndhEmC1o1vwmCrCoHcyCojdfbPlW7XAcv7Mh4CWv/S9pU8H?=
 =?us-ascii?Q?DuvAmg8t5YAn4v0nFdgf9O5MENzz6NEs6JHhs3hAMT5nDDNSea2DRuF0yG78?=
 =?us-ascii?Q?RWncGIIQrZaIaeVk3WJWugeF4PfnpGYnTsqgbxV5vqrdDfZKlHF/f7np4r89?=
 =?us-ascii?Q?5GkVEcLh8N+JTpnIhvsKLCS2SjjJyyVtd8t+zNBBZqtl5dFd1BPJagxVcoxY?=
 =?us-ascii?Q?JTGhmw9m3N763UCE8nbg4qOWl7tI8pY2oJoch80s/vYmdjtbYBva8NmHEouj?=
 =?us-ascii?Q?q2Iu3TrQ+HhZWNui4Xjw9V4wTHnvurwqn0mvlxldOIY0fHTS0gIv6gTn2D4v?=
 =?us-ascii?Q?xl/8OndaeMzG5E8CR5mga1+nmGbWiTrnAOjHZ3P4sSJ4LUdKhdMoEm3XSAvp?=
 =?us-ascii?Q?Q3Hq4G2aDAUNEpkYmoUNAdkwbF8y19W8pDwod1KHfBCAh9iSPD1ZIeX9/nac?=
 =?us-ascii?Q?V65nL6vWGS6Z8gZ0O1in7Nc6kdhc061nmy8toD3JpDGI965MGL6f6oo7hvjl?=
 =?us-ascii?Q?No2A1x2OeNbBoVhTxk6/mInZ8AXj1WEsiwiZmH39Yl5TU2q/cQTtsLy4d0/1?=
 =?us-ascii?Q?ptTqr6h8INQx+PW1tb5ryAOX4WDKA2hnBOEocgaFsmRvcnluDj2WPdeDtnS0?=
 =?us-ascii?Q?d14zoUnUl2b7i9WISmmbJbXYB9ysRoCMW4oLImEU626//aQyOMw1rvDnEIER?=
 =?us-ascii?Q?hxOllO3n6htia07nWCbmNT3Zwijv2iUZnq64iEYkOoa5vb8QQ+GtABbK9s4X?=
 =?us-ascii?Q?yKfVOFF8BXspgITgUWg6wMNwb39wDnoR9vOp9Y1ah2XdSgUuWy/09KXtfILm?=
 =?us-ascii?Q?fncGd/JQkmf6CH6XzDO39lWvZlzlmIxzoWfc9Un93zZccAHuzChR/60GGmdm?=
 =?us-ascii?Q?qd0Uk/6gECycDXsBNMfDgoAP/rsTIJNxT/zoq0n3I2L3ba97kWle4UndQge9?=
 =?us-ascii?Q?GKwOzyyZlyQ0t9WEkvpk4tzzx9OQ1C0nOIFniIhhRYZhJ0s8rnzEPAH1N3P2?=
 =?us-ascii?Q?1ByrswsANq/4Bp/sICpbO8CYnTu5imLYDNcDbIQXLqXCH/mdP6sbkZXa51Ed?=
 =?us-ascii?Q?okfidQtFFuKka3okV8s0jjirLLhr2kUmQhiP+45o/xwUZg7IeBYRfpg/YNQM?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfIqtbIqIrMLrVH225zzv5st5uYo7KO8dzRXCSeLh6rxwahfJe7jP14Mo+QzMbRhGvfw7g+LVB5SAPp5xX5PPOzvGDT5aAksqljH5/Iw/Eon9CXLDQLZFAhoPL12mLpyikT1EuWRIwMyGhd4BX3583MWatwUnA21zzm50Xj7Kl9tbVidistjg20GBYiZLAnakNXmHKoFhpoVj95zUa2AWFq5dp/Al6Bn0lpmUgCYcc+/9woJJEN2E+UydX9qVknx891pjEA7aZfOYF+S2owCQEQKl8msHefc0eXiDQ44tK/LAGNDOIcVwTaNqTmrNBcDcfx50Uwl2ch//KHa7UEKLzvSvLXE7MNlfGXWljYYMw2BH1jGdDO85eP0n3WZeuJgCH4ESauJX062u7YvV1nWqN3sYfz7iQZeOHrL6/4xEJzYejEfOcluemPfCUsxHu84MRnVELpnMv/PY2GF8pKYHvAd7CZSFGFQhwdmkjHlhZVEHkXRaLDFd1G2tBxds2yEZb4/1gFLRvfC8WMRyyyOuinwIeuuSQ5HlSghg/UvOd23m5EHOJ+3OBgWynAgIGuCCzEbIQV1U8FwTq6YZul+y80rWKiT5WgZ+ppKVZFSiaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0879540-c0a8-4852-676a-08dd0fbe3a01
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 15:06:24.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAR4Uclpt75O5jA0748WwEVil46zSKv/tJRXKpMYSjHrFFU2tXFf79kYCSSNMHl9mtQqycoMPaoYt47LX5iRnJM5Yn9jtqYV9kcg3B6iSWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_13,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=875 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280118
X-Proofpoint-GUID: 9kkU83-Xnp7MJbgmFHTCHopek2miygEv
X-Proofpoint-ORIG-GUID: 9kkU83-Xnp7MJbgmFHTCHopek2miygEv

In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
call_mmap()") (and preceding changes in the same series) it became possible
to mmap() F_SEAL_WRITE sealed memfd mappings read-only.

Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") unintentionally undid this logic by moving the
mapping_map_writable() check before the shmem_mmap() hook is invoked,
thereby regressing this change.

This series reworks how we both permit write-sealed mappings being mapped
read-only and disallow mprotect() from undoing the write-seal, fixing this
regression.

We also add a regression test to ensure that we do not accidentally regress
this in future.

Thanks to Julian Orth for reporting this regression.

Note that this will require stable backports to 6.6.y and 6.12.y, I will
send these manually when this lands upstream.

Lorenzo Stoakes (2):
  mm: reinstate ability to map write-sealed memfd mappings read-only
  selftests/memfd: add test for mapping write-sealed memfd read-only

 include/linux/memfd.h                      | 14 ++++++
 include/linux/mm.h                         | 58 +++++++++++++++-------
 mm/memfd.c                                 |  2 +-
 mm/mmap.c                                  |  4 ++
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++
 5 files changed, 102 insertions(+), 19 deletions(-)

--
2.47.0

