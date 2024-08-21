Return-Path: <linux-kernel+bounces-296142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43695A63A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260C41C20BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC662170A37;
	Wed, 21 Aug 2024 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HkfbVING"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177015855F;
	Wed, 21 Aug 2024 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724273751; cv=fail; b=LcJW9Jt9FmtRL+Iyp30XZAZHk8pwf7JvWkIX6P2LYQFtrOOiK/JW0wrll3nTeDg3JZJhH45wmwuiXjixbtaszfLl1iQ2S9YigAZOxsis3EJ1kk2o3yAd6FWZ9ngVHadqTpbAbhbIPT8nJxB6WwQCtIdn1Gc4S1Z3E/O/hUqb6RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724273751; c=relaxed/simple;
	bh=k+KUxS6BYb1D2wXdAjpuOja4qUy/TViZaI1J1YV3Xdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=emjX+OXjaoECzJzadJ1fibLvicGdoy40WWoLmu29u8nRRQL5k33fihQLozc0UjOx3moCRU7KG/Azn9s/gdxG3Ls3+eoB4mQwNEnxaqkErTYGW5HK4DUGb7CPQhxq1QUodLwwNEnw2UEmfSu1n/wuSihrYN7BrgTNYp3tJNIr4S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HkfbVING; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAm/BtqXWs3LD8N0Zdfh669db14FKnhLCO99ZNYZUOHmt5QLZG0vlsBUxFLxxHY2QTIXJEgJ5lZYwopmkynjm+SF2o2fc0x7tCLAJxUFc7+eeXIzMqwFuL1P1WXy0gK4j2nGHBOM9+cP+SeNTiXhDKFe6aBQjLggqi5aEvRDT/bpCyT0EDVE+zvrjFpT9udQO+dvOwga6jvWmrNLrQZ/V8LIqgJDeKhyyfRaiDb2vVDmJp6qdUDt0wGYWx3lp9+Ngg5D6nbqCB+jVtu7Uf0KBeDV+7ja0l1MfHewd0/Hg93ASnMgIkUt8XCM8CdudOB6hPm7I7RQkMiVY6ia7fTKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRTcEs0id/ijpEZZOmKLGuZtFR0HQrpAgTV3CwQIvBE=;
 b=ltZpKY42N+cGI2qXC4KMzc2B1arnvUsa7MsWTKTn+qjLo6HmIcJzVe5uxMy9p1+leATGoI0fKsGc7dEI0EJ6nSSqiZEbT0jkidoO30fzO8sQBBeUNkpF7uSwEskAstEOZnNnBFFloS0XbgYUCtaCS4EffHJF6QnY0l6PW1Wj9/hmXY9wkec/IVfXCo/PM1pHcmjA+5K6pNHLgfP+sNiqQrdIR91I+/HDgEQkz+fLGl1TAsaJyQdljSxZT9ykeFNXeNYPTgEgv1DLTuZOQSWZ4yYTgx4m7eqJhB5EY+c5TbiXUYOj8aCGvQk5+TMY8bBfnRRCnqQMlQB4tbaPD47Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRTcEs0id/ijpEZZOmKLGuZtFR0HQrpAgTV3CwQIvBE=;
 b=HkfbVINGMLRXxBtdLdE3fUCBpqKS7EoHmzZ4WPKd32tkNCxX+M5z9gagp1u+qLyZhUM7oG4JyG3Na6huLHZ1jQlAy8Arer0KakCk+TJL08+guOCEwtfg7m0KvQd4Dg5o/kLtJvFaeYP0F4SZ+zPstSpDmvK57QIF8kOCYxV6qd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Wed, 21 Aug
 2024 20:55:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Wed, 21 Aug 2024
 20:55:47 +0000
Message-ID: <209ec1ca-c050-4f76-bfbd-e9ec52caa1e0@amd.com>
Date: Wed, 21 Aug 2024 15:55:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] drm: panel-backlight-quirks: Add Framework 13
 glossy and 2.8k panels
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>,
 Hans de Goede <hdegoede@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>,
 linux-doc@vger.kernel.org
References: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
 <20240818-amdgpu-min-backlight-quirk-v5-4-b6c0ead0c73d@weissschuh.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240818-amdgpu-min-backlight-quirk-v5-4-b6c0ead0c73d@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0056.namprd05.prod.outlook.com
 (2603:10b6:803:41::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 59185925-6793-4a65-42ca-08dcc223a1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXp4NTlrUHhUSEN6K3BicG9WVjMvcEJvSlpLZHJKeHp3N3JEZ1JHVnY3cmFG?=
 =?utf-8?B?MDRlN0NzUmdzNlAwdHdnUUlDMGF1S1pYSjByckxDbFRvMHRua1JkVFk2eFRt?=
 =?utf-8?B?dDRrVFhEUzNkb3h2ZFAzVzlVTUlaUitTQWd6S3pTRlBMVXFOdGJTWUpwUTc2?=
 =?utf-8?B?aERRUDJtdzhkYnpRNGN2c1NEbUc0YjFpNkNBV3BweDdSemhlejYyYldxbkQy?=
 =?utf-8?B?QWVZcmFIMHNUQlFmSmpkL0FSTDNHL3Q2K1VZYUJ3a0NrcDZVbFRNMVdNTitB?=
 =?utf-8?B?bzhleXlJSWd4ZlJCdEQ3S1RjZW9OZyt1S3grRjBFaGdZNU9rdVdLYkVXdzZO?=
 =?utf-8?B?dDN0bGRHa241NEl0MlRnL3hUd0xPdXl1VVpoRml6algzc0lVY0hMYlVkS2tt?=
 =?utf-8?B?WndVYVFjUzFUUVZ1YTVFNXgwbmJnUUFpUXFrOEdtMW9OenpRMUUwVzZKaFJS?=
 =?utf-8?B?YUd0dENFRkVrRHhEUUJDUWRBc1RqZm84aC9qTHJxZHFBWnNPL3lHZUQwM1JK?=
 =?utf-8?B?QTRJUSs1YUxRR2QyYWlJN2g3ZWhEWUVqWlBMam9uVHJZNlFxdGFiTVRUNlQr?=
 =?utf-8?B?U2dEOU1EaDAva1Vwazk1UFd5b0ZML2N3WEZFenVNY0FMUDlqZjJRN2U1d3o0?=
 =?utf-8?B?cytSMXBrTyswMXVpbUpiS2pKM1htTCsxWFZWSWVuM3l3TytoamV1VEZNbDY2?=
 =?utf-8?B?dnRVS1Z5L3UwTWJob0RCd21VT1VFM2JUTHcwMzVzck84RS9ReWJQaTNOZ1Nu?=
 =?utf-8?B?anFIOVBOQU5TellwZXBWaWhDSVgzdnduSC94amp4Nkh6N2JGZ0t1d0k4RGpv?=
 =?utf-8?B?VGJhZzY2bFh3L214T0JLbUU4OUd5aHBlNzRoRkUrYjY3cHhMeURFemYzZkQ2?=
 =?utf-8?B?OEpJeHZlQnA3ZUNic1I0dCtvZG42bUxueDRscEo1Q3ZEVUJ6enpJWVVBcEt6?=
 =?utf-8?B?Z0NIN0FmMFdNcnhwcnc2b1diWkdSeXphS2ZpaEJHQTJQdmtnWHU5MDFPa0xU?=
 =?utf-8?B?ZXZuZy9EZjM4SVlxTkV3SGZLQnhKQlA5Smh6aVJ1S2pyUjZVYUtLYkpGU1dl?=
 =?utf-8?B?b21EVVZUcE5EYjJlRHJocW1nVGF6Q2tzcUozazQ4dk0wZXNIaFJPYkdMdllC?=
 =?utf-8?B?YTh2UzAwdHRicjYxcTJzem9BZWZobDhobXNjVGljelB5Nlh4S0p3TlhjcnU1?=
 =?utf-8?B?MGxpZ3pwZmtoYWdMdSszelNpV1dIK29KeEhQMkJBdEhETHFtWnBTdHBQR2Zr?=
 =?utf-8?B?M0Q2WGlMY0Q2cVRRWWNPblJ0amhCVFNSbnFwN3lMdWJDR2N2UGl0K1pqZ0Nn?=
 =?utf-8?B?dGhRVHowWDFybmR4QUxTZjhNeXpUc1liM21CS0s1aWJYMWswOXJwOU05Z3Mz?=
 =?utf-8?B?UkJiRGdpYVk2enJwS3BOc05NcWxZQWxyME53ZnNmUVl0UXpvQkZqWXNQMTlu?=
 =?utf-8?B?UWpvZkg3VDVzQnhWQXdMdzB2MEdsek9lWWVNWDVPZDZVWHNZZ2JwZFNTbWQz?=
 =?utf-8?B?b3VVTDdUNDJiVlZIYnJZZUpFQUFlTUlpWElkaCsrdTNNQVZDQmNaM3BKa2Yy?=
 =?utf-8?B?YU1EQkZJN2NZQ3dNZkhic29zYXBObzFYUGVybkVrd3IvTlFVZ2VVYVoyQjBh?=
 =?utf-8?B?OXBoTWZLY1VXMU5TUkYyUFgyRzFJVGpmR1pLL3FNV2Z5a1Q2emVLZFo5M21Y?=
 =?utf-8?B?allPRmRJR2xBUUxqUGt1VUZtRlNTVVN3alJwUUtFbkhseWc0NENTU25YSEhz?=
 =?utf-8?B?WkVLTW1LY3RPNE9FUjh6b1lmOFhVaW5ucDhHTEZSWHU0RjVZWGRWdzV6T2pm?=
 =?utf-8?B?R0VlaU9vM04ySmFuczM2K1dXMjFpNXpValQvclZMSVIwTjkrOFlKbTZkRG9O?=
 =?utf-8?Q?7b+AhXxYRpaUB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTJpaUNnTXZhaURMVUZhQjBxWmROL0JMRTk1aVFMek9BZllCNDJXSlRGcTRE?=
 =?utf-8?B?NGRjQnZDTm5HRk1TREhCU3JPbmVJZk9oYkN4Q3BPalBoeXZRRGRZaU1xSDU4?=
 =?utf-8?B?RjFVUU9PMTQ0UStmN0U4WitabXZaUVRtd1FLVUJWeU5icGdhcjI5SmN4c3cy?=
 =?utf-8?B?aGNhd1hEWkRtNGRjOExPQXh3djJJb0V1TlY2QS9RUEhrSVY4QytFa3hhTEY5?=
 =?utf-8?B?TU9yWVB2RkVEQ21KQnlxYnhtRmszTFd4ZDhkbzlST2FrSkU1a3d5WnI5VU53?=
 =?utf-8?B?VUp1QkJpNVJ1Tk40Qjd5ZGZQWG91dExLdFZJZC93UnVHcE9VQkhZWUV6OVcr?=
 =?utf-8?B?dnFOTUFhNnFUMDllMzJMOGFmK2VJRW9hUVBLWGt1QjlJclZ3S2xRRDdPZGtt?=
 =?utf-8?B?NGxwbWJCWVB2Nnl2YjNITXV0RjNIdVJXSnlpNFppZVFsd3VVL2VMY1l1Sk1P?=
 =?utf-8?B?Q0k1SlFaVzRsZXJWbWRBQ2Uvc3ZxcWkzNWppZUNnYXRzanVROFBCV3ZlZVBz?=
 =?utf-8?B?SXJ5SWpUWi9qWTZnL0F4NHRqWEdrTWZnU0MrclMyMGNpVllTRUtmV2lEU3lQ?=
 =?utf-8?B?bFRPRjgyNHBzMEZ1STBuOG9ianhEYzF0c0VwSnF2Qm9YNzBtRzhML1N6YWRI?=
 =?utf-8?B?Z2NuWnJDYi9CY0dydmtBM3lLVURoL3cwemdYVHIwY1JDVm42N2srZDR0aEFu?=
 =?utf-8?B?dllVNXV4UmZXRnJuNThxakJKOEpaaHdjK1lOTThSc2ZBYmtoQnUwRUtCRHVu?=
 =?utf-8?B?eEkrdjRIbWQ4Y2NyQ2NPK3hUR1dsYnJ2T3hjNzNJSmlzK0daaGlpcC9Wa3Fx?=
 =?utf-8?B?ZGk0Sys5bDlwbEErc01XTXpvcUdUa3liajY2akVNMmpMUmh6ZUZjb2x1SVNY?=
 =?utf-8?B?d09TVWVOdWFQL0pObkUzZnV0TGEybllma1lrc0tMc3pYbEZCTGNZb0E1Ukls?=
 =?utf-8?B?YWhXd2pSVDFoQ0lrUU5sMmRvMzhTVU5oN3hGZ3RsSDI5QjBFbnp2RDh0RXRR?=
 =?utf-8?B?SE03N3dMTGhBdTBZSHhwK3lTRnhIREt3TWNnZ2NBZjlxbkptMUN3SXZWbVpk?=
 =?utf-8?B?bExqUGV6Q05XWlM4UFA1YjF4RUdra3lPc0RPdTUvMlRkRCtncmdOSkt3TzBC?=
 =?utf-8?B?TGZ4YnRsM0h2QjdkZkNMcVpoUnM3UVZpdWowQitEUUhDc0NhMWxETnR1N0Nt?=
 =?utf-8?B?QjRBcHRFTmpvTTZ0RGdVK3hSTThsNUxENk9Bemw0TDd3c3RxUjlLOWdla0Q2?=
 =?utf-8?B?NzQraVhHb1RUVXhFWGJuNjNqRUlCcm8rcU9MYkI4S1BjWU00TUlXNG16UE9m?=
 =?utf-8?B?eUcyNWRxbTJFNGVzQ3ZmRmttaE5CT0czRU5yQXc4d2YzY1F1bDhETGFqM0ZB?=
 =?utf-8?B?enRRVGNGaXQ1UkNZMWgxVTdnVDhrUFE0dlVUTTQxQWYrMjgwUFFsaW8zeWU4?=
 =?utf-8?B?dE1ucXlmeWlQOCtIczN4eXJNOU1GV2Ric0dPU0duVlJoSWNDSW9kdXA1c1RX?=
 =?utf-8?B?OVArMDc4SHNCRWt5Ri8yS01ycWE3WTV4M0NzeHQzaklwV3JZL1ZrVEdCNWpP?=
 =?utf-8?B?bHFBWW9XUGJoNG5ITmNicVI3dXJiNmVQbVgrdUMyS1drbzZ2NFpVbitGaXNC?=
 =?utf-8?B?UCt4dzFTdXcxZ1RLeWNzbVpvL3pyZVBuN2pQT1BBdFQ4b0dyRGlUSE1EVHMz?=
 =?utf-8?B?R0xKU2szK0NlWXgvR3JITElQd0lkZTcxTmZRZ2E0blNTN0o0TWpmc0xHUEN1?=
 =?utf-8?B?VXluc0UvOEFRTW1TazBsaFBTZlZMVEZGdVVxcWZkZ0huemtrRGFXRTNLdzNh?=
 =?utf-8?B?NWk5TUFCNWtFdVpJNExNbEpjbExOYzJrVlZGbGtwMWdDcll1ZEhTTGFMVlU0?=
 =?utf-8?B?aUV5QXNJZTJXVjNTanhrc3JVVHRSS2pGc3Zxbm5mNWx0MGhrRUNmNFp6eCtk?=
 =?utf-8?B?blVPc1pxbzVreGR3SDRxK2dWdEtseFNFSUFQcHVUc0MvVm52UXROTHlmRjhP?=
 =?utf-8?B?T1lKZ1ROenV3SHRWbGNYSjdQcUp5RUxXMXlEemJKMlN3OEJOSE03dG1uM3o1?=
 =?utf-8?B?MjFqUTFVSHRRRFNtWWtSRVZJeG1GZ0pnbkduUG1QaWxCdll0Wm9MUWtrK1Yy?=
 =?utf-8?Q?vwaQ3mUvPBr3aJFZokGwfwyA5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59185925-6793-4a65-42ca-08dcc223a1fe
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:55:47.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIUA/OdUZpVgLYKe4yQvWLY5KgEn9OAPPhpxGXZn9VSh16lmaX/7AA2mSU+sl91MgB6/uFJFUV3LW0cppBqbHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

On 8/18/2024 01:56, Thomas Weißschuh wrote:
> From: "Dustin L. Howett" <dustin@howett.net>
> 
> I have tested these panels on the Framework Laptop 13 AMD with firmware
> revision 3.05 (latest at time of submission).
> 
> Signed-off-by: Dustin L. Howett <dustin@howett.net>

When you send someone else's patch you need to add your own S-o-b as 
well.  Please add that for v6.  Otherwise:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/drm_panel_backlight_quirks.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index f2aefff618dd..c477d98ade2b 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -25,6 +25,22 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
>   		.ident.name = "NE135FBM-N41",
>   		.min_brightness = 0,
>   	},
> +	/* 13 inch glossy panel */
> +	{
> +		.dmi_match.field = DMI_BOARD_VENDOR,
> +		.dmi_match.value = "Framework",
> +		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x095f),
> +		.ident.name = "NE135FBM-N41",
> +		.min_brightness = 0,
> +	},
> +	/* 13 inch 2.8k panel */
> +	{
> +		.dmi_match.field = DMI_BOARD_VENDOR,
> +		.dmi_match.value = "Framework",
> +		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
> +		.ident.name = "NE135A1M-NY1",
> +		.min_brightness = 0,
> +	},
>   };
>   
>   static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
> 


