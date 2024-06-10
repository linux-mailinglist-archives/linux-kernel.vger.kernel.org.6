Return-Path: <linux-kernel+bounces-208336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60699023B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB7928E857
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B92145FEF;
	Mon, 10 Jun 2024 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DmbHcO/w"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06E145340
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028462; cv=fail; b=BrS119yEAzfaY3XFUpsyPX1592EtC4xw45TW+gnuOElc8bunS6OYgvYH6kc5QoXYlmRbG08eN+7JvodnXetc5e9wC+dnkwU62yY3ML26gB4NvlE5+0NMhiQ36QUNjEvzIM4a7Au/OD6A1isMT64Ik/oCh7O9m9WaKhY5iksyejI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028462; c=relaxed/simple;
	bh=eywOFCslKGXhD0AUiDNs/Nf+YnE74TgEPBIbkGAdocs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJCqE9VwYbUT06PZXEIlOCPe7n2qH2HIz2211xyHWFXyaaeyxlE4v4ugZxzdoGnybF4ptPuFc8FJO243RWoJz7Bp47owJJr5SQSsz/b5DCJSOtPNX234dtAkHchg1uvvF4lFalTKDcx+pqr8fV/Y/Aklg2cVpdp8VJfp3+wLE8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DmbHcO/w; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEARuhKlHJhTDor5PqN434XblVT2/efgMBmfBWQq6okrHOog+ghQ02YRLuwHtWJZ1WaZbdqNhnpEv5D7DW6j0yAGoY0ga4MUsKQHWnkR/bQ1DYskYyELTpyyKlSUVHCG6e9Vy63v1eMEdX9XQLqNZK3INgb/tdpiSXdvyfG9DbRsPxiJgI4cqyZtktx5cmVMhLj2b0ENCoF4dQFFcO87C+mXr8eIk/jniB01rbYHqBIDYqmwiO6Vzqv1Jc1R0ikPTy1cSWO+WNj7uMws9/F9Bc6mmiOkRENydNDjQI1ghAz4quLaUxWi8SqfCuVX2gl3S/5hq1L2PKnWzF/1euoBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPOQmADVjzmKBsHiuRQ5xx9bRn5icjKTQysBavmhZXw=;
 b=oSDL8T/L2EDsAJTuLjxejvf0SjNQxaNY4r+Pdzk8SE8GUnJP0k5IcQptL9BEO/TAzOqNN7xpZeWQ5OVrDlTfaQfOuoGUuu0Rs98sAoubN2PAs3tKUMRsZRmqvLezJiKas//xhAoiEClUAtww9uGJ4AeYiEWHLNiJRgHZdgw+PtCgOmi5rjCjbEer4m+yUR5SUAcH9cD8ccv3NnBiuFm7CHfRuv6vAd1FZh7CWxkmftAbPPaln7EIxSaXeHfKJgSQu7lem2wrnWLBbj1U51RkqVJ9jCMJecsaZ+wRg72+ZGKp1UWrw8QXYwNiEEh+7lfjNZZgMyy3wJVhH3YHVvbSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPOQmADVjzmKBsHiuRQ5xx9bRn5icjKTQysBavmhZXw=;
 b=DmbHcO/w6NCls6m7thBKMj8L95M9NJPPbNMMHEcom2CB+rZ/QmU0iR+VwyrVkRB1/kLiJERDvvP5h7X4nou+37zVsI+Min3ujGqrRGP2mbA0pMDmDe8cRG9yqBId5BXuFhNGQNc0jEs+o8PYgP4JH3rJAnJ0c1qhzQw8TyaVdLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 14:07:37 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 14:07:37 +0000
Message-ID: <c29b348c-6085-4fc2-bed1-4db103dae486@amd.com>
Date: Mon, 10 Jun 2024 19:37:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
To: David Wang <00107082@163.com>
Cc: jsnitsel@redhat.com, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 baolu.lu@linux.intel.com, jroedel@suse.de, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, sivanich@hpe.com
References: <31f16e4e.afe2.18fc9d5dad0.Coremail.00107082@163.com>
 <20240610131550.53651-1-00107082@163.com>
 <682dfa6e-7f81-48cf-920e-14d4f2c46fc1@amd.com>
 <373a0740.2481.190026d9d87.Coremail.00107082@163.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <373a0740.2481.190026d9d87.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 5117e41d-5064-4102-fcca-08dc8956ae92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDBCZnJnRUIxRDV0U0RrYzdvZTdSV2o1Tm5pUHhyaUE1Um82OHlNUXFHSkpI?=
 =?utf-8?B?V2VZZmxsVlV6cjMwcURBMzBydnlDbHl5QzJpSzFteWxQakhsYUtmeW5Rbm5B?=
 =?utf-8?B?QldxYWx3RUxsWUMwaEdsRVAwYzJBSnFvdDZBRU5tMjArYzI1NDM0ZzhiTUlu?=
 =?utf-8?B?bDVZcEE1QVVpKzZPeVlzd3pJYzgwOTdGUlJDa2ZaaER5NlJPRjdacnYxTmRQ?=
 =?utf-8?B?U2xmRk9SandpUTJLR2U4WDVXNXZ6TzVUc3pma0g5aCtlSi9iSG9YOUYwc3Ez?=
 =?utf-8?B?Rnc3NjZyR3FmQ1hVcTFoMlFlcExxa0pwcTkwcy9IVzdyc3pSYjNLL1pjeTlP?=
 =?utf-8?B?ck45LzdFTGlRUE5nSlpCZm92Q3grWmpSK0lqbnJrYXByOGR1SUxqRG9ldHJw?=
 =?utf-8?B?ZlA1SENwQlA2OHJiNC81ZDYvd2Q0RDEyMVJvdW14R3lkTVlaWVFnZXBHbnFL?=
 =?utf-8?B?MjdHL0ZQdnVYY0F4K3lQaUt5NkRScDZFZUJ2ckl0L29UQU9POHRtZXFFeURM?=
 =?utf-8?B?M0tkc1dheTdsZXpaUWxXa050eGRuaTZSM3lRMnhtVkNiZGNFS3ZFcy9sUHV4?=
 =?utf-8?B?eFhvNXN0M3VYenVJeUVOMXI1SmJGKzlUNjY3ZzN0eCtETlFjcGhLUWtnaWdI?=
 =?utf-8?B?SXkwbWxuUHh3bE1Bd1pFb2lrL2VCbEFIOVZTa2x6RU9SSW4rbEN3ankyQkNL?=
 =?utf-8?B?MkMwRGpmRGdRK09nRERKWnFWanBicFRCdmd4VmZOOUN1aHRXODNkb1o5bjRQ?=
 =?utf-8?B?YS9BVGVOUzFkbklBK2pUQ2trVUNQK09mMnBBM3lwYzBGOWRuakplOXJCWUhU?=
 =?utf-8?B?ODB1QjVYM2J4SlFsMGQzWmdiYUJ6ZzdhT1dseDA2MGlsRFNqWjJqMWtuZEtB?=
 =?utf-8?B?dFBlYlplazFSSnBZZkhTaGtnK3BZOVIyRURuc2dseTc0K1pJLzF1SzNMSUM3?=
 =?utf-8?B?TE55aGh1TmxUK3dBcjhKWTlvb1ZCS1hEUlkxUXpFWU5JaXA2ZklidjVrM2xu?=
 =?utf-8?B?ekZXMlM2OXltTy84WktZallVZ2x2WXVtY3Z0MFBqZ1VJYVJMRDBrWng5L3o0?=
 =?utf-8?B?UnUyenJLQkZwaU9QMjJmTDZ2M2kyd215SWxPMG5IZTROWks0aUliMWNsSkZC?=
 =?utf-8?B?cHlFblY2dmlleW1NcEFTZ0xEV3NuWWN0U3ZVeEd0VDNtYWNRdXJ3Tzd5Lzdt?=
 =?utf-8?B?OTh4UWd3R3owS095T2cwRUJsRmVtRGZzMnhpS3VTRFllSTgzR1RPejh3c0J6?=
 =?utf-8?B?VTEyTTZoNFBPVVdSVEpzZUEzV0ZUTFhOVUVJOENoTVlWNGtJYXR6eG82c1g3?=
 =?utf-8?B?aUwzQW9JZnhuWGhxcFZtbkV1ZmlxR1FjNjZKaHdnMkpQVFQvcTdoVFZIUFRu?=
 =?utf-8?B?SEczbEhESlB5eWM1QjllNzdXMWtJMjJiUkNNQjErR2MycU90czFLd3dMdkdP?=
 =?utf-8?B?Smd6SDE5UlFuVFRWbjFFcTh5T2M2QkpYVjREczZDeDhiMWZhM3RBNXJmaXNT?=
 =?utf-8?B?bTN4cEhLQjk1ZjZ5M3NaS1ZHUTFoQWtqeDMwUlIyaTEzZU5LbEdLQWhOY1Ex?=
 =?utf-8?B?N1dPdXJVam15TG9LWm9Yeit3b2wzbEQ1VVJUOFExaDdiSWJLanAxUWJGUnhu?=
 =?utf-8?B?aUVSMmNIemZyY2dLRkhNQmx3dVlSSFBEZ0d6R0hBTmZhbVNDeEtsanJLdUlz?=
 =?utf-8?B?S0MyMGF3NWxoMUZMZVVvZERIbkZQOVY5QzVlUEVQYU50YndiNGNRbzRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFNsV2I5dWpaWmtWWk54N2xwRFNySkJhWFFTeTY1WjZKRndYenVod25QMGtj?=
 =?utf-8?B?OHZ2UDJreW5RK2lUR3M3Z3QwSWs1bnlWZ0wxMUZ2dEJjQ0F5ZUFnTXpGa2JR?=
 =?utf-8?B?dk1BbjVDV0lKaGFKdkREdUpNUWtaNEJGS09UelNjVitwUk9aSUVTbUJwQ1Yx?=
 =?utf-8?B?clB1Y3F6VXM3NXdpWnZFK0lRT3hxZHBaQzUrcmxJaVNXL3FTUEYxSGdkTU9P?=
 =?utf-8?B?UXlSWXk5S2M4YmIzMzNFa1AwZEpzQS9CK0xsQVFzZWFlK1dDSkI2bHBMTUlQ?=
 =?utf-8?B?REs2cFZnK0pQTmpyclNTTWNCdjhjMWcvYTBXNndVWWpGcXg5OUt6ejZtdWdY?=
 =?utf-8?B?aSt1WERYUEVBZUY2M3V0OGU1bjFWOHFhZDhpNFJMNDlDVWtBak9qYTVGajl2?=
 =?utf-8?B?Q1FxSjJUaVNXN0hIQ01VNU5oVlExT1FpV0phMnZ0S3RLZk95MnBwUHBTR3d1?=
 =?utf-8?B?eWxTVGxUWXFGeHhpR3hwNGl1TW0vKzBhNDNZeGlTTkFpbVIveXY5MWUrQkJM?=
 =?utf-8?B?T0pSS0Urang2SW9oY1FqQzlQUzJUMXkraXNEVFY4anlWUUJUcUY3WWVwdTRE?=
 =?utf-8?B?WjB2dVZEWlV5aG1VNmFpQnBlcUV5aHRFbStXZk9Od3JTeVRkblFJWU5CQjdS?=
 =?utf-8?B?RlppdGMyWThhUUJTblJyeTJtY09pcitmdjR4MHZVYk5nbnRzdjhUSS9xd0lH?=
 =?utf-8?B?eXErU2lvQ2RXaWVWNGYzMUkyYy9RY0tkMWIrcG5ucWxOV0dIS0JkNjIyM0c1?=
 =?utf-8?B?UWpsV3JxOElTWmltMlEwUG1QNnpNUUUrMjYyVDZQSzZ0bHpleGVSLzd1THlz?=
 =?utf-8?B?UEtvcU9HKzlQVFF3a2xMSURCSm11dGlZQ3BYRHJmWmUycjlmL1g3SloreVZC?=
 =?utf-8?B?THQrNnowaExSc1k4S2t2bFNzWVNscGJjcUR0ajNLTUxhL1VaNXZnLytySzdq?=
 =?utf-8?B?a3h5OUJ0TUxUazlpenFOVGRVbUl2TlV0R2c3dmcxVGxCeXRlZDZtNVhWRzM4?=
 =?utf-8?B?LzhhNGlzZUVpZWFCZGlJVllzaE0vQmhTRUNSc2xTbXBKT0owUHlQQmZyMXMw?=
 =?utf-8?B?QnJEWm1may9iNTAwdzJLdlVzaFlYQkNVd0tWMkV6NmhUcTlhT1Y5bDRkYVVh?=
 =?utf-8?B?Z0ZjYzVXenc0M2VpamdZTjF0RjVLUHBXZjBkVGU3MnZ5R0JOcW96VGxuQ0di?=
 =?utf-8?B?MENQL0pzdFV4WDJnRTVONXNBRENSZ2I1ekQ0bWpxSmRtUFBpdUZNNldxRVVp?=
 =?utf-8?B?KzlON25qYXlZRE5LS0tWcVV4a0dwbUJuSHFiUmMwWEIzMmFKUFd4Q0dGOEMx?=
 =?utf-8?B?WU1xWG1qQ1lWSmFqTlNlNSs5RWhpU05XN2pMNTR5NHpFcjFNLzQ1OGVhR3hW?=
 =?utf-8?B?UHNDR0MveEpzNkZXblZJVDBDU25lY21ZQ05Vc1hwYjNCaW5Yc2Y3aTV4a1ZZ?=
 =?utf-8?B?U0pleStlMDBZcXppY28rZ0NmanVzN1AzMHRveTFRSlRVN3ZLc2hVUUEwTTBo?=
 =?utf-8?B?RU9Ga3Vhdk9abW52TjZVNVdBbjU2aFpQNndCQkNqdzRTdW1vN3RWZ2tHT1NU?=
 =?utf-8?B?Vy9ybU9BVmVUaDBySkR1eWdVV0pIQ1A1Nm1CSjh0UTBPb2crY2JFMlJIb1lE?=
 =?utf-8?B?WnBFeE5RS0RZeEhQUk5tdG9tMVAxdE5hTVpucld3Z3pIZkVMKzhZZFpaM0JI?=
 =?utf-8?B?M3JJMWhkNnM2cE1CZEQ1WkRjeDFxS1VBMzMxRTA1MGFZZnJvd0Qxc3ExcDYr?=
 =?utf-8?B?Z2tkdVltd3NxdG90UHZLTWJLc0ovYUpQell2OUhGckdGZFoxeXlNYlJET3Ew?=
 =?utf-8?B?SkgvQkl5cElBVU1ndVVxTW11VDc1WTNFazY5UVNHN3FoM2paQXZkYkZ4ZjRN?=
 =?utf-8?B?Q2QvYUthNDlKL0xCWDBXVWZ2MWpOSkxKRzRqOTlzQUtDVWV5TDNBR1BqOGVj?=
 =?utf-8?B?d2xUY3R1TGdtZm01dkwrekFrbVFJU0lCa2tESGt1LzdLYWFvaXh4ai85RThO?=
 =?utf-8?B?M1RaMGhGeHN5djB2WTVqWWc1NW80OVdiNXh0K29WUXk4alYwZG14VCtSc1Z6?=
 =?utf-8?B?V2tMTHdDbkIzZGhKa2hXS1dIaGtxTnhSb1BmdHNkTDRtbEVUUTlZaWRtUVdW?=
 =?utf-8?Q?9EkcIlBaQuPjkKFX3XugtbgI+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5117e41d-5064-4102-fcca-08dc8956ae92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 14:07:37.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3qUwRmDPZ29GmT7HOnEWwdeP99xvpNaWgtHQWhPYaBIfiRPUIfSrru19eKcDKZ+83KzFr4cj2G+w9ILRQ3tXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

David,

On 6/10/2024 7:24 PM, David Wang wrote:
> 
> At 2024-06-10 21:44:02, "Vasant Hegde" <vasant.hegde@amd.com> wrote:
>> Hi David,
>>
>>
>> On 6/10/2024 6:45 PM, David Wang wrote:
>>> Hi,
>>>
>>> This still happens with 6.10-rc3...
>>> I think this is a serious problem for AMD users who used to `suspend`...
>>
>>
>> I am sorry. Can you tell us which issue youare referring?
> 
> Oh,  I was mentioning this thread: https://lore.kernel.org/lkml/20240530120110.22141-1-00107082@163.com/
> 
>>
>> Is this `ILLEGAL_DEV_TABLE_ENTRY` (one described in bugzilla [1])? -OR-
>> the kernel panic in amd_iommu_enable_faulting() path?
>>
>> If its kernel panic, then patch [2] didn't make it into rc3 fixes.
>>
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218900
>> [2]
>> https://lore.kernel.org/linux-iommu/lsahbfrt26ysjzgg6p6ezcrf525b25d7nnuqxgis5k6g3zsnzt@qsmzecwdjnen/T/#t
>>
>>
>> -Vasant
> 
> Yes, it is the patch[2]; sad to hear it didn't make into rc3.... I have to patch my system manually ever since rc1.....

Thanks for confirming. Hopefully Joerg will pick this patch for -rc4.

-Vasant


