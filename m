Return-Path: <linux-kernel+bounces-172883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D58BF822
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0CB25916
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AB23FBAF;
	Wed,  8 May 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="aZGvU/DC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736243D96D;
	Wed,  8 May 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155733; cv=fail; b=KAbkGvjM/nmiQsLIMXEXPwckegsGGZj7bkcYkdYNEnBxG3FQ6maLaXhlF9RifVifo5HEdxyqD1EgqRU6XfwvNh/Oy0sebeNe6AFL7Xi2EvRVX4Em6c9Ph4iUBBeO9RVptZDh9bgs5z9fSbvJLPYOYucQvYDvLlwrzeIG6XJvKgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155733; c=relaxed/simple;
	bh=m6Hd16bBi85Ej2FizElh8RuN+wag0urfLVyBkldedRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LTprfPZY4FeA/tKn3vrM0AxgmnAEJjJ32yGBjIP92DKJdyyAo3tOgGUc+zmP4TBkr2s4d1IW2zTOTu1TZCgYHD51QMAGb19jc+cWKFFaecm5H2Ya5jBcyzfKQKFGjMm/iR9Yv61+NwANrnlbud7Metlw4aej9dbE/0B8QaGE6Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=aZGvU/DC; arc=fail smtp.client-ip=40.107.117.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq+paI9qAJ6LGg+ctKjL27g7FVTVbDognj3uytHqqqsjHC/gLY+ZdxQVWVYmXA7jSCTDOyDG6vTpXn1l7JYT18guWOgaTxxQ+SOcZa4pBywutHp7OWcoc+9XaBR3nab4wWfU2zVEHUl+AdYHwnq1tN3Rh7XfUiNwUm2Og0ikcozBELJzsNE3EMV2hqcbY5UxKidUczF/J8Hg3Y1CCqUmGqGD2WbTcDxL+lQgU5hPR/CkYgfAjIfLY5PDVajyqpLR0kUTDNXwYPlHfoZdYlyD+XH5jHfxsU8m12e61+9JSVd2SL2+CsuSBHcg+tC6DV4vSnuko5aKDhVlFrNhD3VXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJp9i/Ln2k/SHQuVgb8a+eRSzQYbWiIHCaN5VJcPpuY=;
 b=Hk5t5fkTbr8L0qZ4hDrFG2d92Fr2b3VmrS3XxYkqArKwb8nygMh0jh4aycG0wB1wtVcO33uVXX4GEAxsARau1srp/wA2paN7nv8jfAYULGaiUL27Va7krWUVk6n8iHYoBTuZ+Esfgo6AJXFGax5jMG7b05LO0EO0WX+pPDMk5s81dDw3nYkKHrtB/4Q6UktgtnZSuVeCS8AoXvToQrh7b6PDHWJ4/NKZBZNjyw3oCMrV1rpDMINPCijjO5W1bu+KaeRuq+mUZi5hjbfTJQtBAh/gs4AQObtAYe3l5qSKlYmLMvzFFDj90xkPi7fc+8UnHC5+DLdjICleD/DMM2kTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJp9i/Ln2k/SHQuVgb8a+eRSzQYbWiIHCaN5VJcPpuY=;
 b=aZGvU/DCXCS8OmvzRrWYidJ5mdpql8po3s3/FlNwqOZko6T2tjgUhog/V7L/A1JIRoH59cy54Bhmlkr46PD9c4SxrKNrWPYWSacfeSkekDALwJ0JQ6sbnZWPRLEyAiXE6k2O3nknPF0F5gDstZ3xQJTi7WBwHabmoJ+LVc5YG/7AailSxILddeQWGg4fjZrbwMQslmS+/4D7tKIEPpsUSHZe95WCU8fdoRswdoc/+LlbfNrRv7TFcq7zyZP5YHvuz5+VdiN7Ciq18mSFLersuFTvSZNgZcv1XrfpTfZKBuZ0jAOOuacjfOpjFJQ3LOECukvvImss5KDAJAZzZEb9bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SG2PR03MB6430.apcprd03.prod.outlook.com (2603:1096:4:1c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Wed, 8 May
 2024 08:08:44 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f4ff:211b:7c34:16c8]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::f4ff:211b:7c34:16c8%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:08:43 +0000
Message-ID: <4fdc9bcc-b9fc-4cf8-b195-b7ab5bdc30ea@amlogic.com>
Date: Wed, 8 May 2024 16:08:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] clk: meson: c3: add c3 clock peripherals
 controller driver
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Chuan Liu <chuan.liu@amlogic.com>
References: <20240430064438.2094701-1-xianwei.zhao@amlogic.com>
 <20240430064438.2094701-6-xianwei.zhao@amlogic.com>
 <1j4jbf3s50.fsf@starbuckisacylon.baylibre.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <1j4jbf3s50.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SG2PR03MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 78960d70-8227-4958-ce73-08dc6f3613a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzYyZ1M4NjMwYjhsSnM3Vi9FSUpxRklmUFpEL29OMjVneDVRWkwyanV4Nmtn?=
 =?utf-8?B?YmJsbTBQZlhYRWpLbGF6NTMyVEJ5RkRwaE1yYXpRejlyV1Rsc0hOZlpjMEww?=
 =?utf-8?B?SzdpOHROZTFvY0g2S3A3M2s0Zk11UUpFRDFUajkxRE5UYW5VQnQ4UkFGSlFr?=
 =?utf-8?B?S1VGYjdVY2hjRWlXbThaVlJ2bkxqTFNRSVRGNWZyVUZZaFZ5V2tQOC9PY3Np?=
 =?utf-8?B?eUh1KzYrUzF2VFBBY1BCdjB6OStzSGp4aU03Y1Nmc1dBSGhJWWdOOE93eWQ1?=
 =?utf-8?B?RWZYZ1ZQWWhTVy9uZVZHUWx1a1ZEODBSSmkrb0JXK1NDT0FsNlpUTk5OeXdO?=
 =?utf-8?B?S2wvaGRMVWJmMnoxR3FGOVVvcHF3NEk2WitmOFZjLzUvQmYrYW0rU1pYSFhW?=
 =?utf-8?B?RHYyVGVoREtibzhaNHhlZDZFSVozMWlaWGxEYTRWcjBCeW9Tb3lTSGd0VUIz?=
 =?utf-8?B?enR5eVBPZitNcE4xVno4blludlBucTU0MnRpR0RpamptVUtUeWlqbFZ2Tkg4?=
 =?utf-8?B?SUFxbVo0TWhjUEVGR0pTbmhwdlhFUmh4QTg3ZjlUblVXY25YSStpQ2ZpbllC?=
 =?utf-8?B?dWpHK0RseHlVZ3p2bllnWXFoS1lmcE9wSU00YTJaZFBDOE1oL3hXRm1zYWJP?=
 =?utf-8?B?OCs3Rjk3MTdnV3dyTE1EOXAzLzVPNlFJRTRHTmJVSm4vc0dJWGM5M3l0ZHg5?=
 =?utf-8?B?RWNaYVhyV0RvTTVPbmVaeS8vYzErdjF4OVRJY2NpZ3U1WEVRVnB1U01kSXF5?=
 =?utf-8?B?KzU0d0F2TC9uaW9XclV4RWJZbGZvVXpNWmlhNEJQQUV6THN0YkI5YjdEK0N4?=
 =?utf-8?B?cUpZTW4zQnNuS2l3L2E1WUZyMUVPVkZZSUxTWndtbzVQZnI3bUdFdTBUZjYr?=
 =?utf-8?B?NUk2TnBhTEVKeVRXMTJJdGhXakVpZE5HRVFnaFNPZFMrRzM0RXdFYXBZa0Jq?=
 =?utf-8?B?WnlkZ1lud0Jna1Z2a28rS3BUbVlnVkg1Z3FJbFd5bUt0OFNOSDluRG5ETE1W?=
 =?utf-8?B?bWF2dXZLNmFNK3J5OGtKR0RpcVFOQ2EwRTduaXU5eHBXdUFMcVF5WDh0TXNP?=
 =?utf-8?B?dEJCRGlRdUpTdUlSUXZPZUNkQU0yN2p5WWo0Qk5aYkxMek5wbUNsODBwYW1C?=
 =?utf-8?B?UWMzdXo5SnRhQ1JrUnRNQXJ3STBRY2xFZ0xhWnJDZnlUL0NRaW5jQXhUMFlv?=
 =?utf-8?B?dktHY3lYNkFadEtyenM2NnhUSk9lWVMzdUFjR2twZWhsMVBYaDMvMXlTSFZ2?=
 =?utf-8?B?c2Rua09NYnFEM0VUUlBDeXdSRjBWQzJnc0FNR25GTGRFWGdhTlJZWURVVmgx?=
 =?utf-8?B?MnlkL1owQkVGb0RxVHdUOFlIeDN6OXc0d1pCNzlXUEVBMGZNeWxvQ2RFOGg2?=
 =?utf-8?B?LzFNYmVWQkR2ZW1UVTVUZTRqSFY3aWEyYXVMK054d3JySkZwaHAva2doSlow?=
 =?utf-8?B?WjVCcDEwVU9yWEI2cWZPdkNGZVNqWnNzQlErTC93dTV5RW1pSTY2TitDZmdP?=
 =?utf-8?B?SVQzdEVYbnhlV29zQ3JVSVM5d01LTGtrcjBjbVhIbk9xYVl2a3hkRzM4OTdj?=
 =?utf-8?B?Ny8rbGl5UGFDZFVheEY5Vmp1MndMTzRrSk9qQW1PM05KQnpTdkF5R0R5TXdW?=
 =?utf-8?B?bmFnQkZiNlpXSGRJWUlDVFBWZ1J3WW9YWS9ubHB3ZExLTUdoVHN1M0VIOVl3?=
 =?utf-8?B?OXh0bGVySllycUJYdC96VFJVRTlRZXlqUUdhTXRoU0xCcnJxMytSYVR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1yWDBiS0E4dCtGQi9RaWRGZDM3Vi96dVhjYzh6VmkyMVJtUEE3NEFWeTJ3?=
 =?utf-8?B?eDk1YjEydHpXVjdiZHJHVmRWODFQZXhVb05GZFp3NnZSWkZka2tiR2lSamZ6?=
 =?utf-8?B?cHI4YnNxOWRGMFhhdGtLT2VYdjZ3QlEvQ3RHdlA0QnZKblAzTUtwa015bmQv?=
 =?utf-8?B?MjNtK0JaaElWdWU3YlNqMURrRXZEeENJbEVsUVhTdytBNkkyU3h4YWo1Mm5E?=
 =?utf-8?B?bWxTdWZZV3R6NFVmQmlsUmNTZFBTNDFSNjdYNXk5blRGUVZDSC9ibmY2V3gz?=
 =?utf-8?B?bGI4WWxuNEFKS01SMk0wWnUwN3FjOTMzWllIVmV5SWdsU256bUcwazZGdlZI?=
 =?utf-8?B?U0R6VTlBRGV1M2M1QzRrNkNVSHVDSCtXRFlNRkFLRnBEcmZEemx4UjBXQTAr?=
 =?utf-8?B?TTd5SDdWTHJTZmxqZUxTeTNMcWVHUDBmVDRmSnFxS0w0TkRYRWp1L2hBSk9D?=
 =?utf-8?B?Ryt4S0RDbE9uOTM0d2llcVpkNnp6RzYrVGRpQ3M0VitXekJXWm5Zc0lzQkFo?=
 =?utf-8?B?QlZiNG9oaU5LcjUwaVk2VUFWa01HcHV5QlhSYkNNc2p4U3ZMSTBUeWJNVWZx?=
 =?utf-8?B?dE5YaXFrODFhQm9HcDhaa2hPSjFCWktzTHk3dzlwTG5uRGVxL1prWXhjWjNs?=
 =?utf-8?B?dUV5RHM1NkxmUkt4d2U5UnZxclFRTEp2OUpVNm9pN1A2eEZuWG4zcS9zcVBz?=
 =?utf-8?B?QTRjQnFGL3lieEJHcHR3a0M3MUxGM0NKWVJLc2c2VFU1eTE5bWFCVTFnVHZa?=
 =?utf-8?B?YWxDZi94NUZKQmx2WDJ1bWdCMEZtN0lwQnBZMnZpdzVLcDJ1d3Y1d3kvWGxW?=
 =?utf-8?B?TStPang1L3ZsUU1aR3ZRWFo0ZDg1eFFlc09GYzdQUjRGVWg3Y3U5L0Q0L1Fk?=
 =?utf-8?B?dStwdjIramZBSGZaQi81c0VDSWZQZXBBTjV2akNvbndwcHoxOHBLWG9ZTzMx?=
 =?utf-8?B?QWdQdG5JS0lhRldzQjVHL2hSM2lzZVdSNWR4dTFoM2J4bzhZTFNKRDZOa0hk?=
 =?utf-8?B?T3dMdXJlMnNXd21KTXg1TTh4ZmxzUEtyTzh3U2IvTzcyNjdhK0NTWlF3dmJ4?=
 =?utf-8?B?Wnk5aXo3WjJjazZ3Zkk4cDRFOXdsSHY2K2dwb2R0TUp5YjZMTkhSL2R4Q3lk?=
 =?utf-8?B?emZySHh0VjI2TW12TTR3OGYwMGNpUnhNZnZNZVQ0NFhHRVBJL0JpVEJpd1Rt?=
 =?utf-8?B?dHVueTN6cW5BRzdMNkFucXYrVlJvWWdTa3k3d04xY2dQM0N2NmNXelpvZWM5?=
 =?utf-8?B?bVhzT1ZtalBhMGswMVFzN2l4bXp4UnBDNXpySEVrSlhRY0dlaUUwdE41bU5Q?=
 =?utf-8?B?a0dsTVlzL2UzTFB2ZHhyN2xlNGJtN2hOS2p6Q0dyZWg5STZSUXVtN0tIa3Rt?=
 =?utf-8?B?ZWplWjMxSmluekxQd0kwYUhCbTAxbkJCUmtYdzd1VG94NnBrOHAxL1A3bjFB?=
 =?utf-8?B?eEJhWDFTTGlXdTBmZklWaTJMVWZtMmc2cEI1K3dNYU53K0dreVk4YlVtZzlj?=
 =?utf-8?B?OFh5UkNhcXJTbDFuQ3lzZ0Vvc3daYWdYWjdYMVhkUHF3VVJWZmlaVUdETktB?=
 =?utf-8?B?S2Z1RlMxT1RzYU1uWVVuV0U0eVVzV2VmNTErUkk3dkdxTWw0VXZMYWt6aUE0?=
 =?utf-8?B?b3p4V1U5UWE3a2dwMDZRVGQyV0I1b0lIc2dSUFRwd1F4VHE4RVpwdGVGdlpB?=
 =?utf-8?B?Y295SU1mcFBLenVkR3lVc0JDZjB1TXpqOTFGKytyVkhhUWRNc0k2c29YU211?=
 =?utf-8?B?eGhEaCtmNFFYclFTcFZvYlJoSWMvRUVoSnAxVlMvNkxDMGtKMSsrdi9KMkJq?=
 =?utf-8?B?NExSUDAxWTFhb1lSSGFCdGVwS2dBS29RTjE0M2NrcGtaRWt4ejJFLzI0RDND?=
 =?utf-8?B?b3pZejF3cHp0TzFEbVpiWWNpV0xLdEY3S1doNFUxdURFQk1MbEhOVWJJcjdV?=
 =?utf-8?B?cVFOdVZZNnJ6YjhPeEo5MFRRd2VtZUJ0WHJ3ZFhRNmpERldjUVlEN0Nqb1VG?=
 =?utf-8?B?SGdXdWFmbG52a1BJSnB3K28wTy95VGh6bWtsbEtpdXBCY3l5VEtVejBua1hY?=
 =?utf-8?B?ZGtqOUxRTGorVzFaTkdOUnlKY1FPUDgweTZWQWE1ZW5yTUROeG5Td3p2Q3JY?=
 =?utf-8?B?eEExaERaMjhBZEt0WlYyVVp2UTR2TUJFQXRQWW0xWnR1WVZnNHVwaTVrWlps?=
 =?utf-8?B?c2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78960d70-8227-4958-ce73-08dc6f3613a9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 08:08:43.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5Zjvgbxk6/avpPDnF3b2iORTirD0I/SQzsN/Rkhhqirlj4qqJbaQ3T1bG7zjf9mMHZSRNNvtH+IGQnWZkr3v9UZiRlhh0fB5mx+UGKNnkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6430

Hi Jerome,
    Thanks for your reply.

On 2024/5/3 22:04, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue 30 Apr 2024 at 14:44, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
> 
>> Add the C3 peripherals clock controller driver in the C3 SoC family.
>>
>> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/clk/meson/Kconfig          |   15 +
>>   drivers/clk/meson/Makefile         |    1 +
>>   drivers/clk/meson/c3-peripherals.c | 2365 ++++++++++++++++++++++++++++
>>   3 files changed, 2381 insertions(+)
>>   create mode 100644 drivers/clk/meson/c3-peripherals.c
>>
>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>> index 9f975a980581..0b85d584910e 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -142,6 +142,21 @@ config COMMON_CLK_C3_PLL
>>          AKA C3. Say Y if you want the board to work, because PLLs are the parent
>>          of most peripherals.
>>
>> +config COMMON_CLK_C3_PERIPHERALS
>> +     tristate "Amlogic C3 peripherals clock controller"
>> +     depends on ARM64
>> +     depends on ARM_SCMI_PROTOCOL
> 
> Rob has commented on v7 that this is not OK.
> It was on the PLL patch but you can guess that if this is not OK for the
> PLL controller, it is not OK for the peripheral controller either.
> 
> So please drop this
Will do.
> 
>> +     depends on COMMON_CLK_SCMI
> 
> imply, not depends
Will fix it .
> 
>> +     depends on COMMON_CLK_C3_PLL
> 
> Same.
Will fix it.
> 
>> +     default y
>> +     select COMMON_CLK_MESON_REGMAP
>> +     select COMMON_CLK_MESON_DUALDIV
>> +     select COMMON_CLK_MESON_CLKC_UTILS
>> +     help
>> +       Support for the Peripherals clock controller on Amlogic C302X and
>> +       C308L devices, AKA C3. Say Y if you want the peripherals clock to
>> +       work.
>> +
>>   config COMMON_CLK_G12A
>>        tristate "G12 and SM1 SoC clock controllers support"
>>        depends on ARM64
>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>> index 4420af628b31..20ad9482c892 100644
>> --- a/drivers/clk/meson/Makefile
>> +++ b/drivers/clk/meson/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>>   obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>> +obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>>   obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
>> new file mode 100644
>> index 000000000000..b786d8ff9be0
>> --- /dev/null
>> +++ b/drivers/clk/meson/c3-peripherals.c
>> @@ -0,0 +1,2365 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Amlogic C3 Peripherals Clock Controller Driver
>> + *
>> + * Copyright (c) 2023 Amlogic, inc.
>> + * Author: Chuan Liu <chuan.liu@amlogic.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include "clk-regmap.h"
>> +#include "clk-dualdiv.h"
>> +#include "meson-clkc-utils.h"
>> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
>> +
>> +#define RTC_BY_OSCIN_CTRL0                   0x8
>> +#define RTC_BY_OSCIN_CTRL1                   0xc
>> +#define RTC_CTRL                             0x10
>> +#define SYS_CLK_EN0_REG0                     0x44
>> +#define SYS_CLK_EN0_REG1                     0x48
>> +#define SYS_CLK_EN0_REG2                     0x4c
>> +#define CLK12_24_CTRL                                0xa8
>> +#define AXI_CLK_EN0                          0xac
>> +#define VDIN_MEAS_CLK_CTRL                   0xf8
>> +#define VAPB_CLK_CTRL                                0xfc
>> +#define MIPIDSI_PHY_CLK_CTRL                 0x104
>> +#define GE2D_CLK_CTRL                                0x10c
>> +#define ISP0_CLK_CTRL                                0x110
>> +#define DEWARPA_CLK_CTRL                     0x114
>> +#define VOUTENC_CLK_CTRL                     0x118
>> +#define VDEC_CLK_CTRL                                0x140
>> +#define VDEC3_CLK_CTRL                               0x148
>> +#define TS_CLK_CTRL                          0x158
>> +#define ETH_CLK_CTRL                         0x164
>> +#define NAND_CLK_CTRL                                0x168
>> +#define SD_EMMC_CLK_CTRL                     0x16c
>> +#define SPICC_CLK_CTRL                               0x174
>> +#define GEN_CLK_CTRL                         0x178
>> +#define SAR_CLK_CTRL0                                0x17c
>> +#define PWM_CLK_AB_CTRL                              0x180
>> +#define PWM_CLK_CD_CTRL                              0x184
>> +#define PWM_CLK_EF_CTRL                              0x188
>> +#define PWM_CLK_GH_CTRL                              0x18c
>> +#define PWM_CLK_IJ_CTRL                              0x190
>> +#define PWM_CLK_KL_CTRL                              0x194
>> +#define PWM_CLK_MN_CTRL                              0x198
>> +#define VC9000E_CLK_CTRL                     0x19c
>> +#define SPIFC_CLK_CTRL                               0x1a0
>> +#define NNA_CLK_CTRL                         0x220
>> +
>> +static struct clk_regmap rtc_xtal_clkin = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 31,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_xtal_clkin",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "oscin",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct meson_clk_dualdiv_param rtc_32k_div_table[] = {
>> +     { 733, 732, 8, 11, 1 },
>> +     { /* sentinel */ }
>> +};
>> +
>> +static struct clk_regmap rtc_32k_div = {
>> +     .data = &(struct meson_clk_dualdiv_data) {
>> +             .n1 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .n2 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .m1 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 0,
>> +                     .width   = 12,
>> +             },
>> +             .m2 = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL1,
>> +                     .shift   = 12,
>> +                     .width   = 12,
>> +             },
>> +             .dual = {
>> +                     .reg_off = RTC_BY_OSCIN_CTRL0,
>> +                     .shift   = 28,
>> +                     .width   = 1,
>> +             },
>> +             .table = rtc_32k_div_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_div",
>> +             .ops = &meson_clk_dualdiv_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &rtc_xtal_clkin.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_32k_mux_parent_data[] = {
>> +     { .hw = &rtc_32k_div.hw },
>> +     { .hw = &rtc_xtal_clkin.hw }
>> +};
>> +
>> +static struct clk_regmap rtc_32k_mux = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = RTC_BY_OSCIN_CTRL1,
>> +             .mask = 0x1,
>> +             .shift = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k_mux",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_32k_mux_parent_data,
>> +             .num_parents = ARRAY_SIZE(rtc_32k_mux_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap rtc_32k = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = RTC_BY_OSCIN_CTRL0,
>> +             .bit_idx = 30,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_32k",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &rtc_32k_mux.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data rtc_clk_mux_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .hw = &rtc_32k.hw },
>> +     { .fw_name = "pad_osc" }
>> +};
>> +
>> +static struct clk_regmap rtc_clk = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = RTC_CTRL,
>> +             .mask = 0x3,
>> +             .shift = 0,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "rtc_clk",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = rtc_clk_mux_parent_data,
>> +             .num_parents = ARRAY_SIZE(rtc_clk_mux_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +#define C3_CLK_GATE(_name, _reg, _bit, _fw_name, _ops, _flags)               \
>> +struct clk_regmap _name = {                                          \
>> +     .data = &(struct clk_regmap_gate_data){                         \
>> +             .offset = (_reg),                                       \
>> +             .bit_idx = (_bit),                                      \
>> +     },                                                              \
>> +     .hw.init = &(struct clk_init_data) {                            \
>> +             .name = #_name,                                         \
>> +             .ops = _ops,                                            \
>> +             .parent_data = &(const struct clk_parent_data) {        \
>> +                     .fw_name = #_fw_name,                           \
>> +             },                                                      \
>> +             .num_parents = 1,                                       \
>> +             .flags = (_flags),                                      \
>> +     },                                                              \
>> +}
>> +
>> +#define C3_SYS_GATE(_name, _reg, _bit, _flags)                               \
>> +     C3_CLK_GATE(_name, _reg, _bit, sysclk,                          \
>> +                 &clk_regmap_gate_ops, _flags)
>> +
>> +#define C3_SYS_GATE_RO(_name, _reg, _bit)                            \
>> +     C3_CLK_GATE(_name, _reg, _bit, sysclk,                          \
>> +                 &clk_regmap_gate_ro_ops, 0)
>> +
>> +static C3_SYS_GATE(sys_reset_ctrl,   SYS_CLK_EN0_REG0, 1, 0);
>> +static C3_SYS_GATE(sys_pwr_ctrl,     SYS_CLK_EN0_REG0, 3, 0);
>> +static C3_SYS_GATE(sys_pad_ctrl,     SYS_CLK_EN0_REG0, 4, 0);
>> +static C3_SYS_GATE(sys_ctrl,         SYS_CLK_EN0_REG0, 5, 0);
>> +static C3_SYS_GATE(sys_ts_pll,               SYS_CLK_EN0_REG0, 6, 0);
>> +
>> +/*
>> + * NOTE: sys_dev_arb provides the clock to the ETH and SPICC arbiters that
>> + * access the AXI bus.
>> + */
>> +static C3_SYS_GATE(sys_dev_arb,              SYS_CLK_EN0_REG0, 7, 0);
>> +
>> +/*
>> + * FIXME: sys_mmc_pclk provides the clock for the DDR PHY, DDR will only be
>> + * initialized in bl2, and this clock should not be touched in linux.
>> + */
>> +static C3_SYS_GATE_RO(sys_mmc_pclk,  SYS_CLK_EN0_REG0, 8);
>> +
>> +/*
>> + * NOTE: sys_cpu_ctrl provides the clock for CPU controller. After clock is
>> + * disabled, cpu_clk and other key CPU-related configurations cannot take effect.
>> + */
>> +static C3_SYS_GATE(sys_cpu_ctrl,     SYS_CLK_EN0_REG0, 11, CLK_IS_CRITICAL);
>> +static C3_SYS_GATE(sys_jtag_ctrl,    SYS_CLK_EN0_REG0, 12, 0);
>> +static C3_SYS_GATE(sys_ir_ctrl,              SYS_CLK_EN0_REG0, 13, 0);
>> +
>> +/*
>> + * NOTE: sys_irq_ctrl provides the clock for IRQ controller. The IRQ controller
>> + * collects and distributes the interrupt signal to the GIC, PWR_CTRL, and
>> + * AOCPU. If the clock is disabled, interrupt-related functions will occurs an
>> + * exception.
>> + */
>> +static C3_SYS_GATE(sys_irq_ctrl,     SYS_CLK_EN0_REG0, 14, CLK_IS_CRITICAL);
>> +static C3_SYS_GATE(sys_msr_clk,              SYS_CLK_EN0_REG0, 15, 0);
>> +static C3_SYS_GATE(sys_rom,          SYS_CLK_EN0_REG0, 16, 0);
>> +static C3_SYS_GATE(sys_uart_f,               SYS_CLK_EN0_REG0, 17, 0);
>> +static C3_SYS_GATE(sys_cpu_apb,              SYS_CLK_EN0_REG0, 18, 0);
>> +static C3_SYS_GATE(sys_rsa,          SYS_CLK_EN0_REG0, 19, 0);
>> +static C3_SYS_GATE(sys_sar_adc,              SYS_CLK_EN0_REG0, 20, 0);
>> +static C3_SYS_GATE(sys_startup,              SYS_CLK_EN0_REG0, 21, 0);
>> +static C3_SYS_GATE(sys_secure,               SYS_CLK_EN0_REG0, 22, 0);
>> +static C3_SYS_GATE(sys_spifc,                SYS_CLK_EN0_REG0, 23, 0);
>> +static C3_SYS_GATE(sys_nna,          SYS_CLK_EN0_REG0, 25, 0);
>> +static C3_SYS_GATE(sys_eth_mac,              SYS_CLK_EN0_REG0, 26, 0);
>> +
>> +/*
>> + * FIXME: sys_gic provides the clock for GIC(Generic Interrupt Controller).
>> + * After clock is disabled, The GIC cannot work properly. At present, the driver
>> + * used by our GIC is the public driver in kernel, and there is no management
>> + * clock in the driver.
>> + */
>> +static C3_SYS_GATE(sys_gic,          SYS_CLK_EN0_REG0, 27, CLK_IS_CRITICAL);
>> +static C3_SYS_GATE(sys_rama,         SYS_CLK_EN0_REG0, 28, 0);
>> +
>> +/*
>> + * NOTE: sys_big_nic provides the clock to the control bus of the NIC(Network
>> + * Interface Controller) between multiple devices(CPU, DDR, RAM, ROM, GIC,
>> + * SPIFC, CAPU, JTAG, EMMC, SDIO, sec_top, USB, Audio, ETH, SPICC) in the
>> + * system. After clock is disabled, The NIC cannot work.
>> + */
>> +static C3_SYS_GATE(sys_big_nic,              SYS_CLK_EN0_REG0, 29, CLK_IS_CRITICAL);
>> +static C3_SYS_GATE(sys_ramb,         SYS_CLK_EN0_REG0, 30, 0);
>> +static C3_SYS_GATE(sys_audio_pclk,   SYS_CLK_EN0_REG0, 31, 0);
>> +static C3_SYS_GATE(sys_pwm_kl,               SYS_CLK_EN0_REG1, 0, 0);
>> +static C3_SYS_GATE(sys_pwm_ij,               SYS_CLK_EN0_REG1, 1, 0);
>> +static C3_SYS_GATE(sys_usb,          SYS_CLK_EN0_REG1, 2, 0);
>> +static C3_SYS_GATE(sys_sd_emmc_a,    SYS_CLK_EN0_REG1, 3, 0);
>> +static C3_SYS_GATE(sys_sd_emmc_c,    SYS_CLK_EN0_REG1, 4, 0);
>> +static C3_SYS_GATE(sys_pwm_ab,               SYS_CLK_EN0_REG1, 5, 0);
>> +static C3_SYS_GATE(sys_pwm_cd,               SYS_CLK_EN0_REG1, 6, 0);
>> +static C3_SYS_GATE(sys_pwm_ef,               SYS_CLK_EN0_REG1, 7, 0);
>> +static C3_SYS_GATE(sys_pwm_gh,               SYS_CLK_EN0_REG1, 8, 0);
>> +static C3_SYS_GATE(sys_spicc_1,              SYS_CLK_EN0_REG1, 9, 0);
>> +static C3_SYS_GATE(sys_spicc_0,              SYS_CLK_EN0_REG1, 10, 0);
>> +static C3_SYS_GATE(sys_uart_a,               SYS_CLK_EN0_REG1, 11, 0);
>> +static C3_SYS_GATE(sys_uart_b,               SYS_CLK_EN0_REG1, 12, 0);
>> +static C3_SYS_GATE(sys_uart_c,               SYS_CLK_EN0_REG1, 13, 0);
>> +static C3_SYS_GATE(sys_uart_d,               SYS_CLK_EN0_REG1, 14, 0);
>> +static C3_SYS_GATE(sys_uart_e,               SYS_CLK_EN0_REG1, 15, 0);
>> +static C3_SYS_GATE(sys_i2c_m_a,              SYS_CLK_EN0_REG1, 16, 0);
>> +static C3_SYS_GATE(sys_i2c_m_b,              SYS_CLK_EN0_REG1, 17, 0);
>> +static C3_SYS_GATE(sys_i2c_m_c,              SYS_CLK_EN0_REG1, 18, 0);
>> +static C3_SYS_GATE(sys_i2c_m_d,              SYS_CLK_EN0_REG1, 19, 0);
>> +static C3_SYS_GATE(sys_i2c_s_a,              SYS_CLK_EN0_REG1, 20, 0);
>> +static C3_SYS_GATE(sys_rtc,          SYS_CLK_EN0_REG1, 21, 0);
>> +static C3_SYS_GATE(sys_ge2d,         SYS_CLK_EN0_REG1, 22, 0);
>> +static C3_SYS_GATE(sys_isp,          SYS_CLK_EN0_REG1, 23, 0);
>> +static C3_SYS_GATE(sys_gpv_isp_nic,  SYS_CLK_EN0_REG1, 24, 0);
>> +static C3_SYS_GATE(sys_gpv_cve_nic,  SYS_CLK_EN0_REG1, 25, 0);
>> +static C3_SYS_GATE(sys_mipi_dsi_host,        SYS_CLK_EN0_REG1, 26, 0);
>> +static C3_SYS_GATE(sys_mipi_dsi_phy, SYS_CLK_EN0_REG1, 27, 0);
>> +static C3_SYS_GATE(sys_eth_phy,              SYS_CLK_EN0_REG1, 28, 0);
>> +static C3_SYS_GATE(sys_acodec,               SYS_CLK_EN0_REG1, 29, 0);
>> +static C3_SYS_GATE(sys_dwap,         SYS_CLK_EN0_REG1, 30, 0);
>> +static C3_SYS_GATE(sys_dos,          SYS_CLK_EN0_REG1, 31, 0);
>> +static C3_SYS_GATE(sys_cve,          SYS_CLK_EN0_REG2, 0, 0);
>> +static C3_SYS_GATE(sys_vout,         SYS_CLK_EN0_REG2, 1, 0);
>> +static C3_SYS_GATE(sys_vc9000e,              SYS_CLK_EN0_REG2, 2, 0);
>> +static C3_SYS_GATE(sys_pwm_mn,               SYS_CLK_EN0_REG2, 3, 0);
>> +static C3_SYS_GATE(sys_sd_emmc_b,    SYS_CLK_EN0_REG2, 4, 0);
>> +
>> +#define C3_AXI_GATE(_name, _reg, _bit, _flags)                               \
>> +     C3_CLK_GATE(_name, _reg, _bit, axiclk,                          \
>> +                 &clk_regmap_gate_ops, _flags)
>> +
>> +/*
>> + * NOTE: axi_sys_nic provides the clock to the AXI bus of the system NIC. After
>> + * clock is disabled, The NIC cannot work.
>> + */
>> +static C3_AXI_GATE(axi_sys_nic,              AXI_CLK_EN0, 2, CLK_IS_CRITICAL);
>> +static C3_AXI_GATE(axi_isp_nic,              AXI_CLK_EN0, 3, 0);
>> +static C3_AXI_GATE(axi_cve_nic,              AXI_CLK_EN0, 4, 0);
>> +static C3_AXI_GATE(axi_ramb,         AXI_CLK_EN0, 5, 0);
>> +static C3_AXI_GATE(axi_rama,         AXI_CLK_EN0, 6, 0);
>> +
>> +/*
>> + * NOTE: axi_cpu_dmc provides the clock to the AXI bus where the CPU accesses
>> + * the DDR. After clock is disabled, The CPU will not have access to the DDR.
>> + */
>> +static C3_AXI_GATE(axi_cpu_dmc,              AXI_CLK_EN0, 7, CLK_IS_CRITICAL);
>> +static C3_AXI_GATE(axi_nic,          AXI_CLK_EN0, 8, 0);
>> +static C3_AXI_GATE(axi_dma,          AXI_CLK_EN0, 9, 0);
>> +
>> +/*
>> + * NOTE: axi_mux_nic provides the clock to the NIC's AXI bus for NN(Neural
>> + * Network) and other devices(CPU, EMMC, SDIO, sec_top, USB, Audio, ETH, SPICC)
>> + * to access RAM space.
>> + */
>> +static C3_AXI_GATE(axi_mux_nic,              AXI_CLK_EN0, 10, 0);
>> +static C3_AXI_GATE(axi_cve,          AXI_CLK_EN0, 12, 0);
>> +
>> +/*
>> + * NOTE: axi_dev1_dmc provides the clock for the peripherals(EMMC, SDIO,
>> + * sec_top, USB, Audio, ETH, SPICC) to access the AXI bus of the DDR.
>> + */
>> +static C3_AXI_GATE(axi_dev1_dmc,     AXI_CLK_EN0, 13, 0);
>> +static C3_AXI_GATE(axi_dev0_dmc,     AXI_CLK_EN0, 14, 0);
>> +static C3_AXI_GATE(axi_dsp_dmc,              AXI_CLK_EN0, 15, 0);
>> +
>> +/*
>> + * clk_12_24m model
>> + *
>> + *          |------|     |-----| clk_12m_24m |-----|
>> + * xtal---->| gate |---->| div |------------>| pad |
>> + *          |------|     |-----|             |-----|
>> + */
>> +static struct clk_regmap clk_12_24m_in = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLK12_24_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "clk_12_24m_in",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "xtal_24m",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap clk_12_24m = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLK12_24_CTRL,
>> +             .shift = 10,
>> +             .width = 1,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "clk_12_24m",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &clk_12_24m_in.hw
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +/* Fix me: set value 0 will div by 2 like value 1 */
>> +static struct clk_regmap fclk_25m_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = CLK12_24_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_25m_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "fix",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap fclk_25m = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = CLK12_24_CTRL,
>> +             .bit_idx = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "fclk_25m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &fclk_25m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +/*
>> + * Channel 3(ddr_dpll_pt_clk) is manged by the DDR module; channel 12(cts_msr_clk)
>> + * is manged by clock measures module. Their hardware are out of clock tree.
>> + * Channel 4 8 9 10 11 13 14 15 16 18 are not connected.
>> + */
>> +static u32 gen_parent_table[] = { 0, 1, 2, 5, 6, 7, 17, 19, 20, 21, 22, 23, 24};
>> +
>> +static const struct clk_parent_data gen_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .hw = &rtc_clk.hw },
>> +     { .fw_name = "sysplldiv16" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "cpudiv16" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap gen_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = GEN_CLK_CTRL,
>> +             .mask = 0x1f,
>> +             .shift = 12,
>> +             .table = gen_parent_table,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = gen_parent_data,
>> +             .num_parents = ARRAY_SIZE(gen_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap gen_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = GEN_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gen_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap gen = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = GEN_CLK_CTRL,
>> +             .bit_idx = 11,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "gen",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &gen_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data saradc_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "sysclk" }
>> +};
>> +
>> +static struct clk_regmap saradc_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = SAR_CLK_CTRL0,
>> +             .mask = 0x1,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = saradc_parent_data,
>> +             .num_parents = ARRAY_SIZE(saradc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap saradc_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = SAR_CLK_CTRL0,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &saradc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap saradc = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = SAR_CLK_CTRL0,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "saradc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &saradc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data pwm_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" }
>> +};
>> +
>> +#define AML_PWM_CLK_MUX(_name, _reg, _shift) {                       \
>> +     .data = &(struct clk_regmap_mux_data) {                 \
>> +             .offset = _reg,                                 \
>> +             .mask = 0x3,                                    \
>> +             .shift = _shift,                                \
>> +     },                                                      \
>> +     .hw.init = &(struct clk_init_data) {                    \
>> +             .name = #_name "_sel",                          \
>> +             .ops = &clk_regmap_mux_ops,                     \
>> +             .parent_data = pwm_parent_data,                 \
>> +             .num_parents = ARRAY_SIZE(pwm_parent_data),     \
>> +     },                                                      \
>> +}
>> +
>> +#define AML_PWM_CLK_DIV(_name, _reg, _shift) {                       \
>> +     .data = &(struct clk_regmap_div_data) {                 \
>> +             .offset = _reg,                                 \
>> +             .shift = _shift,                                \
>> +             .width = 8,                                     \
>> +     },                                                      \
>> +     .hw.init = &(struct clk_init_data) {                    \
>> +             .name = #_name "_div",                          \
>> +             .ops = &clk_regmap_divider_ops,                 \
>> +             .parent_names = (const char *[]) { #_name "_sel" },\
>> +             .num_parents = 1,                               \
>> +             .flags = CLK_SET_RATE_PARENT,                   \
>> +     },                                                      \
>> +}
>> +
>> +#define AML_PWM_CLK_GATE(_name, _reg, _bit) {                        \
>> +     .data = &(struct clk_regmap_gate_data) {                \
>> +             .offset = _reg,                                 \
>> +             .bit_idx = _bit,                                \
>> +     },                                                      \
>> +     .hw.init = &(struct clk_init_data) {                    \
>> +             .name = #_name,                                 \
>> +             .ops = &clk_regmap_gate_ops,                    \
>> +             .parent_names = (const char *[]) { #_name "_div" },\
>> +             .num_parents = 1,                               \
>> +             .flags = CLK_SET_RATE_PARENT,                   \
>> +     },                                                      \
>> +}
>> +
>> +static struct clk_regmap pwm_a_sel =
>> +     AML_PWM_CLK_MUX(pwm_a, PWM_CLK_AB_CTRL, 9);
>> +static struct clk_regmap pwm_a_div =
>> +     AML_PWM_CLK_DIV(pwm_a, PWM_CLK_AB_CTRL, 0);
>> +static struct clk_regmap pwm_a =
>> +     AML_PWM_CLK_GATE(pwm_a, PWM_CLK_AB_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_b_sel =
>> +     AML_PWM_CLK_MUX(pwm_b, PWM_CLK_AB_CTRL, 25);
>> +static struct clk_regmap pwm_b_div =
>> +     AML_PWM_CLK_DIV(pwm_b, PWM_CLK_AB_CTRL, 16);
>> +static struct clk_regmap pwm_b =
>> +     AML_PWM_CLK_GATE(pwm_b, PWM_CLK_AB_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_c_sel =
>> +     AML_PWM_CLK_MUX(pwm_c, PWM_CLK_CD_CTRL, 9);
>> +static struct clk_regmap pwm_c_div =
>> +     AML_PWM_CLK_DIV(pwm_c, PWM_CLK_CD_CTRL, 0);
>> +static struct clk_regmap pwm_c =
>> +     AML_PWM_CLK_GATE(pwm_c, PWM_CLK_CD_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_d_sel =
>> +     AML_PWM_CLK_MUX(pwm_d, PWM_CLK_CD_CTRL, 25);
>> +static struct clk_regmap pwm_d_div =
>> +     AML_PWM_CLK_DIV(pwm_d, PWM_CLK_CD_CTRL, 16);
>> +static struct clk_regmap pwm_d =
>> +     AML_PWM_CLK_GATE(pwm_d, PWM_CLK_CD_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_e_sel =
>> +     AML_PWM_CLK_MUX(pwm_e, PWM_CLK_EF_CTRL, 9);
>> +static struct clk_regmap pwm_e_div =
>> +     AML_PWM_CLK_DIV(pwm_e, PWM_CLK_EF_CTRL, 0);
>> +static struct clk_regmap pwm_e =
>> +     AML_PWM_CLK_GATE(pwm_e, PWM_CLK_EF_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_f_sel =
>> +     AML_PWM_CLK_MUX(pwm_f, PWM_CLK_EF_CTRL, 25);
>> +static struct clk_regmap pwm_f_div =
>> +     AML_PWM_CLK_DIV(pwm_f, PWM_CLK_EF_CTRL, 16);
>> +static struct clk_regmap pwm_f =
>> +     AML_PWM_CLK_GATE(pwm_f, PWM_CLK_EF_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_g_sel =
>> +     AML_PWM_CLK_MUX(pwm_g, PWM_CLK_GH_CTRL, 9);
>> +static struct clk_regmap pwm_g_div =
>> +     AML_PWM_CLK_DIV(pwm_g, PWM_CLK_GH_CTRL, 0);
>> +static struct clk_regmap pwm_g =
>> +     AML_PWM_CLK_GATE(pwm_g, PWM_CLK_GH_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_h_sel =
>> +     AML_PWM_CLK_MUX(pwm_h, PWM_CLK_GH_CTRL, 25);
>> +static struct clk_regmap pwm_h_div =
>> +     AML_PWM_CLK_DIV(pwm_h, PWM_CLK_GH_CTRL, 16);
>> +static struct clk_regmap pwm_h =
>> +     AML_PWM_CLK_GATE(pwm_h, PWM_CLK_GH_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_i_sel =
>> +     AML_PWM_CLK_MUX(pwm_i, PWM_CLK_IJ_CTRL, 9);
>> +static struct clk_regmap pwm_i_div =
>> +     AML_PWM_CLK_DIV(pwm_i, PWM_CLK_IJ_CTRL, 0);
>> +static struct clk_regmap pwm_i =
>> +     AML_PWM_CLK_GATE(pwm_i, PWM_CLK_IJ_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_j_sel =
>> +     AML_PWM_CLK_MUX(pwm_j, PWM_CLK_IJ_CTRL, 25);
>> +static struct clk_regmap pwm_j_div =
>> +     AML_PWM_CLK_DIV(pwm_j, PWM_CLK_IJ_CTRL, 16);
>> +static struct clk_regmap pwm_j =
>> +     AML_PWM_CLK_GATE(pwm_j, PWM_CLK_IJ_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_k_sel =
>> +     AML_PWM_CLK_MUX(pwm_k, PWM_CLK_KL_CTRL, 9);
>> +static struct clk_regmap pwm_k_div =
>> +     AML_PWM_CLK_DIV(pwm_k, PWM_CLK_KL_CTRL, 0);
>> +static struct clk_regmap pwm_k =
>> +     AML_PWM_CLK_GATE(pwm_k, PWM_CLK_KL_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_l_sel =
>> +     AML_PWM_CLK_MUX(pwm_l, PWM_CLK_KL_CTRL, 25);
>> +static struct clk_regmap pwm_l_div =
>> +     AML_PWM_CLK_DIV(pwm_l, PWM_CLK_KL_CTRL, 16);
>> +static struct clk_regmap pwm_l =
>> +     AML_PWM_CLK_GATE(pwm_l, PWM_CLK_KL_CTRL, 24);
>> +
>> +static struct clk_regmap pwm_m_sel =
>> +     AML_PWM_CLK_MUX(pwm_m, PWM_CLK_MN_CTRL, 9);
>> +static struct clk_regmap pwm_m_div =
>> +     AML_PWM_CLK_DIV(pwm_m, PWM_CLK_MN_CTRL, 0);
>> +static struct clk_regmap pwm_m =
>> +     AML_PWM_CLK_GATE(pwm_m, PWM_CLK_MN_CTRL, 8);
>> +
>> +static struct clk_regmap pwm_n_sel =
>> +     AML_PWM_CLK_MUX(pwm_n, PWM_CLK_MN_CTRL, 25);
>> +static struct clk_regmap pwm_n_div =
>> +     AML_PWM_CLK_DIV(pwm_n, PWM_CLK_MN_CTRL, 16);
>> +static struct clk_regmap pwm_n =
>> +     AML_PWM_CLK_GATE(pwm_n, PWM_CLK_MN_CTRL, 24);
>> +
>> +static const struct clk_parent_data spicc_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "sysclk" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" },
>> +     { .fw_name = "gp1" }
>> +};
>> +
>> +static struct clk_regmap spicc_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_a_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = SPICC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_a = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = SPICC_CLK_CTRL,
>> +             .bit_idx = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = SPICC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spicc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_b_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = SPICC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 6,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spicc_b = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = SPICC_CLK_CTRL,
>> +             .bit_idx = 22,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spicc_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spicc_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data spifc_parent_data[] = {
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap spifc_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = SPIFC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spifc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = spifc_parent_data,
>> +             .num_parents = ARRAY_SIZE(spifc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap spifc_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = SPIFC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spifc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spifc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap spifc = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = SPIFC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "spifc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &spifc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data emmc_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "gp0" }
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_a_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_a = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_a",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_a_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_b_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_b_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_b_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_b = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = SD_EMMC_CLK_CTRL,
>> +             .bit_idx = 23,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_b",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_b_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = NAND_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = emmc_parent_data,
>> +             .num_parents = ARRAY_SIZE(emmc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = NAND_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_c_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap sd_emmc_c = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = NAND_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "sd_emmc_c",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &sd_emmc_c_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ts_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = TS_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ts_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &(const struct clk_parent_data) {
>> +                     .fw_name = "oscin",
>> +             },
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ts = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = TS_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ts",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ts_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data eth_parent = {
>> +     .fw_name = "fdiv2",
>> +};
>> +
>> +static struct clk_fixed_factor eth_125m_div = {
>> +     .mult = 1,
>> +     .div = 8,
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_125m_div",
>> +             .ops = &clk_fixed_factor_ops,
>> +             .parent_data = &eth_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_125m = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ETH_CLK_CTRL,
>> +             .bit_idx = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_125m",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &eth_125m_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_rmii_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ETH_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_rmii_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_data = &eth_parent,
>> +             .num_parents = 1,
>> +     },
>> +};
>> +
>> +static struct clk_regmap eth_rmii = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ETH_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "eth_rmii",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &eth_rmii_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data mipi_dsi_meas_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap mipi_dsi_meas_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VDIN_MEAS_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 21,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mipi_dsi_meas_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = mipi_dsi_meas_parent_data,
>> +             .num_parents = ARRAY_SIZE(mipi_dsi_meas_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap mipi_dsi_meas_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VDIN_MEAS_CLK_CTRL,
>> +             .shift = 12,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mipi_dsi_meas_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mipi_dsi_meas_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap mipi_dsi_meas = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VDIN_MEAS_CLK_CTRL,
>> +             .bit_idx = 20,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "mipi_dsi_meas",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &mipi_dsi_meas_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data dsi_phy_parent_data[] = {
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap dsi_phy_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 12,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dsi_phy_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = dsi_phy_parent_data,
>> +             .num_parents = ARRAY_SIZE(dsi_phy_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap dsi_phy_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dsi_phy_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dsi_phy_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dsi_phy = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = MIPIDSI_PHY_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dsi_phy",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dsi_phy_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vout_mclk_parent_data[] = {
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap vout_mclk_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_mclk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vout_mclk_parent_data,
>> +             .num_parents = ARRAY_SIZE(vout_mclk_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_mclk_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_mclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_mclk_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_mclk = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_mclk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_mclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vout_enc_parent_data[] = {
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap vout_enc_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_enc_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vout_enc_parent_data,
>> +             .num_parents = ARRAY_SIZE(vout_enc_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_enc_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_enc_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_enc_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vout_enc = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VOUTENC_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vout_enc",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vout_enc_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data hcodec_pre_parent_data[] = {
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "oscin" }
>> +};
>> +
>> +static struct clk_regmap hcodec_0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VDEC_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = hcodec_pre_parent_data,
>> +             .num_parents = ARRAY_SIZE(hcodec_pre_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VDEC_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VDEC_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_1_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_1_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = hcodec_pre_parent_data,
>> +             .num_parents = ARRAY_SIZE(hcodec_pre_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_1_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_1_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_1_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap hcodec_1 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec_1",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &hcodec_1_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data hcodec_parent_data[] = {
>> +     { .hw = &hcodec_0.hw },
>> +     { .hw = &hcodec_1.hw }
>> +};
>> +
>> +static struct clk_regmap hcodec = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VDEC3_CLK_CTRL,
>> +             .mask = 0x1,
>> +             .shift = 15,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "hcodec",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = hcodec_parent_data,
>> +             .num_parents = ARRAY_SIZE(hcodec_parent_data),
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vc9000e_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv7" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp0" }
>> +};
>> +
>> +static struct clk_regmap vc9000e_aclk_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_aclk_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vc9000e_parent_data,
>> +             .num_parents = ARRAY_SIZE(vc9000e_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_aclk_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_aclk_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_aclk_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_aclk = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_aclk",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_aclk_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_core_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_core_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vc9000e_parent_data,
>> +             .num_parents = ARRAY_SIZE(vc9000e_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_core_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_core_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_core_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vc9000e_core = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VC9000E_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vc9000e_core",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vc9000e_core_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data csi_phy_parent_data[] = {
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "oscin" }
>> +};
>> +
>> +static struct clk_regmap csi_phy0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = ISP0_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 25,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "csi_phy0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = csi_phy_parent_data,
>> +             .num_parents = ARRAY_SIZE(csi_phy_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap csi_phy0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ISP0_CLK_CTRL,
>> +             .shift = 16,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "csi_phy0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &csi_phy0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap csi_phy0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ISP0_CLK_CTRL,
>> +             .bit_idx = 24,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "csi_phy0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &csi_phy0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data dewarpa_parent_data[] = {
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "fdiv7" }
>> +};
>> +
>> +static struct clk_regmap dewarpa_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = DEWARPA_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dewarpa_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = dewarpa_parent_data,
>> +             .num_parents = ARRAY_SIZE(dewarpa_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap dewarpa_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = DEWARPA_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dewarpa_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dewarpa_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap dewarpa = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = DEWARPA_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "dewarpa",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &dewarpa_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data isp_parent_data[] = {
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "oscin" }
>> +};
>> +
>> +static struct clk_regmap isp0_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = ISP0_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "isp0_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = isp_parent_data,
>> +             .num_parents = ARRAY_SIZE(isp_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap isp0_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = ISP0_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "isp0_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &isp0_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap isp0 = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = ISP0_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "isp0",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &isp0_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data nna_core_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "fdiv2" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "hifi" }
>> +};
>> +
>> +static struct clk_regmap nna_core_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = NNA_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = nna_core_parent_data,
>> +             .num_parents = ARRAY_SIZE(nna_core_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_core_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = NNA_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_core_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap nna_core = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = NNA_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "nna_core",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &nna_core_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data ge2d_parent_data[] = {
>> +     { .fw_name = "oscin" },
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .hw = &rtc_clk.hw }
>> +};
>> +
>> +static struct clk_regmap ge2d_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = GE2D_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ge2d_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = ge2d_parent_data,
>> +             .num_parents = ARRAY_SIZE(ge2d_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap ge2d_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = GE2D_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ge2d_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ge2d_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap ge2d = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = GE2D_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "ge2d",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &ge2d_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static const struct clk_parent_data vapb_parent_data[] = {
>> +     { .fw_name = "fdiv2p5" },
>> +     { .fw_name = "fdiv3" },
>> +     { .fw_name = "fdiv4" },
>> +     { .fw_name = "fdiv5" },
>> +     { .fw_name = "gp0" },
>> +     { .fw_name = "hifi" },
>> +     { .fw_name = "gp1" },
>> +     { .fw_name = "oscin" },
>> +};
>> +
>> +static struct clk_regmap vapb_sel = {
>> +     .data = &(struct clk_regmap_mux_data) {
>> +             .offset = VAPB_CLK_CTRL,
>> +             .mask = 0x7,
>> +             .shift = 9,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb_sel",
>> +             .ops = &clk_regmap_mux_ops,
>> +             .parent_data = vapb_parent_data,
>> +             .num_parents = ARRAY_SIZE(vapb_parent_data),
>> +     },
>> +};
>> +
>> +static struct clk_regmap vapb_div = {
>> +     .data = &(struct clk_regmap_div_data) {
>> +             .offset = VAPB_CLK_CTRL,
>> +             .shift = 0,
>> +             .width = 7,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb_div",
>> +             .ops = &clk_regmap_divider_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vapb_sel.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_regmap vapb = {
>> +     .data = &(struct clk_regmap_gate_data) {
>> +             .offset = VAPB_CLK_CTRL,
>> +             .bit_idx = 8,
>> +     },
>> +     .hw.init = &(struct clk_init_data) {
>> +             .name = "vapb",
>> +             .ops = &clk_regmap_gate_ops,
>> +             .parent_hws = (const struct clk_hw *[]) {
>> +                     &vapb_div.hw
>> +             },
>> +             .num_parents = 1,
>> +             .flags = CLK_SET_RATE_PARENT,
>> +     },
>> +};
>> +
>> +static struct clk_hw *c3_periphs_hw_clks[] = {
>> +     [CLKID_RTC_XTAL_CLKIN]          = &rtc_xtal_clkin.hw,
>> +     [CLKID_RTC_32K_DIV]             = &rtc_32k_div.hw,
>> +     [CLKID_RTC_32K_MUX]             = &rtc_32k_mux.hw,
>> +     [CLKID_RTC_32K]                 = &rtc_32k.hw,
>> +     [CLKID_RTC_CLK]                 = &rtc_clk.hw,
>> +     [CLKID_SYS_RESET_CTRL]          = &sys_reset_ctrl.hw,
>> +     [CLKID_SYS_PWR_CTRL]            = &sys_pwr_ctrl.hw,
>> +     [CLKID_SYS_PAD_CTRL]            = &sys_pad_ctrl.hw,
>> +     [CLKID_SYS_CTRL]                = &sys_ctrl.hw,
>> +     [CLKID_SYS_TS_PLL]              = &sys_ts_pll.hw,
>> +     [CLKID_SYS_DEV_ARB]             = &sys_dev_arb.hw,
>> +     [CLKID_SYS_MMC_PCLK]            = &sys_mmc_pclk.hw,
>> +     [CLKID_SYS_CPU_CTRL]            = &sys_cpu_ctrl.hw,
>> +     [CLKID_SYS_JTAG_CTRL]           = &sys_jtag_ctrl.hw,
>> +     [CLKID_SYS_IR_CTRL]             = &sys_ir_ctrl.hw,
>> +     [CLKID_SYS_IRQ_CTRL]            = &sys_irq_ctrl.hw,
>> +     [CLKID_SYS_MSR_CLK]             = &sys_msr_clk.hw,
>> +     [CLKID_SYS_ROM]                 = &sys_rom.hw,
>> +     [CLKID_SYS_UART_F]              = &sys_uart_f.hw,
>> +     [CLKID_SYS_CPU_ARB]             = &sys_cpu_apb.hw,
>> +     [CLKID_SYS_RSA]                 = &sys_rsa.hw,
>> +     [CLKID_SYS_SAR_ADC]             = &sys_sar_adc.hw,
>> +     [CLKID_SYS_STARTUP]             = &sys_startup.hw,
>> +     [CLKID_SYS_SECURE]              = &sys_secure.hw,
>> +     [CLKID_SYS_SPIFC]               = &sys_spifc.hw,
>> +     [CLKID_SYS_NNA]                 = &sys_nna.hw,
>> +     [CLKID_SYS_ETH_MAC]             = &sys_eth_mac.hw,
>> +     [CLKID_SYS_GIC]                 = &sys_gic.hw,
>> +     [CLKID_SYS_RAMA]                = &sys_rama.hw,
>> +     [CLKID_SYS_BIG_NIC]             = &sys_big_nic.hw,
>> +     [CLKID_SYS_RAMB]                = &sys_ramb.hw,
>> +     [CLKID_SYS_AUDIO_PCLK]          = &sys_audio_pclk.hw,
>> +     [CLKID_SYS_PWM_KL]              = &sys_pwm_kl.hw,
>> +     [CLKID_SYS_PWM_IJ]              = &sys_pwm_ij.hw,
>> +     [CLKID_SYS_USB]                 = &sys_usb.hw,
>> +     [CLKID_SYS_SD_EMMC_A]           = &sys_sd_emmc_a.hw,
>> +     [CLKID_SYS_SD_EMMC_C]           = &sys_sd_emmc_c.hw,
>> +     [CLKID_SYS_PWM_AB]              = &sys_pwm_ab.hw,
>> +     [CLKID_SYS_PWM_CD]              = &sys_pwm_cd.hw,
>> +     [CLKID_SYS_PWM_EF]              = &sys_pwm_ef.hw,
>> +     [CLKID_SYS_PWM_GH]              = &sys_pwm_gh.hw,
>> +     [CLKID_SYS_SPICC_1]             = &sys_spicc_1.hw,
>> +     [CLKID_SYS_SPICC_0]             = &sys_spicc_0.hw,
>> +     [CLKID_SYS_UART_A]              = &sys_uart_a.hw,
>> +     [CLKID_SYS_UART_B]              = &sys_uart_b.hw,
>> +     [CLKID_SYS_UART_C]              = &sys_uart_c.hw,
>> +     [CLKID_SYS_UART_D]              = &sys_uart_d.hw,
>> +     [CLKID_SYS_UART_E]              = &sys_uart_e.hw,
>> +     [CLKID_SYS_I2C_M_A]             = &sys_i2c_m_a.hw,
>> +     [CLKID_SYS_I2C_M_B]             = &sys_i2c_m_b.hw,
>> +     [CLKID_SYS_I2C_M_C]             = &sys_i2c_m_c.hw,
>> +     [CLKID_SYS_I2C_M_D]             = &sys_i2c_m_d.hw,
>> +     [CLKID_SYS_I2S_S_A]             = &sys_i2c_s_a.hw,
>> +     [CLKID_SYS_RTC]                 = &sys_rtc.hw,
>> +     [CLKID_SYS_GE2D]                = &sys_ge2d.hw,
>> +     [CLKID_SYS_ISP]                 = &sys_isp.hw,
>> +     [CLKID_SYS_GPV_ISP_NIC]         = &sys_gpv_isp_nic.hw,
>> +     [CLKID_SYS_GPV_CVE_NIC]         = &sys_gpv_cve_nic.hw,
>> +     [CLKID_SYS_MIPI_DSI_HOST]       = &sys_mipi_dsi_host.hw,
>> +     [CLKID_SYS_MIPI_DSI_PHY]        = &sys_mipi_dsi_phy.hw,
>> +     [CLKID_SYS_ETH_PHY]             = &sys_eth_phy.hw,
>> +     [CLKID_SYS_ACODEC]              = &sys_acodec.hw,
>> +     [CLKID_SYS_DWAP]                = &sys_dwap.hw,
>> +     [CLKID_SYS_DOS]                 = &sys_dos.hw,
>> +     [CLKID_SYS_CVE]                 = &sys_cve.hw,
>> +     [CLKID_SYS_VOUT]                = &sys_vout.hw,
>> +     [CLKID_SYS_VC9000E]             = &sys_vc9000e.hw,
>> +     [CLKID_SYS_PWM_MN]              = &sys_pwm_mn.hw,
>> +     [CLKID_SYS_SD_EMMC_B]           = &sys_sd_emmc_b.hw,
>> +     [CLKID_AXI_SYS_NIC]             = &axi_sys_nic.hw,
>> +     [CLKID_AXI_ISP_NIC]             = &axi_isp_nic.hw,
>> +     [CLKID_AXI_CVE_NIC]             = &axi_cve_nic.hw,
>> +     [CLKID_AXI_RAMB]                = &axi_ramb.hw,
>> +     [CLKID_AXI_RAMA]                = &axi_rama.hw,
>> +     [CLKID_AXI_CPU_DMC]             = &axi_cpu_dmc.hw,
>> +     [CLKID_AXI_NIC]                 = &axi_nic.hw,
>> +     [CLKID_AXI_DMA]                 = &axi_dma.hw,
>> +     [CLKID_AXI_MUX_NIC]             = &axi_mux_nic.hw,
>> +     [CLKID_AXI_CVE]                 = &axi_cve.hw,
>> +     [CLKID_AXI_DEV1_DMC]            = &axi_dev1_dmc.hw,
>> +     [CLKID_AXI_DEV0_DMC]            = &axi_dev0_dmc.hw,
>> +     [CLKID_AXI_DSP_DMC]             = &axi_dsp_dmc.hw,
>> +     [CLKID_12_24M_IN]               = &clk_12_24m_in.hw,
>> +     [CLKID_12M_24M]                 = &clk_12_24m.hw,
>> +     [CLKID_FCLK_25M_DIV]            = &fclk_25m_div.hw,
>> +     [CLKID_FCLK_25M]                = &fclk_25m.hw,
>> +     [CLKID_GEN_SEL]                 = &gen_sel.hw,
>> +     [CLKID_GEN_DIV]                 = &gen_div.hw,
>> +     [CLKID_GEN]                     = &gen.hw,
>> +     [CLKID_SARADC_SEL]              = &saradc_sel.hw,
>> +     [CLKID_SARADC_DIV]              = &saradc_div.hw,
>> +     [CLKID_SARADC]                  = &saradc.hw,
>> +     [CLKID_PWM_A_SEL]               = &pwm_a_sel.hw,
>> +     [CLKID_PWM_A_DIV]               = &pwm_a_div.hw,
>> +     [CLKID_PWM_A]                   = &pwm_a.hw,
>> +     [CLKID_PWM_B_SEL]               = &pwm_b_sel.hw,
>> +     [CLKID_PWM_B_DIV]               = &pwm_b_div.hw,
>> +     [CLKID_PWM_B]                   = &pwm_b.hw,
>> +     [CLKID_PWM_C_SEL]               = &pwm_c_sel.hw,
>> +     [CLKID_PWM_C_DIV]               = &pwm_c_div.hw,
>> +     [CLKID_PWM_C]                   = &pwm_c.hw,
>> +     [CLKID_PWM_D_SEL]               = &pwm_d_sel.hw,
>> +     [CLKID_PWM_D_DIV]               = &pwm_d_div.hw,
>> +     [CLKID_PWM_D]                   = &pwm_d.hw,
>> +     [CLKID_PWM_E_SEL]               = &pwm_e_sel.hw,
>> +     [CLKID_PWM_E_DIV]               = &pwm_e_div.hw,
>> +     [CLKID_PWM_E]                   = &pwm_e.hw,
>> +     [CLKID_PWM_F_SEL]               = &pwm_f_sel.hw,
>> +     [CLKID_PWM_F_DIV]               = &pwm_f_div.hw,
>> +     [CLKID_PWM_F]                   = &pwm_f.hw,
>> +     [CLKID_PWM_G_SEL]               = &pwm_g_sel.hw,
>> +     [CLKID_PWM_G_DIV]               = &pwm_g_div.hw,
>> +     [CLKID_PWM_G]                   = &pwm_g.hw,
>> +     [CLKID_PWM_H_SEL]               = &pwm_h_sel.hw,
>> +     [CLKID_PWM_H_DIV]               = &pwm_h_div.hw,
>> +     [CLKID_PWM_H]                   = &pwm_h.hw,
>> +     [CLKID_PWM_I_SEL]               = &pwm_i_sel.hw,
>> +     [CLKID_PWM_I_DIV]               = &pwm_i_div.hw,
>> +     [CLKID_PWM_I]                   = &pwm_i.hw,
>> +     [CLKID_PWM_J_SEL]               = &pwm_j_sel.hw,
>> +     [CLKID_PWM_J_DIV]               = &pwm_j_div.hw,
>> +     [CLKID_PWM_J]                   = &pwm_j.hw,
>> +     [CLKID_PWM_K_SEL]               = &pwm_k_sel.hw,
>> +     [CLKID_PWM_K_DIV]               = &pwm_k_div.hw,
>> +     [CLKID_PWM_K]                   = &pwm_k.hw,
>> +     [CLKID_PWM_L_SEL]               = &pwm_l_sel.hw,
>> +     [CLKID_PWM_L_DIV]               = &pwm_l_div.hw,
>> +     [CLKID_PWM_L]                   = &pwm_l.hw,
>> +     [CLKID_PWM_M_SEL]               = &pwm_m_sel.hw,
>> +     [CLKID_PWM_M_DIV]               = &pwm_m_div.hw,
>> +     [CLKID_PWM_M]                   = &pwm_m.hw,
>> +     [CLKID_PWM_N_SEL]               = &pwm_n_sel.hw,
>> +     [CLKID_PWM_N_DIV]               = &pwm_n_div.hw,
>> +     [CLKID_PWM_N]                   = &pwm_n.hw,
>> +     [CLKID_SPICC_A_SEL]             = &spicc_a_sel.hw,
>> +     [CLKID_SPICC_A_DIV]             = &spicc_a_div.hw,
>> +     [CLKID_SPICC_A]                 = &spicc_a.hw,
>> +     [CLKID_SPICC_B_SEL]             = &spicc_b_sel.hw,
>> +     [CLKID_SPICC_B_DIV]             = &spicc_b_div.hw,
>> +     [CLKID_SPICC_B]                 = &spicc_b.hw,
>> +     [CLKID_SPIFC_SEL]               = &spifc_sel.hw,
>> +     [CLKID_SPIFC_DIV]               = &spifc_div.hw,
>> +     [CLKID_SPIFC]                   = &spifc.hw,
>> +     [CLKID_SD_EMMC_A_SEL]           = &sd_emmc_a_sel.hw,
>> +     [CLKID_SD_EMMC_A_DIV]           = &sd_emmc_a_div.hw,
>> +     [CLKID_SD_EMMC_A]               = &sd_emmc_a.hw,
>> +     [CLKID_SD_EMMC_B_SEL]           = &sd_emmc_b_sel.hw,
>> +     [CLKID_SD_EMMC_B_DIV]           = &sd_emmc_b_div.hw,
>> +     [CLKID_SD_EMMC_B]               = &sd_emmc_b.hw,
>> +     [CLKID_SD_EMMC_C_SEL]           = &sd_emmc_c_sel.hw,
>> +     [CLKID_SD_EMMC_C_DIV]           = &sd_emmc_c_div.hw,
>> +     [CLKID_SD_EMMC_C]               = &sd_emmc_c.hw,
>> +     [CLKID_TS_DIV]                  = &ts_div.hw,
>> +     [CLKID_TS]                      = &ts.hw,
>> +     [CLKID_ETH_125M_DIV]            = &eth_125m_div.hw,
>> +     [CLKID_ETH_125M]                = &eth_125m.hw,
>> +     [CLKID_ETH_RMII_DIV]            = &eth_rmii_div.hw,
>> +     [CLKID_ETH_RMII]                = &eth_rmii.hw,
>> +     [CLKID_MIPI_DSI_MEAS_SEL]       = &mipi_dsi_meas_sel.hw,
>> +     [CLKID_MIPI_DSI_MEAS_DIV]       = &mipi_dsi_meas_div.hw,
>> +     [CLKID_MIPI_DSI_MEAS]           = &mipi_dsi_meas.hw,
>> +     [CLKID_DSI_PHY_SEL]             = &dsi_phy_sel.hw,
>> +     [CLKID_DSI_PHY_DIV]             = &dsi_phy_div.hw,
>> +     [CLKID_DSI_PHY]                 = &dsi_phy.hw,
>> +     [CLKID_VOUT_MCLK_SEL]           = &vout_mclk_sel.hw,
>> +     [CLKID_VOUT_MCLK_DIV]           = &vout_mclk_div.hw,
>> +     [CLKID_VOUT_MCLK]               = &vout_mclk.hw,
>> +     [CLKID_VOUT_ENC_SEL]            = &vout_enc_sel.hw,
>> +     [CLKID_VOUT_ENC_DIV]            = &vout_enc_div.hw,
>> +     [CLKID_VOUT_ENC]                = &vout_enc.hw,
>> +     [CLKID_HCODEC_0_SEL]            = &hcodec_0_sel.hw,
>> +     [CLKID_HCODEC_0_DIV]            = &hcodec_0_div.hw,
>> +     [CLKID_HCODEC_0]                = &hcodec_0.hw,
>> +     [CLKID_HCODEC_1_SEL]            = &hcodec_1_sel.hw,
>> +     [CLKID_HCODEC_1_DIV]            = &hcodec_1_div.hw,
>> +     [CLKID_HCODEC_1]                = &hcodec_1.hw,
>> +     [CLKID_HCODEC]                  = &hcodec.hw,
>> +     [CLKID_VC9000E_ACLK_SEL]        = &vc9000e_aclk_sel.hw,
>> +     [CLKID_VC9000E_ACLK_DIV]        = &vc9000e_aclk_div.hw,
>> +     [CLKID_VC9000E_ACLK]            = &vc9000e_aclk.hw,
>> +     [CLKID_VC9000E_CORE_SEL]        = &vc9000e_core_sel.hw,
>> +     [CLKID_VC9000E_CORE_DIV]        = &vc9000e_core_div.hw,
>> +     [CLKID_VC9000E_CORE]            = &vc9000e_core.hw,
>> +     [CLKID_CSI_PHY0_SEL]            = &csi_phy0_sel.hw,
>> +     [CLKID_CSI_PHY0_DIV]            = &csi_phy0_div.hw,
>> +     [CLKID_CSI_PHY0]                = &csi_phy0.hw,
>> +     [CLKID_DEWARPA_SEL]             = &dewarpa_sel.hw,
>> +     [CLKID_DEWARPA_DIV]             = &dewarpa_div.hw,
>> +     [CLKID_DEWARPA]                 = &dewarpa.hw,
>> +     [CLKID_ISP0_SEL]                = &isp0_sel.hw,
>> +     [CLKID_ISP0_DIV]                = &isp0_div.hw,
>> +     [CLKID_ISP0]                    = &isp0.hw,
>> +     [CLKID_NNA_CORE_SEL]            = &nna_core_sel.hw,
>> +     [CLKID_NNA_CORE_DIV]            = &nna_core_div.hw,
>> +     [CLKID_NNA_CORE]                = &nna_core.hw,
>> +     [CLKID_GE2D_SEL]                = &ge2d_sel.hw,
>> +     [CLKID_GE2D_DIV]                = &ge2d_div.hw,
>> +     [CLKID_GE2D]                    = &ge2d.hw,
>> +     [CLKID_VAPB_SEL]                = &vapb_sel.hw,
>> +     [CLKID_VAPB_DIV]                = &vapb_div.hw,
>> +     [CLKID_VAPB]                    = &vapb.hw,
>> +};
>> +
>> +/* Convenience table to populate regmap in .probe */
>> +static struct clk_regmap *const c3_periphs_clk_regmaps[] = {
>> +     &rtc_xtal_clkin,
>> +     &rtc_32k_div,
>> +     &rtc_32k_mux,
>> +     &rtc_32k,
>> +     &rtc_clk,
>> +     &sys_reset_ctrl,
>> +     &sys_pwr_ctrl,
>> +     &sys_pad_ctrl,
>> +     &sys_ctrl,
>> +     &sys_ts_pll,
>> +     &sys_dev_arb,
>> +     &sys_mmc_pclk,
>> +     &sys_cpu_ctrl,
>> +     &sys_jtag_ctrl,
>> +     &sys_ir_ctrl,
>> +     &sys_irq_ctrl,
>> +     &sys_msr_clk,
>> +     &sys_rom,
>> +     &sys_uart_f,
>> +     &sys_cpu_apb,
>> +     &sys_rsa,
>> +     &sys_sar_adc,
>> +     &sys_startup,
>> +     &sys_secure,
>> +     &sys_spifc,
>> +     &sys_nna,
>> +     &sys_eth_mac,
>> +     &sys_gic,
>> +     &sys_rama,
>> +     &sys_big_nic,
>> +     &sys_ramb,
>> +     &sys_audio_pclk,
>> +     &sys_pwm_kl,
>> +     &sys_pwm_ij,
>> +     &sys_usb,
>> +     &sys_sd_emmc_a,
>> +     &sys_sd_emmc_c,
>> +     &sys_pwm_ab,
>> +     &sys_pwm_cd,
>> +     &sys_pwm_ef,
>> +     &sys_pwm_gh,
>> +     &sys_spicc_1,
>> +     &sys_spicc_0,
>> +     &sys_uart_a,
>> +     &sys_uart_b,
>> +     &sys_uart_c,
>> +     &sys_uart_d,
>> +     &sys_uart_e,
>> +     &sys_i2c_m_a,
>> +     &sys_i2c_m_b,
>> +     &sys_i2c_m_c,
>> +     &sys_i2c_m_d,
>> +     &sys_i2c_s_a,
>> +     &sys_rtc,
>> +     &sys_ge2d,
>> +     &sys_isp,
>> +     &sys_gpv_isp_nic,
>> +     &sys_gpv_cve_nic,
>> +     &sys_mipi_dsi_host,
>> +     &sys_mipi_dsi_phy,
>> +     &sys_eth_phy,
>> +     &sys_acodec,
>> +     &sys_dwap,
>> +     &sys_dos,
>> +     &sys_cve,
>> +     &sys_vout,
>> +     &sys_vc9000e,
>> +     &sys_pwm_mn,
>> +     &sys_sd_emmc_b,
>> +     &axi_sys_nic,
>> +     &axi_isp_nic,
>> +     &axi_cve_nic,
>> +     &axi_ramb,
>> +     &axi_rama,
>> +     &axi_cpu_dmc,
>> +     &axi_nic,
>> +     &axi_dma,
>> +     &axi_mux_nic,
>> +     &axi_cve,
>> +     &axi_dev1_dmc,
>> +     &axi_dev0_dmc,
>> +     &axi_dsp_dmc,
>> +     &clk_12_24m_in,
>> +     &clk_12_24m,
>> +     &fclk_25m_div,
>> +     &fclk_25m,
>> +     &gen_sel,
>> +     &gen_div,
>> +     &gen,
>> +     &saradc_sel,
>> +     &saradc_div,
>> +     &saradc,
>> +     &pwm_a_sel,
>> +     &pwm_a_div,
>> +     &pwm_a,
>> +     &pwm_b_sel,
>> +     &pwm_b_div,
>> +     &pwm_b,
>> +     &pwm_c_sel,
>> +     &pwm_c_div,
>> +     &pwm_c,
>> +     &pwm_d_sel,
>> +     &pwm_d_div,
>> +     &pwm_d,
>> +     &pwm_e_sel,
>> +     &pwm_e_div,
>> +     &pwm_e,
>> +     &pwm_f_sel,
>> +     &pwm_f_div,
>> +     &pwm_f,
>> +     &pwm_g_sel,
>> +     &pwm_g_div,
>> +     &pwm_g,
>> +     &pwm_h_sel,
>> +     &pwm_h_div,
>> +     &pwm_h,
>> +     &pwm_i_sel,
>> +     &pwm_i_div,
>> +     &pwm_i,
>> +     &pwm_j_sel,
>> +     &pwm_j_div,
>> +     &pwm_j,
>> +     &pwm_k_sel,
>> +     &pwm_k_div,
>> +     &pwm_k,
>> +     &pwm_l_sel,
>> +     &pwm_l_div,
>> +     &pwm_l,
>> +     &pwm_m_sel,
>> +     &pwm_m_div,
>> +     &pwm_m,
>> +     &pwm_n_sel,
>> +     &pwm_n_div,
>> +     &pwm_n,
>> +     &spicc_a_sel,
>> +     &spicc_a_div,
>> +     &spicc_a,
>> +     &spicc_b_sel,
>> +     &spicc_b_div,
>> +     &spicc_b,
>> +     &spifc_sel,
>> +     &spifc_div,
>> +     &spifc,
>> +     &sd_emmc_a_sel,
>> +     &sd_emmc_a_div,
>> +     &sd_emmc_a,
>> +     &sd_emmc_b_sel,
>> +     &sd_emmc_b_div,
>> +     &sd_emmc_b,
>> +     &sd_emmc_c_sel,
>> +     &sd_emmc_c_div,
>> +     &sd_emmc_c,
>> +     &ts_div,
>> +     &ts,
>> +     &eth_125m,
>> +     &eth_rmii_div,
>> +     &eth_rmii,
>> +     &mipi_dsi_meas_sel,
>> +     &mipi_dsi_meas_div,
>> +     &mipi_dsi_meas,
>> +     &dsi_phy_sel,
>> +     &dsi_phy_div,
>> +     &dsi_phy,
>> +     &vout_mclk_sel,
>> +     &vout_mclk_div,
>> +     &vout_mclk,
>> +     &vout_enc_sel,
>> +     &vout_enc_div,
>> +     &vout_enc,
>> +     &hcodec_0_sel,
>> +     &hcodec_0_div,
>> +     &hcodec_0,
>> +     &hcodec_1_sel,
>> +     &hcodec_1_div,
>> +     &hcodec_1,
>> +     &hcodec,
>> +     &vc9000e_aclk_sel,
>> +     &vc9000e_aclk_div,
>> +     &vc9000e_aclk,
>> +     &vc9000e_core_sel,
>> +     &vc9000e_core_div,
>> +     &vc9000e_core,
>> +     &csi_phy0_sel,
>> +     &csi_phy0_div,
>> +     &csi_phy0,
>> +     &dewarpa_sel,
>> +     &dewarpa_div,
>> +     &dewarpa,
>> +     &isp0_sel,
>> +     &isp0_div,
>> +     &isp0,
>> +     &nna_core_sel,
>> +     &nna_core_div,
>> +     &nna_core,
>> +     &ge2d_sel,
>> +     &ge2d_div,
>> +     &ge2d,
>> +     &vapb_sel,
>> +     &vapb_div,
>> +     &vapb,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
>> +     .reg_bits       = 32,
>> +     .val_bits       = 32,
>> +     .reg_stride     = 4,
>> +     .max_register   = NNA_CLK_CTRL,
>> +};
>> +
>> +static struct meson_clk_hw_data c3_periphs_clks = {
>> +     .hws = c3_periphs_hw_clks,
>> +     .num = ARRAY_SIZE(c3_periphs_hw_clks),
>> +};
>> +
>> +static int aml_c3_peripherals_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct regmap *regmap;
>> +     void __iomem *base;
>> +     int clkid, ret, i;
>> +
>> +     base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     /* Populate regmap for the regmap backed clocks */
>> +     for (i = 0; i < ARRAY_SIZE(c3_periphs_clk_regmaps); i++)
>> +             c3_periphs_clk_regmaps[i]->map = regmap;
>> +
>> +     for (clkid = 0; clkid < c3_periphs_clks.num; clkid++) {
>> +             /* array might be sparse */
>> +             if (!c3_periphs_clks.hws[clkid])
>> +                     continue;
>> +
>> +             ret = devm_clk_hw_register(dev, c3_periphs_clks.hws[clkid]);
>> +             if (ret) {
>> +                     dev_err(dev, "Clock registration failed\n");
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
>> +                                        &c3_periphs_clks);
>> +}
>> +
>> +static const struct of_device_id c3_peripherals_clkc_match_table[] = {
>> +     {
>> +             .compatible = "amlogic,c3-peripherals-clkc",
>> +     },
>> +     { /* sentinel */ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, c3_peripherals_clkc_match_table);
>> +
>> +static struct platform_driver c3_peripherals_driver = {
>> +     .probe          = aml_c3_peripherals_probe,
>> +     .driver         = {
>> +             .name   = "c3-peripherals-clkc",
>> +             .of_match_table = c3_peripherals_clkc_match_table,
>> +     },
>> +};
>> +
>> +module_platform_driver(c3_peripherals_driver);
>> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
>> +MODULE_LICENSE("GPL");
> 
> 
> --
> Jerome

