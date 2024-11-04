Return-Path: <linux-kernel+bounces-395534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467F9BBF32
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273851C210F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34C1F76C5;
	Mon,  4 Nov 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lu+S3bMv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oIZxFzqy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C041F76B7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754288; cv=fail; b=FFt+GHgHHAqJP2lh5oBMzAV0uZ/bxOQ/E3Ujdyf/DaItngpOjGiqQImIbmfvwzXkNsm2sIbHi/zbvpkoe0xrXLgFIP1sJDrdi0myB0zVdbi6MirmUkDj5Hq6BYG311x5ZFiJNe2uOQ6DkhBDzeIa8UuzKtVrPc52Vg0sIFpINSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754288; c=relaxed/simple;
	bh=ujxx696sPkZjFvUjEdEv+YafWhvDAvL9/fYpLfjM8mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBpx+baJaBGShARqvnPXiorKoidtnLlsKmdsKLSeT9yVwJ5Ic4G4ePt/onkoJGfjvSYO6M0oUsBqYW1emoKoGIp7WSF+F3SPfc7Mh2J/HeQFVO36hcWbTbZ5aJTwD4HizvxQOGTJu7AhgA7FNy++D+qMmuQOFCe/ILyQ+JC8Z6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lu+S3bMv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oIZxFzqy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KMafk008279;
	Mon, 4 Nov 2024 21:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p29hU9Wd2D7TY1kVEB7aCtmEGUAO362elgpSCQ/iu1g=; b=
	Lu+S3bMvTMpONU+QDvzXEJ9CKgnic/vIYuBaPsK/I+pvrB5p9KjnNk/bBFghwDUA
	8bDgxLZdxV4uIC2OFqgkPXVkrX98dwXClEcaA08mTwudslTiGPX7cx6sxfs57ofY
	tGHJnopxrt1pnx/e/l8R7e0DGfZ13nITUmguOz4ll0Xx8wQkzBsXsKUpoFwih9NG
	4Uxh7mOyE5AJiaeLWouCyGlSqJt4uwLkaNzqujnyyl3batjwtLP+q0bllUyodnGn
	4t8OxPYcC6l7bfZzpEq7kN3gDT+McPC3pH/eXcyARs83vIBnNwPYcQJfPkbpNtUK
	m0iK0yjOVvPUKjR//NZgHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0cbve9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 21:04:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KiNnG008558;
	Mon, 4 Nov 2024 21:04:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah6a8b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 21:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3hc79sVxlA8Qq7pLHkcLEZkb3mlomazOiF2RHdUqeIlosB71LXjCOsX8ERM5dEYRsHWsU2OFF0ZNoY/A9Vi0GmlM3H4octEnq4uQ2mS6qMLALpA0Fec4cusvngsCWqiuhsaWjrjmtCKTuQLvZaqMEtQ/zVPyq3nMeFOkt2kgkKAlsfE6VlYMMRE0mnlV3ObvbDQYAnI7DkB3KGR2y6egW/3MewYit8bqEn48ZeTCys+UFgrY0NwraiFJM6nqWHkgam89OZW/V8zYigcV/TlIW6vhQ/vSXD1pa1Qh+wckne9D9e4ynwjVyRqm9UBvoYXAql00tC7NLi8vFO9DIpHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p29hU9Wd2D7TY1kVEB7aCtmEGUAO362elgpSCQ/iu1g=;
 b=E2DWCJLchFXx1vp8bfeO7Nlo8ZYNaZW/1ZaGN6QaYfQQlOVSF6q0VZqZUQKD6odAuEt0Z//Hvai4NEXVCoewkXcpRw+HaGAlPIfYTjnmpXIJqnKJqyMnWt+21ctiZbUpApl6xgNMwAm/uq84rGsckMgCFhFElu8RiMOGQor1775vjxmlnZnLcjOFk0vVu8dl3w1OSqnk1lcRh8ZXPtv+XMXB+QW16Hh5ppCKp7mRslzAPQHfhMOLyr26zvkPkB265ASnzkvEwq0VYFd48CZpVPM+xzK7ix0cifNoaskfzDe44qL5SIf/huidfXBwv9MWJqbbdQtlEwsDOyZxuMcwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p29hU9Wd2D7TY1kVEB7aCtmEGUAO362elgpSCQ/iu1g=;
 b=oIZxFzqytGGHlqw8r4rZETccKFPyfVt/XZtHmRNL+TAGSkuO/L4jIkOrQfubKQCAQmYPxevGqJuLBc2X92M4BSazoKf699czVtzCkyegBnvsFqgJTY1Lk19qNpOXzYJMoBjqNGA2vMi4KDM31cQxXMYciqWb0QSQ/uqBVF06CJA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7442.namprd10.prod.outlook.com (2603:10b6:208:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 21:04:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 21:04:20 +0000
Date: Mon, 4 Nov 2024 21:04:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <03cc76df-8814-4d0a-83a6-447212ef2370@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAJuCfpEo2RyBLpariVgKBjQrZxdHuhMCgOGYfESZsYOPMD5vBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEo2RyBLpariVgKBjQrZxdHuhMCgOGYfESZsYOPMD5vBw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0271.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 164f142e-5107-4309-36b5-08dcfd143fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmdHaEF4ZXRiSjhUb2ZjTFlzRWFGRkpaVHZqNkRDbGRuT0MvVnZoQmJSTW4w?=
 =?utf-8?B?YW81Y29oWFFpRVoxVVozaFY3UWF6QWpuNzEzZkRXamlXdDVIODU4RER6ZnZK?=
 =?utf-8?B?N3VhaFJ1clpkNzZmeDFHZ2IxUVZSQ2E0eGQxSEdsZG9OQ2M1Tzhva3gvY3Ew?=
 =?utf-8?B?Z3RkZjY3c0dYTWV6ZVBWRVVHWXV5L2YyaUNHSTVmcFRHMGlzRlE1WkJjRmo5?=
 =?utf-8?B?clZvYkh3MXJRM1piaWZ5UUZXZFJQbEVrQVV6MFBJQzB4ZmJwYS85dUREcnF2?=
 =?utf-8?B?UmovNU1zTXVUa2hqZXZBZ0JqR1BZWURxNnpVTkVkTE54MEJLYzJrbXU1UnV0?=
 =?utf-8?B?QVltYjl6MzJPSkVUZTA0aGFVOUVpQzRHSmxGQWVNZC9VbkxtcmxjTFRGUDFj?=
 =?utf-8?B?bWpiVlVydXFsR0Q2bHZUeVAxTm4xTnpBUnhFVURrU2R6akJmTHlpaXlQTEJC?=
 =?utf-8?B?dmx4Ry82NWI1T1h4SU1Mc0dPRFFJSjJOMkMweUNBTFhuMGFHRVdiT0RQQTNu?=
 =?utf-8?B?TmJjYmJqck9mOEFZcTNVdFZ6bjYwQnpPdDh5UVlvblkxZkZGTUo0VlREYUdR?=
 =?utf-8?B?WlVHVC83dHdlcW4xdlZvVUFjWWI0MC82bEtjUW4wMjhEaFozNE14U1cyRnRD?=
 =?utf-8?B?RjhGKzNVYUxyd1N4WFhaS1lPTG5xTHBkYUhOclBiR0lod016WDg0ZDNIZUZ0?=
 =?utf-8?B?elNaSjk5YktaMkZyNzdGa05DY3dmemtqYlhNZ3VuUS85UkU2Um9ZdGplUi9F?=
 =?utf-8?B?Yi9rY0ZQNTIzcGoxYWpVenc4bk5Xd3ZoNXhQRURaM0NucE9Fblo5d2dkOUlC?=
 =?utf-8?B?czF2Q1VsV0RNaGIrWFFVazIraUZhZlh5eDRWMURycmFrNjBDTnNIQmZSN1No?=
 =?utf-8?B?Yk9KUjdtSTdvSjFiOFZqek83bXgwdkFyUjNtRVMwTjRtVmlTZFQ3NTZsd25G?=
 =?utf-8?B?TEc4L2liZlNOVVV6aG1XeDFUSzEyS2V6bTFBaHkxKy9oTW52QXVoTWI1cUpq?=
 =?utf-8?B?Zk1VdHl3VWl5eFg2WjJ3N2FSVXRWQWQ2MFE5WG1pZ1dzSHluaHdjVjg5S3Rn?=
 =?utf-8?B?ZXREWmpKL0NjN1lFdVFrLzdkUks0VnZJeC9JRDd3L1QvNkcrWU0rSENPQUNR?=
 =?utf-8?B?TU1WVjJHY3BFNEI0SzAwSEFyK2NHL1FyN1JuMWdXbStUalNhSEZCL2pMMS9E?=
 =?utf-8?B?NjlBanc4QXJ6bytNclBjWERmWExObDdtNnYvYTkvNHNxeTBaTXJjSHZjQUtB?=
 =?utf-8?B?Q3R1RjZ4SE9DeXRwMGRCWlJ6UjlON3hTTUIwRHMrZjdDdENzZThlZ29PNTND?=
 =?utf-8?B?bEdKUDU1b1JQaDZWcjlwNWpmR3BVM1QxQ1NzUnNoeHl3b1p5WVJPbFpHZTJh?=
 =?utf-8?B?ZkR0WFJScDJRcGVZN1p0N3lxUjFjSmpaMTVPKzBzTnJLckhIYzh0WmtsUUZh?=
 =?utf-8?B?RldOSm51NGR4WEF6RXMvZHpmazg1eEdZc2xwV1U1WVZSTzdNbU80L1BoMnBF?=
 =?utf-8?B?WStJdlkzSGt5RFFkcGQ1dUEvZTdFY0J1SmVsT09wZTBlNG9rSExmSnE3TlUx?=
 =?utf-8?B?UE93dWltc01SVytBcE04NGZmOTNCaXEyT2RacFFabzNLYUxLVXQ4dHJWWDZQ?=
 =?utf-8?B?T290MDBlMVcrSU9wRW5vUlg3NnlzdVY2UElRQkFsZlY3Yyt6bGw0MkhVb2kr?=
 =?utf-8?Q?DwKrl6pdGbEnLkYoycm1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkpvYVdOQjJCVU11clF4WUM0N3ZSVmpsZm5ZSHNBc1ZaT0FLaGVnRGV3YnVH?=
 =?utf-8?B?aTdiMkE5Z01NekJpRHNmdG41VlVRaGlsMUVWZlpLQmoycGQ3bGdBZlpIYUt1?=
 =?utf-8?B?eXd3d1I5czhrTEc1eDJzSkN5UGJSUlNMZVYwY3ZRNnhaYWZiRDhZaTFMT3Vj?=
 =?utf-8?B?VG5qang1WEJTY3dNcFVvQVNJc05YaGRmVmdIVFlWZ0NINTBYZDBiUHZDdWtv?=
 =?utf-8?B?STZTbDhoaWE0RFdWVUZHVDJ2TTNxL2VIY3B3b2Vobmk2MWYyNEdwdkVlQkdY?=
 =?utf-8?B?UVhmVnd1UkRTY2RzN0Z0WTkxTXlMZkRVcXVIa1dxSHplWVppRUt3NVZLTTNU?=
 =?utf-8?B?Y3N1WUYrRzVZS1pkaWRFMnJlb25rdmZ2TGxKcGtTMHUxMjhHTGdHdk42SWFa?=
 =?utf-8?B?Vm9rQ252V1haS1ZxQTBuYlpzZG5zV05wVlk2MHIzYlpkU2NNbkRrTmF0Slds?=
 =?utf-8?B?RGQ1OU5GSFpDQVRwQUFEZmRaSlZkV3FlUm95TUNaeTd6SEFEai83d0tYOGg5?=
 =?utf-8?B?Uk44U2g2ZlYwTTJnZysvN1p1Q3hhWjhEYlB0cmdrb3JiTklJS24yZ254cWpz?=
 =?utf-8?B?NUZDdnRwaTFWbTR0RjR3dE0ySm95dzNuNWl2aGNyckJKZ3RsR1pWUjY4b1Vv?=
 =?utf-8?B?MXU2eWY2SzdHOGdMSyszMlFWdnBldS8vZHc3RjBhYTJrZDV5WEM1emQwUmly?=
 =?utf-8?B?Z0pmRUJ4elhiUGpKQ3d0aEVRNUh4ZEJsT2VQeUY4b21YMkxCWVlhb3lmeHhS?=
 =?utf-8?B?U1I1SzZ5c2dpQkdEcnNZa0FNeDBMVHlqeTlRN1ZnaGZuaEdFOFAvb3NxMGNG?=
 =?utf-8?B?TXkybzJnNXdldFNrNGxuRTl0by85MGF0M09vd04wNVluR2FtUDRLdHdkd2ZG?=
 =?utf-8?B?dDcxcGlnZ092MUtkQkhRN1FybzVnVUtibUxianBvNkFaTzRvTEZVNVpHMEZ4?=
 =?utf-8?B?Tm9WRnpHdmdkSXZQZFp5dENFNEdxUGFpdnQrdDNHaXZENkdBRWFqckNSdG5l?=
 =?utf-8?B?RU9lYTJlWDNTU3FiMmVhdkhQVG5vYXVKaEpqVUF1bmhSNHN5VUY5Q1lmNGRI?=
 =?utf-8?B?ZUJRMXNRZDl5QkJpMDVpTzNENlVEYmpEVlZwMkxBUTlMUWlpSEZBTjBZWnZs?=
 =?utf-8?B?U0JVMjI5QUx3RjdLV0l3U0hIbW1TNnRjaGViY3dmaEFYdU0yeDFjUEQ5L3VX?=
 =?utf-8?B?M2FhNVV1RmxqTUxtdHc3dVBtbkI0Uy9LVnNZdWROamorQW4xMFdFRlNlandm?=
 =?utf-8?B?NjNRZFZPbTlWbDNPV3k1aXY5V1ZKU2VHbk1tWVlTZm5wLzcxcE1Qa0JseVI4?=
 =?utf-8?B?emxpZEZGL0dZaWIxU2JaYzNzRmtPUVZ5V2hPZlAzc1NreTN1VzNBZmROL2VS?=
 =?utf-8?B?N1JOS3RWb2YvR3lIV1ZNNFBaQXhxN250SUNZUXNzTm1uN0VkV1pDRnRpbmVw?=
 =?utf-8?B?QVdWWGZEZVFBMmIvYWdKQVR0bzlmTmYzUWtXSjY5M1R0eUdHaUd3ME1YWFJp?=
 =?utf-8?B?NkllQWpxVUxVQVQ3eVM1OU9MQUk2dGFSN3BsTW9RcUtHRkhFMUtjODh5WXU0?=
 =?utf-8?B?Z3BMS3hheDJjMWpNZ2hrdlNHUFBFbmlWWDNpSG04UjlDMFJFTHpCTHVxTkd3?=
 =?utf-8?B?aHo5VGhsclN6amppMEp3bGUvMUpUcWVPbE52UWUyS2JkbFU3YnNLUVJCK1JV?=
 =?utf-8?B?QUYrLzAyalM4RlNWdGtHazlPOWFNOU5lSlpIYldsQlVnTTIrczF0WmtoV1JI?=
 =?utf-8?B?RmtOYTVUelpXTndhQzVxK3ZFc3ZtVlBiM3dUKzkxaWFxYjlLWm0yN2l2emgr?=
 =?utf-8?B?ZlFiVEZaVnpJY3paamw2MCttUEFiUU1rK0J1dkhzTCs5SFVvVSttV3F4b3pu?=
 =?utf-8?B?Nk1wT3NJcW0xZG5DSkFhakRxRW9waWxWZUl3WkhiVng5TGxMSWRIZEVZUTNH?=
 =?utf-8?B?SFRuODV4d1Q1T2JHRnFQQStBbHRsL0hyNlQ1YUthelNiUVY4YWpqcnpxbjRu?=
 =?utf-8?B?Nm5OVWdYN1dXVlpDT1hjMThpelFLWHVYY0kvRkthQkJXalR1Z3h1dE9FdmRv?=
 =?utf-8?B?ZUVNSE9vb0ZaOGVZQ3FQZ3hZUndqSW81Uk1la2h5cEhRTURReHVLaW1SZUNz?=
 =?utf-8?B?c1pKcUN1WWd0M3JXUzBRWjc0UE1qa0grdjR0RTA5TDhobmF5TVJGVnBadWRu?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vgKylA7by0bQrb/eKbWmsjQU6qQRzdqAqJS2tOFvVDoLkEN4+o7VncfFDrXPyd8OdGLIsySllYOQmIkWuc6mtxM68uw9fGwPan31S4cdW1hjYahEof0773Qbj+Cgk8B7QiTh9inCx36URo/DMhjjvlXaHmhRL8BWDvnRo4d8sZCgzJpRQ75AUkQB39O9PwX4sw2n04p9KpSvdp3QlDNcLkac2IFgMfDy8nwC6EDIQlkBTHGElJR0/X1Oz56bIgaqC2egUvxkezMC4RiZVhCX2Z9rOtuiQOkzLQhimz5TSDUKsOaqtgWTXWx2/R3TtRS44PFyAkSFxI8AYIxIqc9alAvKwYG3xonPUicJVwZrALTTAMOHQXuiUJOr7ozeWywFNyCgaApKipaJaaaUM5h8FV5/wo0iuj8/b6QLa1+/2TPeNc/TvkXmoY6jXjUO4pPaXCkbTxdEDSp7v+25z6T9RqJIETkD3AJ8M4XGmmyVwuZQxgkIIDGZPMHgyHVL/ese9N/siEbMIkLLEauS32b2vgt45L5nkvqGtVFQ/G9lH7n1mpd0hZq7Xl6b+jpOUNUBNf7NmA4H7TIBh/HjVVBI2AhkIuRpsrCO80E7vObry7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164f142e-5107-4309-36b5-08dcfd143fcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 21:04:20.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNraD4MvkuVTNKxJrPl1NEGECm3Pe/SIaE2oEvLtckYFo7p6or2KqMmgMkBZQqXN9NEZU7qgqD4pe6GqlzcD+xzfg4DfzJx66gpyCgFh62k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7442
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_19,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040170
X-Proofpoint-ORIG-GUID: MwNb6tyVda5WVQ42hFO5MBA3pDTy2Cop
X-Proofpoint-GUID: MwNb6tyVda5WVQ42hFO5MBA3pDTy2Cop

On Mon, Nov 04, 2024 at 09:01:46AM -0800, Suren Baghdasaryan wrote:
> On Fri, Nov 1, 2024 at 11:51 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be interacted with when it comes to interacting
> > with mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards efforts to find sensible
> > abstractions for these fundamental objects within the kernel rust
> > abstraction whose compiler strictly requires some means of expressing these
> > rules (and through this expression can help self-document these
> > requirements as well as enforce them which is an exciting concept).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> > The document also provides some VMA lock internals, which are up to date
> > and inclusive of recent changes to recent sequence number changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks for documenting this, Lorenzo!

No worries, I feel it's very important to document this at this stage.

> Just heads-up, I'm working on changing some of the implementation
> details (removing vma->detached, moving vm_lock into vm_area_struct,
> etc.). I should be able to post those changes sometime later this week
> if testing does not reveal any issues.

Ack yeah we can update as we go, as for removing vma->detached, how are we able
to do this?

My understanding is that detached VMAs are ones that are being removed (due
to e.g.  merge/MAP_FIXED mmap()/munmap()) that are due to be RCU freed (as
vm_area_free() does this via call_rcu() so delays until grace period), but
which have been VMA unlocked prior to the grace period so
lock_vma_under_rcu() might grab but shouldn't do anything with + retry.

Will there be a new means of determining this?

Anyway... we can update as we go :)

>
> > ---
> >
> > REVIEWERS NOTES:
> >    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
> >    also uploaded a copy of this to my website at
> >    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
> >    read through. Thanks!
> >
> >
> >  Documentation/mm/index.rst     |   1 +
> >  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
> >  2 files changed, 528 insertions(+)
> >  create mode 100644 Documentation/mm/vma_locks.rst
> >
> > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > index 0be1c7503a01..da5f30acaca5 100644
> > --- a/Documentation/mm/index.rst
> > +++ b/Documentation/mm/index.rst
> > @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
> >     vmemmap_dedup
> >     z3fold
> >     zsmalloc
> > +   vma_locks
> > diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_locks.rst
> > new file mode 100644
> > index 000000000000..52b9d484376a
> > --- /dev/null
> > +++ b/Documentation/mm/vma_locks.rst
> > @@ -0,0 +1,527 @@
> > +VMA Locking
> > +===========
> > +
> > +Overview
> > +--------
> > +
> > +Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
> > +'VMA's of type `struct vm_area_struct`.
> > +
> > +Each VMA describes a virtually contiguous memory range with identical
> > +attributes, each of which described by a `struct vm_area_struct`
> > +object. Userland access outside of VMAs is invalid except in the case where an
> > +adjacent stack VMA could be extended to contain the accessed address.
> > +
> > +All VMAs are contained within one and only one virtual address space, described
> > +by a `struct mm_struct` object which is referenced by all tasks (that is,
> > +threads) which share the virtual address space. We refer to this as the `mm`.
> > +
> > +Each mm object contains a maple tree data structure which describes all VMAs
> > +within the virtual address space.
> > +
> > +The kernel is designed to be highly scalable against concurrent access to
> > +userland memory, so a complicated set of locks are required to ensure no data
> > +races or memory corruption occurs.
> > +
> > +This document explores this locking in detail.
> > +
> > +.. note::
> > +
> > +   There are three different things that a user might want to achieve via
> > +   locks - the first of which is **stability**. That is - ensuring that the VMA
> > +   won't be freed or modified in any way from underneath us.
> > +
> > +   All MM and VMA locks ensure stability.
> > +
> > +   Secondly we have locks which allow **reads** but not writes (and which might
> > +   be held concurrent with other CPUs who also hold the read lock).
> > +
> > +   Finally, we have locks which permit exclusive access to the VMA to allow for
> > +   **writes** to the VMA.
> > +
> > +MM and VMA locks
> > +----------------
> > +
> > +There are two key classes of lock utilised when reading and manipulating VMAs -
> > +the `mmap_lock` which is a read/write semaphore maintained at the `mm_struct`
> > +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock at the
> > +VMA level of granularity.
> > +
> > +.. note::
> > +
> > +   Generally speaking, a read/write semaphore is a class of lock which permits
> > +   concurrent readers. However a write lock can only be obtained once all
> > +   readers have left the critical region (and pending readers made to wait).
> > +
> > +   This renders read locks on a read/write semaphore concurrent with other
> > +   readers and write locks exclusive against all others holding the semaphore.
> > +
> > +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a write
> > +mmap lock gives you exclusive write access to a VMA, and a read lock gives you
> > +concurrent read-only access.
> > +
> > +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> > +complicated. In this instance, a write semaphore is no longer enough to gain
> > +exclusive access to a VMA, a VMA write lock is also required.
>
> I think "exclusive access to a VMA" should be "exclusive access to mm"
> if you are talking about mmap_lock.

Right, but in the past an mm write lock was sufficient to gain exclusive
access to a _vma_. I will adjust to say 'write semaphore on the mm'.

>
> I think it's worth adding here:
> 1. to take a VMA write-lock you need to be holding an mmap_lock;
> 2. write-unlocking mmap_lock drops all VMA write locks in that mm.
>
> I see that you touch on this in the below "Note" section but that's
> not an implementation detail but the designed behavior, so I think
> these should not be mere side-notes.

Right yeah I do mention both of these, but perhaps it's worth explicitly
saying this right at the top. Will add.

>
> > +
> > +The VMA lock is implemented via the use of both a read/write semaphore and
> > +per-VMA and per-mm sequence numbers. We go into detail on this in the VMA lock
> > +internals section below, so for the time being it is important only to note that
> > +we can obtain either a VMA read or write lock.
> > +
> > +.. note::
> > +
> > +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu()`
> > +   function, and **no** existing mmap or VMA lock must be held, This function
>
> "no existing mmap or VMA lock must be held" did you mean to say "no
> exclusive mmap or VMA locks must be held"? Because one can certainly
> hold a read-lock on them.

Hmm really? You can hold an mmap read lock and obtain a VMA read lock too
irrespective of that?

OK, my mistake will update this and the table below to reflect this,
thanks!

Also I see that this part that was in a 'note' section is probably a bit
wordy, which somewhat takes away from the key messages, will try to trim a
bit or separate out to make things clearer.

>
> > +   either returns a read-locked VMA, or NULL if the lock could not be
> > +   acquired. As the name suggests, the VMA will be acquired under RCU, though
> > +   once obtained, remains stable.
> > +
> > +   This kind of locking is entirely optimistic - if the lock is contended or a
> > +   competing write has started, then we do not obtain a read lock.
> > +
> > +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()` to ensure
> > +   that the VMA is acquired in an RCU critical section, then attempts to VMA
> > +   lock it via `vma_start_read()`, before releasing the RCU lock via
> > +   `rcu_read_unlock()`.
> > +
> > +   VMA read locks hold the a read lock on the `vma->vm_lock` semaphore for their
> > +   duration and the caller of `lock_vma_under_rcu()` must release it via
> > +   `vma_end_read()`.
> > +
> > +   VMA **write** locks are acquired via `vma_start_write()` in instances where a
> > +   VMA is about to be modified, unlike `vma_start_read()` the lock is always
> > +   acquired. An mmap write lock **must** be held for the duration of the VMA
> > +   write lock, releasing or downgrading the mmap write lock also releases the
> > +   VMA write lock so there is no `vma_end_write()` function.
> > +
> > +   Note that a semaphore write lock is not held across a VMA lock. Rather, a
> > +   sequence number is used for serialisation, and the write semaphore is only
> > +   acquired at the point of write lock to update this (we explore this in detail
> > +   in the VMA lock internals section below).
> > +
> > +   This ensures the semantics we require - VMA write locks provide exclusive
> > +   write access to the VMA.
> > +
> > +Examining all valid lock state and what each implies:
> > +
> > +.. list-table::
> > +   :header-rows: 1
> > +
> > +   * - mmap lock
> > +     - VMA lock
> > +     - Stable?
> > +     - Can read safely?
> > +     - Can write safely?
> > +   * - \-
> > +     - \-
> > +     - N
> > +     - N
> > +     - N
> > +   * - R
> > +     - \-
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - \-
> > +     - R
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - W
> > +     - \-
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - W
> > +     - W
> > +     - Y
> > +     - Y
> > +     - Y
> > +
> > +Note that there are some exceptions to this - the `anon_vma` field is permitted
> > +to be written to under mmap read lock and is instead serialised by the `struct
> > +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
> > +lock-specific fields are permitted to be read under RCU alone  (though stability cannot
> > +be expected in this instance).
> > +
> > +.. note::
> > +   The most notable place to use the VMA read lock is on page table faults on
> > +   the x86-64 architecture, which importantly means that without a VMA write
>
> As Jann mentioned, CONFIG_PER_VMA_LOCK is supported on many more architectures.

Yes, have updated to say so already. Sorry I was behind on how much this
had progressed :>)

>
> > +   lock, page faults can race against you even if you hold an mmap write lock.
> > +
> > +VMA Fields
> > +----------
> > +
> > +We examine each field of the `struct vm_area_struct` type in detail in the table
> > +below.
> > +
> > +Reading of each field requires either an mmap read lock or a VMA read lock to be
> > +held, except where 'unstable RCU read' is specified, in which case unstable
> > +access to the field is permitted under RCU alone.
> > +
> > +The table specifies which write locks must be held to write to the field.
> > +
> > +.. list-table::
> > +   :widths: 20 10 22 5 20
> > +   :header-rows: 1
> > +
> > +   * - Field
> > +     - Config
> > +     - Description
> > +     - Unstable RCU read?
> > +     - Write Lock
> > +   * - vm_start
> > +     -
> > +     - Inclusive start virtual address of range VMA describes.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_end
> > +     -
> > +     - Exclusive end virtual address of range VMA describes.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_rcu
> > +     - vma lock
> > +     - RCU list head, in union with vma_start, vma_end. RCU implementation detail.
> > +     - N/A
> > +     - N/A
> > +   * - vm_mm
> > +     -
> > +     - Containing mm_struct.
> > +     - Y
> > +     - (Static)
> > +   * - vm_page_prot
> > +     -
> > +     - Architecture-specific page table protection bits determined from VMA
> > +       flags
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_flags
> > +     -
> > +     - Read-only access to VMA flags describing attributes of VMA, in union with
> > +       private writable `__vm_flags`.
> > +     -
> > +     - N/A
> > +   * - __vm_flags
> > +     -
> > +     - Private, writable access to VMA flags field, updated by vm_flags_*()
> > +       functions.
> > +     -
> > +     - mmap write, VMA write
> > +   * - detached
> > +     - vma lock
> > +     - VMA lock implementation detail - indicates whether the VMA has been
> > +       detached from the tree.
> > +     - Y
> > +     - mmap write, VMA write
> > +   * - vm_lock_seq
> > +     - vma lock
> > +     - VMA lock implementation detail - A sequence number used to serialise the
> > +       VMA lock, see the VMA lock section below.
> > +     - Y
> > +     - mmap write, VMA write
>
> It's a bit weird to state that VMA write-lock is required when talking
> about vm_lock_seq/vm_lock themselves being parts of that lock. I would
> simply say N/A for both of them since they should not be modified
> directly.

Ack will adjust.

>
> > +   * - vm_lock
> > +     - vma lock
> > +     - VMA lock implementation detail - A pointer to the VMA lock read/write
> > +       semaphore.
> > +     - Y
> > +     - None required
> > +   * - shared.rb
> > +     -
> > +     - A red/black tree node used, if the mapping is file-backed, to place the
> > +       VMA in the `struct address_space->i_mmap` red/black interval tree.
> > +     -
> > +     - mmap write, VMA write, i_mmap write
> > +   * - shared.rb_subtree_last
> > +     -
> > +     - Metadata used for management of the interval tree if the VMA is
> > +       file-backed.
> > +     -
> > +     - mmap write, VMA write, i_mmap write
> > +   * - anon_vma_chain
> > +     -
> > +     - List of links to forked/CoW'd `anon_vma` objects.
> > +     -
> > +     - mmap read or above, anon_vma write lock
>
> nit: I would spell it out for clarity: mmap read or write

Ack will fix

>
> > +   * - anon_vma
> > +     -
> > +     - `anon_vma` object used by anonymous folios mapped exclusively to this VMA.
> > +     -
> > +     - mmap read or above, page_table_lock
> > +   * - vm_ops
> > +     -
> > +     - If the VMA is file-backed, then either the driver or file-system provides
> > +       a `struct vm_operations_struct` object describing callbacks to be invoked
> > +       on specific VMA lifetime events.
> > +     -
> > +     - (Static)
> > +   * - vm_pgoff
> > +     -
> > +     - Describes the page offset into the file, the original page offset within
> > +       the virtual address space (prior to any `mremap()`), or PFN if a PFN map.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_file
> > +     -
> > +     - If the VMA is file-backed, points to a `struct file` object describing
> > +       the underlying file, if anonymous then `NULL`.
> > +     -
> > +     - (Static)
> > +   * - vm_private_data
> > +     -
> > +     - A `void *` field for driver-specific metadata.
> > +     -
> > +     - Driver-mandated.
> > +   * - anon_name
> > +     - anon name
> > +     - A field for storing a `struct anon_vma_name` object providing a name for
> > +       anonymous mappings, or `NULL` if none is set or the VMA is file-backed.
> > +     -
> > +     - mmap write, VMA write
> > +   * - swap_readahead_info
> > +     - swap
> > +     - Metadata used by the swap mechanism to perform readahead.
> > +     -
> > +     - mmap read
> > +   * - vm_region
> > +     - nommu
> > +     - The containing region for the VMA for architectures which do not
> > +       possess an MMU.
> > +     - N/A
> > +     - N/A
> > +   * - vm_policy
> > +     - numa
> > +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> > +     -
> > +     - mmap write, VMA write
> > +   * - numab_state
> > +     - numab
> > +     - `vma_numab_state` object which describes the current state of NUMA
> > +       balancing in relation to this VMA.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_userfaultfd_ctx
> > +     -
> > +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, either
> > +       of zero size if userfaultfd is disabled, or containing a pointer to an
> > +       underlying `userfaultfd_ctx` object which describes userfaultfd metadata.
> > +     -
> > +     - mmap write, VMA write
> > +
> > +.. note::
> > +
> > +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LOCK,
> > +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'nommu'
> > +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab' means
> > +   CONFIG_NUMA_BALANCING'.
> > +
> > +   In the write lock column '(Static)' means that the field is set only once
> > +   upon initialisation of the VMA and not changed after this, the VMA would
> > +   either have been under an mmap write and VMA write lock at the time or not
> > +   yet inserted into any tree.
> > +
> > +Page table locks
> > +----------------
> > +
> > +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> > +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> > +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> > +
> > +.. note::
> > +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> > +   however at the time of writing it ultimately references the
> > +   `mm->page_table_lock`.
> > +
> > +Allocating a PTE will either use the `mm->page_table_lock` or, if
> > +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> > +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> > +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> > +
> > +Finally, modifying the contents of the PTE has special treatment, as this is a
> > +lock that we must acquire whenever we want stable and exclusive access to
> > +entries pointing to data pages within a PTE, especially when we wish to modify
> > +them.
> > +
> > +This is performed via `pte_offset_map_lock()` which carefully checks to ensure
> > +that the PTE hasn't changed from under us, ultimately invoking `pte_lockptr()`
> > +to obtain a spin lock at PTE granularity contained within the `struct ptdesc`
> > +associated with the physical PTE page. The lock must be released via
> > +`pte_unmap_unlock()`.
> > +
> > +.. note::
> > +   There are some variants on this, such as `pte_offset_map_rw_nolock()` when we
> > +   know we hold the PTE stable but for brevity we do not explore this.
> > +   See the comment for `__pte_offset_map_lock()` for more details.
> > +
> > +When modifying data in ranges we typically only wish to allocate higher page
> > +tables as necessary, using these locks to avoid races or overwriting anything,
> > +and set/clear data at the PTE level as required (for instance when page faulting
> > +or zapping).
> > +
> > +Page table teardown
> > +-------------------
> > +
> > +Tearing down page tables themselves is something that requires significant
> > +care. There must be no way that page tables designated for removal can be
> > +traversed or referenced by concurrent tasks.
> > +
> > +It is insufficient to simply hold an mmap write lock and VMA lock (which will
> > +prevent racing faults, and rmap operations), as a file-backed mapping can be
> > +truncated under the `struct address_space` i_mmap_lock alone.
> > +
> > +As a result, no VMA which can be accessed via the reverse mapping (either
> > +anon_vma or the `struct address_space->i_mmap` interval tree) can have its page
> > +tables torn down.
> > +
> > +The operation is typically performed via `free_pgtables()`, which assumes either
> > +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> > +parameter), or that it the VMA is fully detached.
> > +
> > +It carefully removes the VMA from all reverse mappings, however it's important
> > +that no new ones overlap these or any route remain to permit access to addresses
> > +within the range whose page tables are being torn down.
> > +
> > +As a result of these careful conditions, note that page table entries are
> > +cleared without page table locks, as it is assumed that all of these precautions
> > +have already been taken.
> > +
> > +mmap write lock downgrading
> > +---------------------------
> > +
> > +While it is possible to obtain an mmap write or read lock using the
> > +`mm->mmap_lock` read/write semaphore, it is also possible to **downgrade** from
> > +a write lock to a read lock via `mmap_write_downgrade()`.
> > +
> > +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA write locks
> > +via `vma_end_write_all()` (more or this behaviour in the VMA lock internals
> > +section below), but importantly does not relinquish the mmap lock while
> > +downgrading, therefore keeping the locked virtual address space stable.
> > +
> > +A subtlety here is that callers can assume, if they invoke an
> > +mmap_write_downgrade() operation, that they still have exclusive access to the
> > +virtual address space (excluding VMA read lock holders), as for another task to
> > +have downgraded they would have had to have exclusive access to the semaphore
> > +which can't be the case until the current task completes what it is doing.
>
> I can't decipher the above paragraph. Could you please dumb it down
> for the likes of me?

Since you're smarter than me this indicates I am not being clear here :)
Actually reading this again I've not expressed this correctly.

This is something Jann mentioned, that I hadn't thought of before.

So if you have an mmap write lock, you have exclusive access to the mmap
(with the usual caveats about racing vma locks unless you vma write lock).

When you downgrade you now have a read lock - but because you were
exclusive earlier in the function AND any new caller of the function will
have to acquire that same write lock FIRST, they all have to wait on you
and therefore you have exclusive access to the mmap only with a read map.

So you are actually guaranteed that nobody else can be racing you _in that
function_, and equally no other writers can arise until you're done as your
holding the read lock prevents that.

Jann - correct me if I'm wrong or missing something here.

Will correct this unless Jann tells me I'm missing something on this :)

>
> > +
> > +Stack expansion
> > +---------------
> > +
> > +Stack expansion throws up additional complexities in that we cannot permit there
> > +to be racing page faults, as a result we invoke `vma_start_write()` to prevent
> > +this in `expand_downwards()` or `expand_upwards()`.
> > +
> > +Lock ordering
> > +-------------
> > +
> > +As we have multiple locks across the kernel which may or may not be taken at the
> > +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> > +the **order** in which locks are acquired and released becomes very important.
> > +
> > +.. note::
> > +
> > +   Lock inversion occurs when two threads need to acquire multiple locks,
> > +   but in doing so inadvertently cause a mutual deadlock.
> > +
> > +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> > +   while thread 2 holds lock B and tries to acquire lock A.
> > +
> > +   Both threads are now deadlocked on each other. However, had they attempted to
> > +   acquire locks in the same order, one would have waited for the other to
> > +   complete its work and no deadlock would have occurred.
> > +
> > +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> > +locks within memory management code:
> > +
> > +.. code-block::
> > +
> > +  inode->i_rwsem       (while writing or truncating, not reading or faulting)
> > +    mm->mmap_lock
> > +      mapping->invalidate_lock (in filemap_fault)
> > +        folio_lock
> > +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> > +            vma_start_write
> > +              mapping->i_mmap_rwsem
> > +                anon_vma->rwsem
> > +                  mm->page_table_lock or pte_lock
> > +                    swap_lock (in swap_duplicate, swap_info_get)
> > +                      mmlist_lock (in mmput, drain_mmlist and others)
> > +                      mapping->private_lock (in block_dirty_folio)
> > +                          i_pages lock (widely used)
> > +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> > +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> > +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> > +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> > +                        i_pages lock (widely used, in set_page_dirty,
> > +                                  in arch-dependent flush_dcache_mmap_lock,
> > +                                  within bdi.wb->list_lock in __sync_single_inode)
> > +
> > +Please check the current state of this comment which may have changed since the
> > +time of writing of this document.
> > +
> > +VMA lock internals
> > +------------------
> > +
> > +The VMA lock mechanism is designed to be a lightweight means of avoiding the use
> > +of the heavily contended mmap lock. It is implemented using a combination of a
> > +read/write semaphore and sequence numbers belonging to the containing `struct
> > +mm_struct` and the VMA.
> > +
> > +Read locks are acquired via `vma_start_read()`, which is an optimistic
> > +operation, i.e. it tries to acquire a read lock but returns false if it is
> > +unable to do so. At the end of the read operation, `vma_end_read()` is called to
> > +release the VMA read lock. This can be done under RCU alone.
> > +
> > +Writing requires the mmap to be write-locked and the VMA lock to be acquired via
> > +`vma_start_write()`, however the write lock is released by the termination or
> > +downgrade of the mmap write lock so no `vma_end_write()` is required.
> > +
> > +All this is achieved by the use of per-mm and per-VMA sequence counts. This is
> > +used to reduce complexity, and potential especially around operations which
>
> potential?

Yeah sorry this sentence is completely mangled, will fix!

>
> > +write-lock multiple VMAs at once.
> > +
> > +If the mm sequence count, `mm->mm_lock_seq` is equal to the VMA sequence count
> > +`vma->vm_lock_seq` then the VMA is write-locked. If they differ, then they are
> > +not.
> > +
> > +Each time an mmap write lock is acquired in `mmap_write_lock()`,
> > +`mmap_write_lock_nested()`, `mmap_write_lock_killable()`, the `mm->mm_lock_seq`
> > +sequence number is incremented via `mm_lock_seqcount_begin()`.
> > +
> > +Each time the mmap write lock is released in `mmap_write_unlock()` or
> > +`mmap_write_downgrade()`, `vma_end_write_all()` is invoked which also increments
> > +`mm->mm_lock_seq` via `mm_lock_seqcount_end()`.
> > +
> > +This way, we ensure regardless of the VMA's sequence number count, that a write
> > +lock is not incorrectly indicated (since we increment the sequence counter on
> > +acquiring the mmap write lock, which is required in order to obtain a VMA write
> > +lock), and that when we release an mmap write lock, we efficiently release
> > +**all** VMA write locks contained within the mmap at the same time.
>
> Ok, I see that you describe some of the rules I mentioned before here.
> Up to you where to place them.

Yeah may rearrange a little in general to clear things up a bit.

I wanted a bit on the internals here, but then I end up mentioning so much
of this above that maybe it's a bit duplicative... let's see how I do on
the respin :)

>
> > +
> > +The exclusivity of the mmap write lock ensures this is what we want, as there
> > +would never be a reason to persist per-VMA write locks across multiple mmap
> > +write lock acquisitions.
> > +
> > +Each time a VMA read lock is acquired, we acquire a read lock on the
> > +`vma->vm_lock` read/write semaphore and hold it, while checking that the
> > +sequence count of the VMA does not match that of the mm.
> > +
> > +If it does, the read lock fails. If it does not, we hold the lock, excluding
> > +writers, but permitting other readers, who will also obtain this lock under RCU.
> > +
> > +Importantly, maple tree operations performed in `lock_vma_under_rcu()` are also
> > +RCU safe, so the whole read lock operation is guaranteed to function correctly.
> > +
> > +On the write side, we acquire a write lock on the `vma->vm_lock` read/write
> > +semaphore, before setting the VMA's sequence number under this lock, also
> > +simultaneously holding the mmap write lock.
> > +
> > +This way, if any read locks are in effect, `vma_start_write()` will sleep until
> > +these are finished and mutual exclusion is achieved.
> > +
> > +After setting the VMA's sequence number, the lock is released, avoiding
> > +complexity with a long-term held write lock.
> > +
> > +This clever combination of a read/write semaphore and sequence count allows for
> > +fast RCU-based per-VMA lock acquisition (especially on x86-64 page fault, though
> > +utilised elsewhere) with minimal complexity around lock ordering.
> > --
> > 2.47.0
> >

Thanks for the review! Will try to clarify and tighten things up generally
on top of the points you and the other reviewers have raised here and
hopefully v2 should be nice and sharp!

