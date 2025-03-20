Return-Path: <linux-kernel+bounces-569082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91367A69E55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452A73A98A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020311EB19B;
	Thu, 20 Mar 2025 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="EXhLvUVQ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2137.outbound.protection.outlook.com [40.107.117.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36718C02E;
	Thu, 20 Mar 2025 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437879; cv=fail; b=TEn1f+2b/N4EU60W1UX78SWoFVfS9zPnxrQ6QCwYY7kMOoUjP86hP+Yb1SnOiFQuhJo17TKRd4Oy/5V7qhEoqBkK/Cy+kMUPVY5fBjq+BGykGwH1Y52GepOACTnmlg/3NCb4UNT4gUj5+QVuc5C4pRYmFjrglcG2rPlKU4tQVso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437879; c=relaxed/simple;
	bh=GSZrznMyiKf/iD0jsSs1G3D0ns9NkkSXos7AhFLLxUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CBoNCGk+bOcABX/+OGzTqwfvvMXSvn3Q1kWlivbfGGjRF7SpzjsZt2tD7XhmWibpiVZ7CNw7MujFM4xO+8s6jkefOmnmwt95eWsNJgcLtO4FuWahuqYbHs19xc7xGBEPbp+XRU5MWhUFk11cjrAzi7gJRNZhFmSQvvu+uJhI21E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=EXhLvUVQ; arc=fail smtp.client-ip=40.107.117.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJZc3ZZfj5DkoPVbqKcU7IdJ1eXsYAqeEMVK3P49RhVgGjsbrBbBpVYEGYz8YzAtKKUn2JpvH+npXtIRWIK04SMTRmkuHYXbUyORrWv98sCTD74upArP2mhULWgS3zUp/tNUdvpM36aV+dis1g+SKMBdIVnKSYk9++X787ssd2ZhzMIrNNARov7U2T+FlZU0DvyQTYdGKPAh8wHk3Yr18MS9JO52VACHURsF50mG6Fk+Y1W/dnBFlAK2BCrtadSEjeeEVWlcz9bsuLFB58fPdFsalHi8cfAB/t0l871B+TmwKLPeppxSo6d7yD06MkXcFwRwMPohLdkyCSg6hY/aag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZMIo2Ggat9ntABznHVoO2zcFF6vDgo3M8mDd9XL1RM=;
 b=KhJ0plecYImqeU+WnzEA8lbexFDOIN+n7uBkSO60B92Qv8F+DOyngUItZghrhJ503qicJhWCcXX/v85Nh4WMiXZmUUYxL6dt/57Fi+S7DkBBdoFQ0tLvBvzS0CgV9tX1KWYrHTfxiox0kZjbj2IrAV/Wmv39U/DLZhgCGPjcb51wBZ5J3cg9kv+RDrxZN2ppPr3ZJXs/Pg40pfzywHmP2AVwfmFGG/K8XwJuSs5WoTD9pA9eK4F8YIJiQhbgNQOajB5Bq6wUa9LyRqtONx442ME6/ThqRDTCcAKhnMLI4EUQy3fKOe9fFsJb38F4T0f6lN6lBeaGGwJ881r7J6K5tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZMIo2Ggat9ntABznHVoO2zcFF6vDgo3M8mDd9XL1RM=;
 b=EXhLvUVQp7dvlvLMrXsi9dobG5HnhC0EtrWmh0Sv2DAzrhuJkSgaDCAamTLHTG9fAzB5OpTO0+TFT0tEBiXgHdQuImet71Kj95nPXRvkWVZ8VImpp8EZHAr2D/VfXdv5jAvIQ94LUJrZ/Z04JRQkeUdoEksXQ/TP2UGAx5dkyTMR9WVLVLCUCGsDJ2Or3r8IRo4kN18KIUulQmCOqFy4CRQze4unZ4b04AjNiT+plySR/DpifZDMKxNZbIkRsCVQGHEhSMueDkOsUU+mR6snPDHmykpWI6KapAhW4YP8OL9MRyCyDbzYXK7U1NftrxpvElDLJtuhvE3JaosaXTWJFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by KU2PPFAE58CCB97.apcprd03.prod.outlook.com (2603:1096:d18::421) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 02:31:08 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 02:31:08 +0000
Message-ID: <2ea32d85-1d96-4b40-909f-053f309861d4@amlogic.com>
Date: Thu, 20 Mar 2025 10:31:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: amlogic: Add Amlogic S4 Audio
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-6-686867fad719@amlogic.com>
 <20250319-quizzical-coyote-of-assurance-d4c91d@krzk-bin>
 <9397d6d5-518d-4bd0-a34a-7a5f5e1201f1@amlogic.com>
 <37f65ad0-69fa-4031-86da-8b07828aff34@kernel.org>
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <37f65ad0-69fa-4031-86da-8b07828aff34@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|KU2PPFAE58CCB97:EE_
X-MS-Office365-Filtering-Correlation-Id: 89be2020-e3a4-41f6-1f49-08dd675745aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anY2YjVONWhoZlh6aytlTVU1SkpMdnlDcGlNaCtoTGtrTjM3aGRDc1M0WHNk?=
 =?utf-8?B?YlR2byt1c1FvMEd1QkcrUzU5SmFwNHBhMjBEdXZXY3Q1eUFRYVFnRjA3ZUFn?=
 =?utf-8?B?ak43cDVpL0xObmVCcllQVktlaHBVMDYxV3pDL1J5UkVUTHB6WDYra0NDNi9L?=
 =?utf-8?B?NCtCVVNQSFZEWVFnejlKd0ZmNHlKc05mVTFSUFRpUWdVdlhsbHM0VVVybTVE?=
 =?utf-8?B?aVozUHRLM1hqa2VLMEZUSk9UZU05NGlFUTc0Z2NuNU1hbUs5NGgvK0g4UnN3?=
 =?utf-8?B?OUZ0MjFObjNPZTgyYmlwMWhMSUVmRFE3V0ZPYkpmVnVGNDcvRlo3SmltcS9M?=
 =?utf-8?B?WFc5R0srTzBhcmIwd0d4S1hIQkhxK3pLajRBYWlDZEh1VzBrZUQ2cGNFMFBR?=
 =?utf-8?B?cFljT0RVb09EWXhwWmw4TnNlTkM3UEVXM1VYeWxNbzRKRkd5bVZ2NVhLNyta?=
 =?utf-8?B?eDN0Y3ExVytZeG5QRTlTSzUzUUZJMEF0ZGpJSDJmRE1DSGVacXBuMlpVZ21S?=
 =?utf-8?B?dldhQ3d6V1pSKy9VYkVYYnU5R3h2SHN3MVhzb2VhaGFyMTRPZUIvY1F1OFpz?=
 =?utf-8?B?aEM0VGo4NjErVDhXNnNmcHJTZnk3NmJTcGFwQ1o4cUJnaFozeGp6eURNamhS?=
 =?utf-8?B?ankzK1E3ZWVtM0NZdEY0bHlxSHI2QXVvb3l1Y1NRRW8zSnRqWGkxWThFYmpq?=
 =?utf-8?B?UEQzQlhIK01SZU1nU0VqeUQ3Z2VWekpGYThqUUk2dWtYSHZlVmcrODMrUHNQ?=
 =?utf-8?B?QmtlK2N6Z3cweXdYMUdrZW1KcUh4QlJiY1BlL3BBbm9RdXNCUDArc0dDNVA3?=
 =?utf-8?B?L3ZCblVSY2c5TDhrYWc4Nk5VRHlVNlVKTGhSNWZJV084TGFFTEJJU1gxVXBy?=
 =?utf-8?B?TjV3TEJlLzNMZ21SVmR3QWRLUDdhTXFDN2RiVlBHRTRSZ1ZXVVhvOGFqdUo2?=
 =?utf-8?B?d2Q4UlVIRkRWRjZjcTJmTW56aFQ5d2hiYnRuckV5OEpzVkNXdkxWU1pyU3Z3?=
 =?utf-8?B?THJsUVRLWGw5UlhUWE1ES2pzMUg1cmFPN2llVktocHZvaytiTE9IS2NZa0Jn?=
 =?utf-8?B?UG5vTDFaOFU4VzcyeDJleHdwNE45ZVZzN0tMei9ZZUYvenRyQ0NjRTZNSG14?=
 =?utf-8?B?RlRQa0FPUFYwclRxMFdldEJjaEZ0alZVZHZlMTIxZVdzSnYrL29qUUZNSW5w?=
 =?utf-8?B?SHVnZjlvQ0U3MzJUZnJqNUZyWFlMWi9sOS9GZDR4a2VyOGorYk44TzRIYWsw?=
 =?utf-8?B?SEoyU3NSRzhtcUhuWWhvZHpzOGFLbWp0SmtpdW10aTg1T0VieE5kOGpxNlBj?=
 =?utf-8?B?ZXgzL1VqVitHd09vdFNKd2podDcwNktQbHRmWWRpU0R6Tk85bWZRZm1TOHNm?=
 =?utf-8?B?MTdmYXZSendndDkzMkhqRVQzN2l0YWhOMjIzZmpJaUFNWlpyMU1MWnoySzdt?=
 =?utf-8?B?L2d4T0lHYUNuVmt5OThlZGpaTDNZVklsWnF4LzAvQ2k3cGFVZWowdEYyWGxY?=
 =?utf-8?B?U052U1l5Q0NReTZsNm5CVmR3eGhkS2UxSmhlTWFBc3Y0dzdMZ1I5MC9NWkxu?=
 =?utf-8?B?eG92MHllSldQWVU4bmFaekgwSGVPSnJVNlRldEtGNVU4eEtOdE1IbUVyZW9z?=
 =?utf-8?B?YUQ3cGlDT1ZLcFAyNWdnNW5CSmg2Z3VsYng1SXBUT1p0SzZaTm5heEQ0bWpJ?=
 =?utf-8?B?R1R1Tm1TQ1pxeHJkMEpxcnRGZngwanIxWXFCUWc4SDlzajlsZmpVOGh2RjJV?=
 =?utf-8?B?ZnlOYkM0aWZZdHVJYXYwb2tjVmdSRnNUS0Yxb1U3Mk4yN0xNbUlCMEdUNklP?=
 =?utf-8?B?dDNUNHVoSXJqZVQ4ODZoZFlOa212R0xER0RZamtBcXNBUURlY3l1ZDhYdWtv?=
 =?utf-8?Q?1UZbv4jvOH5YM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU9PUllaZWpJU0tITmRrR0tVL0NOWjFLN1RHOG5rQm4vSG1mU21KMzRJREIx?=
 =?utf-8?B?eTFuSUdOaGxIcllqcFBGTjIxUGJOdktrbmRJM2s5enRiKzg1a3JvS3pVNU82?=
 =?utf-8?B?R2xwOXNaN1orelplbC9jWHg2QURTL3JBVXE0ZkJMS21KTnZISjVtU0pJZElr?=
 =?utf-8?B?RitxRXFzZU9QQlpHSGdtNlRpOWYwcWMrYzRCZVNQQ2ZEc0xuSkZkQjM1YnZV?=
 =?utf-8?B?L3ZWS1hqRFN2NVNwSXd3ZHVlTC9kSWNUdXQzVXpITkVRUE9xMnp1Vi9Rc3JS?=
 =?utf-8?B?b0M4MkNpZVI3UkZMUFBRNXR2MGp2QkxJYkFLa1NnYlZ4ZGlPRjR6Q1ZDYi90?=
 =?utf-8?B?c3VPVzJMM1Rielo0UWs3OEd4OFMxNkgyYjAxTHArdHZHWWh2c1RPWnZWV2kr?=
 =?utf-8?B?UisweFp6MDdPa1ZvVUJyKzkwY0x1akVEQU5lUXVSWklyOEd1eXdIVkl5L2VM?=
 =?utf-8?B?S09sODdjcDZLTjhveTdDcFVGVVZtVC9VaG5ERk43TlpSMThZK3phdXFPNUJp?=
 =?utf-8?B?SGRsYlRwYnJhWVY1dXlueTNZcWJtVWpRRGFkdDN1SC9hMnpTSks3S0xqYnRO?=
 =?utf-8?B?K3RlOG9sYkkxZmZlTFI2bnpMRmxaYmlsMWM1aW50NWRiQ2t4aHp2RWpCZDdM?=
 =?utf-8?B?ZmpqRzZGb3hSVVBoUUlDalJnNUk1ak9ucTI5M0hEdTlEWStlZGYyWXBUa0sr?=
 =?utf-8?B?cnlxQS9zWEJmMlhuZWx3MEJtbnd1dEJLSCttTk5HQU1yNUJmNXJ6M0kyTFJF?=
 =?utf-8?B?UG5TcmczY0ZyYTl1ZmZXWmFmeE1KdjFMUVJ4SGhaYUEyd1ErSS94Y1N5Z2tp?=
 =?utf-8?B?V1I0RlUwdmptMlp0ZDA0dGp4TmJTTjNhTTFCTk9XTFgySnJ1WE4rZzJKNFlB?=
 =?utf-8?B?c2dYNVRQVUg3MDZFdGVEVVFudW80eGJRTCszUHpXRGc4dXBRNS9OM2wxLzgw?=
 =?utf-8?B?MkROMGFzaFdPZlNEMUIrSFgxNTMrZVN5UjFlOEF6Q3N2c3djMExGUnBySE81?=
 =?utf-8?B?VVlYZGsrVFU0UGRpdEVyTXBKaUpHQzJ0WGlRaVlFMVpKS2xtMFcxZDUvQi9h?=
 =?utf-8?B?Q0NlY3ZObFZ2TWxESkk5U3NxQk9kS1FxSXJ3MGQ3Z24vSkM2NnVmQWNOR295?=
 =?utf-8?B?UjV3MEVlUkpsZEtHVzdvcGY1ZXFWZXR1RzNwVTZJaVF6THl2M29yUmhLcXY4?=
 =?utf-8?B?RnhnZ3kzQisyQlc5cmJZOHVJblh2ekVoLzhvWnJNNlJpSWFLSitEa3JpMUd1?=
 =?utf-8?B?WkxMVkE0UTV2N3NQeVIrZnI3MTFBcHpKUlYwRDR5MTBNWUhJc2k2TWZyVmtw?=
 =?utf-8?B?aTdXYU9jcWFnSWc2RWd6SHRRRlpHKzB3YmVCdE9EeW1TMTVzczQ2U0VoM0lD?=
 =?utf-8?B?R3padkl2S21keC90Nms1WWNoeHdlbFJQVDRxRGVhQlBaZzNhQmVVc1RpNmpB?=
 =?utf-8?B?c3JNUkhxdVFMTXczNnZjclQzUzJvU3owWFNhRm1tOEh1WHNDbE00WW5CNmJh?=
 =?utf-8?B?cHUzRisrQW9zWHYrSkZPM3hpbFU1enRZNG8rVnF2YWpTYnF6Vzg5b3hLZnA4?=
 =?utf-8?B?TTBDZXlTUlpqdGFtcnhkUU1SSDUzeG1nRi9HZVhEQ2FmcHE2WWZtN2pBdzF0?=
 =?utf-8?B?R0dMdzFNK3ZMbGxxMGVEeVNldE9Say94ZkRwOWlCdy8rbFpsSFAyY1I1WVhO?=
 =?utf-8?B?K211Z1VTYVJlaFdNLyt2UjlCbWNRdmRDdDZrUUpQZ2V6K2ZsRU5wdjltd1hR?=
 =?utf-8?B?UVNJRTZKOTcyMDd6NHFLVmhRZkNTbnMrcFFmWEZpTVJqeDNMRDdwYUpubzAv?=
 =?utf-8?B?K2V0dFYxUWttRzFqSlUyYWNCY0lJRGkzTld2Y21xY3RCRDhLdmZnT1dETFls?=
 =?utf-8?B?NUUvSnhabnBYSUhwM2czMEc2UGJvc1JoVzdUalZkdFBQN0x6WSsvdXNWWmtB?=
 =?utf-8?B?SE8rT0puUi91a1dGaWo4S3ZTWURweU84cjMrVVA4RldxRlhPcGV6bTM4QlF5?=
 =?utf-8?B?NnRINGcwRGlCR0FKS3hhSGVVUXBIR21wZi8xYnNHTG5wZkYreXUwMlNLYXUz?=
 =?utf-8?B?UHRuTmx0L0JVSkkxcW93MjNqZktEc0RwV3JBbXVIU1o4UTZVZS9uVGNPUTJR?=
 =?utf-8?B?SDJqOGd4UHR1RU1DcTZ1NFQxbkpaNE82Wi9zUUl6Ykp5NUxKUUZaY2xzdzFJ?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89be2020-e3a4-41f6-1f49-08dd675745aa
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 02:31:08.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qR0Mv/5vIKzTrmC+oU/3zvRVes1XR1oEurwSOXt/k8nPLkopYaBKm5QKc3+5VAUciulMwO27wfDpf5yDQun5MV4h5Zgafji94OMDAM9vMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFAE58CCB97


在 2025/3/20 3:31, Krzysztof Kozlowski 写道:
> [ EXTERNAL EMAIL ]
>
> On 19/03/2025 11:38, Jiebing Chen wrote:
>>>>    };
>>>>
>>>>    &pwm_ef {
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> index 957577d986c0675a503115e1ccbc4387c2051620..83edafc2646438e3e6b1945fa1c4b327254a4131 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>>>> @@ -11,7 +11,11 @@
>>>>    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>>>    #include <dt-bindings/power/meson-s4-power.h>
>>>>    #include <dt-bindings/reset/amlogic,meson-s4-reset.h>
>>>> -
>>> Why?
>> The following files are included that the audio driver depends on
> Do you understand how emails work and patch review? I commented under
> your change, not unrelated code being there already.
Sorry, I will check the rule. Thanks you!
>> it is same as sm1 chip
>>
>>>> +#include <dt-bindings/clock/axg-audio-clkc.h>
>>>> +#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>>>> +#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
>>>> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
>>>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>>> Old style was correct.
>> I didn't understand where you were referring to, I'm guessing that's
>> what it was about
> Read your patch.
>
>
>> the following changes to tdmif_a
>>
>> old:
>>
>> clock-names = "mclk", "sclk", "lrclk";
>>
>> new:
>> clock-names = "sclk", "lrclk","mclk";
>> it fix warning
> How is this related to the patch hunk?
>
> Do you understand how patch format works?
>
>
> ...
>
>>>>         timer {
>>>>                 compatible = "arm,armv8-timer";
>>>>                 interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>>> @@ -101,7 +135,6 @@ apb4: bus@fe000000 {
>>>>                         #address-cells = <2>;
>>>>                         #size-cells = <2>;
>>>>                         ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>> -
>>> Why? What is happening in this patch - why are you changing so many
>>> other pieces?
> You did not respond here, so I assume you will fix this and do intensive
> review before posting next version.
>
>>>>                         clkc_periphs: clock-controller@0 {
>>>>                                 compatible = "amlogic,s4-peripherals-clkc";
>>>>                                 reg = <0x0 0x0 0x0 0x49c>;
>>>> @@ -134,6 +167,17 @@ clkc_pll: clock-controller@8000 {
>>>>                                 #clock-cells = <1>;
>>>>                         };
>>>>
>>>> +                     acodec: audio-controller@1a000 {
>>>> +                             compatible = "amlogic,t9015";
>>>> +                             reg = <0x0 0x1A000 0x0 0x14>;
>>>> +                             #sound-dai-cells = <0>;
>>>> +                             sound-name-prefix = "ACODEC";
>>>> +                             clocks = <&clkc_periphs CLKID_ACODEC>;
>>>> +                             clock-names = "pclk";
>>>> +                             resets = <&reset RESET_ACODEC>;
>>>> +                             AVDD-supply = <&vddio_ao1v8>;
>>>> +                     };
>>>> +
>>>>                         watchdog@2100 {
>>>>                                 compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
>>>>                                 reg = <0x0 0x2100 0x0 0x10>;
>>>> @@ -850,3 +894,327 @@ emmc: mmc@fe08c000 {
>>>>                 };
>>>>         };
>>>>    };
>>>> +
>>>> +&apb4 {
>>>> +     audio: bus@330000 {
>>>> +             compatible = "simple-bus";
>>>> +             reg = <0x0 0x330000 0x0 0x1000>;
>>> That's not a simple bus in such case.
>> these code base on old dts like sm1/g12a, we didn't easily change any of
>> the relevant properties
>>
>> To be consistent with the previous one
> Still NAK.
>
> You cannot add bugs just to be consistent.
>
>
> Best regards,
> Krzysztof

