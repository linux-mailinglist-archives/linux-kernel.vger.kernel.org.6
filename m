Return-Path: <linux-kernel+bounces-416988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F01F19D4D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE23D2839B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE321D7E46;
	Thu, 21 Nov 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ofZwaXTB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LjHEQk6B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B741C7B99;
	Thu, 21 Nov 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193996; cv=fail; b=VQ2iOM8TfyCwANEaKhPld9snUG5yspYnqnKKPiQ872lkzGnC+1Ktrg2cuYM1EMC8aX1bV9/kvSMFatfFWnLKqb0FsGmrnk4PpZWyBExn4g+h1YRCwJ7n+ea1aohm7ON8Kf4EZR9dNY4LoDQ719IwQ3RI8KnVq6mDlWhmSnyqL/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193996; c=relaxed/simple;
	bh=/Yp+11dpSJaSPqrHlYahRYCmfe4AmGPFeQ3o8ONGGXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YD/aVhupalbuoTTjU/NIsO27vbw2/5Jb9/HE+uvo4aCkZ64ot5zMu5YTmtA9olWdEF4DkmHVOA4PnriNwuq0ZuMKmF9YWAuhia2K2VymMJAacfLW6yvGi6Y9YMa2orWUsjuDt/VP+O1m0dgBNANLYzugrKirr9sR5nGU8B+TzmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ofZwaXTB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LjHEQk6B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCtfWs028984;
	Thu, 21 Nov 2024 12:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F7o7dvrTSfr8DJq9rcsQScqWZOnCfnT2ljT6T4ENeTE=; b=
	ofZwaXTBssu03coWJ6i0Z+SF+IgKFmluzmd6xgK/qv46wNP3HawniPX/nOqckXkY
	fKd0lildxRVrvQ7ZN3andIV+OmX9hH2CplqaE/fdc5TG1ksEe5LWTewqn8m2y94w
	cbf7zaZGfa6Digj7m7N6WKJy2ZYYHlWRmswSVuIIP0tIzUYGUIO90mMc9XlK6d0X
	Ho/Y74UDxyQLsoll8QtoQHPKLsyElOe8gSF2RpUIA1M2THxOY17dNWG8UoHzlCn4
	cI0kQAnzbiCLx3SWqgJ0MvRjOagoKZpB4wu5W1mCY6TplRi4cK7fcXPEdaCGcdkX
	aybS6OgUXmGUQ+Jsf1HLng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc9kja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:59:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCSc0A008449;
	Thu, 21 Nov 2024 12:59:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubmdd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 12:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOonCkOgyvUw59xPpxNYDJOrSsJ7buTjnvs6OzDM3m/GxrUFCT7SW86rKKatfSVKXb9M3W3e0Hz89p1GGsQH7z9QEyMpa7NaWJ5MqIieqjh42VV8EyXxkMC1hOPk1vk8/vPtfpElwJ1ZaxRXplYgrfeoyF9cRqCZN914T19a22zRAyEms8W7Xi08pm0O/KIU83gAPR04caQYA+TQ3rjy8Nnt8o4W9IH1v4TWmaOU6Ba1xNbLm1dp+BSrsYGtio+bgw1ychumBdjpn597haoGLAF+zF9HrFX/kAsAxiPifnJuPv1vz3vIjZSoi20iPEP2Hao14TT76ybjIj4CWv1lrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7o7dvrTSfr8DJq9rcsQScqWZOnCfnT2ljT6T4ENeTE=;
 b=JCQqCpGGnv97+W5TlXWjhsQdVwTJQUXAO/0/2chY5WqFc2gInhNNtBnwik1cJvc/fo+Ty8MmvwIcEaZQbu0KjM/3nvbJMairtyMZNHBdGCQXFARyARieuablaFofEshjb2DtlaMwKfFlFxF+D1amJsCY8updxoZxL8NWFb8AA4BlUl1gVT6e37M1MogtFGx2seqMe6/x2UzXZA6nxmnSgBp+wsZUuKPl6+/Oq1b7s7DRiZPgkiGHrk3bjrypWZ+E1OSaKm9/MiJGlCeR2ypqQrCKWbNeb4hfFMEzvzwBLbdgmjK7Xsuvh4XxaQeAyPRXVesilFa3jtLOU5CoXXsW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7o7dvrTSfr8DJq9rcsQScqWZOnCfnT2ljT6T4ENeTE=;
 b=LjHEQk6Bn0ECyPa9oTJ4SjJhdymeaDwnyG95QLJxjqTySX+Sxy7clg2u06eNtcNrghUwoZrPOHcWCjIo00Dqx6ZTPSWwo394z5ob7nkfYvzPpTkTfg5vhesjSEFQtEmcZyYgmZBx2R6yhpdkXtqauierktMa5J1xGTE4h3fChb4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4197.namprd10.prod.outlook.com (2603:10b6:610:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 12:59:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 12:59:25 +0000
Date: Thu, 21 Nov 2024 12:59:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 4/7] mm: rust: add lock_vma_under_rcu
Message-ID: <fe7056d9-ad54-48a5-912c-ba19ba7c09d3@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-4-eb31425da66b@google.com>
 <40be19b0-4c32-4554-a01f-649c12f889da@lucifer.local>
 <CAH5fLggw4Ca59-AA+ArHYD0QrKH8cGd_i0EN83MnYYZK1bmTGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggw4Ca59-AA+ArHYD0QrKH8cGd_i0EN83MnYYZK1bmTGQ@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4197:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6e3eb8-5701-46d7-d63f-08dd0a2c5389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTgxajZudk1CMnRWUm45MGNiSmx3OUM2TlFaaFFzNXh0eDFJbGZ4TGg4dnFC?=
 =?utf-8?B?aGpUMERwT29UMlhMVHloejJsbjFqa1F2Y211Rnk4YXhabmtXMGFLeWp2SmI2?=
 =?utf-8?B?a3J6NVFZSk5wQzl1VzdibTlUMWFzb0V4aWdtOVlkc1JTVDFPdDgxSHNLUy9O?=
 =?utf-8?B?eVZRVDgvRk5pNkptdVlTYjl5SEZhU2F5SElDODBZUTRCV2RwczFvUU5GTHdn?=
 =?utf-8?B?Q0hWT25GTGpUZjQrb1dSMEM0bHp6QW94ZXY2aEhYN2tVbEtJVlZXR3pOMy9P?=
 =?utf-8?B?NmNjMUs1akk0RGRwQUdZMzV3SGdmSW84anRQc2lYUFNTWVdiZ3NxUjZ6NkQr?=
 =?utf-8?B?SS9hMWdUU0gva2FsSTJ1eFU2eTY3VnpjR3dRYUYycUFYUmd1RkhiMVhIR3pE?=
 =?utf-8?B?VzBBZ0k4V01kYnJuam1HVTdsZnRnSDFwSExRZS9aTHB0S29abjlSeXEySjFy?=
 =?utf-8?B?aXRlOUo4c1R1TUhBTjBwTWQydGtaemd4U3dJV1YrUVlVRk1ZSUp3L04yNzcw?=
 =?utf-8?B?Nkd2dHMrUnVINWxyUmJNbUZ0UmhiSU5FU2MrNzA0TDFrQzlEZzNIajd5dnFI?=
 =?utf-8?B?YVNva1hIc0dHcDUvV01CcHBLQUdEdUkyTjFFeUZQZGJadnpqS1BkN042QTFR?=
 =?utf-8?B?Q1BKbXhQa2RNa1V2KzdZR2ZXTDVHdkpGNTBKOERNaEFNb0dsRzZPUUpXNGpT?=
 =?utf-8?B?R1NMRXJud3lWK0JqdFFtdWYzK0NxT1l0MUd6akNPb001QTFROEZFeFBqQklK?=
 =?utf-8?B?QlU4QjZhdjhtUEZQc3V0K3NsQXA5azJwUCtESVlVOUMwVCtJcTUzYml6bk5R?=
 =?utf-8?B?ZmZyWFFBMUpFbHBJN3ZnM3BhOWZydkJ3K1NQS256T3dMTXh3UHowdThSUGk2?=
 =?utf-8?B?VjNPTFJoNU8yaUdrd0IxcEphejZBR3BOcUdQQWQ3NHRRdkRmWVZZQ2gxYkhK?=
 =?utf-8?B?eC9STFNIREFZbCtuUm81d3BpZmhieUNrRWFqWmRoN2xwT1E5ZEVRNTl6b203?=
 =?utf-8?B?U1diSDQwcHJWS0puY1FpbkEvQzZ6S3pBcjZhYlM4cERZbnQ0dmQ1Z2lCV2xj?=
 =?utf-8?B?Qy9kcEt3akVCMmFxdmtHYllrTjZiekExNHhIZDdzZGg2UURrRFZZMmxUcXJL?=
 =?utf-8?B?TzVFSjJQM01DMk1jV1REdnlpdm91eUdFVGdwc2NGR1Ywd243RysveDFzK1dU?=
 =?utf-8?B?M0pxOTBEWmJpbUJPcFB3UnJ4Y1VjM3JFWHcvcTk4eGU2ejFNbFhPRmZENlBt?=
 =?utf-8?B?UW5rTU9RT3lhT1NhZ0dRWXRuUWZScGNBRXVnZ0NFc0cwT2JQTkUxRlJPVy9D?=
 =?utf-8?B?K25QK2xCeGlOenhWNCtqSWYyWGZCYUFNOUh1VmtTLzQwNk5YL2hqMlRHeUpK?=
 =?utf-8?B?WnJSK0Vzbk5BTENmaHV1d1RKbEc1YnorVUgvb2Vnd2xVUnFha1FYZFlWMkRI?=
 =?utf-8?B?cXZMSHJiUVpUZ3IycG9CMDVpVG9jQ2hHZ0xGZENlS2ZqejRBY20rTTE0dFox?=
 =?utf-8?B?cVV4WlV3c05FQXY3dGxuZ29ERWxvQlJpbXA4dzRBQ25yNjZWczlrSVpMVXB6?=
 =?utf-8?B?eHdNTXFJTnk1c3FOSHQ3Wk1lT2JmTlZaeFZpUTd0SEdIdGVwempWK244THNL?=
 =?utf-8?B?UlUyL0tFQi9hVnNxQUNwU3NoeGZSSGpUL2UzSTlDbkdkc0E4OTB1bnROS21Q?=
 =?utf-8?Q?eRPBLDc7h6cN9Rs2cJ03?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdhL0NuRU81dThyR1laNjJTN3FpM2tVVWUxakVKRTVoYS9lT3NEQmh2SGZP?=
 =?utf-8?B?RStIWVN4WXZMc0NIcTRBZVcra3ZGY0VqbEt5OFhycU1uZWszMTB5M3Viczlv?=
 =?utf-8?B?TGpUZ1ZiaFN6Zit5dnN2MTQ4YTRBa2VjeVZGY0VXRjY4K0JsNkUyUUlOeVVq?=
 =?utf-8?B?SS95SzlCOUF2Tmt5SGJSNzQ4aG16R3NVV3U3Qi9GSVlmVVE3Q2s0d2xVbUxt?=
 =?utf-8?B?SGp4WlpZL1hjNDNCMG9mYzY2Z2ZJZGpMT1BQajhEVHlTQVdmTGJHNlhVOWdj?=
 =?utf-8?B?OFprYW5FR2xDbXMvL01hbEMzMVhlVCs2a05tUXB0MGNUVlZLbTl5SHhNN0tL?=
 =?utf-8?B?NmZxMHdXenhxeWI4OUxQK0prRXhQK3ZrT2dKWHRRWUVvbEF4NXFuOTRQQStM?=
 =?utf-8?B?N2dJUHEvVnZHUFJUajRURDNMM3BDQXdrM2Y0ellKZ0tEc01xdUZYR2sxZzFE?=
 =?utf-8?B?VGJXdStlWG9MZVJGd3lZYmozL1VPNVBWUmR5SmtmWWY0TzA3Q1ZuYjFNenJY?=
 =?utf-8?B?b3pFS2ZUWWUvZE9OdW10d2RLcTk2MHZKcmhKaWJKWXQ2UmFTR0pOQ1pBQ1N6?=
 =?utf-8?B?RUFSRzcrVFVDU1NnYThZa3NHb1J4S0NwaGV6TFFPRm5sUUNuSlZBYlVBTU0y?=
 =?utf-8?B?eEhIZE0wVmRHc0NDWmpNd0tpQ01FdzhrNUNTaEl4SE1JblBOYjFnRW5Ocnl6?=
 =?utf-8?B?aDh0aGZxdWxIN1dyelBxaEtoUlNWUHdQQ1VONTR3ekE1RHQvN3dzSitqQkt2?=
 =?utf-8?B?cjNUVjFiVXpCOUV4UlVodUlXamRaWGZFTzF1NmJnN3Vsd0RVQTNtWTc3QUJ0?=
 =?utf-8?B?aHRiOStISHFEdTJwblFPd09uS3hqWEVHNFowKzhCV1llbDk1d2RrbFdtUngv?=
 =?utf-8?B?c3RFQm8wYVRJc0tKL3N6NExyUmNRYlJrM2dMazEzVjBmbWdiZCtCWXQzcFdQ?=
 =?utf-8?B?RmJRUDVvaDBETGRYNzNXbnZhTHFBQXFYbCswNmwrTG9zTUJMTGFaOFpGWGEv?=
 =?utf-8?B?UzdSRGs3akpSalVwc2RncmFiNExIUStRd25qeVF1eVlhT0NZTGtDR283eDFt?=
 =?utf-8?B?eGNrTWJGNFJyNWZLQVlBNTYwQ3ErZ1RZUk81QUJ0anV1bFNPbVlkS0F0MWd2?=
 =?utf-8?B?ekZNY3ZzMHEyRmlKSVVyZkpxYWNJeVg3RFBDN1RMU1Q0UGQ0Q3NjT1RwWGkv?=
 =?utf-8?B?ZEdmT3JwNGVrNEY4amdvcDZjM2hVNjBwWHFSRFpWNGw0M3ZnZU55dzVYS3Rr?=
 =?utf-8?B?cVF0aE9ZcldHVFo1VEUwZ3I2eVgraE83cU4xL1I3Um5SN2V1M0FPdlhuUG5B?=
 =?utf-8?B?SndkeUtPY204d2pJZGUzb2V1Y2MvbTRxQVRXd210Nk1rcTczaDZ3dDhMT1Bi?=
 =?utf-8?B?czJVdHUvKzhuZzU0cDRRcFgvNkFNdVplaDF2ZHJZZjR4ajRLOVBTRU9YWHhp?=
 =?utf-8?B?eTNLNFpneVJMTnFBalI4KzZGcG1pMWszalpjR2RxNldJSURNU1A4VnBlR0J2?=
 =?utf-8?B?WVkwRjRoZC8vVGZEMTFXN2J4K3djYkdaTDJUNXlkMmRvZGE1eThDY3hlaXdG?=
 =?utf-8?B?QUtyeFAvVWJyR29LZlAxSHBWRENTUGxmWm9tSmxvUit3Nm1PUDR4Zkh4V1Ny?=
 =?utf-8?B?SzZDR2d2ZVVDWGREd05MY2JvTGd4QnJKK2NrNUVrZUFTMTcrdzZJU1ZJcXox?=
 =?utf-8?B?aWNoTWJzMlNCVnFsNWhhdDFVUVVvN2xBeCtBVitSbU1vMGY3SnpaMmxDMFl0?=
 =?utf-8?B?SVltejhUTDNmVllXQXVxNlNaZUxSdXlJSnc3N2daN0dvd3IzajlwZTB1Zy9K?=
 =?utf-8?B?My8zeFlORVhkL2s2S2ZQVTFEYmlSUlN0bStYUnFta0pBQUN4bUhYTk8vajFY?=
 =?utf-8?B?OHJmcXpCQlhOTXUybFpNN0l0L1F6TGx2V25MdjhLWHl3VWQwN2w0YTZSZHZi?=
 =?utf-8?B?UG1aeUh5WFU4czJWbDV2STJqUmdkdHBWenVxYVFlOTRHNGJCS1FJb3FXeVQr?=
 =?utf-8?B?d2FMTmQwYkpzUDJkTUF6Ny9VVG9DNXZGcVJjVytxUUkvUTM5YWJXWENXeWtk?=
 =?utf-8?B?em55cmIvSEc0TDdQcndQOFZGTHJDUmVwSFkzRGZ1c3NDb1pmdFBGU3NoVFUz?=
 =?utf-8?B?c3N4bG9ab3Q4UHdYZUtZR3R6cnhySWYydjl5UTFBVXdtOGZmMkRka0dNOVJX?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vyu+MsZwb8vGta4o/OFeWICCSadQ6FM5X0AgfTCQTjrVTPw+6GtDqpPCzGiI+NxwtC7DGZsOfLs2cgnhEpmFHsRmT5msXTpVCURznhbbqehXL9fLVoNl+NQ3E1mEqCJBadU4zA5h5ZyiRT7aKsPE02LUdGkt9xwRwH0107wopGhJoZT391PMw7gPdHwi6oXflaaytCFbviV4Q10a4NUBONqUWX5ZzUD041LTrVuspKvMBXA/uJSNr5laKNylEGhQNqk2spQoQH3Qk/kkW2xdBv4zLe/SH7WSHzujoxPVNPo75bg/WJ0ZbFeBjHCUCndkgagJQ9ri5B0F73IfOC0HdIj70zEYWMzWjMBp1FoclpokUWM1kY3WNmgyEeUcMtFa5slZ76Yz3TwXqGK0+QqypvS5xneDHnRvOwxQ0j7bkoaSRL0A4q0zBE4ljw47n0AMBWm3VUKce9U4S+tTo5EPkGcuzJ6lmz/Y0Y7RrFx1KrBfeylCFd4oBPv4kpx3eUMN9WXsaat3lhehno7FA77MJnGKpS3xZPyYtH9uH9OkArqn1fwifbuU+tLDG0xvbWF1APYZLe/h0ks+RK8UJBtnY6J7hsOGZdWOg/r9tQMPgZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6e3eb8-5701-46d7-d63f-08dd0a2c5389
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 12:59:25.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPDV4kf2IT+dWs/Ps2DsjrQh6HxVv6YuroN7B0EsFWCzqvoPACCNvnZ+sZQgqLUFrveiR6lLF3dFSBG0aZxCLKa5sC0y88oRUfH8n++L2qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210101
X-Proofpoint-GUID: SZG-cn-UThGs9nO5B1WzAtdwajf2VBaO
X-Proofpoint-ORIG-GUID: SZG-cn-UThGs9nO5B1WzAtdwajf2VBaO

On Thu, Nov 21, 2024 at 11:44:52AM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 8:29 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 02:49:58PM +0000, Alice Ryhl wrote:
> > > All of Rust Binder's existing calls to `vm_insert_page` could be
> > > optimized to first attempt to use `lock_vma_under_rcu`. This patch
> > > provides an abstraction to enable that.
> >
> > I think there should be a blurb about what the VMA locks are, how they avoid
> > contention on the mmap read lock etc. before talking about a use case (though
> > it's useful to mention the motivating reason!)

^ I think we should update the commit message to add this at the start then the
binder stuff underneath.

> >
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Other than the doc stuff, this looks fine, so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> > > ---
> > >  rust/helpers/mm.c |  5 +++++
> > >  rust/kernel/mm.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 61 insertions(+)
> > >
> > > diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> > > index 7b72eb065a3e..81b510c96fd2 100644
> > > --- a/rust/helpers/mm.c
> > > +++ b/rust/helpers/mm.c
> > > @@ -43,3 +43,8 @@ struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
> > >  {
> > >       return vma_lookup(mm, addr);
> > >  }
> > > +
> > > +void rust_helper_vma_end_read(struct vm_area_struct *vma)
> > > +{
> > > +     vma_end_read(vma);
> > > +}
> > > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > > index ace8e7d57afe..a15acb546f68 100644
> > > --- a/rust/kernel/mm.rs
> > > +++ b/rust/kernel/mm.rs
> > > @@ -13,6 +13,7 @@
> > >  use core::{ops::Deref, ptr::NonNull};
> > >
> > >  pub mod virt;
> > > +use virt::VmAreaRef;
> > >
> > >  /// A wrapper for the kernel's `struct mm_struct`.
> > >  ///
> > > @@ -170,6 +171,32 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> > >          unsafe { &*ptr.cast() }
> > >      }
> > >
> > > +    /// Try to lock the vma read lock under rcu.
> >
> > This reads oddly, I'd say 'try to acquire the VMA read lock'. It's not really
> > necessary to mention RCU here I'd say, as while lock_vma_under_rcu() acquires
> > the RCU lock in order to try to get the VMA read lock, it releases it afterwards
> > and you hold the VMA read luck until you are done with it and don't need to hold
> > an RCU lock.
> >
> > A reader might otherwise be confused and think an RCU read lock is required to
> > be held throughout too which isn't the case (this is maybe a critique of the
> > name of the function too, sorry Suren :P).
> >
> > > +    /// If this operation fails, the vma may still exist. In that case, you should take the mmap
> > > +    /// read lock and try to use `vma_lookup` instead.
> >
> > This also reads oddly, you're more likely (assuming you are not arbitrarily
> > trying to acquire a lock on an address likely to be unmapped soon) to have
> > failed due to lock contention.
> >
> > So I'd say 'this is an optimistic try lock operation, so it may fail, in which
> > case you should fall back to taking the mmap read lock'.
> >
> > I'm not sure it's necessary to reference vma_lookup() either, especially as in
> > future versions of this code we might want to use a VMA iterator instead.
>
> Thanks for the doc suggestions, they sound great.

Thanks :)

>
> > > +    ///
> > > +    /// When per-vma locks are disabled, this always returns `None`.
> > > +    #[inline]
> > > +    pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {
> >
> > Ah I love having lock guards available... Something I miss from C++ :>)
>
> I've heard that C is starting to get lock guards recently!

Yeah there are some (e.g. [0]) but the weak typing hinders things imo and the
syntax is not fun.

This is wrt to the _kernel_ C rather than C in general though in case you were
referring to the newer standard or such!

[0]: https://elixir.bootlin.com/linux/v6.12/source/include/linux/cleanup.h#L307

>
> > > +        #[cfg(CONFIG_PER_VMA_LOCK)]
> >
> > Ah interesting, so we have an abstraction for kernel config operations!
>
> Yeah, it's basically an #ifdef, but the block must still parse even if
> the config is disabled.
>

Right, kinda sane to actually make sure it parses too... :)

> Alice

