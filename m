Return-Path: <linux-kernel+bounces-425525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BE9DC32E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984DD163D66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9E19ABD8;
	Fri, 29 Nov 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzOEeOur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zq2+NpsQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFC33C5;
	Fri, 29 Nov 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881551; cv=fail; b=fKUwsYke3h34ZhPXQApcnul3Kbe1TOvUNuEODff57c4drMz6pV7+RVV+4v+NlwkrmxbK+95Xn1bPVWMjMuf2MCcdPvlt4sq+lDOsVQ8iVzlcjLqzaudpRsEZ100cCjdFyRTwgU2YJhGwT+zpcnA+bt6mgsUSv4T0mBYJKTltGjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881551; c=relaxed/simple;
	bh=zfHgcF1RpbdTlnGQw+qEZgQlpGXOytymbuiJDAaVj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfQ560QeUVXsn8OCY5+moKRuGP6mqH0yI9AKuU846yPM9bLqSrDx0O1Y6utD6MnbQ+3MioVcgYBJyIXC3jEYQSQ2rH+XV1fSatA8fk2xlRVzjNxbOZYTwsS7dJzphdUk1Btji9GB4MbzdkZd52U9FbYqF01UBKmQPlRVOtuXx/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MzOEeOur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zq2+NpsQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fq7K008079;
	Fri, 29 Nov 2024 11:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=04K3QXiRugn/mJE+0UKkrVSRumzMggnJqyVrkekfNuk=; b=
	MzOEeOurTzRFsot46UkRYRGSRDz9ln0F16utoMPvGKkxw2OiENW/xNHxNjB7lW/c
	G8il+ipoNquV9gwZmZ7ER/eVYWbIQ6w9W/QrtMQbc+b/KLVvgvmMrVQ9tddAbAvf
	9krzc+BNWEKWCrn+poM8BqQ/rAuA3z8Jqm5ThxDAdebidf/SC8PL20jgIgr7+sFQ
	TSAx9Zew3gJ5zFTAiT5oeAvJPh/SVxfycQCXhzqOCdbMYlraH35XV0UKQIi1haqr
	dCRzdreRbAAAdqBji3Ht+MTpYpjuoC/Ko7uyWnlf/L606yT2Z3V92hi+mrQ44zd8
	MlzCnJoG42pgQ7ThMQPTzA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyb98t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 11:58:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATBYRox001495;
	Fri, 29 Nov 2024 11:58:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436701bncy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 11:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riatrbKasWDDtUoJ0S4hWR8WB+UIzRO3c8aGNRoCMFw90fqcyRoLCjRaCG3wH5dWYiRxWNWO0ByqYLTeIhXgcdQ8UFADkVmfDm9j51lRveXExntLUrx6xPRN2NNwprpeQYg+na6N9t413PtyHq9VZa8HcPMKeKxeZ+Vz4C190JYcVaPnVzwwSbUej0Cd8pCO8Fqg4RiQMjnYKR8Em8uZN1UIwu/9GwGan03nHz9GfIp/1u8Xqyj/VdWOUR0yHRL9skxy80aIGAEBY9t1iJRbk3g2oPLnxaSxMp3qyihD/U0t9S+0nA/+Wlf4LVw650PCNw+ZlO+Anpq1q4vyXiP3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04K3QXiRugn/mJE+0UKkrVSRumzMggnJqyVrkekfNuk=;
 b=gE/bPu1H7hfiOt4lYwv2zA8FTyXkFoOytLT8w/ACl7y9AkvHzt4SZad5DRNkvDLt9qDU+S6DCksQDwO7WvhchRqknau+uzGLHylUB1YETQPIDZUiHh+d+ZIDM9H/kECqn+HrRbJvNHtNRP3AE/izzF5i/gyLkDEqz+06KRrIi1+wpfSTr/PvBS8tklbw4ieRlZq9DPL4+gY+fHuFeUKtyTmgIENqkiXByLKos/PHGx1OKqooYB3gOGdz0i9wjAAMHSobSdAgSXa1uQ3Py4qqDlAIwY4aQ7i2sNmtndixcXntmPVtml6nh5oHfVj3pg68JKkGxM6MZoE9o0RBCoj30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04K3QXiRugn/mJE+0UKkrVSRumzMggnJqyVrkekfNuk=;
 b=zq2+NpsQIb5rPaplMtBpY7tDu8hYnrAmaZ77xvdkvEFbC3d/WYGARhCCVU1ARp/S48OsMIzStW/gTNrDtWM+sXMJNW/E/H2zrXZxsJTYXyweL04didtGwg9Mk835jAW8tBLzd1RXdJyDjJZQgY9g+W+QsBQbAzdSubqJx1chz2s=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Fri, 29 Nov
 2024 11:58:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 11:58:39 +0000
Date: Fri, 29 Nov 2024 11:58:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 2/8] mm: rust: add vm_area_struct methods that require
 read access
Message-ID: <f0da7967-2d0b-4890-a4a7-bd5e36538eea@lucifer.local>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-2-7127bfcdd54e@google.com>
 <CAG48ez28kzjrvMN66Yp9n+WziPzE5LU_Y320405Q=PoOzdzStg@mail.gmail.com>
 <CAH5fLggh7HeOm8wGZH=hnR+SyPoW8Hik3uy4RodibyjY1UT36w@mail.gmail.com>
 <CAG48ez0QmQ7s_MmPj3Q9joEvGSkr9DUWoeJ6dvD=6icq+3DwKQ@mail.gmail.com>
 <CAH5fLgieAEKQt9CyjgFWYQBpy-651SpEU-qoYM2ORtJH9w5=Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgieAEKQt9CyjgFWYQBpy-651SpEU-qoYM2ORtJH9w5=Yg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0439.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 1818cfeb-7420-42db-c12e-08dd106d297d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFpNdHdvRUpEdGZ5OW02WUh3dXF0Wkpoc0gwbGpoZ1dFVFlhZElFTFRGc0g1?=
 =?utf-8?B?cGVMQmVWQnBsVEgvUVZ3ajZTNU8vUW5OVGpvamR0aWpsUWxOSmhRM0pFRVpx?=
 =?utf-8?B?OVppOXl1L1BkWUZ0Z3dHRVZRSngzZDJZRHRTY3lUL2tIemIzZkVnRWFtUlVj?=
 =?utf-8?B?RGZ4SURzazhQWVo1WUhNcnhLUUJ1N0JoM1Qxa0wrb2M2WU9SVVMyK2tYbFVC?=
 =?utf-8?B?QVJ0S0JhN3dUVVZXQTVHTjBPY1ZpVDBxQk9lWllWU2k0N081U2JrS1RGSml2?=
 =?utf-8?B?cVZnOW5mQnp0ZHFLaDVNdnpINUxwWFZWTWVNWm8xZHhESnZSN3liYkdNT05J?=
 =?utf-8?B?akxBMUI3cjJObWRPNmh3alNPMXJnMVpXQzltRGRwUW5BTG1HWGFnY3R4NCtt?=
 =?utf-8?B?YUUvZERTQmxnVlo2YUNwZ2RwVmtodFphZkZRZElxUVdNOEdncEpMRFBneXlD?=
 =?utf-8?B?eUV2R0RBWU1PM3dqUURiamlxcWFKRS9nMHdSbXczZ3VWQVExcmZwWGoyMXEz?=
 =?utf-8?B?MGtDMlloV3pLZC9UdnRwa0x2SUdXbEx2dnBueThMZ3VDWCtlaEU2a1Y1dlJZ?=
 =?utf-8?B?akxOOEdTSVBQMUtLNCsrMlRTakRFb3laMHJaay9KM3Y2QmcxMWhNQkpMdlgy?=
 =?utf-8?B?Wllzb29QemFRTy9mTHh1Y1lDWHhDRUxyQzhXUWVMZ1k1WmZKM1ZKQTV6NWRm?=
 =?utf-8?B?ZEV4c2VKLzNsejBkUkdHM25iblFNQ2pJL1g0Z0VLczlqN3ppU3h1a2syLy9W?=
 =?utf-8?B?eGsvclFMSUtldzE2TlZqa3E2ekpLS2dMaWR0YmhwSTZ3b3ZSVW5aNlRTRksz?=
 =?utf-8?B?V04vemRZdW9UTVZ0SjlMVFdCcFNaRFRaUktIZ05qSGE0cGdVNzlaazZrYzJR?=
 =?utf-8?B?WVNxTHpSamRtY2hybE5CRnlqNGh5WFVRSUpOTmIyczJieVN5alZHV21HQVlp?=
 =?utf-8?B?MWhza0tQTWsybXFxSGo4V3RpaFVhQ0hpdVpjaEJqbEd0UElXcVFvWXZsVWVU?=
 =?utf-8?B?MnQ0bjQxRkhnTHNUTkN4Umk2Sk43ZW5qRk9OY21hYUtEYWlKZnltaURnVnZT?=
 =?utf-8?B?dE1pTXpTanZnd2piQkQvNFZETW1tWlNMYVRNV1UxbEFuODdBM0RTblBqNWpW?=
 =?utf-8?B?Q2tSWHZYVWMzcnhnN3NDZVJ5cGZlcTYwU25XdVF6dnc2WFd3MFd1QU4ydmg5?=
 =?utf-8?B?cHdyY1FmS2kweXR2L252dGVUdGtBaEtrbHJHdVJhSFhzZFBOM04reWpQczdQ?=
 =?utf-8?B?a1B2c3pCSFdvNjVPdC8wdzBjTTI0V2huMzc5c1MzdXM0aU1qbjU5UlpIRnF0?=
 =?utf-8?B?ZTA0Y3FPbkNYOTJYK1Q4RXEvblBuczQzRHFOeitoYXZiZ0lUNUw4V2JKR1B2?=
 =?utf-8?B?VWUyVU01a2EzWjE2Y1BuUDBRS2JTZW8wcWJOc3Y1TlV5cUF2ZHhMR0J4c3hG?=
 =?utf-8?B?WHIvb0dOZHR1NDFiUk9saGlJKytSK3k4clVyUWpaL0xwUUpVSkFyL3lncjJY?=
 =?utf-8?B?cnhOaEhXRGcyMDZ6dzhBSEl0TGRybXR2NGtNaUZxaVNvd2RXQ2t2cmJiTjZ4?=
 =?utf-8?B?UDBZMllvZXhmNXJraGdVNGtubVlmTzcxTEZyeVkzYlhWUXRvcjl4Zk1CbFIv?=
 =?utf-8?B?SkRaZ0xlREhBS2NaM3dRcENYK2VhYW1tWGQwR1pibCtDa1FTYnA3b29vNUxi?=
 =?utf-8?B?b0Jmd3RySGRTTmNtMUE2Rk1IY2ZVUWdpUGk5ZFZRMDRaZWhFMU1yeEFDS2Ro?=
 =?utf-8?B?UmZGWWJIYnhvYytuUnZNTXpGR0Y5WnJxcVlxOFllL3NIa3REMjhONU16aTJI?=
 =?utf-8?B?VGVCcnZHZjk1K2krYmpJQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnBDZWdkem5YWUZ5VGEzcllwK1dxTlJKamFkRnZUcTJ4YWwvWERzSlhoQ09t?=
 =?utf-8?B?TmEzc09WRGliQlR0cTI2OVhmM0duNkZiTWNoNEREdGdqVjg2NXMyOWw5WFhx?=
 =?utf-8?B?RFVWZDk1dVlVR0JwL3VrYVNYZ1ZhZTJCcVZ0WkQ4Q3RucnIyVk81UmxmUmF6?=
 =?utf-8?B?N2tQTFRZYlJvVEo5clQzQml6cUxBdENDVGR0a3FUaThNajB1Sm9uNW5aNDBu?=
 =?utf-8?B?WkZmV1NkZlM4K041Z214TmxHc1dnS3VYSTdML0tzbU91OWQzQ3RNUjQvSWdU?=
 =?utf-8?B?S2RhMXhvV0d2bXRHTnVnY3RWcHJCeFRUcWpWZ0RaN3lORkdtR1Y1bVlwRHdl?=
 =?utf-8?B?SzNxd2xTdkhZYnJKYTQ5R0R2TFVFWWNDZ3NZcGhRcHBOS0M0RC85VitvOGww?=
 =?utf-8?B?TUNocFRUN3o5ZlVsQTY3eG0zUnY2U1RKTFFkTDA5ZGVXb1JXQVVmQUlsY3A3?=
 =?utf-8?B?OTZ6citZNjcvZm5DOVBHZkZWQWNLSm5tRGRTWHlCMUZDbmp0dHVLVnNCRUJX?=
 =?utf-8?B?UzZWWnd1QmU0L0srQStEZjExSlJPZlpxbDVYbWw2SGx6WVpkNGhKMTFZK05x?=
 =?utf-8?B?dnR0NzBSbEdBeTAyaGphUUhoREE1c1Z4WUFsMFA2endkRzQyckZBMzVmNUtF?=
 =?utf-8?B?Vy9wNHRsSXNFVTB3ZnBsd1czL2pwYWNvZWlsOWhONGxPZm5iRWhycjlQMmM0?=
 =?utf-8?B?OVVzY3hOQWs2RjVQcWNXZXpmYnNmbWMrVVJOaWxaK1VJNW1NejBrSWxRQ2lD?=
 =?utf-8?B?Z0pjKzJxSTkzWmFCSTgvWjduQnk0bG55TTF3MVROWERQUWpFdU5RK0h3ZGQr?=
 =?utf-8?B?TVRJdnI5VStZVHlBeEtqZlRHNkVGeEFSQXhuam5TSkNJcHRsOU1RMmdrNlRE?=
 =?utf-8?B?ZXo2SVlkZjFsZ1I2NHVHU2tRdUVVdHBTbVNERnExbEJXeU1mRUtVWlZpSDVM?=
 =?utf-8?B?Z3hBQWNXQ244V3liVkxzTlFwOFd3cXRZU0xUNGFsbHRFdVR4WmYzcHEzaW91?=
 =?utf-8?B?eTRUMHgrTGR2b1VGRDJSSXJDQlVLRVVLOEhScDlmcTIzdUVxeHp1VXBZWEVX?=
 =?utf-8?B?SmF3N3NxQUMwd0xyWkp6TkY2Wno2cDFvaDlRcVhpRUZMY05DSFEzbkxXb0Zs?=
 =?utf-8?B?WWxoQnhMYXQ0R2xyYnVTRitKSVE1K3J1dU8xYU5WR055ejlpRGpDVnY2eU1m?=
 =?utf-8?B?K2JWcDZRcnp3cmNyTm5PeVV4QWFkMU1ZZ2k5TE5GdVl5V1BYOFhWNmxEMlpB?=
 =?utf-8?B?enZlRlc4U0dHbWVIQ2lzbk1QMkF4bU5DbnpWSzBkdkNPL09XT2lnTTFZS3kx?=
 =?utf-8?B?NWNMR2xSVkhlTUk4M3NKbzNadmpDaFpjL2psU1pBOHl1YnVxZStaNXJGL01i?=
 =?utf-8?B?VHRZYzdZdWROb2l2UklHNENLZmpwbkpnRTZPSm4xUXNHd3FobGZmU0t0bkZa?=
 =?utf-8?B?UlpDZXVjZVhHMTVFM01Fd1F4a0h2cEZZTWE5anNCQUh1N3JEaTBBbGFLZWRs?=
 =?utf-8?B?NzVURjdPcWhDd1AxanhTbHZwZ2dSbXk5NkpkT296dldxaHBHY2pSdTY0TmRi?=
 =?utf-8?B?VS9jTERDbUloWmM3Y0t6R1phRkZEaUNqeU85MTRaRGI5KzV6WU1ybFJyS3Rs?=
 =?utf-8?B?eHJiOXVXckhGM05CNWREek1PZ0x6VmI3Q3JEY3Z0VlZnT1dsWnpKYW9YNy9U?=
 =?utf-8?B?QlZJVEh0MkV2SmFtM211cmdSeVB1L2dxQWNoa1NzUWQvRDRqMGxYckRGRDVr?=
 =?utf-8?B?YTVjdTl6NnRqTVZReWxZK2xIR21GUWRRZ3dFVlY1L25nRVFtMThseG10Unp0?=
 =?utf-8?B?OEtDR0xhVmRERi9hRU5nK1M5dGQwalcwd1VNUll1OGhPc2JBV21lRTdLMnBX?=
 =?utf-8?B?K0NHQzRjdytydE0xcFZrTWtjNFVVWDBEeGU4NHhXcVJGVTJsdGdCQ09iS2hK?=
 =?utf-8?B?THBGK253dmptVWd6c1BCWDZXOUxHanJjWm9oNjF4SUVOKzZsMTRTL0lneGxj?=
 =?utf-8?B?MDJWZnFPQ1VSWlkrNm0xVGYvOG9VbzJkUGxBeEJtUDVaTFRLK2dQRDVlV0lz?=
 =?utf-8?B?eDNPbHVYUFlhYUR0THJ6WU8wcWpoSEhvb1hDekhXbzBISFIyb2dMTW4zR21w?=
 =?utf-8?B?NGxwMXM2Ry9yUlNlQjJyM2U0R3lzcVR5T1d2N2JnSGZQbEFIVXlveEhxREpE?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Edq0XDIRTHv2XeR2Zh4QtKDStj6CHCaA7Wy4gZXKU2SdVXMgO/jikN7llEVEQAt/CcTUo5AB8pLrgAiWue/FmagBAc7MyXGrTyFPHG+P7CpMyGP4m7KYvdjWmwb902fY/ESdWlTG2vnfoX0vv5ILwLMrqWf8ww9ryZAZrAT0QGD8SAv7tSeWr6tGpxu0URvzbpDt9UXd7sYIrk2BhOHbxliSSI04YQBykz706Ak3lckZyFNaI8AOXbZRzPDR55RZeGNDpwCNOqSYI2lh1R1HAkZIvL3QZQPlbOKpGi8PTfRn9zUUw0ISdyvTqKHmPoR6SVXXVa92jeKNaE2PECtDRhW2uaoLK/w2idTjKJGMNqS62aLyvJmBYlHiHEhuebtGna9x/1d7wAv10FJwdqQ2m78rydTcgHP0NoSq8mzo6L6aGVCTMmJRXLKygZoS8e5AEZviQEMDHmnQZXVs1tqVeiZDbU6SoBfR3JnNiYtowLDgkQnIBNwI8v9W1oxA1XXb/NPYZtpgUbr3UDc/PdhQPvt0lGhxqKAO1K03RpMfyKmtK3HzPjiKkqOFONl1eURrSg/s66sVAi1BYdRr6YiKxZnydESv4b2RNAtlG1eJPiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1818cfeb-7420-42db-c12e-08dd106d297d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:58:39.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2ef9EJ6BMhq6vAZ/05hyYetev4JA0qHn8QCc/66Gw9Lc5CWZSab80c9canlElA81GQbYJJR8I/2FkkS9HveWl+LsW6J5BkMX9irIHIElRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_10,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411290098
X-Proofpoint-GUID: 0URp1Ru42kRUox3Zn85KDWhlEpGb9RIP
X-Proofpoint-ORIG-GUID: 0URp1Ru42kRUox3Zn85KDWhlEpGb9RIP

On Fri, Nov 29, 2024 at 12:44:10PM +0100, Alice Ryhl wrote:
> On Wed, Nov 27, 2024 at 4:41 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Wed, Nov 27, 2024 at 1:01 PM Alice Ryhl <aliceryhl@google.com> wrote:
> > > On Tue, Nov 26, 2024 at 11:10 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Fri, Nov 22, 2024 at 4:41 PM Alice Ryhl <aliceryhl@google.com> wrote:
> > > > > This adds a type called VmAreaRef which is used when referencing a vma
> > > > > that you have read access to. Here, read access means that you hold
> > > > > either the mmap read lock or the vma read lock (or stronger).
> > > > >
> > > > > Additionally, a vma_lookup method is added to the mmap read guard, which
> > > > > enables you to obtain a &VmAreaRef in safe Rust code.
> > > > >
> > > > > This patch only provides a way to lock the mmap read lock, but a
> > > > > follow-up patch also provides a way to just lock the vma read lock.
> > > > >
> > > > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > >
> > > > Reviewed-by: Jann Horn <jannh@google.com>
> > >
> > > Thanks!
> > >
> > > > with one comment:
> > > >
> > > > > +    /// Zap pages in the given page range.
> > > > > +    ///
> > > > > +    /// This clears page table mappings for the range at the leaf level, leaving all other page
> > > > > +    /// tables intact, and freeing any memory referenced by the VMA in this range. That is,
> > > > > +    /// anonymous memory is completely freed, file-backed memory has its reference count on page
> > > > > +    /// cache folio's dropped, any dirty data will still be written back to disk as usual.
> > > > > +    #[inline]
> > > > > +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> > > > > +        // SAFETY: By the type invariants, the caller has read access to this VMA, which is
> > > > > +        // sufficient for this method call. This method has no requirements on the vma flags. Any
> > > > > +        // value of `address` and `size` is allowed.
> > > >
> > > > If we really want to allow any address and size, we might want to add
> > > > an early bailout in zap_page_range_single(). The comment on top of
> > > > zap_page_range_single() currently says "The range must fit into one
> > > > VMA", and it looks like by the point we reach a bailout, we could have
> > > > gone through an interval tree walk via
> > > > mmu_notifier_invalidate_range_start()->__mmu_notifier_invalidate_range_start()->mn_itree_invalidate()
> > > > for a range that ends before it starts; I don't know how safe that is.
> > >
> > > I could change the comment on zap_page_range_single() to say:
> > >
> > > "The range should be contained within a single VMA. Otherwise an error
> > > is returned."
> > >
> > > And then I can add an overflow check at the top of
> > > zap_page_range_single(). Sounds ok?
> >
> > Yes, I think changing the comment like that and adding a check for
> > whether address+size wraps around there addresses this.
>
> Hmm. Looking at this again now ...
>
> For one, the function returns void so we can at best handle overflow
> by performing a no-op.
>
> Another question is, are we actually okay to call it with ranges
> outside the vma? Does that just no-op or what? Maybe the Rust side
> should just bail out early if the address range is not a subset of the
> vma?

In unmap_single_vma() invoked by zap_page_range_single() we check this:

	unsigned long start = max(vma->vm_start, start_addr);

	...

	if (start >= vma->vm_end)
		return;
	end = min(vma->vm_end, end_addr);
	if (end <= vma->vm_start)
		return;

So you could specify start <= vma->vm_end and end > vma->vm_start and it'll get
clamped like:

0                                        MAX
        start  <-clamp->
<---------------------->xxxxxxxxxxxxxxxxxxxx
               |--------| VMA
xxxxxxxxxxxxxxxx<-------------------------->
	        <-clamp->

However note that we will tell mmum_notifier_range_init() and
hugetlb_zap_begin() incorrect values in this case... not sure.

I'd prefer if rust would strictly only allowed ranges within the VMA.

>
> Alice

