Return-Path: <linux-kernel+bounces-572229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B41A6C809
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB75E7A6A05
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBA18BBBB;
	Sat, 22 Mar 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QfBBp6nE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zw/ZFynV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D413B5A0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742628130; cv=fail; b=IbyEmXk47Bb0hyWZLBJfIUnqRerNHirjK8reSMrl35J+MKT4z2tBQoSD9/6gcMB4DvAi5aagVEQK1IrWmOn5gKx3AdbJIKy2ExMbqUtR41UysWRscZ9klJOIKF5FUq+DJL6toMIX6/Uo57fvpNVRDKy+kiOqaRTuMdDngTCjHBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742628130; c=relaxed/simple;
	bh=aMizMAsXrS9DafYO2cldBDLaicHIfL+a07hf6cg7ttc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0tgb7e+dsKoMTo+hXqrjUYDTyWOkjnfRtOOGn0dvEpV9zJmvYAZsVLpK9/F1UArDP7pTVUti3Jyr5Viaoa6OY598xX5YmzihcQQ1M1+Is0etMDMZUnUwgFxHaghnsmmj4LYhQCwLuRra5M9XDI5vEAep8KUf+Zgj1DLLbR7g/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QfBBp6nE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zw/ZFynV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M5CA32029727;
	Sat, 22 Mar 2025 07:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Qw7wn9frbnLHjTsVxWb45o+Bqmx0i+tGcj4DvuGWAes=; b=
	QfBBp6nEIRCv/tdtkTXY+SoytEVkYDJceJGadLws4ONJvuRsE52O8zSBOvjUinsH
	hZFBeT0K8GXvfgk2kxpgZkXfa2UkTGXTkeG+SbJLmPrg0HY/NIyHk8k63nJNg5lt
	oQsX4qWRqjcZvTIkOWFU6A5z3q7Z/qT34b1ec7SXKtH2MtAdfpJOgJHe/x2Q7lNJ
	hpDkeIRrxIcLkAEbMkwkCZmnIRKZCwkXvouagAlhj6T7ji9hLpgHZ/boh7pBR85G
	XOCfP9bjlauEHivhhAMIXsI8CAakCwlVA8+XwxXVG5YZkq9YC92p+zkj3kwtAjBN
	uHIW1rp1TD74vtatGFY77g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5m03rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:21:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52M399CL007338;
	Sat, 22 Mar 2025 07:21:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn6554q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 07:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSYRNhb7PBVXb+l1XJXAMYh+9epC/DgdhlliA4yay/sViIwW68lyA6Ds9+knbusW4oKjhvRKhFBmljVelHjOEQKaqosRdm2bcnISFpiKEqP9+F/vnH7zRWWWx2jvSdWJmXxiBpydZbMkxpXG83udBJRtpKd0UkQD/M5/6+lIlywzjKAcK+br/ZSE6xhPYsgxZQg+HSPszP2B8idKIE0hUK9vwtyzD2cPgkQDCyIwGK+sFug3Cs8wgo4mLVLf0fS8C4DRVW0k1ovroC/g+rBjK5uvWuvFRRsZLx8Gc2ES85J7cCb/lBTHMDE0b1bOP6sGzMwTGtUcxrvratLwR000mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw7wn9frbnLHjTsVxWb45o+Bqmx0i+tGcj4DvuGWAes=;
 b=yWRkz2d9+vHeUP1PHOgh6GqTiz6aWeeqDQGPhyuTu77+n0FsSfBrYC6hoPMNObFNXkVh8zekJpmqy+d5rnHkDvoqRtyAKubbx3Zp5TxUYzOKe1aE+IENlsbEGXJTcMxDqZF5VnTonnnB4M47x+6bL/MduvFxUqRuiGs4PVG+2/kk/ZUbYN7ojWKyCU1ChPndpKXvD2bJGgWgQtuRwrQFhuCCP7g+ZZUQLR0U2gYTAIwmyKqZZtqiHqdvcp0Y7o40vfe5CkfpHT2xBGyzO/9JvgbS5lzkanrrXpE3wknfr9//Kk3qnWiudmwDgHqLZanJu5rNuWokimKPgtCa9b2RDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw7wn9frbnLHjTsVxWb45o+Bqmx0i+tGcj4DvuGWAes=;
 b=Zw/ZFynVwbX6qUMq1y5C2Yb9wss80KlePMCRBaJN8zJUZ6U91ajVMQ/0Fv+lCkT2VQ9K7PMsrqs9YzBP+f4KPhHW79V0cieN2V4i+hQd5TrBMaKCHKD1tZUJC6YKYwevcMkFNx0Jvv2QUoCpb9G9t/ZWNUPE5AxJTRZi0wSEPSc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6559.namprd10.prod.outlook.com (2603:10b6:303:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Sat, 22 Mar
 2025 07:21:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 07:21:51 +0000
Date: Sat, 22 Mar 2025 07:21:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/mremap: introduce more mergeable mremap via
 MREMAP_RELOCATE_ANON
Message-ID: <9f81bfe4-4cc7-4754-b92f-db3a4e549f86@lucifer.local>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
 <d10037699391c42a4943f578c2a0bca890640f30.1742478846.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3CiRTUv4Qwy_UQzQuEDtUoPVVXnuPyiWoAhWVqkF3VTA@mail.gmail.com>
 <182bf1ce-1b67-4243-854b-4d0c26aae563@redhat.com>
 <21f89b73-aaae-4674-aea2-aefc7a4847d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21f89b73-aaae-4674-aea2-aefc7a4847d9@redhat.com>
X-ClientProxiedBy: LO4P123CA0280.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8ebf1c-5a80-415b-52c7-08dd69123720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHJyYkYyVDR1anhTZkphR21Ma2VIc1ZVa3RZWXRwTEdDZWlMNldGNE1HNC8y?=
 =?utf-8?B?dGUzS1BGdjBJT0g4UG5KQVYrK09GdlFta2pQWGd5SmVaV0NuSnNCV0I2amFM?=
 =?utf-8?B?eWVwUk13SnZxak1DMGVXbm5BUlpMREc1VlpnQUVTR3ZDN0FicmRwNGhWSm9z?=
 =?utf-8?B?SE92clYwQ2FMRzZWZnFydG5jcXdNSm9Ub2VzYW1JaC8vYkFUNFYvcE5HNHN2?=
 =?utf-8?B?Wmgyam82VE1BaHltc3FxcWxKc3ZibjUyS2lhaGNNeGVGUDgwWGpiTXc1N29E?=
 =?utf-8?B?VVFNTUZFQUxoMjNPVjhuK1UrR2VsL3l2ZDUva1dvWWpxdEVCUTl6b0haV09P?=
 =?utf-8?B?UnFnUm9mM05UdFhGM1JoakVxK0xMTjI2VDBVem1vWGJpSWF2SmU2dWFocmFv?=
 =?utf-8?B?WERZWjMzOFBXK3ZTMVpGRVlXZGRvUUQ1Zm9uYUltS2Y2M1BVVTdGMFM2YnNM?=
 =?utf-8?B?VDlYRkplaWVoYjFWT2YwcUY1TkpIUzJqYStnS1FYeUVVNzRRL3lTdktmN1B3?=
 =?utf-8?B?b2lNRlBpZ0Zka0gxTGNvbk0vTDVsV3pxN2t5OGpJSTBkZU1ubFV2MWZLeDky?=
 =?utf-8?B?MXFIUzBhSlVvVmlPWU5EUzlrL0pKQ25Lbnh2ekN5d3RmK0ZOM2lVRndrMzZK?=
 =?utf-8?B?cG9xU3JMdHZ0SVhiMzgzR1hrb29YdElBalJGZ1lEOE8zN3hHSTVPVUQ2NkRU?=
 =?utf-8?B?alVSSWxVVUJNd2VlaEEvY1RkYXBrV3JwMW15amxUVDVGVWJ0VzhZeW9ocHd1?=
 =?utf-8?B?N3lsWnNRWVRYb0ZCaXJIc1NIYzJOUXhmYndqbiswZEQ0N0FLU2hzSGg3QmN3?=
 =?utf-8?B?R3hpY254V28xWUY4ZjU2RENJS3pjNDNFLzdHYU5NNVVhRitCaDdzU2JpTnN1?=
 =?utf-8?B?eVp1M1hLeE5hNTlpUmduKzdjSFdIU3B2Z2xPdzNjRXRHR3NqNE1pR2tsRGd3?=
 =?utf-8?B?THBWdjN5ZVRiY0J4bzFFQy9lYU9za0h1NTNuNmpZeExIOHVrUWJqaFZ1SUZ6?=
 =?utf-8?B?UElDb3Q0ZGkzYjhVaGdOTmR5UnltU1BYNlcrUWZkejFUQWdJQWtvb0RzT0c1?=
 =?utf-8?B?WjVzN01IU0FmZFl6c0pIS0w1RXpnZU0vbGx1UFd3VjlVVnRIc09DOTRmSEhq?=
 =?utf-8?B?dlFEdk4wZE5VbTNhRkdleXVtSUd3ajA2WDJGS3I4Z2o1SUFCVlJQQXBPUHJz?=
 =?utf-8?B?Vk5xeFBrbUpRT01XMHZ0ZXR5SkVwV29JaU1OWmZJYlFRUEV1VnhUNDhNR3o5?=
 =?utf-8?B?Zzk5RG5YelM1ZndidmVJcXRNKzdId2ZMcnhCY2dSdnphUnNzSDJEcElmM3Fk?=
 =?utf-8?B?N0hEd2M1NkswWGVlUURBMThyeDJUOWt3bTZMMS9IWDZuZU9aQ0pDNlJrMTVi?=
 =?utf-8?B?OW1mbnprdER0R3dnOTN6M0RGdlM1K2tRWmdtbU53Y3lrYVJzT0FSV3diQ3lE?=
 =?utf-8?B?VVV6ZEEyMCtiSGpHVWJnTElLVUxkV3p4V2VVYkZubGVvZ3BxeE43VWRSUVY4?=
 =?utf-8?B?VEdwZ0FzUGpKMVlBd1NSWVFNNjFkbFJRMUdmdXh1SG9wTzd3SDhWWHhXc2JB?=
 =?utf-8?B?eHV3cm53OTZhb25KL2lPeHJjTndpM3pwUnRMRTVEZTNyOUlhd1JVeE81Umoy?=
 =?utf-8?B?bjJmRkhIMUNqUFpMZjc3VkliQkhkd0gyelY4QXR4am5JZDBzVUt4L1VHTVNq?=
 =?utf-8?B?RzdUTFN2TGJqWnIvMXJBcXQ1MmJHaUI3YlQwS0F3allCZkNvNktXZ25nMFBq?=
 =?utf-8?B?dEFJMmkvZDdkejFMNGE0a2RnbGpIaTFFa09IYkRRUGJ2MzUvc0JGYUUvRkRu?=
 =?utf-8?B?VVpCdFhlNTd2UEFrZ21zenJmQ25la3U1cnV3N0oxZ0t6akFFTGdGZ1BnUnYz?=
 =?utf-8?Q?rqA4LGRk+CE3T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2IzOUIyK00xVmhCaG1TWG9SKzdsQ1FqZFMwK05ySUZRWS9BYms1dWNJUm1U?=
 =?utf-8?B?ZE1HU0Z3SE5RYUIwSFIxUGNKb1c1Rjc4bExVYmF1WmRPZS9XajBLZ05KSjdE?=
 =?utf-8?B?MDJ4a1gxeUxFT281VUxUUnhjUjNYMzduVVczcHhJUGd4QjB3d2VYZGRJTVlt?=
 =?utf-8?B?RDF1UFZkV25aRlRXTldmMzVpZ2hKaC9ZWmpBY2h5VVhRR1Q3dS9OSjVVcWVj?=
 =?utf-8?B?Q1VlemJSckVtYWJFY1FMT045WjIxT3Q2N0N6eVlZVmdrOTJFUWVPbTArSzlm?=
 =?utf-8?B?Yi94QVVkUXJybzJCQkJnSGQ5bXdMcWpRVEtndElLZkpzR3BjdDNKWE1kYXVw?=
 =?utf-8?B?bUY2ZnljZExnb242VlFuS2d4SGpIQVRBUlcrTldMem0ybkhuaWVwa2NjQXdV?=
 =?utf-8?B?SmRzeHBHbEFLby9VTHV1Ukd6cWcvUWo2aGRlUVJudGh6eTFWbHB5dll2VWxs?=
 =?utf-8?B?S0krVnVjR05NUC9GL3ZNZHYwSnVkanl2WUtIaEdjN0xVV04rL1V2ckorQkxn?=
 =?utf-8?B?aytRbTNzcDU3S2xhaExjUExnTEZUeVBaY01icENvTFFGa1hUNCtMSVYzT0VB?=
 =?utf-8?B?UVRWVU0yS1ZBbm9RbkxXdXBnblk4NEdMdGxGZ0xkbk9ucnpzRnJnUTFwNnVK?=
 =?utf-8?B?MDJFQnhHVms3aHhPN1B2bkhWSnhnQkxQWS9GY3BtQnhUdFlOTW1yMG0zQ3hJ?=
 =?utf-8?B?eWZ5cDhYVzBUT2hLVlU3MEJHN1dlNWplSUdZYW5GZUxTc1BIT1ZvL3RMT295?=
 =?utf-8?B?NGFQRGtybHFaZ3pETklyQm40aHlYbWNKaUowTzlpYUZnUmQxYllxSC9QUm5M?=
 =?utf-8?B?OVRmeFV2bHA5eHNZQzJUUUo0Qml3UzhMSkxUaXZPbnNGNmpOZ0JOdGNSajNk?=
 =?utf-8?B?YkxLQ0xFWDNuSzZqaFZDeHFlaFM1ZHlNVGliUS9RWml4OWxsVGNRQzB2akxO?=
 =?utf-8?B?MXRyd2I0bHNCakJVZGxCcXhkYmg4RjVueUhlN21pTFJWV013bEV1ZWV1VmJB?=
 =?utf-8?B?ZW14U3NOdXg2YW82UXNJL0dtTjNsam9vSnpRNUMwL0svVExReUJrdi9UMU5T?=
 =?utf-8?B?MEVubGJpUWg0aWRMc3ZneFNXWk1yeldoZUFLYW9TaHRLdTdyb1lQR2FyNjVa?=
 =?utf-8?B?a3hIVGRnTXFSM3N0S2dZQVBLc3FYcVpSc21lZlBDakxCcmFBbFRrVTZqRmdw?=
 =?utf-8?B?dlJXOVpPTVBpNHVacXhHbllUTCtvc2dJV3dnN2tVSEhWdk10aDdnL2dmMkY0?=
 =?utf-8?B?ZktGNm50aXBWUVZUWHowUGdwcXppdGlvT0F3WWJIRkwxNWtDamFwRVV6REo3?=
 =?utf-8?B?YldGcEEwNlRXWjgxVVdxTmxiM1M0c05JK21ydXhTTWlGYzlXUXhSeVlEQkU4?=
 =?utf-8?B?ZktVWEpVREtnN2NTYWRvWUtKRjFBMWp6d1lYbng3ZTd5RDR3eFppbDhNcHRk?=
 =?utf-8?B?SmxXbzR2bUJMTGFiaG0ydXNSWmF5UlVTUHRBU3E3dGJ3WkRwS2t2TDhtYUpq?=
 =?utf-8?B?NERiM2kyV1o4K1V5Y2VSWkJIMExDUnAxNFhXdWEwQ1RGeFMxcmxWcU5uNTNs?=
 =?utf-8?B?c2JNVkd4NGxxVGRHR3dybUordDc5ek1XVThTVTB3ZW95WEo0eDRya0dWTEVL?=
 =?utf-8?B?RzVicTd4OURJMjdYaHdhUHovTWhWNHVrZ3pHMGttak13K2N5WFByZ1FmS01r?=
 =?utf-8?B?QWpraktHSTlZdHV5WW9BaHpmTmdCbGwyNWdQQjF5UkRZc09ScFh4Vjh0TWhm?=
 =?utf-8?B?cWRaOTNKTlpEWFowZ05MOVpYUjR5cnd4NkJPcExnSmY5b2FpQVpjRWV4MTVI?=
 =?utf-8?B?aTV5YTFqMzF0RTNEYjdLZUx6OVlVUFNkN1BCTERldEs5Uzl3ZGgrYTJ4M3A5?=
 =?utf-8?B?aisxbENESEpzam5HLzFFTXo0Vm11N0RJbjRtNG42NDRBUDh4U2JmRE5QRUZ1?=
 =?utf-8?B?QzZYMTBrand4Yy9XWDNyMVBaSFo2aTlFdEp0MkdGdGxiT2pVcnJ5TUVvQU9p?=
 =?utf-8?B?amNuandreTdnOTh4bEJtQzJSVTBJbU8rb2pIMkVpR0NnSlNSK0IySXc2eSs1?=
 =?utf-8?B?R0dyNU5OZ3FNVHM5NHpwVDRuUVREc0h5TVlDdzU0RE9iNmRjbDRMKzFsdkh5?=
 =?utf-8?B?Z0RCNXZVU3VLbDl5VnpHdUxhVFZldk9JM1ZIRmlncXNGUTFmbGE3Sitwalgw?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ViG2j6dXpAq7DbINmy5yz/uzOlflpT73ZZXOha/AExWQeeIpebzWL7snDH8tqteS0uO5H+ikPFmY8Wz8iYcyFpOpPgxbKld9sMKcA5CVYQ5ClwfVIgB76CxjaY33a8c07bfdZ5ImyKLGhTnwrk6FvXTh9Unjqv7lhE8PDuDKCHVRSF4qYMtmcpsJ8HwIrSQTB0NHkz4GWadBDMy/5qn16Gz8rvPE+P7Pyy4c6RZZksBc715VZpbYPTQOQVzYDdqWOxtD0mN2ylPAx3Xg/SAE5FVEnaDr3s5AsPg93uB77mfCtEJzx1xPdu3pCtI8mbZczBy5V89Pq8m/aQLn0uaIS/j6agUoHeAqZMTkGVld9qZJ2U155De9S9lD4fHJUWsGTaWOqCMEJ8GB+hjOBQ/MtlEFqG/GqqDpQRrMrw/TNDahfkkYpISgPo5BLlOIB4ZLEQ2tBW/0OCV9nM/8FDKidU7mU4WVaLWq9RX/OcUd/FWPlAxL+BvsxbLFnbGjrOfALhkCqMJyW0hH0EgnrA/TN15PApOglcY8l8hnn0BGDMxTl/fu5lX7xva5gjq27UU09kT2Y0dv0zJ2i9+JqoILAbkvebxVyfrwNu5hSvXsdAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8ebf1c-5a80-415b-52c7-08dd69123720
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 07:21:51.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqXVIuEjuxw/Ad6K/LYKiSIZgk3cd8pWC2/njbpZ/DXUljhT68qHLbfKONRM61fLhdXF93KTONLjbS36XOJOathXGOTxwwmV7v7FIsLAhdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503220051
X-Proofpoint-GUID: tl_pE0gdnFiX3p12KnTTfTeSleAcGz6J
X-Proofpoint-ORIG-GUID: tl_pE0gdnFiX3p12KnTTfTeSleAcGz6J

On Sat, Mar 22, 2025 at 07:17:05AM +0100, David Hildenbrand wrote:
> On 22.03.25 06:33, David Hildenbrand wrote:
> > On 22.03.25 01:14, Jann Horn wrote:
> > > On Fri, Mar 21, 2025 at 10:54 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > index 0865387531ed..bb67562a0114 100644
> > > > --- a/mm/mremap.c
> > > > +++ b/mm/mremap.c
> > > [...]
> > > > +/*
> > > > + * If the folio mapped at the specified pte entry can have its index and mapping
> > > > + * relocated, then do so.
> > > > + *
> > > > + * Returns the number of pages we have traversed, or 0 if the operation failed.
> > > > + */
> > > > +static unsigned long relocate_anon(struct pagetable_move_control *pmc,
> > > > +               unsigned long old_addr, unsigned long new_addr, pte_t pte,
> > > > +               bool undo)
> > > > +{
> > > > +       struct page *page;
> > > > +       struct folio *folio;
> > > > +       struct vm_area_struct *old, *new;
> > > > +       pgoff_t new_index;
> > > > +       unsigned long ret = 1;
> > > > +
> > > > +       old = pmc->old;
> > > > +       new = pmc->new;
> > > > +
> > > > +       /* Ensure we have truly got an anon folio. */
> > > > +       page = vm_normal_page(old, old_addr, pte);
> > > > +       if (!page)
> > > > +               return ret;
> > > > +       folio = page_folio(page);
> > > > +       folio_lock(folio);
> > > > +
> > > > +       /* no-op. */
> > > > +       if (!folio_test_anon(folio) || folio_test_ksm(folio))
> > > > +               goto out;
> > > > +
> > > > +       /*
> > > > +        * This should not happen as we explicitly disallow this, but check
> > > > +        * anyway.
> > > > +        */
> > > > +       if (folio_test_large(folio)) {
> > > > +               ret = 0;
> > > > +               goto out;
> > > > +       }
> > >
> > > Do I understand correctly that you assume here that the page is
> > > exclusively mapped? Maybe we could at least
> > > WARN_ON(folio_mapcount(folio) != 1) or something like that?
> > >
> > > (I was also wondering if the PageAnonExclusive bit is somehow
> > > relevant, but we should probably not look at or touch that here,
> > > unless we want to think about cases where we _used to_ have a child
> > > from which the page may have been GUP'd...)
> >
> > UFFDIO_MOVE implements something similar. Right now we keep it simple:
> >
> > 	if (folio_test_large(src_folio) ||
> > 	    folio_maybe_dma_pinned(src_folio) ||
> > 	    !PageAnonExclusive(&src_folio->page)) {
> > 		err = -EBUSY;
> > 		goto out;
> > 	}
> >
> > Whereby we
> >
> > a) Make sure we cover all PTEs (-> small folio, single PTE). Large
> > PTE-mapped folios are split.
> >
> > b) Make sure there are no GUP pins (maybe not required here?)
> >
> > c) The folio is exclusive to this process
>
> On additional note as my memory comes back: if PAE is set, there cannot be
> other (inactive) mappings from the swapcache. So whenever we use folio lock
> + mapcount data, the possibility of the swapcache (having inactive mappings
> from other processes etc.) must be considered.

Ack, do you have a feel for how such a check would work?

>
> --
> Cheers,
>
> David / dhildenb
>

An aside in general:

I realise all of this is very fiddly, this (albeit early) RFC is several
revisions deep and fully expect considerably more fiddly cases to come up :)

I plan to do some deeper testing on real iron running very heavy workloads to
encourage reclaim and races btw.

One test I've done in past is to just hack in forced-on MREMAP_RELOCATE_ANON so
_all_ mremap()'s that move do it, which has been a good way of finding issues,
but also in tests I add in series I intentionally trigger reclaim via
MADV_PAGEOUT.

So in general - I'm going to proactively try to really eek out all and any weird
edge case stuff where possible before more seriously pushing this series
forward.

Thanks again for early review, it's much appreciated! :) and see you at the
topic I'm giving on this and the pub after... ;)

