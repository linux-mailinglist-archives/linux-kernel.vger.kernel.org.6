Return-Path: <linux-kernel+bounces-296158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1F95A65F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145FC1F238A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E184E176ADA;
	Wed, 21 Aug 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n3cYL4do"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9986AFA;
	Wed, 21 Aug 2024 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275000; cv=fail; b=tDdIfOfBMKBHI9xL53VOpZxpL6vuiLjyn9J4d9UyYEPyXo6iNVFESI0AexEQdsDnbgVjsJGp6RkOjD0eLyiRbcYeW0xV63NfUrcGace3YfnLMZqqGmqxWK99sMNFnnXFqkzJ6/TjqHggzBRBzdS2B8Ztt1XZGO4ZoPs+avhmqJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275000; c=relaxed/simple;
	bh=83LDq1T9bEKe6gq1XFyMaiU2x1wmStv5b1LlBKmAn6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=POj+W2Ana69v4zam6KCnsxy7aRcpnuDdmDqmgtCySpE+6IWvWgT1hBh9rXlipDDlOU2CBw6V0BMZaa1yTisqPnEPH8JyOFgVjX7R0q/kkHp1qq3IlWYasQJ4jFhLwU6944zaEYIws2RU//zpsbPuyoyzCv7ONYeKXhiJgRhnW2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n3cYL4do; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFRVI6dRmPRlQKt18Lz+JQ8OY8tWRB4SbUh6RtOhNrQF2LsF69cEdNp8ECxzNSgoDOsSVy4nI5bDriamsEMk+XhFbz4DYCrLKCv3ojrawZOYVpTBA6WIO+6wWwGdsGf9YnhYEBe1h/oNihi3zjkK0pOwd283d5POLWoEzxiewAP7rejQc8D0oEKi4I7oyfXGeF7y21EXb2VXNCbH+tKcoITYCrXQaxJFNH65ba+99QOUu1gJSRVgD7dMekcoj/USZ6jqf5pkJ8aYEHen1dZVzlHWIuHY7wlOkgaJwnrkD0uIeFfexFhvNzxqiQz/jmKP2oVcagYWnfO1nYDo6vlq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWt+9xThQeb7bN3l+ZvgKfSMEhRHFpX7B2chPklexMg=;
 b=NfoMNbnDlNnlRL8qYmT7DJ6ZJjhJCV91QGsD2Ksdntm2Hh+DB1rfobmcshqOGXiCOl/FIddvoadZL0qsQpYKJnzym1kq7+rtUSXgSWnnjwTdhrK+WkUQic/ZkXToyU39hms8qvw91YU/hHm/xf63ZYSS59SOOyp55TEF7NR+Noe8BAQDr5X4SuZGNuZqIqUpQihFcVt7Bi4b27ze5aeb7E/HUJeQiftf54ZpDXS4l8ezxlnohdhnYCtTTf3sLyRZDzRncq8IkNt6pewtEtjiw96Qi6P9wSKI7MgEn/tYN8opqPvdfWu4GT7IjtkFqjW/McuNDWCZKiMzwLiySQ40Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWt+9xThQeb7bN3l+ZvgKfSMEhRHFpX7B2chPklexMg=;
 b=n3cYL4doOWTQRzd1ov1VQlEKgPBXxrX4UdQUSNVXnIaSdBjHtBLU/v80i0cCwrMHa4bcHAXlpSHR5NBmL3wofBBFGfGZiqOynK6K5Myg7OWxSEmNywOXv23MRkjVHWxUMhfEi10nE/D330to+4BUZZlqB8IV7RQUrBoyh7yf4cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 21:16:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Wed, 21 Aug 2024
 21:16:34 +0000
Message-ID: <07fe1bf8-f470-4e40-86ba-0f8d2e61a3e6@amd.com>
Date: Wed, 21 Aug 2024 16:16:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] platform/x86: introduce asus-bioscfg
To: Hans de Goede <hdegoede@redhat.com>, Luke Jones <luke@ljones.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 LKML <linux-kernel@vger.kernel.org>
References: <20240716051612.64842-1-luke@ljones.dev>
 <8273ed57-4c65-41da-ad7d-907acf168c07@redhat.com>
 <e9f4fb37-5277-a7f0-2bec-8a6909b4e674@linux.intel.com>
 <1e309d39-43d3-4054-88a9-0c1da3de26eb@app.fastmail.com>
 <517aa9f5-00cf-4a68-b1d7-a6dc9f942e7c@redhat.com>
 <a35c923e-be2c-4083-8c65-c83b49fe4350@app.fastmail.com>
 <55756822-4eb8-419e-ae57-655caa70edd9@redhat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <55756822-4eb8-419e-ae57-655caa70edd9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a5cb8f-6509-42ed-0e3b-08dcc22688ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmFoOU9HbTAzMnV3MzVHUFhJdDVUR1hxNnVlU2UrYVVUVlpoRloycG1sVDA2?=
 =?utf-8?B?SEJKQXJOeFhFYkszZ01kMnZuSEVFT2VKZHpJMDV0Qllxa2Z1NC9vYU5KanBn?=
 =?utf-8?B?OUJucExGSHpQbkhCZGhpL01QTlFFcXB4QmVpK01MMGdiTWJ3ZUlhbmNlbmFr?=
 =?utf-8?B?VStMTTNHdTRRNU5qRVc1d2Y3M1pjL3BpYjJURzlPTStNM0hZdUwrRU5HVVNN?=
 =?utf-8?B?N3RLOHY4aVYydWc0NkZsb1VVdnBGTm5RcGpaOXFWbFBKMitJZE43S2xaQmlh?=
 =?utf-8?B?dDZQZHo2Z2NyYmhXWDJMcmxIekV6YjJjWHlGY0xXUXdWR0x6UnkvS0lMRFF4?=
 =?utf-8?B?OW9OVWNIOC9zZlJab3JRWGRUS0xyRm5hdHIrcXFYVHlhTTFLcFFyOVM2eFNo?=
 =?utf-8?B?WDJTTytFZUc0dmVrTTAxZU1GRTlCTFhiL3d2S3owSkw1VVovVU9YY1FHOUsx?=
 =?utf-8?B?bnZoWEFtSFZwMDBBNGdjcUw3b3hwYkNQUHp0Tys4c2xickloVEozeXFGRTcx?=
 =?utf-8?B?V0RTQU9aMThCS0twQ2xTdlJXUUhGS1ZpQ1FvakxMaFA2cUlyV21QdGNzbFlr?=
 =?utf-8?B?Q29ZOTBmRXVtNUJDRkpVZzNLdWwyaGc5UEIwSGNNb0k5aGd4Wk1KNVlZcUpC?=
 =?utf-8?B?WDBMMXBudXRsUXk4TmJDallxMURMQWZXR1IyWlZMclJqRmd5aHZQVzhxNzlJ?=
 =?utf-8?B?MWVYdkIzaEZpQWJHYitkbG5ndUdaU1NpNW03VGdPY2FURkpha0lSSlg3MjE4?=
 =?utf-8?B?UGpzSGhoUzltYWJpT2ZTTDBlQ3MwK0plK1dFK1hMYyt0aVVmOGg0b2h2ZHNt?=
 =?utf-8?B?a200cDJMa1M3SGs3eXhUbXhEb2RXdElHVzNTZnMxcmpkWis0c2tYdnV2ZjJ5?=
 =?utf-8?B?cXVBVWhwSkJ2OWkxTTYwKzZkckx3d2NuYThRTWRoV2xKQ2h3NDRlS1RJRGU4?=
 =?utf-8?B?Y2JZUGtlUVFKb1ZxU3F5RDVaOW1sSjBMZk5JQWdSWE0vQmZydjNTMjFNdGpZ?=
 =?utf-8?B?eHRVVWtjUzFIM3hJQjlFandYUTNpN3N3c2FqQzVoYWFxQktKRTRESGRjZko5?=
 =?utf-8?B?ejVkOWNhWlBnak4raTdibUdCUFBBVm9WRFFTSG5BOTRDMXUvVGlwS1ByL3Vp?=
 =?utf-8?B?clBQK0RDMlFTVFlMMlBzS1BjOGtYZzZBcU1PalNVN1cyZTlKckpDOTZGM3dP?=
 =?utf-8?B?WmZ6VVhYREN3SFFCRUVYazZ1SEhuckNDa2l5VVNKU0RYZjUrNEVwVWtzM3RJ?=
 =?utf-8?B?TnBhaDFtNVN6MGZHcDhNRE16VVV6UlAvYWkxUzBGMVNUb1U5UDVVN0wyU3Vn?=
 =?utf-8?B?V2dCeCtjTkk2VHViU0t2ZTk2aTRtWC82aHEvNjl0S3ZIemZwK1M5OS9YNXgw?=
 =?utf-8?B?UHZVb2VUOWEyTXJFZFl3bDB4RnNxTWVyTjR3SFdDb01hWmRJcndGS2wzK3Iy?=
 =?utf-8?B?VXlrSVVSeVBYUXdVWkJ6cFNwUWhETWxwZkFqNEdvTzMvTFdyc3JWZFNjdnZZ?=
 =?utf-8?B?VHAxbzg5eCtmbXdQLy9mY1FIRERpNm01NmFuY0RTTjgrcVhZRzZ5N0phd2dX?=
 =?utf-8?B?MkgxZEc1OSsvc0VVQ1hqUnBTazFTalcyV05TTnpjWG90TlhKNW04am4yWVdN?=
 =?utf-8?B?NFduVHd2cGNmOUFGN0RBMElhWGZmamttVFV0Y0xvSE91LzNlY01odURUTE1C?=
 =?utf-8?B?K01PanJ4d1k3Nm5GYlg4M2tmQkFEWUIxODc5S3RuTWFrd09seWNpalpHRmlo?=
 =?utf-8?Q?pu3bI+mGbMkJ1JewQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nyt2MURXc09uTktpZ0ZvQlMrS21mUndXVjFBUm9mNzVTKytyY09PYm1paUQ2?=
 =?utf-8?B?ejZ4S0xhMGdTZ0J5aGpQazkvRW1FbnVLT3JSazY2WmlZS0dsNitnRGJzUCsy?=
 =?utf-8?B?MXRhNVFXcDBkcVJuQlBNZmQrbjFKdGNXWWxrTEt3LzkxMWxKU0cwYW5oelp2?=
 =?utf-8?B?QmQrWHl0S3VaR0R0azkwLzJKRXkrYTlRZUlRQUY1UGp6M1hLeS9hL1hHMlhW?=
 =?utf-8?B?K2ovL3pxTW1jRXorbk4zSFRldjVvK2E2azBhLzVERkYzMlMyVlBTdzdqcDVq?=
 =?utf-8?B?SlZDV1JqM2tBWTMxaUdyWkUyM3p1M1FwMXZxS24yOUliMUQ1YzBUdTN4Vmdn?=
 =?utf-8?B?YWZsOXpKZnp4NTY3aFNsWVFTVnZKclVOemZEYTZBVDJyOEZVa2JId0h0NTMv?=
 =?utf-8?B?TXhtcHpBVUdCR2ZaeVBxb0RvdTVsdHdScjBDNXkzbVVud1c1QThGekpQek9T?=
 =?utf-8?B?ZTBEMjR5ZVVGSUtudGxTM2dGbnc4UVRvNjV6S21QYUJHZE5KWC9TRDBxM1Jp?=
 =?utf-8?B?aWVWb3ZnMm1OSjVNZjhLMTV1OHJoNFdNVlRVT3pUS1AwSmJGSGpnMkUvMUFy?=
 =?utf-8?B?b1psRW1yN0hhVFJFS01mYlJQU3Z6dFF1TGNNSmxYZTI5ZURDRjdJSEIwSUxv?=
 =?utf-8?B?bkdIb0dUTTZPTmxvRVpyUUMzTEZNTGxPR3hDRjlRYmk1Q0ZVVk5UOHFyRDVX?=
 =?utf-8?B?NDJXN3YwSS9PaHR0N016NU5EUjQxTmwzajNsU2E1Y09Fbk1zdFkydWxJYUtT?=
 =?utf-8?B?eGFJbGJFSlcxcUZ2ZFpjUkZnakQ3Slp5ZVlnd283VWxxT1l5RDJQUzRNTlUv?=
 =?utf-8?B?VGVTQ1FYNHV2TUdnZjl3b1RmaHdObVNUakVzRW1xQitpWXVEU245TmgyUWZF?=
 =?utf-8?B?S2k2UzF0MXVvZFJLYWpBY3NpTCtvT1VaUDF6ZWtWUjF6NnJ1V0Q4ZXpYZVB6?=
 =?utf-8?B?eXFQUUhqZms0TVp1Sm5Zc3c2Slk4Y2JQVlVXYXFJN1FaUnZMNlNQWG5nTTJ3?=
 =?utf-8?B?QzlkbHpiQjd4MTRHbWMrNkxkMmFJM1ZIVlBPbmNOakU0dnJiKzh2aFAvK0xp?=
 =?utf-8?B?a0Fzb25yVjRKc0xqUXRMOGFUdWZxV0ZtZXBWZnJuTjBJOVNWRFR5SDNNRjNY?=
 =?utf-8?B?Ym9Md005VkhMeStKTk5lZ3J5bjZCcmlLQk1vaEdBUWpqNU1Pa2VleFQ0ZlF6?=
 =?utf-8?B?ZTF6bmNXOFo1MklrZFdTWFpWNEdRTDg2WHhyTFcwRk1hUjJnbGp4ZlQrNlho?=
 =?utf-8?B?QmxkKzM0cjRLQ29NOVFyUndwM0NydGs1Y2I2RmtFdXpkazJTc1ZJREg1b1ZU?=
 =?utf-8?B?b0lrak9ZV29mQVBlWVZLd0Vmd2hDankzUDZXcjlZd3lTa3JuM0ltTEoyRGQw?=
 =?utf-8?B?bWlrNEE1T3plZjNWbjFRNktrQStEVEtRZlByN2lQVnZmTVhvSzM1cDRndGsx?=
 =?utf-8?B?TStTSkZ4TjlyK1hwejl5cGxZUERUNGVsb2x5UkdnaFBNVjErUnlMMmZVdGFF?=
 =?utf-8?B?SDBHN0F3TXM5bGdoc3JHT09CNDBhN3F0dTRvS3lEQ0FwRG1HTGdmaWFPMXl6?=
 =?utf-8?B?RVgrUEYyZkMrQjhOUWRIVHhVNHVJMDk5SENtL2xrYXcrbnpMK0RxT09YaUdR?=
 =?utf-8?B?eHZ5WFB0RkcrRXJsWStneFNkWlJTNjRDMGFBOWplbGUwRUVFRWJiakk4Sjky?=
 =?utf-8?B?K1NUbitlNG5IUlhlSFVIOWhUMmZLVVk1d1czUnZoMTdGOEoxK3JZN2RtN1Bw?=
 =?utf-8?B?SHhLYWRsRmUxR2ZSSEtRTmVOZHFvQk5BTmVadjdBTGttRENzbWU4bVhRYlZr?=
 =?utf-8?B?Uk9DN01KeW9NSFF5ZDB1bUxEUTNHYy9aUmJJNCttQmpORWVFb1FjSVdVcHBu?=
 =?utf-8?B?MDRmRjZ4cnEwSUdDd1hiN0habjV0YzcyOStLcEdscFIyZVVhaTJRaDh4V2ln?=
 =?utf-8?B?ei9KMktGei9ZTTBpdEdVRXVheXVUZXlwT3RsbUV0VThlc0RpUFJQcWdrbzVE?=
 =?utf-8?B?RW5TN2pJb2c5TUVaQ0tMcVB3anVxOGIzZDduaThOOWlmeklvSzhTNU1GRTNL?=
 =?utf-8?B?STI1cFE5clhwOFhzNW1qRXZWVmQ5bXJSR2ZBamk5b2RhNTF2Z2xhZENtcUx5?=
 =?utf-8?Q?5bRzN91FX8nOBhdvTJoDqkfyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a5cb8f-6509-42ed-0e3b-08dcc22688ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:16:34.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kene5mHhg8JTNmSndMdA1v+d2kq2u3SWtXSC0RRYwQOqLEaQ4Cb0sChkrCMfo6lJFNYpeOfp4Ha71jytF9KKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

On 8/6/2024 04:34, Hans de Goede wrote:
> Hi,
> 
> On 8/5/24 11:41 PM, Luke Jones wrote:
>> On Tue, 6 Aug 2024, at 3:18 AM, Hans de Goede wrote:
>>> Hi Luke,
>>>
>>> On 7/17/24 4:34 AM, Luke Jones wrote:
>>>> On Wed, 17 Jul 2024, at 3:11 AM, Ilpo Järvinen wrote:
>>>>> On Tue, 16 Jul 2024, Hans de Goede wrote:
>>>>>> On 7/16/24 7:16 AM, Luke D. Jones wrote:
>>>>>>> This is the first major patch I've ever done with the intention of
>>>>>>> introducing a new module, so it's highly likely I've made some mistakes
>>>>>>> or misunderstood something.
>>>>>>>
>>>>>>> TL;DR:
>>>>>>> 1. introduce new module to contain bios attributes, using fw_attributes_class
>>>>>>> 2. deprecate all possible attributes from asus-wmi that were added ad-hoc
>>>>>>> 3. remove those in the next LTS cycle
>>>>>>>
>>>>>>> The idea for this originates from a conversation with Mario Limonciello
>>>>>>> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
>>>>>>>
>>>>>>> It is without a doubt much cleaner to use, easier to discover, and the
>>>>>>> API is well defined as opposed to the random clutter of attributes I had
>>>>>>> been placing in the platform sysfs.
>>>>>>
>>>>>> This is a bit of a novel use of the fw_attributes_class and I'm not
>>>>>> entirely sure of what to think of this.
>>>>>>
>>>>>> The fw_attributes_class API was designed for (mostly enterprise)
>>>>>> x86 machines where it is possible to change all BIOS settings directly
>>>>>> from the OS without entering the BIOS.
>>>>>>
>>>>>> Here some ACPI or WMI function is present to actually enumerate all
>>>>>> the BIOS options (which can be set this way) and get there type.
>>>>>>
>>>>>> IOW there is not a static list of options inside the driver, nor
>>>>>> is there special handling in the driver other then handling differences
>>>>>> per type.
>>>>>>
>>>>>> And if a new BIOS version has new options or a different machine model
>>>>>> has different options then these are discovered automatically.
>>>>>>
>>>>>> This new use is quite different from this. Although I do see that
>>>>>> at least for the attributes using WMI_STORE_INT() + WMI_SHOW_INT()
>>>>>> that there is quite some commonality between some of the attributes.
>>>>>>
>>>>>> I see how using the existing firmware-attributes class API definition
>>>>>> for this, including allow tweaking this with some of the fwupd
>>>>>> firmware-attributes class commandline util work Mario did is a useful
>>>>>> thing to have.
>>>>>>
>>>>>> I guess using the firmware-attributes class for this is ok, but
>>>>>> this _must_ not be named bioscfg, since the existing hp-bioscfg
>>>>>> driver is a "classic" firmware-attributes drivers enumerating all
>>>>>> the options through BIOS provided enumeration functions and I want
>>>>>> the name to make it clear that this is not that. And the Dell
>>>>>> implementation is called dell-wmi-sysman so lets also avoid sysman
>>>>>> as name.
>>>>>>
>>>>>> Maybe call it "asus-bios-tunables" ?   And then if Asus actually
>>>>>> implements some more classic firmware-attributes enumerable interface
>>>>>> we can use "asus-bioscfg" for that.
>>>>>>
>>>>>> Mario, Ilpo what is your opinion on this ?
>>>>>
>>>>> What you suggested sounds good to me.
>>>>
>>>> Thanks guys. I think there might be a few names that could be suitable
>>>>
>>>> 1. asus_bios_tuning/tunables
>>>> 2. asus_fw_tuning/tunables
>>>> 3. asus_fw_settings
>>>> 4. asus_armoury
>>>>
>>>> I'm shying away from the "tuning/tunables" label since there are also a lot of settings which are just toggles for various features rather than actual tunable things. It makes sense in some contexts at least.
>>>>
>>>> Armoury Crate is the software collection that Asus uses for the gaming laptops, and they tend to lump these settings under that label.
>>>>
>>>> Personally I'm leaning towards "asus_fw_settings" as it more accurately describes what the module does.
>>>
>>> "asus_fw_settings" sounds good to me. I'm looking forward to v2 of this series.
>>
>> I've actually done a poll on my discord, folks voted overwhelmingly for `asus-armoury` and I went with this before your response. The reasoning here is that many of these users are coming from windows where Armoury Crate is an app that exposes all the same functions and so that's what they look for on linux.
>>
>> If you don't think this is suitable I'm happy to change.
> 
> asus-armoury works for me, I like that that name makes it clear that this
> is not changing BIOS settings like other firmware_attributes class devices
> are doing.
> 
> So asus-armoury it is.
> 

I have been OOO so I'm late to the party, but yes I agree with adding a 
prefix and the proposal for asus-armoury makes sense to me.

And I had suggested Luke in this direction of this API in use by this 
series with fwupd's use of BIOS settings on other laptops in mind.  It 
feels like a really good pairing to me.

Luke also mentioned to me (and maybe somewhere else in this patch 
series?) that the ASUS tools will be converted to use this interface.  I 
think standardized interfaces are the way to go, and that way if we ever 
end up with GNOME or KDE GUI that changes firmware settings we cover all 
the laptops and handhelds at the exact same time.

