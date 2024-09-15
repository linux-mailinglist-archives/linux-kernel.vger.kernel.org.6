Return-Path: <linux-kernel+bounces-329863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A39796CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BC6281AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F41C68AC;
	Sun, 15 Sep 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VO036574";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Do+EgWJL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06D1C3F38
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406781; cv=fail; b=uQfNxhMcBxWX3IH8MUhQC9ADx4UDKiojuHdB42xMNVfm5yNutsB30UpT15JGzxWwqPBwEFDoX1QtDgMXBlcjMnWv4+CueZ0Kof4Bex29zr2jPUHFdE5VsM/rOrv5SzAsjDcHglJFc3nGtiGMt0IMW3x8kzENrn8nbXIMQia8YHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406781; c=relaxed/simple;
	bh=LOLtZyOinVamNw7txopnz0Jiy2RHcb2lsVbup6JxqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gKrzLkL8tFTlYXNJwRjRGig11wDYtJv7ZZmh8CYm86jOk8W0wcpgo3eZ1xICy4UxL4en4n4lwvpvYSaOVIYlnTZVsd2vdz3ltFvn74aIkinl82HNzr+QiSwnuCzMasjXDmtZJgXdJF5ZgRmykSo5ETov/jAdYwGOXzXNcdfCiCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VO036574; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Do+EgWJL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48F4tEAv026591;
	Sun, 15 Sep 2024 13:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Dt+UqbXF1qRWaS1
	zhKnv9GuwJYoZm1XlZMA7rCUNhg0=; b=VO0365742IalVMCwrzN0lromW9jkOOn
	GlzzN0LPpMciOoSMSC3Eo0G+/alIUTJKDH9yQ/BKXEzwqTdF6J46N8tLqZlltASg
	3wPD0qHdZV5YxvcPovgA4e2B+0rggevMWrzrNWH2Zz9W+heXhRMLpnXOnl3uODh7
	B5uDjO0VwWdkvUGJGcda97nKiqtX2sBONc+WIXGxhsLyJLHJyfJoZkqnWPqytleI
	t8xJX2ObXS2boqgRbQsOvpPE1J517hl0HeCtE6PnNxvmuKo6BXEaLu6BRYg4md3m
	N5mnXJ/KNUYUpFgKv1TQSfoGl6+Tc4imZSa/cnjEgTLa7lgWVT8I8eQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjskc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 13:26:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48FCI07k008173;
	Sun, 15 Sep 2024 13:26:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41nyf9rtw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Sep 2024 13:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSOQKMrIJDuoCYshnNvA65qq1/6ogF5rQRPYyl3ZpCzSoNWM61LxBIhliUsC74v8ydnC566G2FfWWth22D8S19AiLxj4IwdrjrcXXBy2piE92V50/JM4DTDQySeUvXWNLUkmHjaZkF2KfjwzO2D+aeM1NATfyFe8PTAfoHINRwL46KFtRZfBrsZjgDeo4Rn7ywaBbz/r3x5O2ytypVVci/gn7PQixOG8ON/PnXpmTRs7d7oQQkQ6euyV5saeDsm6x/ErRk6cwDSi9EstRdUNrgJADSSWIUCmRrukXjeMMTmhOPRQbOfM4SzW9GAUdd0l/NE97SFcDRZL4H5Uvm+Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt+UqbXF1qRWaS1zhKnv9GuwJYoZm1XlZMA7rCUNhg0=;
 b=UC94Op6drneXZlOM43XDiHPtU7gyiG1hoDrWbgXXZEaJ37sIoOkxeUJjxgStDplR0uB+2Ng4i2VbNtW8LgwW8pBhgs/fNadgvJ02GFdJ/oKVuBEEBrUabR6mNsFsaxEx/n9/lSyScUPPsdxhe27oGGhUY5RJ3h6WLfhX+8BT8ibUOChDarrpQDY9hNCo5u/2/OcBKl/JFNv4nzFDCOE7WK53ocoKYcSozpy+ZTqlgyei57OIjPzDGi7C4xfe6J0QbQKt5WvkSVGaokIbFIPHvAZVzA+uL8DJdRqhMQLTx1NOOVmrRrgjCp8o+haEKJOTJYsBrZP1LyGuwzHfYq6lvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt+UqbXF1qRWaS1zhKnv9GuwJYoZm1XlZMA7rCUNhg0=;
 b=Do+EgWJLSd1MS9sRAXSDNf8XkfNYsUSSVUJKdotOxH1yJxV/UkaEBaXZdWDUbY5Ee/LNQtuDHRMFDYBu05itJjyhTDmn6q66CQuKIkYoaPn4dFcxLMJneWoJ3JatCNGMRFjV2coGz0QCFGQuu9/G+HMP3O6BN8Y73uqPKPyxopo=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14; Sun, 15 Sep
 2024 13:26:07 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7982.011; Sun, 15 Sep 2024
 13:26:06 +0000
Date: Sun, 15 Sep 2024 14:26:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report] mm: avoid leaving partial pfn mappings around in
 error case
Message-ID: <c1c272df-8dfb-4bdb-b379-c644de414fd2@lucifer.local>
References: <8e3ffaf2-358f-479c-8de6-46e1b0bb0c5f@stanley.mountain>
 <68590155-fd3c-4ce4-9a1f-d314efada198@lucifer.local>
 <5a2f4219-e863-413a-96b9-ad2002f5b35d@stanley.mountain>
 <998b7c12-19a5-4213-8df6-154f50cd5dee@lucifer.local>
 <e62f5784-f4e2-4f46-b8e8-8ea80b400927@stanley.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62f5784-f4e2-4f46-b8e8-8ea80b400927@stanley.mountain>
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 96893210-6270-4d3d-fa00-08dcd589f479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/MsB4/mhKoxXbNJqj0GbBqUVLEu24XtIhml/RSJYYAvNdINxlpbs/7j6BPK?=
 =?us-ascii?Q?vxHfHFQXefSMxCEX8/NxnDEbkEfztiNVPZhA1pTogMPGrZ2kVexfGpMloooI?=
 =?us-ascii?Q?Nx0H0a+/ye28yKJKZk+bYrb46YIH4Th7PKkH6X9jzXGkrEXXQnTCiCd4Eve3?=
 =?us-ascii?Q?+A/eoeWQ/OJwmip+8TX/lXa4DVllU0TXcEHPGG/GCTcsughWWeox15APx02V?=
 =?us-ascii?Q?CZgXF4DthrLczTIcpO9pVuqQy2NhmZy6nQs673uqnnZPGqaMsSOXTLftXgde?=
 =?us-ascii?Q?KUQcEfuBAML6AftyHTbDdmhztwraMxUvpwStT8L2/o98RTsl7reZzMJYJV95?=
 =?us-ascii?Q?EnFz6tglwE+S1mMCyKbqp2NB25VdPF1Uf9a1NbL5sPs1bBoGFQNdc1rrgF2c?=
 =?us-ascii?Q?u8JSHD5hocBw2U39V0f6OVJqW5uSNjn3MsXXAi1ZmsOsm8XYX3bvgFJjv8Hh?=
 =?us-ascii?Q?v/1gpXjNRTxiWpDeEzQAb5+ZLYJs6tQC6CWRo4PArttGhLLG6DmYN+Hjfpx3?=
 =?us-ascii?Q?TEN0XMVFFGBmYPRJlH6JmAakubcfnUz/5PSfTB4obs/57vhH9Taj2Y7oIWzV?=
 =?us-ascii?Q?wAesVekm8AyDvvdxcW+CUauv8ZeCwy5BRcw1XkTAe95Crfm2eR92hi3qdBJw?=
 =?us-ascii?Q?Icx6QdI5ZaZ7Eod/VG5vmAAF9uq/rJ3HMLcKYIDQ6vMb1bECsg4xkwoNnXWw?=
 =?us-ascii?Q?cZHSHCPGRWJMkwayxbu2F3GuIFUb4ieWKx6bSLCpEnCFIEnTNK8Po8czW+w7?=
 =?us-ascii?Q?EUNfSU9JNrgolAG3jKNESMJRHKtOESGV0QK+8XwqEG+RdUlgGwuWYgI147qV?=
 =?us-ascii?Q?rC8H3epJ3NGHpkAVhOfRrLjcFCH2SV1xdBOh+rUNqkrk2gQFqcmdLGkETzmZ?=
 =?us-ascii?Q?i74antIfsC431RDbhQn1Gt7kL5HFIdCPNs5U3em5DbnAKG5dE8tmdE7ImLd3?=
 =?us-ascii?Q?9h36tpzMQdzGnUah4zVyF3h55ievIBFcbChYKKaV/ryU2iWJJjN+2L03jWhD?=
 =?us-ascii?Q?GBkvSrsZUnPAAryqH1Qar0/+3iaHnFrmFzoMarghoYfozFPy+ziYvCf4UFdX?=
 =?us-ascii?Q?7Nn44XR0EEy8STvYuD8r5GbgzcEfZWWpIX1gl67Pa6P7uju74Rox7kOniT2v?=
 =?us-ascii?Q?SebKHeFsCXVVplDCTqfFbR5zk+ke9VHQvCCl3mtm5S4lw88OnxfUJjKZIto8?=
 =?us-ascii?Q?ky/v0ScHUWZ9Q0L5Tam4edmpdUJzzWjorq7SEgSidF2Sp2DPTQOG2U3kJ69W?=
 =?us-ascii?Q?mZsBqawwqoGP7XFTkMw2xEd8crBL/4cHw3Fben+jtOONWRz7crXCw6vaeIa/?=
 =?us-ascii?Q?ClSxcnapYhq/2DuG02sCaVQOG5NuBBx3N2cueVyEj21XZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?crSBBIuOvTlwAqsOwPwyLllEG0O8kMA9/5B7F7nQZ5qqESwYHoXQksjEJ/lu?=
 =?us-ascii?Q?a+qgqsgyv3HwEGnECaO301ZQyet2hw1pW9cV3v6bnI1kAg5QZ/8xP8GeEHkv?=
 =?us-ascii?Q?8q41vPFFVYCEBg8tPhnkB4QVYRGgb+/7J9wixuZFyu9MlKtpuyTxx9rbpWRe?=
 =?us-ascii?Q?hHd11Nm2ozbXL7bXbIyMCKcfi6qecD2H5PCSpSQaqowOCI5/sEGhq3G5m7HI?=
 =?us-ascii?Q?LjGcaUzz+DpF6REYQQmMMXBQnpGulTV48ZRcwOBhl1RDAVU3EiXX+509Qyft?=
 =?us-ascii?Q?7s5e/65ZVthyysvnzLQA/dto9c738MeC0AN3v5os5tjkAQuhzS9HmfXysZ6j?=
 =?us-ascii?Q?1xp7WGz+jEKhXP1MKyveq1oUWD/w5LzqVcEdAiHIq5MGByld9+5fCZcK4SE8?=
 =?us-ascii?Q?tWP40tFD48qRCJeC2VUrrsVYWEhbjJ805H0TEGIyTCTjbYiWe3pP/z+yA9pa?=
 =?us-ascii?Q?iT21QKMJJsjLp7R1SFCYW9kDXs1CO31E6nsbuBavsFUsIgKYIhJlHEZzlFlf?=
 =?us-ascii?Q?mZexRpvMzagVN6CoTkX0qvT1NRUBqP+1k0pcpCRrKIfa6eMTJl/eYezYg1Dm?=
 =?us-ascii?Q?XC6bI2jm6gjlamYyNOvUZfmJ3CoXbHmT9/0nWEm6fWPNJaVrQaKOBM2HAdFO?=
 =?us-ascii?Q?+DY0UG2Jd4LaxZNve6y/BGDNjHqSQpC2WqKUP4km4jyrjlYnEcR8ySZqZcm1?=
 =?us-ascii?Q?WVngvG85zBPdZbR/UwZhKG7lGOnmu0IbSD43q/M7ye/R3DUt5Jx0RlltQEoI?=
 =?us-ascii?Q?Vev2/6sT1YY4MiNtJnVZ9RwyPEz0tvpLt57ZdhMQWHVnSaq0p6s0UPn4qrVB?=
 =?us-ascii?Q?Cdfu5NjQtVIyO+2l95p04Bku7BCVFxvn2ovVOwhXNgoHpzJwb7/q49jP6I6W?=
 =?us-ascii?Q?QfPOTldSuhgQhXhO4OK3/BX7UQfchwx8Pe6wa9s+l4vMXHp9U81pNz5rvfgI?=
 =?us-ascii?Q?6EpFfqul2xYQlaMsWAB1Rg20dqBurEOl49VogdzjyMTbEGVLO4t/WsRgutP/?=
 =?us-ascii?Q?woYjgQsd2ywSuRvbZ0a8/HSGN0BUgetP/zB7f5nx6uW6Dskf+Um66buL9A5a?=
 =?us-ascii?Q?QvbBisMyfmzEAYZmu63Kz3bT3TNEmoXMjutUX2WweHU+mAtuGasHMBkaSagX?=
 =?us-ascii?Q?scGgQJxFuTBM0Zy5h5/7wTzSUNEwWok6Po9Zq8wVmFKZ69F7ER9Zly5k3Vog?=
 =?us-ascii?Q?U+f1Gnqkd1WacBrSSpJnXkJeuKgcrYjKSYZ1bDP/UQzXOFq8uxWSncco0PB4?=
 =?us-ascii?Q?AWRBRCb9ZFZWBZvu2HPvCTqfsTURivowCtNA3megIkN6NogQD/klSx+c5ANm?=
 =?us-ascii?Q?arP/YgkmlZ2dty9OeQOmsHMIQ0lIrfViYXtSdBxWEA7FcC9iERvqMUi8ziRJ?=
 =?us-ascii?Q?sR188KJK9RuL0jfrOiEozIm6/NkxAKp5+oNgI6cdH4Y3wEVpVP6SYnppjJjF?=
 =?us-ascii?Q?AEu/2l4ALdm2w9Dhlacx/Y5k+mFZAsuCCauPoFr91WAonrpOqI1pKJ2b9tdT?=
 =?us-ascii?Q?0lNEU2vecPiG1GI0F75zEfjwdodsN0BmkLHipsnkD6/5HR0QtxU+aBqn/jMP?=
 =?us-ascii?Q?aVJyoRpSSKhw0JO4/fs2QZy4lK0BZdPaRXyZDsghHYuj8fyIhYfaLK5roEdF?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MdF0ZsSUP8F0xBlS9YsYd84k0/AHH7eiImKxlfXwneHGSj9FOGpiNiLPCz8KVABHnVp21Lzi+9H9roN+Fwa38IiaTdeaVZwzvWOtvsfgdTminq/hESIFc0z8rGbCsywjxsgPRmFU8buzoGhCFJNPwykZB25f6PYNkLxkQZ528N+POIJBxd8Sxvod14TKiVDxmY+F6WiNT+78+ugA4p95jQXZimLHhDydCNRDFMAMlM8jqE78ec49GBhy2FzxvyPjzyzdYdzFGoUDj3ryXxIYe7BbU0MKG2EYvFhMLuIaF+1fAWAUntmjwOnmsM13D7f2PGc95g4/26iY20jEm5X76lfTmNuDT5usYeEbYi0yRdFfLkbHd94aVW8OeK7ZBZth+v5N36ob2JqJPlZwh6CQeB0T87wQj8RZqRDK3dVs5I7z2UNChP/VPsqlqnG21dikwEOM8lG1oW6A2YIy2ZWqayqjHMEhjG58Cp5lUf84y8ichMEU3jwjO8hPo/HXAWuJyz5ROI1o1LYXwfRvilH4RAQ9kmVXch28CRYb0W49wMSn2Q9VR6T6WlGj+G1n5ILp+3Eutrqrd5Y49GfriRfWGopKp0qNlwg2iqgrq8FLhsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96893210-6270-4d3d-fa00-08dcd589f479
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 13:26:06.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUvKRicldct7WFtNg5EFFGAQdwkFV4/0HYhsObg9ZrwfjxaUH1wDwImQYA1O5FBGvO4cMrz6QApHw3MH3pN/VP9crLcUX5cEWU57cezlGSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-15_05,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=851
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409150102
X-Proofpoint-ORIG-GUID: NH5Cs_1UVCnzxsnXzKRJLKFsyR-r95D3
X-Proofpoint-GUID: NH5Cs_1UVCnzxsnXzKRJLKFsyR-r95D3

On Sun, Sep 15, 2024 at 04:14:21PM GMT, Dan Carpenter wrote:
> On Sun, Sep 15, 2024 at 01:38:40PM +0100, Lorenzo Stoakes wrote:
> > + get_maintainers.pl people for drivers/misc/sgi-gru/grumain.c
> >
> > On Sun, Sep 15, 2024 at 03:09:35PM GMT, Dan Carpenter wrote:
> > > On Sun, Sep 15, 2024 at 01:01:43PM +0100, Lorenzo Stoakes wrote:
> > > > On Sun, Sep 15, 2024 at 01:08:27PM GMT, Dan Carpenter wrote:
> > > > > Hi Linus,
> > > > >
> > > > > Commit 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in
> > > > > error case") from Sep 11, 2024 (linux-next), leads to the following
> > > > > Smatch static checker warning:
> > > > >
> > > > > 	mm/memory.c:2709 remap_pfn_range_notrack()
> > > > > 	warn: sleeping in atomic context
> > > > >
> > > > > mm/memory.c
> > > > >     2696 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
> > > > >     2697                 unsigned long pfn, unsigned long size, pgprot_t prot)
> > > > >     2698 {
> > > > >     2699         int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
> > > > >     2700
> > > > >     2701         if (!error)
> > > > >     2702                 return 0;
> > > > >     2703
> > > > >     2704         /*
> > > > >     2705          * A partial pfn range mapping is dangerous: it does not
> > > > >     2706          * maintain page reference counts, and callers may free
> > > > >     2707          * pages due to the error. So zap it early.
> > > > >     2708          */
> > > > > --> 2709         zap_page_range_single(vma, addr, size, NULL);
> > > > >
> > > > > The lru_add_drain() function at the start of zap_page_range_single() takes a
> > > > > mutext.
> > > >
> > > > Hm does it? I see a local lock, and some folio batch locking which are
> > > > local locks too?
> > >
> > > Ah...  No it doesn't.  It's the mmu_notifier_invalidate_range_start() which is
> > > a might_sleep() function.  Sorry for the confusion.
> >
> > OK so in conclusion it seems to be that Linus's commit introducing
> > zap_page_range_single() accidentally had smatch hit a might_sleep() via
> > mmu_notifier_invalidate_range_start(), but it should, in theory, have fired
> > due to page table allocations invoking the page allocator that might sleep,
> > but didn't, because smatch misses the below might_alloc() path...
> >
> > -> prepare_alloc_pages()
> >    -> might_alloc()
> >       -> might_sleep_if(gfpflags_allow_blocking(gfp_mask))
> >
> > ...as a result of get_zeroed_page() tripping it up *breathes*. :)
> >
> > (please correct me if I am wrong here).
>
> That's an accurate summary...

Thanks!

>
> >
> > The preempt_disable() is introduced in commit fe5bb6b00c3a9 ("sgi-gru: misc
> > GRU cleanup") from... 2009, but it fixed it from the far far more broken
> > 'disable preemption before taking a mutex' situation that existed before.
> >
> > So fix seems to me to not invoke remap_pfn_range() with preemption disabled
> > and a mutex held? gru_fault() maintainers added for input...
>
> Every time I get a response to this bug report I feel dumber.  How did I not
> see that this was a bug in drivers/misc/sgi-gru/?  Here is another one from the
> same driver:
>
> drivers/misc/sgi-gru/grukservices.c:262 gru_get_cpu_resources() warn: sleeping in atomic context

Nothing to feel dumb about, this stuff is confounding by nature, if I had a
penny for every time I felt dumb doing kernel work I'd be very rich by now! ;)

>
> regards,
> dan carpenter

Cheers for report! This means we can now get this thing fixed...

