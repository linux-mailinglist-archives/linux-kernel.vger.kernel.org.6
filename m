Return-Path: <linux-kernel+bounces-412826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08609D0F99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594E41F2260C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F49194A7C;
	Mon, 18 Nov 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NutoibJR"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D58D190493;
	Mon, 18 Nov 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929108; cv=fail; b=KIlDlYjhOH+DIvV+0qLIJEJqqJAr7rkENHpGmdeKsjPJELdB0XrpIp7nUC/9dEuFMixN++dsK8lo3Jp06GB3o+tTpLj/S3NpGBba1sePNUI3PEztUEgl+wCqtdJOvuMkTXETqjDU2OtsQbl/k91EJALw5hBNoQnwG38KDMLmrAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929108; c=relaxed/simple;
	bh=gtnweQaa6tiiCi2CDFHcSjxULpDo/wjlJP6+PutqqXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jDAz6Pg8CU7spuGfyyzQgQlXUID6kJxyzjJNvWrkzEpPhazJhjsngiWoqjZZ+kE87Ro5is9OutBmi1pUNXk188FuTIdR5FCB7EtOkqyzyNyK0H8s4Pfn5UYCu7VpSgk7ZTyPmqUE0D3eWJlVPjqEpWTh2FkoaCXDMJ7AmIaIhRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NutoibJR; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg1wRT0OT0PT60uroMrEAsvyUuAYWnCQMvH1w0khxDP+oscWunLjYmSV7wE2ITYwdrCcEddl28acl3gafBfBV6m8bg5hWZHD1jeHLm2ky1ZPZexcAmdz5GIU2Xcz7A0CU6hCVkcYdDmHiKBBZmJ4hyotUAT/Z8RKURd5R1Kn5JqaC1Z4S8y810ZfRAhVE+zjClSMfwxp0ARnkXAsQwioJ/HjFiiut+KRaxzgjkPwCYWk5H96j36QNrA/5cxJC+PZGkX8WSGblf8OUZesXoIaCfvUshISaUWiO0TNMfOog1Dy4G/YgZD8NLD09Bx8OI7VbNzJyXD4ZwbqG94HdOwOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz2HIVaXzdzvD1O9sYnNpYX5boYbEHl8K7jJAO9HuIc=;
 b=JNzEcTrqos7kktf5Zx40EETe5FtNNj0iGwYRIg99sGlNNgUBVW0wkPHcftH2kbqlUCG+n13R3WZRgDQ0sjOS5ZzHkLSY/4Bb/UQdv+af1B0kNoBQOmzKHA1xLGh9yAnJACkj5egSz+m6vRtzmqZx25esi/I5MSf7QgFLGwNVIGlpz2cDkohR8AvyT0PqYO4eAB4M6gbC0Ix9IQOzD8b8XEr5a4iK4Dt04dTvhHXxO7e5MzVHKjbQNl8l15eYB5JZ1rvZ3At54IO99aPNyoIPZJUi5Esbjoqnj9dYETUYe5FtROYU2HqUn2+Kpn2zVeyToB+F2EYalxFW57IQosEJTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz2HIVaXzdzvD1O9sYnNpYX5boYbEHl8K7jJAO9HuIc=;
 b=NutoibJR4FqFEYkm8fSdhjh46dIbB5DEMV5rdm24vTIduJmkTPgylHVwSmfAehkAbntFmjhLi+8Rz3pY4Pl4lKbYN2M4JH09NAbh+xT7ioT5mxRse1pj6dqlmfnP384JEHQwddCIeB6rLjfcrZGBF3nCrHuUf6JNvfAzTUfT7jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 11:25:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 11:25:03 +0000
Message-ID: <acd637f7-a1ce-443b-8d05-d285c28cea7d@amd.com>
Date: Mon, 18 Nov 2024 12:24:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Constify struct pci_device_id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux@weissschuh.net,
 broonie@kernel.org, lee@kernel.org, Alex Deucher
 <alexander.deucher@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <039846c0278276e7c652395730f36051216fd4c3.1731691556.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <039846c0278276e7c652395730f36051216fd4c3.1731691556.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5e7aa8-0ce1-4cea-ff58-08dd07c3a53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHZQa1ozd3hpay9qZ0hNVHQ5bVpyUUF5VVV1U2wxYlptMHVEZDcwamlYcjlU?=
 =?utf-8?B?RG5aTVBXZkY4OThJTFQ3dWhKREtWdndIYWZxYlRuWGRYMlZjSHB5d0dORGtw?=
 =?utf-8?B?MFR2QkoxS2REUitiUklhaEhZdmNaTzVIRmYxYWplZ0NIQ0NzSDlsUm80Sm9Z?=
 =?utf-8?B?TnhIOVBMWk9oVE1qZHNmK0JyVlIvYytrYzVTVDVja2VubjZjb2N6SW5oaGVO?=
 =?utf-8?B?MmdLcVNtVCtPcUhXbnU3Vzl1WHBXRG1jcTA2YWdUNUVrdmQvQ0Y0SysyeVRp?=
 =?utf-8?B?d0tyNFZYWDl5dTY3K0JSVDBHSHZJWmVXMHkzcHl6dlZnOFRtQ3JxTkFuNGlD?=
 =?utf-8?B?ck8ybnNOSlFaMDE0RmNmOUZnUmZwRjhqTFlmSHdwWGxwOTVBMmpTRjNzNXUw?=
 =?utf-8?B?aE9Sa1FjK3VyWGNiTjlzYTBnd1pPM1U2YXZpMVhwUldiaUlVcitUNzkxRHFx?=
 =?utf-8?B?MkhEb293Nmx0cHVsa0ZxYkpIZTF6d1RSalk5cU56eWxiSVFhMGxsQ3BPbmRC?=
 =?utf-8?B?QzJWWHVLRmRjRkpvSlBwSEFNcE5kQ3pQZ0hyVWFPR1dRb3lzM0lNRXFQSDYv?=
 =?utf-8?B?YW4xWDZZU25uU1dyUmdSMVVmUjlEVVZlR1dMLy9JZkdtNjlHRGpyWHpoN09W?=
 =?utf-8?B?c1JaS0cvc3hVNTRvWXQ2VTlIdlM5TE1IUWMxOVIyZHhHeHhmcERYOFhXWHI3?=
 =?utf-8?B?UkFiVStlNVhWeUV5NVlUbCtzeVJyN091WnpML05zZW5FUzR1R2ZXK1FXcHhE?=
 =?utf-8?B?M3doNTBDWE1uUW1WM1drZmppQytQWnlJN0NId0lsOTk2QUpoNzVIU3l6U2d2?=
 =?utf-8?B?b0FyUFZqRVJqNXA2b1kzN2duU3NJWFVnV2lqYWNhVDVqc3MxeElvbnZRdEk3?=
 =?utf-8?B?eGt4cGtxNHkvY1R0ZUpQQUk5anhQL0VacDBoOUFrZDBMOHBZWXRpdWMxTmdO?=
 =?utf-8?B?WnJRUGI4OXFiaGlGdDRxQmNoaElQT0lpRjRndyt2RFhkcjgxSVZjRjMxQzNV?=
 =?utf-8?B?d2NtVHVTWDJRVHJjRC9heEFmVHNianJPeFB0ZExXYmQ5Tyt1OWtmd3pISVU0?=
 =?utf-8?B?dDVIYU83cXNESVlEbGF0MnJLMTVSclZvSUZiKzhML1JKREs3dElPQzE4c1Ft?=
 =?utf-8?B?eER5RWRPV242U3l4eVhYbDVKWEo1Z29iZ3lVMjNBTVhhaVgraTR2aFhpYWRv?=
 =?utf-8?B?UjQyMEg4dE0vZkRhcDd0M1lvMmFMN05nK2gzeE1HV2xSTlFXQmc4eEtsNG1G?=
 =?utf-8?B?VjlteVVXckpLZ0xHM0hFSlp4Nlp5L0NjNm95WWJ3WkNGNUNvVFlGZjNnTGFS?=
 =?utf-8?B?VittNXRUSW5yNEJyWmFJRlBLRVZCcHkyaTQzRkMwdGxkUGV2b0h3MXhDZjlP?=
 =?utf-8?B?Q1IrdWpCbHdTOHdXaUhlbGZ4RGJXNEVvQU91MjRKZlRyL1dmamdzSnRXUlh5?=
 =?utf-8?B?eXRIVnBFWWkyWjVRRmhEaldkdWo2bWMvRDVXV3FQRlZHMWpUQ3FWQ1JxQ0Q0?=
 =?utf-8?B?NjRFUnZaOVAyNTBtQlJvTnlLd0t2K0lYdlgyWVF0T25iTGU5TWVVUkova1RH?=
 =?utf-8?B?VUxkcGhIalZkUzdjWDJzbHNZZzVrQzFsZ2lQdnRaKzk1MzJ1cFBqcndjdEpw?=
 =?utf-8?B?Sk5lVnRmSURwbUdtb3pwWlkvWHkyZFZUZVVKNm1QeDRPZzNRRXFJRVV0TEFB?=
 =?utf-8?B?bFcvYUkzWmZpekg5dkxUMFg4ZUo5dndKeWlkcmZlVUFxSjBGZUdsbXZoM1hm?=
 =?utf-8?Q?omWYGgqpRFMAAlEni3Aw9sV5CmIvNh3Vp6BKjZy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZDRzB6ay9ENnlkdGhSYzZhZm50Qi9aSjB6OGRzQnh5bzVEWmxMdm1ZaFdw?=
 =?utf-8?B?dGg3cXBJaHhDTGxXTEVkUGJEcFhhS2wwRVozbWdxMUxiZW85Yks5NnRDTUxE?=
 =?utf-8?B?anpwQkhFZU9jZUZodHd2VW9kcm43NnovcjRrb3ZHczFvaHJLbHFlZUpzQ3Vw?=
 =?utf-8?B?czRZMUgzUU95TmNHaU1iSTd0ZFY2Yk0ySUpKSGJwcTdEQU1ENkluUyt6bU9i?=
 =?utf-8?B?M2YyeC93K3pHMldOUHJuTkZSbE8zYUZHaFZSQ1A0Wk52OEtJMGRZdnRSVjBY?=
 =?utf-8?B?TWltcmR2bHA4dHJjcUJqQU11azQyUlVzd1FHd0p4YkNlbnMyaE1vN1RjdHM3?=
 =?utf-8?B?cUNaN1JPeitWTlNBcEZXVDJxc3lJM09DVjB6TDc2NFRJU2c0WnRLMWpNS3Bz?=
 =?utf-8?B?YzhYcHp3dm5MS3UvN2RoVGtIdEFVWjIzODR6SzlqQnhFdUN5dHdlZ1ZtellE?=
 =?utf-8?B?M3NuZjQrbEU4K1paU2NSekJBQmZlOXFqc2UzVnVySXlTV1F3NzhxcXNQWm9r?=
 =?utf-8?B?dTRpSlVnRlB1SjhYeU9hZk5ONldzWVJmV2pURjBrQnBWVkxiUnc2WndjcG4y?=
 =?utf-8?B?ZU1VRTN6L3ZUSEZOcDlIcTEvWWVtSmxLYm9PbTVxd0g0SXA5YXY4Zkl6QmNT?=
 =?utf-8?B?VGE0UWJWUlpydmJDOE9pNzA5akNMZ1M2S1Q4REJFU3U2eXoyRVFBMENrMHFs?=
 =?utf-8?B?eWluZWRGTWh0QVlnbWIyemZ2c0ZFTjFVUG0rakZBSlpaL25CNEFETy84eUhu?=
 =?utf-8?B?RXZKUHV4NzBCa01YaGRnNnptZFBnSFhycnZEVmZ1L0MweC9XNWdtNWxPN0M1?=
 =?utf-8?B?Q0FBUlVlWmdsaDl4UnlOUGRGYzh6eXhzQkEwOWs2Ny82ZWFhREQ4b2NJMTdS?=
 =?utf-8?B?cDRHcW96eHZvY2Z1a3RPcGhGNnQ0UUl3Z1d5OXZGbTd6Slo2TEwxcFhzS21k?=
 =?utf-8?B?M2t0R00ySzd5Vmt2ZXNURDlkdE9RczBQL3d4VnVKS0dHYmxCQXZLNUdubldp?=
 =?utf-8?B?cWRuRGJMZUtKQW50eUtzbnEwVDNxYytRSDhBTzlad0pBM28yaVVDRGFEQUp4?=
 =?utf-8?B?OUlMZWdaZFdwY3pTUGo2Mzh2NW90dDB5QWw5YUV5UGlQRVBna2xxVjBlS3Y3?=
 =?utf-8?B?dlZRNE52dTN2aGxDNHdhcVhoZC9BQ3g4ZmV0U2R4b0tkOC90WEROeEkyRFFL?=
 =?utf-8?B?Z3p6UloyREVhTmhhS09VNzlIZjlmc082bkJnaGk3SDRtaG9NN2NuaUJFTEh2?=
 =?utf-8?B?QVRuTUxONG9WRWU5aEZYbDJZN0VHMDF2VjF2RnpMRW5CckxlUE5YcFRwNU9Z?=
 =?utf-8?B?NWg3QzRMSStOMmVZVFBsZHg1TWMyRWtoSVVvbW1HdTRZcVJ5dU1OY3lpVWhh?=
 =?utf-8?B?akZQR3RVbTBBeEhyYkZOTyt4bW16ME0zQ1dxcDJidVZkcVUwQTZZdDNjU0hF?=
 =?utf-8?B?SkZPNkF5NVNRdVUyVXAxQkV2R1JVeHFGeHVWeFloZ3craTZBbktheUxNOHo5?=
 =?utf-8?B?eVYzd2VmenYzYS9nRkFBTnc3Mzc1MFNuNVBTOVk0UTRmYVd1NWlsSy93WWx6?=
 =?utf-8?B?Z1dBZlRFcnNYVXVmLzY5ZlF2NG9JbXZPUGxSQUFwZERUc1hDbEcvVG1BOFps?=
 =?utf-8?B?VktmTFU0ZWIvdWVkcGlkRHZFWTViTXYyOW43SWRmbVUrY213ei91V29MbE9m?=
 =?utf-8?B?WVB6K3hDSmdMU1VLa3JYQnpldzZyMUN2VjdHdDN2dG1saHBLYTB0UDliRmhm?=
 =?utf-8?B?Ry81VXk0L3k5b3QvVndmTk82MUFvNmpCYURlU1hzTVl0NSs0RU1PaVVkRE1M?=
 =?utf-8?B?aU1LWkJUeVBGWUlBdlMrb2owbUt6Q3lJS2tBN2lpbkxsOVdkUnRZbGtMMUNB?=
 =?utf-8?B?SjJrS0RJUUNRalF0NUFmUzR5ZWFLSmNCMTV6MExGWUR3cDlJa2EvK0QxTlA3?=
 =?utf-8?B?TnNCYkVNY0ZJRmU5TmNJOUkvZUlxR25IdFUwVVgzZXpyMFdvRWgyYko5T1Jo?=
 =?utf-8?B?SkgvK1V5TGMxU1d6dEJWVWlvclZCSDYxci9pQ0orNFIyNWc5TDY0RHpuZnhR?=
 =?utf-8?B?Q1ZEdnJlaVZBeWtrMGdmUlJxV3JxTjhac201YnI1VEwvMEhQVjBwS2dmYmxC?=
 =?utf-8?Q?QZ0aLaWEQrp5/lBlJ4hjitQ5T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5e7aa8-0ce1-4cea-ff58-08dd07c3a53d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:25:03.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SInMB3XqjMUkEBwdAKl4V39rtCosse/V5POUGEDkUztrx1SebyrHeuK0Bent0HB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

Am 15.11.24 um 18:26 schrieb Christophe JAILLET:
> 'struct pci_device_id' is not modified in this driver.
>
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>
> On a x86_64, with allmodconfig:
> Before:
> ======
>     text	   data	    bss	    dec	    hex	filename
>    11984	  28672	     44	  40700	   9efc	drivers/gpu/drm/radeon/radeon_drv.o
>
> After:
> =====
>     text	   data	    bss	    dec	    hex	filename
>    40000	    664	     44	  40708	   9f04	drivers/gpu/drm/radeon/radeon_drv.o

Mhm that's a bit more than "some data" :)

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
> Compile tested-only.
> ---
>   drivers/gpu/drm/radeon/radeon_drv.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 23d6d1a2586d..5e958cc223f4 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -248,10 +248,9 @@ int radeon_cik_support = 1;
>   MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
>   module_param_named(cik_support, radeon_cik_support, int, 0444);
>   
> -static struct pci_device_id pciidlist[] = {
> +static const struct pci_device_id pciidlist[] = {
>   	radeon_PCI_IDS
>   };
> -
>   MODULE_DEVICE_TABLE(pci, pciidlist);
>   
>   static const struct drm_driver kms_driver;


