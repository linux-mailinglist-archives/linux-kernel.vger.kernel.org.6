Return-Path: <linux-kernel+bounces-418582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2CD9D6337
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB00BB25D43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474791DE89D;
	Fri, 22 Nov 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C080vHyn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VQtPlExg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DE70812;
	Fri, 22 Nov 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296896; cv=fail; b=OlCSTFyNXyC8nWCrtFMcalpQerkRp2V9SLaKXn2PxL7p0OLDirAB9aNNg4urjFkMEoyGF+yMxrudJs2mo1R0RQ/zh8fPsPLVlVXr/2c2bc9W2erBGm0A5+lyT/BWh/b5lkqVKA57efjrhq4+iOpr/VlimbRg83bUab0sgDGaC1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296896; c=relaxed/simple;
	bh=Vvbijo2McWCzI5nFU9kqb7gDGJaavhIov39D65XIWxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgNRdjirUV9FMGnMcKA1M5mV+nZa0KS4RzHkGferjGRLgpXyctf1RhxPrR5BGy6d66cJvsIduMsXGiilEEKX/mWyDNIYGgqBSwhcq/2Lcb3sQJroaEz6BHDZOSQEruF3R598pZNwe+dQCRbLgaCyebrzaT2JUXpqdMSgRvCNRcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C080vHyn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VQtPlExg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBZNR009432;
	Fri, 22 Nov 2024 17:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d4Ii/Q+Sx8P8CWF2N2lWPJZublHQamn35fDdI4orpqY=; b=
	C080vHyn0/LZaZcqWbCRaeb3tRw66m6TIQrRxfVCp1zrJd8xfgUonob4phvkIckn
	GXNLiDaAKh0yCvPkH+DoUmD7ePuTwIl7/0wJnmasSmdW25jT/YWi7Grlgayw4Va+
	L2pgy4xG6M55sRXZ6I7NmyG46F35OQoopOwPa68mALqDfD48gEu2me+vWtCsqyVB
	Yzfo9+mFY7nZE8cYhJ3wgxaJjrIoGzH4Hgor7Y9WKq2HLgb4qdKQwLxDk5xYt6Rd
	b2qa+/aIaeNa1cY8lA5x5z9SzyUr+QGtR8IO7PlHWcC1Qbtb6c96LKWVJIe6finR
	OeGLS4s4F7Aph3XZW4U5Qw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtccjwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:34:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGiIJ1008913;
	Fri, 22 Nov 2024 17:34:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudn7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKWLuLPGDzT/dSsZR0K9ZXehhb8LzvrOvW/BYzz/FaNLFN/9TUyra0p6iiWRAI+XrecESmIRA9CGNbXYL0Dcf/GfPzi8hRV+Kk7y/QVc3rPSTZnLRhpo06Pt9qKivCv8T/juVAG7L+5F9FGUClpYSyN1/Q0Rc+y/RhAMRCwbiXonp0cG46a4u5pEtaEjreQhXzWIVEBc2zqM/Axxc9GvScqIHykNsUNm3O1zKJe5XP5e+tBg2Z3fkKfqajm8ESsAIVF+qKyuKsxri/6sjG5rhnmFPlt/ct5PxjswHXfGq5/l9l1FLb/NZPRCz+Szk0hBgr1h1ng6Th3vyzq8knwBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Ii/Q+Sx8P8CWF2N2lWPJZublHQamn35fDdI4orpqY=;
 b=SeZRWZnzv3+plYRIcJfi0+8yYP0cSRMBbIVedY8qAtwbOYzhIiroLt9y/OG1rbZqYyWzN41M9xrL/UqPnwxoNwZxLgDckAD0vyCORBAcodMU4Xjc9H8fHgksF04/9rmj7Z/ynqVl3oAyi6W5pIHaUxvAA8L33GDbBgT2lYui6rPpB5F6YblbPYvw/2FhxPLU1mjC0hLanXhUnn6iS4CHGwxIcdtKUq/rnmAka83aI0o8HloNiHZ1qtPjaBgnClWOoObiGF/oNLAPLkCG7eFNHdONkC5NfgGDVK+Yclolqx7cLCTmsfVAL+g3jS1vQRNxjkMgukMUmS496SVXR5mjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4Ii/Q+Sx8P8CWF2N2lWPJZublHQamn35fDdI4orpqY=;
 b=VQtPlExg8k5gj3434TPBA5+iWbVzmnNC79fcvBJOFNhtHtZe07Ilj7yhslo8pyfsd+8EWVzvjW+aYVdTNkymUKN7wnsbADRbSzZBFP43LY3Vf/dpa2X4Aj7ZbgJYj0/S+AUzLC7H4xfQckenhDEvhyKdGDghIOG0RlO9X1dWKRA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 17:34:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:34:22 +0000
Date: Fri, 22 Nov 2024 17:34:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
Message-ID: <ba35cb10-21e0-493a-935e-f314bc0214c4@lucifer.local>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-8-7127bfcdd54e@google.com>
 <CAH5fLgguMwp=jfSG=BSDWxCVO7cd2MQVfLsFLH2byDBJVZbOfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgguMwp=jfSG=BSDWxCVO7cd2MQVfLsFLH2byDBJVZbOfg@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: aa68a2c8-2aee-4e46-f031-08dd0b1be6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2QyT0Y1MWNLdm40S21ORnJxV3N4RWpkUDAwTVlpMUNYbE9hRU5SdVJ6TWVN?=
 =?utf-8?B?QUltNWhkMHdsQW40WHM5YVNhZmpzVS9QdDVIVHZBcFRZMzZxdFBSa2VvallM?=
 =?utf-8?B?enF2Tjc1a3luVnV0NGxneXYxdUY2djJhRTNVRzVCL29rZENIdFRUYTZPOEo0?=
 =?utf-8?B?NXh0MFJvTXpSUFV3WFllNjZUNXdsSmdubURNcVo2NTN0dG5icWpVUmpjYmR6?=
 =?utf-8?B?dGhIS3EyTzRzbEdnck5FbkV3ZWlEa1BIejVmekhHRGtkK3htMUdFK2F3cGhV?=
 =?utf-8?B?eCtxQU1pc2tlUTdkazY2UG5qVzZaTDdYVGpRaUF2TjYySHU1bEhKVzlMTGtP?=
 =?utf-8?B?b05RUk5NeEhqV1hubXNxUGVrRVRGbU9WMFJDeHNrSEt4azJkN1ZTZTRXMHcy?=
 =?utf-8?B?TThZRWoyeWlDQ01ReTVTbFJlbU5INlF1SXl0ZGtWazNOclJSZEM2MGZvMnFj?=
 =?utf-8?B?MDJHRG4wK1FKZXdnYTgvK1ZiUy9xZUpWTGtkN25VS25CbXZlWUVlV08rR2ts?=
 =?utf-8?B?eFYxTk94N2h3ZU05MWYyRmdRN0xUL0VZNmU2RFBXOXNYK0V3WnA3Qjk2NFp6?=
 =?utf-8?B?cFQweW4xRDQyZ1FjLzBKTFN4aitMV1drd0YvSmMxdTBmd1BqendTM1hrSkFR?=
 =?utf-8?B?SXJ0MTRnWlRPSVYyTmR5bGQxQTMzbkxmU3NCVXNWczJ3ZDJiaXM4TXMrK0Ez?=
 =?utf-8?B?VzVtR1RMbG5pZzVWcGhpVG9Zd2xDZk5JdkxjVUoydzduWTAxV2U3bVZKMnpK?=
 =?utf-8?B?NXphMzVsdlhTVC9CUUFlUXdzcW03MCtnRHRwNmhKM3JzVGlKRkh0MC9DOHBN?=
 =?utf-8?B?MWpuY0ZreWNBSHlTL0ErTkp1Tjk2dGYzWU95UVBVRU9zcnpSa2NEVG90dldD?=
 =?utf-8?B?Z2EzNGZsOFZDZVU2YjZPSytLVkcwczZQUksrcFVCVEdyWEdKSHNWU2RqS1d5?=
 =?utf-8?B?R1VuMWZhOTBNV1VsdjNxWkZXeDFxVVFDMkp1VXNMalRtNUZsaU9iN3o5U2dh?=
 =?utf-8?B?dGpyY3lYTkd5VEl6YW9yeWhHNEFFbk9HZ3Bpam5rTGFQdGIyQUpabU9KRVhD?=
 =?utf-8?B?YWxpNEJWV2tMRVg1cjkvVVJQZUJkV0VYVkpLMFcrMHEyQWZjbmU0Nk8zQnFN?=
 =?utf-8?B?RVNKeXFBTjB3NlViR2h1clc2OUYzMmZrVEZvVkQ2cUZ3amtpSjl5NE5RODJn?=
 =?utf-8?B?ZFNDTlorKzVlamVRV09DTUtPeHVXVjZ3Um8vYlNrcTZzR3dObDlPNmY5Zjlu?=
 =?utf-8?B?ckUrTzZIUFV4OFcvdG1pSFRoNjQyUW5iSE02a2hOS0llbFVZSFZvc0hOOFNn?=
 =?utf-8?B?UmJXTWFpa2pRR2NYZlMraUFFSjlvdWpQWEFsS1lTaHhiQWdZUEhwSGRiSTVt?=
 =?utf-8?B?VCt2ckZLelNoSnFhZUVYNFNReU91Q253WWNUMVpleFY2MCtuTjFsdzArN0VY?=
 =?utf-8?B?MlZMa2llRHF3UFBxQnJZanptM2lmdzNGcFNhVjZMUE02UlJWT0lDaWRUMk5M?=
 =?utf-8?B?V1Z1L0psWGs4WXkxbVYzQlVTT3VxRUk0VXpaZmhPWi8xd0dLb0RmTExzQ2xP?=
 =?utf-8?B?NmVEQXVSRjNSVnpkakJyVWJSRytaQkxpK3dETGJJK0VVY2VqOFAyVjVvcThM?=
 =?utf-8?B?eHhOTTFsdE9OeUg3Nk9zemp4Y0pENGovb3h6SG9tZjlPRnFxUE1DdjBmTG5x?=
 =?utf-8?B?Wmp1RUM0QiswTUNGQnhsMmtQSFJiY2pLTXd0dHRJYVJITFAxZ1BnNnlWYURO?=
 =?utf-8?B?QUwwY3NsMi9oRlpwSmtnNlJ2aTVLQ2w2Y2wxaWxULzZzTE4ycEtFTGdka0JR?=
 =?utf-8?Q?d2OcGEbEHdl2xrQJrkTPRRgVeaNGBkQHowouw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUFRNGJXZHRhWDFTdVJlVlFTcmE1YThVTktZczZieHdFUU1uLzR0d1FCQTBE?=
 =?utf-8?B?V1ZDakpRS1VSLytNM3VpVFVtenpFV1QzT1Y1Z281b29kRG1qUXhZeDJyMTQ1?=
 =?utf-8?B?cGZNR2xySDNuQUxUM3U5VHcwcHVVZXpkQnFwRWpUeHpkajV6ZkJlL2tZR0NE?=
 =?utf-8?B?SUFzalhpTmt5RTQxeVZCeWE2aExLaTdvRzRrWE1rV2phNk5RRG0yWnRMNUo4?=
 =?utf-8?B?RFRYOXJCS093YzdmVFdSVEV4bUNWbTZJV1o5TGkrWlIrRU1ZQnIxTFY4cFR6?=
 =?utf-8?B?WU5raDlaeWhmUFN1cHhlRzVDL2sxc3BKdkh5cm5wcVRoMFJ2SGhtNFNrd0NJ?=
 =?utf-8?B?L0poNXBUdmp3RDJTVEVRV1RyTjI0QUx3UFNGdW93RVhTSUF5V2NNZE5NV3RV?=
 =?utf-8?B?eERPeW51Tk4yNUtpZHdsY1pmM3hjTTdtM1U2VXhnOWJtdk5hVXk4eTFJNnZQ?=
 =?utf-8?B?K0l0cGtMTGJZTGZGYlVrM3VGVVVnWG5ZTW1sekJMVmY2OG1Pa2hJbUFla3Ja?=
 =?utf-8?B?Y0VxalNNVGVBL01HMWs3RHFtWjFFdXZBaWVmZjUwY3dTSUNuWlpxRDYyRS9Q?=
 =?utf-8?B?MHAvNUhxTzJ0OXZ0ejlSZjRVZTJyeUhjNGM2ZExHMnFTNTlWNTZLdnYxNGs0?=
 =?utf-8?B?RWcxN3hiNlFLNjBWTkNnZW5FWTNrWDlJeXdrdkMrR3V0dHFTbXIyMjNnVnl2?=
 =?utf-8?B?R0I5VDc3WGlaUXErMGZwWUhCU1dZM2pFL1VPYkp1TWs5T0E1STBVR09QKzdW?=
 =?utf-8?B?OC9RL1huNVVCaGludjVrQ1A0VHpPNE8wZDljVlh2aUo2WVpvdGlBL1FpTHh5?=
 =?utf-8?B?eUhNVHg1Vm5EREpWT3hNd21QRm1JdUpxSGs2WHdGaE80SjE1VnBmTTlqNk80?=
 =?utf-8?B?a21HUjM2S0pZL1R4bkRpbnNFd1RQTVNrQzlSTUIvN2RHMXJYbVBMT2VXMEY4?=
 =?utf-8?B?L1ByazFZcEJUZnJwQk50NnVGTlcwamJSNzBqYk9HcjIwOXp1TUYrLy93a2s0?=
 =?utf-8?B?QkYyLzBjNDBCYWVSVnBEejJFTVBDQnpjc2FITmhQNlk1dmlRSXZ0NXRCNnN2?=
 =?utf-8?B?RTQzcHVmWnF1Q2liUmwrcUNWWmRmRlJQR2VIK0FjcU10eXdFTmV4TldoeHdX?=
 =?utf-8?B?bmZ6S1RiWUhOOWlWMGNwZTZKVHdraVI2Z2RoTTRDZmE2ajEycGk1RzVQeE9w?=
 =?utf-8?B?Z2JZdlhiaW1WNFA2S1M4enFRandKM3pkTEptQ2x6MWZpdFVhYVFWMkMwbkx1?=
 =?utf-8?B?amZMWm53TGVtNWo1Mk1DQlJNRUppOXgvL2RHaGJlSlV1bjFDZHo2ak0zUjZB?=
 =?utf-8?B?LzA3dDFDcjNTOEZmRnlReTBGMDhac3hOK2hmRnh0ZHFNc2VhL1VBVERDNUhL?=
 =?utf-8?B?MWNMVDhIRnBjYjVmZzk1RDlsMm03Mm5uMDNTclZCZFl4a1NMNUpGeFVZbk11?=
 =?utf-8?B?dDR4QTdRY0JIQm9ZWE5obGZhWnV1cVBTS2piZ2lkREY3OFkrb1M2MEpwaE01?=
 =?utf-8?B?OVo4cTJsTnFGc1dTVUlvaEhKYzZISlJyVEltZzFDMlBOeWxwRjJDSXBKUWdX?=
 =?utf-8?B?VEd1dEtTWE1BMmYvQStYWndDc2tlNC9rNnVyZ1dQcE9zcnhHcVY3RUtNR2hK?=
 =?utf-8?B?UDJoQ2dTK0RyRlRpeXYvcXBjc3RhY0VHbXBZSjBXUWZKRi82ZDJTdGIwWTVJ?=
 =?utf-8?B?T05FcmRjbU43aTNOd2E1RDhzSlZSVzMzSGFmZ3pXd3hQTGI1bmJrQStIVGVC?=
 =?utf-8?B?YkJYenJaSStLRy8rYlhRb2pzQkNnL0NwVnZjaE0ydGVXdkRueE1ROGtvZFBO?=
 =?utf-8?B?WWdteVZCYndvd3hJdnJkbTVlamNkUk5Bd095SzVwTmkyc0hKVXV6TEdXeHp0?=
 =?utf-8?B?UThrMndFaElSdnlBMkg3bFl3OHhobEduRWFLOWFMY0JtTDZGY2ZMYUVaMHA4?=
 =?utf-8?B?andIOWtqRjFGOHo1SW5iQldOaCtwaU9IdU5tMHJBMzU2TGlsdTNVaHJKSEFY?=
 =?utf-8?B?MlJ3aWpHWGkxSWZqNERUUnR1T29pbXlMbFZZendKSUo4dCs1bytHS1R5TVpy?=
 =?utf-8?B?TzVoOXBQOE5SWkVnL3NwK1lYVnlwalFrVzVzMjFxRWJZdDQvMDZoNUp0UFYy?=
 =?utf-8?B?bFpiTy9oUVh6VGVqczg5RzMrQlFvOGdoK2hVOTVKVStoNGdoTW1NNWs4b0Vs?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iMZ3kV6FsY8nMVmRMplelfn4Sw9QolmTBFk3jClPyvbIrWw3ZXa8eXfo46rX+7pnwkUW5dcXRw1gyX4tExY4nDakaRYHvOMSfyq1AUoIHKljkzxnJaUmVReVUAllqKxv3azpj2g1C+frOk/fXTH8YphEOmmjkA1qY957z34fZUbrhHDuUgQQjni+9YqPaQJWgqCUV+nGUB/sOGyCFHfHTeDczsOHSAn7hOAqwgSgA4JpqzXxDDmLRyo+6VO4qv6YaSYy4YBTrnEH/yhRLT00izqQ6I82SdLn3NG7Pt4x2pTcAWBf5MOFINc1M5/zf/3UJNsNyp3cr8hK2ndhvQD6+JQh3E/THDVGIhPrjjPGp02sO4UXcIBjKt9pXlAB0yEPQwm6dXXyf3hwUjDgY/DmusXRQX5U+Ez86YuSznt/KCNeDGdhORh1mlsphqpFes2XgwV4F6Ssj3AsYgVB66HG+3V4mtMMMSgCn5AmfhiA1FXbH5iQ5G3GerjH35POlcnV1Mb25v4KcYazk31QA+3p6nYK+EUsQ2hW16N7bsIPolrVvP393xv2/fsC12OSQGjhAcTv7NiTl6282Mdjr5T3EFEm+35X3UjKHhWfMrWw4jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa68a2c8-2aee-4e46-f031-08dd0b1be6c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:34:22.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcPZTiR1lKCdXd+GJKI1XNZtMIZ4JgMSQ7mih6QJ3fA38ssGrKUXobUfa1y+MPM5aumFU1c7Gt6z31T4IxfabAIHxJ6FVnYdQLGiGMitMTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411220147
X-Proofpoint-GUID: fuyvYFwidEhE8bCvR94lzLY-sGqBY3IV
X-Proofpoint-ORIG-GUID: fuyvYFwidEhE8bCvR94lzLY-sGqBY3IV

On Fri, Nov 22, 2024 at 04:53:58PM +0100, Alice Ryhl wrote:
> On Fri, Nov 22, 2024 at 4:41 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Introduce a new type called `CurrentTask` that lets you perform various
> > operations that are only safe on the `current` task. Use the new type to
> > provide a way to access the current mm without incrementing its
> > refcount.
> >
> > With this change, you can write stuff such as
> >
> >         let vma = current!().mm().lock_vma_under_rcu(addr);
> >
> > without incrementing any refcounts.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Oh, that's awkward, I was testing this change using a config file that
> was missing CONFIG_RUST=y, so it didn't compile the code at all. You
> need the following imports for this to work:
>
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 103d235eb844..60659076997a 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -7,7 +7,8 @@
>  use crate::{
>      bindings,
>      ffi::{c_int, c_long, c_uint},
> -    types::{NotThreadSafe, Opaque},
> +    mm::MmWithUser,
> +    types::Opaque,
>  };
>  use core::{
>      cmp::{Eq, PartialEq},
>
> Otherwise the code should be correct. You can fetch the tree with this fixed at:
> https://github.com/Darksonn/linux/commits/b4/vma/
>
> I'll fix it in the next version, but I will wait for review before I send that.

Sure, no problem, we can just make this a predicate for the ack.

>
> Alice

