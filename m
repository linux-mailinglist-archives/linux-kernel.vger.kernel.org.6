Return-Path: <linux-kernel+bounces-568430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4501A69551
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B6B3B8889
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFACD1E3DE4;
	Wed, 19 Mar 2025 16:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cJBo+s2P"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FD1A3A95;
	Wed, 19 Mar 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402891; cv=fail; b=ijX2btC0f8AD9OfZP1PG3RJdK4A7p3zMjnvcaUxsfNTzXYH5Gy4yWPNaZX1poS3DeT03m7oYSqdKb2nM8tb2llnnp/OAIlm99KDj6oCegkRNI+VMbUmUFGBeJ40/0j3EAp5VIfrgTRF511yqXS26OuGme6A2E4wKycpA3jFff6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402891; c=relaxed/simple;
	bh=vHpt/djn6XL0kVMVfPwsXJ3Z7mOgjYUDpF2Q7HffXFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atHpCb8C1/94E7mB/tCpF5mka2WISRzy0E2uiGbgAH/C8HfQnwwJi6xlWMafEKtElG65sIaz7ojeMxesbJIzib9z3zpArrnBMLjl/zxcl4WY4cZHuPJM1fZ5VKr9lmQDw8uAOisgcBsh0TfoksVR0Ej2AJkhTDq4p8zjFVgtuR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cJBo+s2P; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXggbY+D/Dk+GhrZnOnFbI9dR2bPEc1Z/kqjf9ECDknDZ8OnLtSDR4sJtI+M581laGFO9gS27IFt4y4FUiDpTvCLLIhIVq6zto5q5NDE2peCpa+V0s1HP2hJzIZKaxw1+yrqjPOmb/4jEQauNGy4SppYnv6imMp+qMiH9BLKI4WcRxK6zfFKnEIQKBelTTmbqAVrBAiBCsElbZO0udTvMLRMuF9jCWtXNShEWkB0Yeyx27PP4il+ROSlLZsLiniEDMjGeyAdG5Cl8xiGYApWNQJXirCXN8lYPriMxDjEXIgjF+rLaJDluWnZBEsFTvd1Ew9hpM2x2FEPYczi0bI2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58pG+hq5zpVBeEb4ZN3ROlz/np+UoxiUG94zFqlL+V4=;
 b=qEwH4zvLMOYsT76usLNTA7wSmqwUrKufrJJ0AFpjlEGmNP/gBALyoN81mS2WvoGoHp7tn0WK0DiTpHCYhXQh++svW6N4yEWsWKK5dziYxiCYIDr4rKnFvSd28MahLvnqAosZHLqBeMXjuM20pyc4954xJv5iznYkk6TZqo9DUDCwDM8GIa8eEImLlBuGvlFHPGgjnHIl8Kae/el3SfxpzeS3OJDZDe904VsVLFWrcniyPX7uIpAh9sjLN0zHuPhD1YaaDZght2IyXx5SPyyU4NY6IovTCXFh/XEF4kvrhCzwyMyiaAWWx2Kb5+6xRkWWIFNn0TaoH952VJjNh6mcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58pG+hq5zpVBeEb4ZN3ROlz/np+UoxiUG94zFqlL+V4=;
 b=cJBo+s2PcBYjXAV/UBeBu/jpH63h7uIpy3zo2ZGjEMHvnD7XPQCt3lslO85+IUa25Gd/VQsiuu4XONWdX3KL7ZR7yUtZ46F6OWytDwZ7jROOjBcAUjtpwdf69xaSAuuFEdcvHRcdUbAvrcidrmeg2E+l+V+KNhIJFjzKG00lgeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) by
 MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Wed, 19 Mar 2025 16:48:08 +0000
Received: from DS7PR12MB6285.namprd12.prod.outlook.com
 ([fe80::6acf:b37d:a152:409e]) by DS7PR12MB6285.namprd12.prod.outlook.com
 ([fe80::6acf:b37d:a152:409e%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 16:48:07 +0000
Message-ID: <3780ab88-f6c5-4298-89c2-ae798592c5bd@amd.com>
Date: Wed, 19 Mar 2025 22:17:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: Add Initial device tree for AMD
 Onyx Platform
To: Andrew Lunn <andrew@lunn.ch>,
 Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jothayot@amd.com, Supreeth Venkatesh <supreeth.venkatesh@amd.com>
References: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
 <20250318174730.1921983-2-Rajaganesh.Rathinasabapathi@amd.com>
 <472a4f78-24f4-4bfd-bf99-8b1194bfe8f0@lunn.ch>
Content-Language: en-US
From: Rajaganesh Rathinasabapathi <rrathina@amd.com>
In-Reply-To: <472a4f78-24f4-4bfd-bf99-8b1194bfe8f0@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To DS7PR12MB6285.namprd12.prod.outlook.com
 (2603:10b6:8:96::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6285:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7535bb78-86ff-420c-2424-08dd6705d346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJJMGxXNXRrcGxTUWY2ZS81L2xwS0w4b1F3L3NIU0RTb1JPVzRKL0FsazNr?=
 =?utf-8?B?UDFJbDduSGZKQnVOSzRFUGtWUmp3ZXZwY1NUbnovVTdjVHpwdWppdkgxMFNz?=
 =?utf-8?B?Y1ZtbFE2a1UxNjhDRVZmUFBIY0tsVTMrWXdJV0FjSUNtRGtWRkpudHc3eVlT?=
 =?utf-8?B?RS9JZkNkWVlTM1E2L25tNmtqcWtLSGFGZjhCbXZFdVBML25RYmU3eUVmaW13?=
 =?utf-8?B?VEcyYzFlRC8xTUx5UmJieGpYeW1LWmJQVjdWUk5rQW1lNHB6S2tzRk85TjZ6?=
 =?utf-8?B?QWcvVnc5MlVKU0lRczYwTUlUR2RLZDF2VHhqVjVwTlhPL0RqaE01RWhjaFRF?=
 =?utf-8?B?NVpUZDkxWU4zcFZtRTBqVEVwbzg2R0wyL3FYSTNGUTJudERxcGxQL1RNT3du?=
 =?utf-8?B?Y2hqNi9NeUhpM0ExYTlaTTA2dVFzMVRjSUtNUExXWHU3WVRmTzMvMlVzWDVa?=
 =?utf-8?B?VUJNZnhFZ3lQZEJQMEtsaWQ3L1Bwdml2bVBlOTJjZjh0RmpmemFJMmtmRGdH?=
 =?utf-8?B?SkhTbmh0b3d2UFQxRlVabW1MZjY0ZzJmTFRRRkJHblNiUFE5SUhjNVFtcDR3?=
 =?utf-8?B?ODdaVEJUYVRPaU1CYVN1enpROFYvMTh4UGxWNXZGcW5RTm1xV2luMHhMNEQ4?=
 =?utf-8?B?Um5ocmJJaTRFWkRxemdNZVdNbjZ2SXBhTFhCbjBqOUVKQ0s0RjhrTXpQSVpM?=
 =?utf-8?B?WjNjUGFvWlE0L0dWSDNaQ1JFU2I1c3l6TkxPVUxLcmxKSFJScGtPYTNxcC8w?=
 =?utf-8?B?NG4rQTdHZitPUk5SMFUvRVRwRk9Oa29GSnJ0Tk04WnkrMFRSbS9HZWMwVlN6?=
 =?utf-8?B?OExQWmtWVTlRai9XdGVsdUJNL1d6bnFVTUpMemdkLzZGelFseEdhL1puWjRz?=
 =?utf-8?B?VkY4U1lzLy90SHVKclhoTXN6ZTVOdGVPV0s3SUpLT3hBZEpBNU4rajZPTHFn?=
 =?utf-8?B?UkJ1R1doM1V2OEdiaUROdDBDcXhQVEZvV25pcExma1YvZWNpbVN0V0g2K2pI?=
 =?utf-8?B?SExmelk1VHJjNlRnMCtvTG9HdVNQcU5hdnM2KzlQZjR0WDJyTUx0Z0dQcXJw?=
 =?utf-8?B?bGpMdThtODE5Z2NkdkE0cERlWW1rVldhaUZzS3VSbEI4enpIbTAyYXU3VVhS?=
 =?utf-8?B?VFZuT3FYcE93bmZVeGVYRlVjQXlIcUZwU3NTc0lFOGN4Z1NJYVFYS3RVUURa?=
 =?utf-8?B?UVVhZk1iSDZiK3FHWVBITGdsZjVvaWE2MWtoSmhUK1NKNXBRaXBCeDMrUmFH?=
 =?utf-8?B?Y3pWRkVMUktMT2N6bU9RS3Ria0MybE5kWGhkSUpUcE12UXJRWW5WaTVjelV5?=
 =?utf-8?B?V0RrV041TTBEZVd2elBqQWR4eVdlaEhVVnEvWFphaDlIMGd4VkJ0NThNWWc4?=
 =?utf-8?B?M0QyWHBBbHdXdWZHblQySkR2d2JOaUMwQUFLZ3FFdFZJUE1TWVRWZGlsdjlK?=
 =?utf-8?B?WDZpL1JzZWRqWHd0NjhIOUM5UXc3NnRQdmZpYmIxeXRaUktscmJoWVYyNHgy?=
 =?utf-8?B?MWJtbUtVeFJ6ZStPR2NtckVGa0NZLzltRUZOMVZZRlFPb2NKbzRZZmpZOEd2?=
 =?utf-8?B?QTJhNkdYMFFKSVBJU2hlN0xQeFlqTzVsclREME5FWE9FRnhmUFE5dG9rNUdn?=
 =?utf-8?B?R0FKSzVqMUlLRUdzOGRHaCtVZXFhZ2NtUTdhVFpScXNqcUdkZGE2RnpsUjNv?=
 =?utf-8?B?ZGkwenNpQlBHV01aTVdnTWZ5TER0R29aQm1pVkdLZitlN1dqZTdSNlFlUkxs?=
 =?utf-8?B?bG1jT1ArUVBpOE5PTVZNSGFvWFhGMG94RnZQYlZEVkJLK24vZHljdWFiaTZF?=
 =?utf-8?B?UmdoL0kzR1MyTy9ZZkowb2kzMkE1RGl4MVh3cG1zbzVVeXpCUVpKWXR0RzFP?=
 =?utf-8?B?UGNxTWgyTFBtQTRnTGEvTDZ6RjQ4Y0F1dk1CTW5uQXU1emc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6285.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmJaYlJkdHBrSytIU2lsTDdWTS94ekc4aFVZUkdkTXUwUWowYXdtcWhYamE2?=
 =?utf-8?B?TlNoc25NVTJFcXpLQnVJeVJNdzl0akNldG9Za1B3aXdWVmNiNGRWb3VhcUF1?=
 =?utf-8?B?R25WM1E3ZmRUeUM2L3Z6TmI2L2E4eWNHL2EwRnJmRFN3UlliRmYzeEIraDlD?=
 =?utf-8?B?RXk1cy9aVHR3ZHFPaUROMWlweXFtdDRNR0VZeTJEdzVRYjlKMU5yTmlzSkpn?=
 =?utf-8?B?Z29wL2FCQncwRGF5cytlVWlQVU5mVEszY0dQU0dKbWUwcHk3Q0ZEOEtLWkNa?=
 =?utf-8?B?b2QxY2dIUXVXNmtoMEZFMU9aUGVaTEc3c1N6OVlEaG1BeFh0cEFFajBVd21K?=
 =?utf-8?B?anU5U3NkNEVZS1FQUEJZeStzRWE2Q1N1UHpaWDdvR0h1UDhXYUtoQ1dyQTBU?=
 =?utf-8?B?aFBIT2hEWVJJaVRJcDAyUldITnkzR1Y0VmpwREdqQmY1azVVMXNxQXNCd0Jz?=
 =?utf-8?B?ZHluU00xQWtaQzNJa2h0bnFyUThBWUpqMC9LbGVoRXN3d25yMzZGSTB0Rjk2?=
 =?utf-8?B?eFJua0p2aEFLNzBXTW0ramNBRS9IOXo2MGNaaTliRVdaQU5vRzJHZnVCZVdu?=
 =?utf-8?B?Y3BEVy9jSjU1YnZkcXlhTWxtMjA4YlFsZE84a1o4MCtUVGZKc1hEOGY5OUtX?=
 =?utf-8?B?OFYyTy9za3NBcUZicVNwSS9wZGQ4bUI3VTlVNkp5MUwxcW9wMzdaYTV3SVhI?=
 =?utf-8?B?Q3VHcEdmb280SEpiRTcyY21QaHNiOUNGd1JWanNUM0Nuc2pvNmJJd1RLUlZL?=
 =?utf-8?B?S1l5U3M3Nml6TmpmUkdleUxmeklIbVNkclR2ZlByVVpkcGlaVTNvS1ZLcUMw?=
 =?utf-8?B?b1F5dmk0YmoyaXBQUmpXMWduTEY2cnR6RmpFUEJtYk00UzhtZ0lja20wN0ti?=
 =?utf-8?B?U08xZXdZcm15dnN3L2NEUENDSU40WU1jN01VYXhoRStIemNlWE9yanZvUFVZ?=
 =?utf-8?B?aUtCa1BKS2FPODJKRWZmZDB5SFlRWUN2YW16MXhMMXJpakpHbmE3d2k3Z3F1?=
 =?utf-8?B?UEdhY3Nsay92Vlo4Tmh5MWtiMjQwOC8rd3BDK1QwM00zV0JHRVVibVA2SkNR?=
 =?utf-8?B?ZXdUbWdWWVRXZEdmRS9MT1hkbnFuWmVOMHI0MG5GSFhQem5EeDl0dVNVUHM0?=
 =?utf-8?B?ZHVsVVVrRW1KZE0vVjVhNDMwY2dwclU4R0VVNmlQYW94SERxdDVnZEVIQkYw?=
 =?utf-8?B?ekxOTUJnN3FYS1k4SHB5Ym9zbUlUMXJPOG5hWFY1Y3lCUzJKaFNqS0RkeW5q?=
 =?utf-8?B?b3hiQnpQMU9ySGM4czNoWVJCMmc0eEhQWm9WVVVjRWtKL0c2NEdrK0daQmR1?=
 =?utf-8?B?eVdKTUNPUTRmcU5yRGMwSnZzZkV6bEQwRnRwcUpGdEpnSjFWa3E3WmowK0g2?=
 =?utf-8?B?NEsxbHlUOENkbWV4UjJQMEhzRXhDQlprOVhpR3VhNldBQjJYZm5EQXJ2V3B0?=
 =?utf-8?B?b1kwTS9QeXkwZHVJRlJ4OHl5MlhmbFl6V0NiYmd2RGtMVnZFVGVMek91S3d1?=
 =?utf-8?B?WlBJNUpueTNNcUQydFlKQ3hCdzNFcEkyd040dFBOS21ZVWRuTnhhWXhnYTF4?=
 =?utf-8?B?ZzZFbHZ1S0M4WVVkTXZ0N2hLZ3VPcS9tU1ZYU0htS0FwUEZaN0c1UzV4OHMz?=
 =?utf-8?B?eDNSZDN3VFJ5VUVVMDdVaFhPOERYbXh3dGl2VGlWOFAvVTE5QzRKMkpZYUZY?=
 =?utf-8?B?QUl1c3BURDhZMUJMR3V3c095OStYdjBiV0FTd2swK29yVmptWUk1eSt0L0ZF?=
 =?utf-8?B?NzA4UGNuNnpxZXhCcmhCNlVhaDFCL09PK3hWb0JBWjhOTU9KOU9SZUY1ZnZx?=
 =?utf-8?B?R1ZkZkZGV1Z4RTJwMC9wT1pQdmJWQ0t3R2cwNmF6OEd0RFJnL29jTytWREFq?=
 =?utf-8?B?b25XbDM5ZCtQN2daRm1rQWhsd0JvMlkxUWRQamcxWERnbVpQNmFac203SWE4?=
 =?utf-8?B?V24zZDM2YXh5bUQwbEpVZzVWRnk5NDdJT0M4V2R3aVJyU1JSL0pUMjVJdlk3?=
 =?utf-8?B?bCtHTXNkbVQvNG56VU8rNjRvQldYMzFrNUJ0V0M5K0VuM0hGMjZtcjdrMXFL?=
 =?utf-8?B?M0lucTN5NnY4ajlMVkE3WXFwNWhCV1NuMlFjQlJYTlBNTEFmVHI2Zkt5TndG?=
 =?utf-8?Q?8SWp0vhMSXslrxRXs4NBmUPnr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7535bb78-86ff-420c-2424-08dd6705d346
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6285.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:48:07.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhAGsoTG1DBO0EvHSxvQBAtMc3/n/CNJsVYRTsek06YHT9jf1EZBZ3VHfzb+7Shl1jJx8j8wcOIptfb4GIBkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

On 3/19/25 00:03, Andrew Lunn wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>> +&mac3 {
>> +     status = "okay";
>> +     phy-mode = "rgmii";
> 
> Still broken. And it appears you are just ignoring my comments.
> 
> Sorry, but:
> 
> NACK
> 
> There is a discussion here:
> 
> https://lore.kernel.org/lkml/20250317025922.1526937-1-jacky_chou@aspeedtech.com/
> 
> There is also IBM in a similar situation to you:
> 
> https://lore.kernel.org/linux-arm-kernel/20250108163640.1374680-6-ninad@linux.ibm.com/
> 
> and NVIDIA
> 
> https://lore.kernel.org/lkml/20250312045802.4115029-1-wthai@nvidia.com/
> 
> Could i suggest you, IBM and NVIDIA work together to get Aspeed to fix
> this.
> 
>         Andrew
Hi Andrew,

Thanks for the comments. Will follow up with Aspeed.
We will skip this node in next patch.


