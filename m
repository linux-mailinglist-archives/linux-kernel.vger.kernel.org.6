Return-Path: <linux-kernel+bounces-576771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA19EA71443
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360C3173985
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689381ABEAC;
	Wed, 26 Mar 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SPNffz9t"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097124A29
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983065; cv=fail; b=Un+7BmUSF3Y4BpoBoTlWS8IAvRr1uyo2QYEAIUJFcmr4QQk5xtHvEw5TesPF5ghmI74Q2TnbKg6BoKxWupiq4dTw2Q1tcN2sdux/ZqMU2BV1dKbJpXhbQQUBZfkBf8SGDEl3dlxiK7zpyYQGcMeiiq5xueTZnY1X7xA4zMdHiho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983065; c=relaxed/simple;
	bh=YuP5+AtuxzKwU+slpeZ7BJsQ6tNvvUKUuSLzb9AVjcI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1Dxx6eLPvUCIHPL9BOtMDx/CE8Ej1VR7Er7IgeSTOIMxwvjvcTxUhJqL5rf3dtrcvP6d1XnT7SKn6Ty9WBQwtP6Os7q6mxROYkArhA5XWg/ll32V06XP2oe/2jveDTHFbQArrNt2h3K2yrh6MlhLQi8Ab2DdLynNef7VxyyQv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SPNffz9t; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIb1da1vvggSJdAoqySEPVYGMwdrE4vs+eMneQEnemwNNljd8Ha3xe9OhFGZtfnrxOtfTdgMx5GTdbBgtgfL3EGWOa1Vha0zrfgW79IwDiqQhoR44Mvou0ZcEi9tlLKrnwF7Olmpb73UTpvSvZYmnKMh+uhIeeSpelLkUUATLaHheJ7Y+oe+Mw5fEPaNiHttfWZjJ6d3Cv55m39UU6XcLtzn3GHArrgwiYlzbK7n0Cl+xDUnSnUhPsJllyQWORgJbvuaiXlTJODvUrKSsFkw8dcHu5BIIocORhQgrq9ekWsZPNd2Ae86U91edwm+CdQba+btGmGeqw0FBGyGHj4ZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lUFK7rQaLUJE1yFyO/j7KykDoa74+4nuUL4KWL7gVQ=;
 b=IhcV2NGL/XQtBVntlULKHEYZDoyU6uBtWyM2d9xgCV+WMW0FmwvCO6HVHeMVSBE1DWNTQOcNGEYq4E+37s2BnEXTP5pMYhTTCrGEsoL8CFIs799GEgNir8HZA6Kj42fk5mWRGbThMGWl+RTuID9IouH7nq6b4U39G0d8tX9IBOe6zXFoGTUf666jrP+wkDqNpspfYTJC5pKdcR01ZUviHHbp3T30BR3ENjGQFicP/7nGj3k7JnzKxEK2OzdTRoQWblmJGp5OvpiZozRiyVhMjwwsI7DgCLzlbVLyo/61MvKVGgmyyGoz8WMKgQpE4lYXs0hZk3Xa3QI5KVgtj9oUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lUFK7rQaLUJE1yFyO/j7KykDoa74+4nuUL4KWL7gVQ=;
 b=SPNffz9t36LIV+x/fewKia7PqiT7JvVLdQUGrTfi3AyjCs5xCFXyVpFwpgiLL7QNxVMxoCWLk+zkWupEyd4Tobc68CHbAoX988EouCYYMxmbbQeMDsy5OuhDn/rSfWgV3AxFVWTjsMpp6acKjGfWDLZU2R+4+nWBRVRHczqZ5WsK5hKeeHU39jUhtHZ1XbY14N6yocaTZUTffF9cayOdxPSQzkdERBCiKlq1Tkv2kIdfKoxEAyhB2FIMKhNjmn57Dp7mEyifuYTF6VF5gpvF4RGpeEoRfNu7z/0UkYjvZgNl6FG83VTTcJnk+ZRdcbLisAkqDNI7fABJTOxDpmyWAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by PA3PR04MB11228.eurprd04.prod.outlook.com (2603:10a6:102:4b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 09:57:37 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 09:57:37 +0000
Message-ID: <2d7b18bf-31ed-abfc-20db-7f5b54c812af@oss.nxp.com>
Date: Wed, 26 Mar 2025 11:57:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
 <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
 <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
 <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
 <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
 <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
 <f1268261-c900-4adc-aefe-795f23faba59@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <f1268261-c900-4adc-aefe-795f23faba59@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::7) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|PA3PR04MB11228:EE_
X-MS-Office365-Filtering-Correlation-Id: e084fed7-943e-4a39-c099-08dd6c4ca33e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qzh3WFplbkZ2SmZMWGtoQTFRQVB0Rk5VUTlpSStqSkw5Rjk1WUpJcE5IdVVY?=
 =?utf-8?B?Rk9zZ2F4aXpvZlVoZDNQK3RWR0hSWlNqUG5NRnROUzhnTnlPSjM2cllmZGVr?=
 =?utf-8?B?VGw5clJzaWhCZDhLVi9OcFZCNGZ4QS9qaTNhMXY0eWJmL002VXZOWTZYZFdj?=
 =?utf-8?B?SUJ4cXN6TmxoVGJvY0RxR3dmK2IwSFpFaDdRT29Ca3Y3Zm54YURYbUx0RG5o?=
 =?utf-8?B?d0dNZGxJc3dXTWVtM0k0eTBMOUdqWnN5WUpyNUx4UXJJNFQrcjlBTDBRaC84?=
 =?utf-8?B?UkRUMGFRMFZNZG1aK0pIU2d1Qm54V0g5QUZ6VTJRMGhZL2laZXB5OXNqRUl5?=
 =?utf-8?B?RmpIUktheTZKQ3IvVHZOQkoraXVBQTdNUmJiKzJUQUN3eVdpS2k4QkV6eWEw?=
 =?utf-8?B?S21Qa0VKRFQ0RkFucHd1YjJRQXVLWTBQQjRkbFFtSFE1TG9YbjlEWTBOdTBJ?=
 =?utf-8?B?MjFTaFBkNU5BQkN2bUpoUnVHT0xCRll0REpIZnhwb0hUZUE5eXlrOVlNMThm?=
 =?utf-8?B?OGV2azgzNjAySWIzNHZpTElwQzZlQytYaE9RQ3lWVzBnUERNYTIzLzJIWXBH?=
 =?utf-8?B?enllRTRGV2hkSU1DUnYzQkZtc0FxOGFXSFBhTFIxRGVtWGdFbHFNNzYwbExv?=
 =?utf-8?B?RDBtRDFsb3lFYUNuckVVdGxiVUI3RFJuY2pSNjVwU05XY1BYMEZqSUh3dmY5?=
 =?utf-8?B?OTlJaUgwVTBNTTh2NEZ3eE9oM1RSQXhpNFM2czNENExoSXBjSThVdGNSM3hO?=
 =?utf-8?B?c3lCSDFvWks4eFdIQ09jdkM4a2QyOG13czUxdHkzNklFRWMrbzU2SEZaYU1Q?=
 =?utf-8?B?M2t6dzFBQkZlNy8zNk9STVJ2bjRQNnUyY004VGRMV09ZbU5KSVJudzJQS0ZE?=
 =?utf-8?B?clVVWGdCSC91Snp0ajg3VnlFZktBSnRHaVhSUi85QnFnZTNLTTkxczZkVW8r?=
 =?utf-8?B?ZzNaYnBNT0xFZllZbXl3ZEJueSsrNmwxT0dMRi9yb1d0Z2ZCLzlqYjVMZXpW?=
 =?utf-8?B?TlN4MS96WkpIRlZiQ0gzTnptZkR2S2QyM0gyd3N0YUhFM1VlNjEralpZZm9F?=
 =?utf-8?B?SE9YeVErNkYvckk1YTBkOXpIcFBXR3FSbEswaytwWk5tMWN5bjQrcVNkZjdI?=
 =?utf-8?B?dW5pOGNQajA5SFJES2dFYTBEbVROdE10TVlwSWV4aGZYUmJhWFhBaHh5NkZh?=
 =?utf-8?B?aGFuck5aMnFDUjdiNXAxUkdYRStZTlFPRVN4eXNQTkxRSTJqeDE1Nyswa0lt?=
 =?utf-8?B?aHBpNGc2dDdmdkhEM2FibWJ2aHpaUUZCM0xGcFRCaEZDdkJtRFNYVVRwTCtK?=
 =?utf-8?B?L01wR0VGa0dLdEY1KzNVbzNMSy9sNkVDZEFYUlByZjJ6Y2ZlQ3hrN0o5Y243?=
 =?utf-8?B?dmliaXkrTFlSL1BSNjZ6S0hrMzIrMzZRa3Y3VnlGZlBMY3NNa0o1MERHM1pm?=
 =?utf-8?B?STdWRFlqMUJ5YWVhUG0yWll6TTBOc3dTeTBSWC85bzh0aDg5NzRoeTlDRlVq?=
 =?utf-8?B?cWhIMGNXaVBlU1dkQ3owTkdna0M2d0d2U1A3K1NrY0JUUlcrWmlZdHQvbUJ3?=
 =?utf-8?B?THRYdzAyMFpFUy9VNytjZENDRlAzMEhXNS9PK2x3MzYwcWRoSkZvckhudlF0?=
 =?utf-8?B?QUloSE5lWU9CZHJvUVY3blBsa04raXpZY3EwRUJIemNGY3NDdUViVTV6MEk0?=
 =?utf-8?B?Z2F2d0lDdXpFWGN0UDkrdjNzVlFIaEhjQUFNSmFyL2phaEJpNDRPMGFxaFZE?=
 =?utf-8?B?V1pOQ0tLTUc0RE5RSlZreEw3MnQ0eVRxSE1QdWRIOVZRKzlYMWV3TFBiclJR?=
 =?utf-8?B?dEtUanJKN1MrMXYxYXNodFBrU213UEs4TmEyczBqeDFjd1EyQlFwYU03TTZF?=
 =?utf-8?Q?548oW9ZPBuvmG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdrWWhiSHNOWGlxMncrWXQzSEN5ejBROTA0aEliQ0NHRXpnRjRWUGtLVU0x?=
 =?utf-8?B?K1AzOG1kYWc5Y0hjZVJ5RWxPaldGYktDd2FBYVpBenBxSWxuMFRCTENiMnhw?=
 =?utf-8?B?VkQ3MkJBYks4blJlSzUxc0pvZmJSSEdZdjUvSVdDQmI3bExremFVTjJTWkp1?=
 =?utf-8?B?USs2T3MzU3dlVzdnWldHZWY0SU9LUkIzMlVSVlhDQ2VpK2dGQXhmNEJmTGJP?=
 =?utf-8?B?WGd4UXpGaUdLblBSOHNJa2sxQ2Q5b1JlZG9CcmpBbWlKYnZsVWlhOTg2VWdP?=
 =?utf-8?B?eEtiam80WThBVXNWeVNITTVzRkpzYmVvNlUvQmpjRWJpWDYwY2FjRkNSNmcx?=
 =?utf-8?B?bVJhOUVpeDR3aXNKbFhWSVRzOHJMSFhtU1pyam5hcXVPajc2c3hCNi9mcEgz?=
 =?utf-8?B?MEtBOThSdzJZRUk2SERQLy9uMnNaMzJXdlkrV3ZCN1Jpc1RtRzVMejF4U01t?=
 =?utf-8?B?RFJ4U2FBckNrbFYwZlFsc2tJS3JMREp5UWY5UkFsMFZTaHoyUXRjVmp1ZDdJ?=
 =?utf-8?B?eHFlMFJpTkp3d0JSbUxoSC95N3pKZXRlZnNFRjl0a2d1ZVdSU1Fmak9JSCtO?=
 =?utf-8?B?K2VuQWZCNVNsUzlURjd6M0Z0WFljcmYrZG1YakN4MGJvTTE1UjJMMjY0V3px?=
 =?utf-8?B?aUhBU3dGZ01tRnJDY0V5UDFOZkJYeUNLWVRUTHdDVjUyemZaMXptRU9XWVhq?=
 =?utf-8?B?dkpKT0FUVzhROG9jc1AxdUFmQVUzd2Y5elJtcEZkWDhIc1RsdHhYQTZGSU96?=
 =?utf-8?B?bzU3WWdPQWQ3REFyMVFWdXFrc1VnWWhNUGJ2YWdrMjVvdDVFR1JtYi9SdEhh?=
 =?utf-8?B?Y2JNUC9mUGNsYlk4cmRXcWdHTkFKOWxWcFZHZTJ5TkR3ZjZWWHdhd0NCKzN2?=
 =?utf-8?B?L0RMckhrQ0Zua21zVFA5VUw5bm1LSGd2N0R2NytGN3RWMDdkRUxVWXhjeElM?=
 =?utf-8?B?SnRhUm9zdnJqeTU1ZlV4UExibWhtUDlWUGNxYVhPc3VkZDJnVDdrMGRZSDdI?=
 =?utf-8?B?MFdDK20wNHJycGVJb1FyQVZ6dWxGd3VjNkU2N2tBSGlWdzFONVZFSDVKNUpB?=
 =?utf-8?B?NytYWG1kN2U4Q0FKVEhUa0dBTXlwUngyNGIzd2YzbWNBRmt6czZEUkk2dEJp?=
 =?utf-8?B?TVlBUWQ4Z3BkRU9HbG4rd3JhSUpPa1RUR0NhSVV6YWNadWZVTytya1FaaGt4?=
 =?utf-8?B?WXBiK1BVMVJhSVhCSFZxREZlVmQyRVpIZW9PM2dZcjVZL1IwdFg3TDV1d2JG?=
 =?utf-8?B?Y1FsRGxvd3NiclVtbm54eElzaXhnOUNEZXNRQlRKU1BoWTZZR3lNMTd4Z1dN?=
 =?utf-8?B?RlFFdlo3TklscVZoR09DMTBKN1dxWTBPOGplNzY5UXNWT2hXT2lsVGdab0py?=
 =?utf-8?B?UlFqV0ZDUUdwTzRJSlN2R0VPcHhyVmdxNUR5ajJ2TEVlbDZvVm52aVQrLzM1?=
 =?utf-8?B?UVV1VTFPVDdOMUx2ZFk5MUdXaXczSmFXLzFiYWxyeTRMVEdSZi85RnFHSy9C?=
 =?utf-8?B?d3M5Q1RhVGFvWitieDh4T1BjQlBnWDRMZEhiU3Nzd3JoY1BRcThrRy9mczhp?=
 =?utf-8?B?SXRXL3Q1VUR6U3IyUEtNQUdhL1hpcmlMWkZ3ZnhkUzhHSGxxN0pYR0FocDFv?=
 =?utf-8?B?bTVOeEhGUElIcWNOSnJjcnRyRFdVVm9PQi92Yno4SWJBeXE0OG9HR0VWZGly?=
 =?utf-8?B?eFczN2RyY1dpL29FN0lkbHNtSExiWUVBYnhMV1d3clRYY0wxVWhhNTIwYnEw?=
 =?utf-8?B?bTlpQi80VG1RMUFmVHZqb3pTbktuQ2dRTDJNdG0vM3pBbXR3SzNyNnYwZFJI?=
 =?utf-8?B?ZkVuSkFrcWRJQlZ3b2psSDZrRHFoUHltQWYvNXNKZHlsYUJWOTV5Y04yMDU3?=
 =?utf-8?B?MWo2SWd1SThvZ29hbUxMaktNaGprL1RNb21vRy9TT09FUllySG5PRDVYaWo2?=
 =?utf-8?B?NXREVlRrWXAybktyK2hzVXl2S3lRazdGRzRvMGlHNDU2c05jMzd1Q1NwaWhF?=
 =?utf-8?B?RDBxWFhKcllER054Z2dscjJRUVNnbHJFSnJ1bFJrejNUMkl1ZGJ2aVM5ZGNl?=
 =?utf-8?B?L3AxU09Lc0Y1c1haSTdGSE5IaDg4RUtnajg3NDR4UC81Mnh3a3d0dGQ1T0RJ?=
 =?utf-8?B?VHpZa1Vrem15OGYzNG5xSGs2TzFsYm43MVo0WVNDcFVZOENrOXRsdm5BTW1i?=
 =?utf-8?Q?BweWTcxY7jgMktO43lECRMk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e084fed7-943e-4a39-c099-08dd6c4ca33e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:57:37.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y18GUsjNKwNp4/dSo73i6whJ+8TsVcG3DNSY7bX6ovsoVFqjkdqya0plXCMlSVss/qB2C9N+SE76oOk5TmFKcxKEWwHcbJrRxJBwKIKH+iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11228

On 3/26/2025 11:19 AM, Daniel Lezcano wrote:
> On 26/03/2025 08:44, Ghennadi Procopciuc wrote:
>> On 3/25/2025 3:54 PM, Daniel Lezcano wrote:
>>> On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
>>>> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
>>>> [ ... ]
>>>>>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device
>>>>>>>>>>> *pdev)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>>>>>> +    void __iomem *base;
>>>>>>>>>>> +    int irq, ret;
>>>>>>>>>>> +    struct clk *clk;
>>>>>>>>>>> +
>>>>>>>>>>> +    stm_instances =
>>>>>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>>>>>> +    if (!stm_instances) {
>>>>>>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>>>>>> +    if (IS_ERR(base)) {
>>>>>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>>>>>> +        return PTR_ERR(base);
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>>>>>> +    if (irq <= 0) {
>>>>>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>> +    }
>>>>>>>>>>
>>>>>>>>>>      From commit description:
>>>>>>>>>>
>>>>>>>>>>> The first probed STM is used as a clocksource, the second
>>>>>>>>>>> will be
>>>>>>>>>>> the
>>>>>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>>>>>> affinity set to a CPU.
>>>>>>>>>>
>>>>>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>>>>>> clocksource?
>>>>>>>>>
>>>>>>>>> It relies on the DT description and it does not hurt to have a
>>>>>>>>> consistent code path for clockevent / clocksource even if the
>>>>>>>>> interrupt
>>>>>>>>> is not requested for the clocksource later.
>>>>>>>>>
>>>>>>>>
>>>>>>>> If so, in my opinion, it would make sense to use the same STM
>>>>>>>> instance
>>>>>>>> for both the clocksource and broadcast clockevent, as both
>>>>>>>> functions
>>>>>>>> can
>>>>>>>> be accommodated within a single STM instance, which will help
>>>>>>>> reduce
>>>>>>>> the
>>>>>>>> number of STM instances used.
>>>>>>>
>>>>>>> The broadcast timer is stopped when it is unused which is the
>>>>>>> case for
>>>>>>> the s32 because there are no idle state powering down the local
>>>>>>> timers.
>>>>>>> They have to have be separated.
>>>>>>>
>>>>>>
>>>>>> This wouldn't be the case if the STM is kept running/counting during
>>>>>> the
>>>>>> clock event setup, with only the clock event interrupt being disabled
>>>>>> (CCR.CEN).
>>>>>
>>>>> Are you asking to use two different channels for the same STM
>>>>> instance,
>>>>> one for the clocksource and one for the clockevent ?
>>>>>
>>>>
>>>> I suggested using the CNT register to obtain the count for the clock
>>>> source, while using one of the STM channels for the clock event.
>>>
>>> Ah, ok.
>>>
>>> I think it is preferable to keep them separated to keep the code
>>> modular. Given the number of STM on the platform, it does not hurt
>>>
>>
>> The S32G2 and S32G3 are SoCs featuring a diverse set of cores. Linux is
>> expected to run on Cortex-A53 cores, while other software stacks will
>> operate on Cortex-M cores. The number of STM instances has been sized to
>> include at most one instance per core. Allocating six instances (1 clock
>> source, 1 broadcast clock event, and 4 clock events for all A53 cores)
>> to Linux on the S32G2 leaves the M7 software stacks without adequate STM
>> coverage.
> 
> Given this description I'm wondering why one STM has to be used as a
> clocksource if the STM_07 is already a TS one. And also, we can get rid
> of the broadcast timer as there is no idle state forcing a switch to an
> always-on timer.

Indeed, STM_07 can be used as a system clock source, but Linux should
not assume ownership of it.

> 
> IIUC, on the S32g2 there are 4 x Cortex-A53 and 3 x Cortex-M3, that
> means we need 7 timers.
> 
> The system has 7 timers + a special one for timestamp.
> 
> So if I follow the reasoning, the broadcast timer should not be used
> otherwise one cortex-M3 will end up without a timer.
> 

On the S32G2, there are eight STM timers and STM_TS. Therefore, there
should be enough instances to accommodate 4xA53 and 3xM7 cores.

> That leads us to one clocksource for the first per CPU timer initialized
> or alternatively one STM instance == 1 clocksource and 1 clockevent
> which makes things simpler
>
I'm not sure I understood the entire description. As I see it, two STM
instances should be used to accommodate one clock source, a broadcast
clock event, and four clock events—one per core.

E.g.
STM_0
	- clocksource (based on CNT)
	- broadcast clock event (channel 0)

STM_1
	- Cortex-A53 0 (channel 0)
	- Cortex-A53 1 (channel 1)
	- Cortex-A53 2 (channel 2)
	- Cortex-A53 3 (channel 3)

-- 
Regards,
Ghennadi


