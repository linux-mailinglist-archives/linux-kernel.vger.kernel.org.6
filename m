Return-Path: <linux-kernel+bounces-281230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA394D4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451BA2815FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC61990A3;
	Fri,  9 Aug 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GBV3TtEz"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFF1870
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220717; cv=fail; b=FmxPTcAt6fLI4P/2XktUC5C7Xy3W4QSaCkTDcrfxRUPpJgiJEEwWoGIk+KxbXCofW7Ej7Dd52cNn1QhjjlBaNJwSIBZKIDP933t2DdJw5Nzl9g5/NFAlkITzYer+mgpO/96fxq11CRhb8qJ4goSR9zSlSIgD1VbZrRaWit/1kUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220717; c=relaxed/simple;
	bh=RCeLxxC41z4Nw8zlK+AS3U7qBOfmZ4P/BlZWiKW95s4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eIdkNHkHdwI1gY88g3lUOrl58TxuPZH8wS+O2DJ4xEjVuuAkqc3jBFPzqJPz16/o2etNdtWyRa2+e1EfaD0SCOxbatU58KSLqwqwXxW1PhYJMEzifGadEwPZhjO4dKia8tBMsKYoAEojpCHk8jVGpIppMO85277B159r4gKRBD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GBV3TtEz; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goRdeDu2Ljh0MMYIoKba244OV+lLazBUy0OmIfD04WC05c957GQiiS4WoHiwV+ii1bFLlEzU6FECSyVFYQL8hNvE/zMnnUFms1dHQPrw3aFD+1sfYwEVoHfZDAt7iBPXG8rsVCTz9XdOJHiSgeZzxKRIffgzzRDjQdwRJx85TcitDCd/SdFm9hlH42H9p2plxofQGmaRfDyAL0a+dscVhdVc08cLDCgmGjSi/R0iw5y0pGJciP5nWLTwN1+UJD8b5/+Vm1J6uwM0UlmKxYAQz87TDFlqavo675pxdcc5Ctkp3PgTi72ppNTy0GFnFO+oYnQfL9DE+app7hUgrKZSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkcqo0h5Wl0mLGksd+bSaQEBrsRzfOC25QjdL9kzl+M=;
 b=ddaKcPlcMEGR6K16EY6vIPEjOxEnI7fByNYfrbRihPgx7fcSxf1RAxuhrgBf5aMOq+PBJi3xaB6bu2suhJ0pBwtoGjNHHlB7nmPmjWXL3RxzAnvnkWqcyGsV0D5ZVgrXs7KarpLTmpkwBeDWNyUTvdHr0zotzR4Dzpv5TneYXd/0cBM/G4KpGZLHiPrreNztlGk0DRftlsvF/UFxxnN5Qd6k56nMSwov/+KiiBJ1ZxQPfSvTiPfklFLPMOCv7L76w7iWs3UHOqMzPFkBUo2q6AYeUkOKLSWPQ0I/1zUwEklR9YtF5kgbK867ivZxeauqGjLoxeo0xAqBvZdpJvoxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkcqo0h5Wl0mLGksd+bSaQEBrsRzfOC25QjdL9kzl+M=;
 b=GBV3TtEzSCJGdFFVB/J+GqONhLejHsUFl9AHC0gdZS0qOtBha6vti06BO7jfM26vK7c26eVHOtnawnHWo1IX55pkV1dHl6QP9cHbMBxy+bYgm0H1YAbyfn4LpHdbpRRDVRwcOFlaP1NlE83KI4O9ZmCbejFPH6dLcENj06moZhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 16:25:11 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 16:25:10 +0000
Message-ID: <a48bfb06-d236-44a1-9ee6-600e63c00711@amd.com>
Date: Fri, 9 Aug 2024 21:54:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to
 the I3C Support List
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
 <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
 <ZrYlNOjFQE9dHsVV@smile.fi.intel.com>
 <c6ef0253-9f32-46d6-a658-295e39c926b2@amd.com>
 <ZrY8UOIsud8-NM_F@smile.fi.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <ZrY8UOIsud8-NM_F@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f41518a-45b0-4cbd-d885-08dcb88fd6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0wwZ0REZnU2eldkZlRzMU4rMVYzWDNHV1c5QmJpQ2cxdzA3eWRNcHpDTU1L?=
 =?utf-8?B?ckw3dTZqZ3BuRjhQZDA2MGE4TEVyRm9RSGpqN2FXcnVSa3BvM3N5dUsvalFP?=
 =?utf-8?B?WkdMRzNuOU9qS0ZkM0NvbVdKU2pIMEVQcXRJeHdrQ2ZTV2pyTGhyUUpsWlg5?=
 =?utf-8?B?cW4rSjRhVjJFTEJlREpWUEk0MFkwRUFxZ3hPK0V1RXEzeE03UDc3NDZuQXh0?=
 =?utf-8?B?clQ4UUp5YzhHenFJM0grcWk1dDZmOUNwODl3cmxsN0R5Q2Q0U3ptL3FMY3Vq?=
 =?utf-8?B?L2t5SE1lNUtBQURrRzg4aHp0cHBHUEZ4Zk44QUVIWm5BZFVHcCs4T0RGeldN?=
 =?utf-8?B?ZW01T1hqYVJJeDJKemp3ZXI0TmpuM0l5aGQwT2thMWNsY0lXdEJJek1xdEhV?=
 =?utf-8?B?MjJ6Ylo2a3VBaGpzSmVHVnF6azBuT3M5V2k5dkhERzhBeHVqaFFycktqNE1p?=
 =?utf-8?B?QUt1VWRuYVdrdGFSYkRjNTZHTURNRjNsZmw3VXBVdmlnVzlEWWVsYi9FSDBz?=
 =?utf-8?B?cTlLNHZIZUdLakY0akpPU2dONUN3WFlYV0h4MTUycytJcFFIRE9ZZWpxWHpy?=
 =?utf-8?B?Yk5aS1Z2dStvZTBUL0JqMDFKejIxYmdHTmNpS21JcnpuWUtBYnB5dWdCWTZS?=
 =?utf-8?B?RDJ3b05heTdxZjIxYVA0ZGlwbWN4SnQ3TFArdmV3Q2ovU3dEYTVXdzc4cWl3?=
 =?utf-8?B?bjhISkdVUXhkd3FVNHYvT3RLa3dJSW1jTWJzZUlNR000cHdlUzFXVkVmMk9T?=
 =?utf-8?B?bXpXcjZaRHhWenA2eGMyNzZBbW14MlJWY240RjNoOCt2WjZmOUNHZCtNMmgy?=
 =?utf-8?B?T3ZGdi9pNDUxQUMyOURXc1dkVjhGa0NGU3kyNm9PeUpkUHFKby9SQWN2cXB6?=
 =?utf-8?B?bU10SENuV2FNSnZuZmcwYnB5VUhpR2ZBcVpzVUJBSW5YOWljUGhQVGM2UWlm?=
 =?utf-8?B?d01yRDd1QzI5K2laUHZoR0pLKzh0WTRrZlFMSGpKelZ3akp0cW1uZ1gyM3pi?=
 =?utf-8?B?ajdrKzF6TXdqcEVHUElWUmg5dUc4NnFDWGRRY3dsWXdEaTRKenZ3dmdsWllR?=
 =?utf-8?B?WGcvU0l3UCtoc1NZd1NNMW5KbUpnUkxadnR0eFBWZjQyT25zNHA1ajZGQ00z?=
 =?utf-8?B?cnZzV0pJTXl0Zmc3aTI3MXNVcjVCYk9sYjJSNXN5Y3A0Tk5TTzgzZ3dEcFRL?=
 =?utf-8?B?S01xL0Y4QVZsUDFmRlZzc1c4QkFhYk54WDBLYm5UeFJCMkRoazBUeUIxbXl2?=
 =?utf-8?B?dGdIaGNxbC9lczJCTHdkMjN0dWxhL0J2K04xbHd2Y1lIbTRQOXRsOEF0NXk4?=
 =?utf-8?B?MElPNEZoaVl1ZUF3SjQrcWFKR0VPSmVxSVNWdFl5SDRTQmRvR3RQdlJzSzJM?=
 =?utf-8?B?M1FZUU1qc3ZCSmtXc1hvb3VrVU1rdkM4MEtoQktGcUF5RlI1WmwyeEhaTnZ0?=
 =?utf-8?B?Q253RjljQ1lZeHcrS0JSR0txZzNSbWxQQXhacTY5VGxMV0llcE80dEw3YW1Q?=
 =?utf-8?B?MEhuL2hObDcycm52R05hN0NsdG5ZMFEwWG11QktHQlNNUThKUTVQMnBkeWFG?=
 =?utf-8?B?cTlPcnJHV1piRnBpQkgwb0x3S1hBc214cFFZSWU1NDRuRVVIalhEOXllQmxJ?=
 =?utf-8?B?RWtobHVaS0ZrRU1pVXFiQUFhcThvZGdKRHRYRGNrb0dNWnNuSlc0bDE5QXUx?=
 =?utf-8?B?bE5lNktIWWFSZGl5WXdNbElKdUFKNlROdW9UVmNnQ3VIQzVhRGN5ai9jd1Rm?=
 =?utf-8?Q?DVIgzr2vTH7X8t6YXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0VmUy85eHZYWnduRUlZZmRQZmpwN3drU1poamhRVUxjZVlEWGRoLzIyVHNh?=
 =?utf-8?B?OUd6NHhmTmxPNFFsNkp6VUg0eUlRVG5YOU1hNytGQ2M3MDg1bzJZTWpjMlZu?=
 =?utf-8?B?ek8yckk3UGFWdnUwSWQzblF4cWhZUEN3amw1MzFxRFZFZGQ2NklrUGxyenpY?=
 =?utf-8?B?dGl4d3Zld3EzOFZPeDBod0NDN2RMSHpyWlVwWElVKzJrUVpSdGRVc3Z3MU0w?=
 =?utf-8?B?UExNYytTbUk1UERhMEJTMXBxUE9oS082b25uOHI1KzlvRWp2K1pZRmhLbUJn?=
 =?utf-8?B?RVBMT3I3Q0tZNUdVM0JpR1ZPYVRUcGtRaW81VGgyVDVaYlRWK1o2TWMwUEVl?=
 =?utf-8?B?Z29WYk03NGRmMjJFdVpIU2cyRy9PWTE0OVBncDJtcEpiWkpTOCtzUHQwV3h2?=
 =?utf-8?B?U0FsZkhhbENtRTNFTHVaOVE2bS9Jak5yaGpyWHRjNXFIUUVIT1VXQXMrUGFo?=
 =?utf-8?B?Y0lxWkdjZDY4UWxHdExjNEJmRFM0TG9ZN3VEN21PV25IRVBqUTJUNHpjQTV4?=
 =?utf-8?B?SnN6MDdqVnRrQ2dERWR5aXhQWGxBTU9vYUREQkVyNXVCYVBWeEZROWk1akxI?=
 =?utf-8?B?ZHNLbXYrQU5HMXRNSFN5MnFjOSttVmhub0hKOWF1elFYcGdIZ3ZLcU42aEc4?=
 =?utf-8?B?NzJuQlNyQlpqY2NLZUpBUjAvVmVST1FvVGVKWEp2bTdrV08xcmdxc2RhS3dy?=
 =?utf-8?B?K2JVOXAxQXRoMHhLaVZjQjZobXJpTENKTllCM0ViK0RPbmo1a0dSWE5PM1Nl?=
 =?utf-8?B?UFpQeEFyWm1NU1poZEdjNEZ3MDlZcXhYaUVUYlJtTGhsV1JDZmxwaUZIczRv?=
 =?utf-8?B?RHE2dlVpbjg3a0txNzREOWgrL1F2OStOY1RXbGRFcVZFMGJHMjM2Y1MzeG1l?=
 =?utf-8?B?dTZvL0RZcXpVSFNid3lvZkhSWDBFY0VRUHAzRzN1d3hEV3FPY3dxODAwQjJo?=
 =?utf-8?B?WDhtSms0UXpObEk3R1BzSGpNSTFWMmVkV2hvV3UyQmFJajJOVWY2ZFEwbllZ?=
 =?utf-8?B?OHM1K3JVdDVxWEljQ2tsSGRTY2ZvcWVZRTgzWHpYS2dmd3N0YnNEdzlxWmRu?=
 =?utf-8?B?UERZa0ZjamxGSXVZaC96N3R1b3pLa2pnaTVDWEhNSXZhZjNwaXdrQTRHZGo4?=
 =?utf-8?B?K24veEtZbVA4TDdYQVdJZkE2ZmkzRm1jQy9Ib0lmaTlFVkVZcDF0bGhnUy9r?=
 =?utf-8?B?Vkw4dWNsbmIzTHdzQTI4UVpWTW9UbGdBQlRPdDBGaTArQ25sNFNHMFZLbzZT?=
 =?utf-8?B?WHpVVXhmbjRySzk1K3ZVVHV2NWJqQ1IyM3ljcmszUXpCMm1mUmJURHc0TjJX?=
 =?utf-8?B?Uk9hd0lxZHpDSEIzRllsNWhEU3lCbzdtbitpVzI4THRxSTZyc1VETEdYNzB3?=
 =?utf-8?B?NVljc0RWTCsvbFBERDZtRS9xWTRkZk5RVE0xM1haVVNUVWNYVVZSZmlvVklW?=
 =?utf-8?B?K1lrRzkyN08vUGFoK3BCMUl2dnljbjF5VmNSY2QrSTBRSi8veGdWdkVBdFFJ?=
 =?utf-8?B?MDRUZDJoVHFramVzWGFhZ1dUT3JhNHlQd3JXMzNma0EydnFBVDIydStwZm5K?=
 =?utf-8?B?Z2xmTWtGRm1QOEdOUTFWb2VUc1pFRUtKQitpendIOWhKNWtMWSttNHAzV1dD?=
 =?utf-8?B?SEx3LzMrL2dmMzRHZ1BXaXFVK0RGZURGYVZkS21LcUw3bHNZOVZaMndrK1hU?=
 =?utf-8?B?VmQ5UThrLzJUcHhqelhLdlhSOWppMHJ3eGM0bkFWU0pKZkRtMTVKV2NxYk81?=
 =?utf-8?B?ME1IZkZnTkxQUlB2UkpnTE5Rb3EwdUZ5SlJDeThVdmhYcVh1Y3dzaW1JMEt0?=
 =?utf-8?B?cEs5aGhOK25ZZytZVHlyVEZtZ1BuUnJDTWR4NGl6cFZMVE13UkJxSDNzY1Jw?=
 =?utf-8?B?SHh1QVhvVVBpNXNGcjNTdkQvSVlBOTc1aitpR1ZpbFg5dWhDUW0rNG9IRlhi?=
 =?utf-8?B?S1pRZENaK2srM25rOVhKa1BPL0IwQ0FEZ29zdVAxNUxkVmZqeXk3NDVMb1pz?=
 =?utf-8?B?VlljaTIxc2pQdEQ3eUlHak40MTdGaW5HVFY1Z21rWlRxbk5hcndFRXg3THdU?=
 =?utf-8?B?L2FPeVpVY3QrLzUyVlpqamNnZjg0c0o1TG1QQUlxeFZlUkFkRkdmdFhCbkUv?=
 =?utf-8?Q?8gAhdT2IBkAHLuKQ+CsRzLSs+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f41518a-45b0-4cbd-d885-08dcb88fd6cb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:25:10.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MECyJIGEcIZZoesjxbsXn7mmbJ6uUF11TUt2xnuYtfhVOgZOGObngMUrq2lUikPvNTNmN+VVAaBwQFufWTT+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467



On 8/9/2024 21:27, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 09:02:35PM +0530, Shyam Sundar S K wrote:
>> On 8/9/2024 19:48, Andy Shevchenko wrote:
>>> On Fri, Aug 09, 2024 at 04:54:18PM +0300, Jarkko Nikula wrote:
>>>> On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
> 
> ...
> 
>>> When adding a new ACPI ID, always provide the following information:
>>>
>>> 1) link (in some form) to the official confirmation / documentation for
>>> the allocated ID by the vendor (MIPI in this case) _OR_ (very exceptional!)
>>> why the bad ID had been allocated;
>>
>> Member version:
>> https://members.mipi.org/wg/All-Members/document/previewpdf/89465
>>
>> Public version: https://www.mipi.org/mipi-disco-for-i3c-download (this
>> requires a signup).
>>
>> Since there is no direct link available for preview, I did not include
>> them in the commit-msg. But left a note that the MIPI ID is the one as
>> specified in the MIPI DisCo spec.
> 
> It's fine.
> 
>>> 2) are there devices in the wild (on the market) that use the being added ID(s)?
>>
>> Not in the wild. But the latest platform will have this support
>> included. So, these device IDs are crucial for the i3c-hci to be
>> supported on AMD platforms.
> 
> Good, let's do it right then!
> 
>>> 3) excerpt from the device (independently if it's public already, see above,
>>> or not) DSDT ACPI table.
>>>
>>> With the given patch it looks to me that you most likely need a local, AMD
>>> specific ID as well.
>>>
>>> So, in my ideal world the DSDT should be like
>>>
>>> 	Device (I3CC)
>>> 	{
>>> 		Name (_HID, "...") // AMD specific _HID
>>> 		Name (_CID, "MIPI0100") // Compatible ID for generic I3C controller
>>> 		...
>>> 	}
>>>
>>> Is this the case? Why not?
>>
>> Please refer to the MIPI HCI I3C DisCo specification
>> (https://members.mipi.org/wg/All-Members/document/previewpdf/89465)
>> section 5.4. The ASL looks the same in case of AMD.
>>
>> MSFT says that they want to use MIPI0100 as mentioned in the
>> specification.
> 
> MIPI doesn't know how to assign the ACPI ID correctly. But again, what I put in
> the above is the correct way of approaching.
> 
>> What would you advise?
> 
> Since my intuition and experience tells me that the two devices even based on
> the same IP are not the same (see word 'quirk' or '.driver_data' or alike in
> the kernel sources) the generic ID may not be used for the specific vendor
> unless it's _the only_ vendor for the certain IP.
> 
> So, please do as I suggested above. And file a error report (and correction
> proposal) to the MIPI, so in "5.1 I3C Host Controller ACPI Hardware ID (_HID)"

Thank you. I shall file a error report soon to get it corrected.

> they should use _CID instead of _HID and add some text like
> "Each vendor should dedicate it's own _HID for the platform in question. The
> same _HID as _CID may be used if and only if vendor guarantees that there 100%
> compatibility with MIPI as described in this and other related documents."
> 
> I.o.w. do you 100% guarantee that MIPI HCI I3C DisCo covers all necessary
> properties that you need for _your_ hardware? If not, use my approach, if yes,
> use the same _HID *and* _CID.
> 
> Microsoft should know this as well and much better than MIPI.
> 

Agree with your thoughts. I will respin based on your remarks after
internal discussion. If it requires _HID to be MIPI0100, I will come
back with answers.

Thanks,
Shyam


