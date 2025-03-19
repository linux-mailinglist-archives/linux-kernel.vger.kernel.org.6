Return-Path: <linux-kernel+bounces-567737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D8A689CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882D0188E875
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3E219DF98;
	Wed, 19 Mar 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="t1l14D+b"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2107.outbound.protection.outlook.com [40.107.215.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABA8F5A;
	Wed, 19 Mar 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380735; cv=fail; b=hyvWZ7braFobyswBzcLFPYvGxmiVbGXEbIz3c0uX1xWaHYYGbso2zxpMJkrRT0KCYpt2VgphDbWctcnXIeo7ErpvpFZ3NdDFJKRupULkSKL5bP7G/iiHfLG5aK6Q5ehK+EbbPIsECvWU0700RWLY5sSleiEw0ZjOcEwL3kH55Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380735; c=relaxed/simple;
	bh=ictapU8VdWGhAJhjqK4pHdvHDfE8MJWI8UWfjTLbX3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IfQb72ufhMjeFOvP3YjCR80F5ef0su71/6baewS/yUi4mPdTrwwg4VAHG/HqwyfobWwTrjiZtStbPmZTIQoRRZC9+trLmfDZQsRtYzGmyXu4Xa69/h6eC1HYpE+ytSebFWwakpDyXq8EltQteV8eb5aAcXAXXIQccvzDZeB3lW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=t1l14D+b; arc=fail smtp.client-ip=40.107.215.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAoDHkizOag5LS+L9Zx+4NKEOIa/BMUIVnBl8wB0tj3Qt8OcGj8uxegNs53AV4nYbUaI4GTzltoXWFq0lNJaYfwo4dONqsaLsJ1AJ7i+rfbfV01csQpIpH++8HOZdODmFzKx7J8/SSIgZdkMAdXrQZxfGT0yduicjKu7czkfCPCGLrOcyBefeWD5zACd4bfuD/tNZC+SDS823mKtb44xlHGGmJajEUVD3FrrDmKRLUK1HcbTlS28FCS54pk5gn6mH2/3jvQfLzzLs1oYBex50rDdz8F3yWvcbJ8zdotZoiYviZGyvDayAiqq/jIyuoFqJRW4788CwH2FYzzOFGQutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5b3igubDhuU5HR1um3nzESUfEmedLO5VGNPmNXB81I=;
 b=LYWK2gKivdsSwY84cOKPzqeewh4r01RFySoosEoIStzmRG7ZWkrDkeQWNXM+oDdERFZIW2iUDLnCE4bVnBQeI1/bhqnYOTyTzy0WCVI0wl9TPAJJa4F9EqsNhvfNYZWxA40eSOEHUdk+bUSxXI87a9f/V4HMtDxrXGlwSuh8XSub7BcWKi7zR0AfyeaM414e1aMklpZSWTVxzr+AMCrIlnSdohPKPNNktvOfZGCOnyXh8W2XXhx5mYpJPhbM8QZAR6Ixnt2C+9a0swsLnpcNjJ9W3VyRP2C7fzjubwL6IfudqfXSfbyGjjLu7wBT3M0dMHneWM0NdwChsQZveb/cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5b3igubDhuU5HR1um3nzESUfEmedLO5VGNPmNXB81I=;
 b=t1l14D+blt5yim1SdmDetXj9Wkm9EwxxUE3PC66iMBh56lFSFEJ58PbpuoStC54NzelnSm1TH8PQA5rkpdk3fiX2CYnRQnq7MmqAkii2EgEtkIjvjcYm7dr79UQVMH8SEYA8tqObk/mrsfkqvZSlhsoDM4SxQ64/vMWC/aarlXW0eA+2K9b4YC9Aq9RzqbF1GxgBxBtt5wvzcNrQULiZ9l2RFo3AXASezskuRsh/WY8SN3knXUmvawBIlTVqwaYy5SU+tB4S8HtIREY4/7mLP307WRiyqEnrhLeUSJI/zD8/KUzGUHShNBdzlSS0ICZc9vQMzs78utQVYZByBwS0Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by TYZPR03MB7518.apcprd03.prod.outlook.com (2603:1096:400:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:38:50 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 10:38:49 +0000
Message-ID: <9397d6d5-518d-4bd0-a34a-7a5f5e1201f1@amlogic.com>
Date: Wed, 19 Mar 2025 18:38:44 +0800
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
From: Jiebing Chen <jiebing.chen@amlogic.com>
In-Reply-To: <20250319-quizzical-coyote-of-assurance-d4c91d@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:820:f::18) To PUZPR03MB7135.apcprd03.prod.outlook.com
 (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|TYZPR03MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fec6d1-9b74-4a82-deea-08dd66d23c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1FMYzRCaFVWY1VneStGa0RrTFpYenpPQm5JdU9RWStpWDlTbHU3TlZIeCth?=
 =?utf-8?B?bG5aZkkwUWFZS1FzMUpZSlUwUGFEc012aGl6Vnk3VWFRM2hlTUhTQlFUWW4y?=
 =?utf-8?B?UFhUcm9IditGaG12MW5FT2hiK2EwOENjM1JjcmVqMzhDZkNXUjJ6MVNhU2kv?=
 =?utf-8?B?RUNCelpLQlBXdnlhaDNKV0hXa0FhaU4vcE9pdUlNNk13RzczM0RPM3R0NnQr?=
 =?utf-8?B?ZFdscXZ2TGw4WWl4Nisrdk9INTYvOFBzL0d0c3JZMDViNnlaNFFGTUY5cXJt?=
 =?utf-8?B?LzZRUStJVmR3Q3Zmc09YRCt2RlZrcUtsUTdpUlZXU2ZjZitHSzFkNGNwWC9S?=
 =?utf-8?B?V0FGWWV0OUxUdjU2TUY5WTZ4b21YbUR2b01Pc00yNE9icTJlSXlPdVNzcEZ1?=
 =?utf-8?B?d1UrNTVxa00xYWF0VUpOcjZKTGR4RlpqNTZ4T3FzYloxZ0cxdm5wSkJvbGd4?=
 =?utf-8?B?cE8yQitxYXFOeWlFeThrMzJuaFJUd2FPcy9nRm11aGxaM01Ea1BBQkZYbERz?=
 =?utf-8?B?L3BVcUtNWks5Kzk1bTFvZ3psZDBsM1ZxeDRGVmcvYThqdHdVWkp0RkxtV1lZ?=
 =?utf-8?B?MzcrSFdlM0Y0SXhNWGNuWkNBYm9nektidDQ0Z25iQS9VZ2s3ZDBwbUc1aTkz?=
 =?utf-8?B?bnpKcmJNaGlMd05kdVdxVW52aHJDZklOQkVJM2pmQ215aWhtdXh3K3ZBSmIv?=
 =?utf-8?B?WGExTFNpQkhYWjFxSTlaYzUxMnY4dk50UEl3cEJ0SU4xS3M5YWg2Mi96RHlu?=
 =?utf-8?B?WmdlYmFGU3RINkpYeXZNdkJsQU9GYlVhcXZ6bXhZaEtnWjFja3ZuYmVOS01K?=
 =?utf-8?B?RUxDU1RhQTBFZGJwQW55cnUwcDYrRDN4dzNoQm9TMWZlL3NSVGhFQkZvQ3V6?=
 =?utf-8?B?aExGbFJPUUVOK3dodWlEZE5rQWNUUEJTWDVmdUdDMWV2MExPS095SStGZ05z?=
 =?utf-8?B?cGlGenB1anFDZWhQSE5heWJRa0JmbmhrTXRUR0NzMDdISk5KWklvM0pUZlBI?=
 =?utf-8?B?bUtoenhJdDVQMjI4QU9GeEMrZ2tUaXlseGFDc1U5WmVmV3FmVVA3VkpFYXor?=
 =?utf-8?B?Nm92cmlEOW5Va1JHTFpXQ0VadXg0SENrM2VyT09iT2N0RTRXeTNyQSt5U3ZN?=
 =?utf-8?B?anZjbXdmN290alhTVm55Y1ZMb1dGYjU0SXoyQ2pNektXWUd5aGFFaldLL1lk?=
 =?utf-8?B?SEhTSG9LS0ZHelpjUUtxemhBK3luR3BYYlNhK29NYUEyWlRTL2hDNmlYNTYx?=
 =?utf-8?B?M2prdDE1dE9jVyt1bEdXc0RBU1dTR1JsdWhSRHYwc1QvUmd1RnIwbTFEYlNl?=
 =?utf-8?B?SmgydGdtMk9adGN6RGNJbE9JekV4VEFNQUNLSmdMaTRjT1dNWFpWQnhJb3Bs?=
 =?utf-8?B?R0hoM1ErODZjNXU5UkFhbEJ5YzU1OUNDZWNxNTA4YlgxR3Jwb204eHZITjcr?=
 =?utf-8?B?aWdJR2lmdDEwRHB0a0N6OHBBM0ZoRXkwSC9DclVQTXdSc3p5YkpBdU1mUUs3?=
 =?utf-8?B?eitQR3o2UTRtWkIrSEtXelJEVDFBNWUrYmRtRkVGZTM4NGJrMTArQzBOVVpz?=
 =?utf-8?B?OUVUNDJvWldZeGQrUWZxME9wNStESjNIbWdpL2pBOW5nWHdWdmF3Q00wbW5I?=
 =?utf-8?B?VWVYOWR5ZDl0WGxQZFR2OWozNnlUVmU0aGs0Q3JzNDM0c3lyUmtPZ244TEtD?=
 =?utf-8?B?S1dWV00yLzlwRzZtQ0NLblpGbVV1UVlRNWs5cER3b240eU50dng1bGRCaGNW?=
 =?utf-8?B?ajNLdS96L2F6anpqa21laFJ5WHdVTEwxNDUySHF5T1IwWk8yd2h5YTg2NUtB?=
 =?utf-8?B?S3grYlNwWUROWm1UanRqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDBjbC9GekZ4RUxFZ1ptNEc1dEloeVdVbms2RE5LdUlWMzhTQ1BLcDBtcVU0?=
 =?utf-8?B?VTE4bldsNUdYL01TaWlWYUlOQS9lOGtON21BRS83WEwrK09sWFNqelV2QytE?=
 =?utf-8?B?RjZiTnJiVFQ2KysxempFaVcvSkpZTFdMVGJ3SWdrenpkS050bEgzaDY5NVVT?=
 =?utf-8?B?SWRlNFg2M1lHZktFOVloTy90NzdvNUtWU3ZaYlJwODRYRU1UNnltMk0zUFFE?=
 =?utf-8?B?UDVjcENLQjUvOVN5UTZ4dk5lSVpHOW82eVlDcUtYMitHOW9sSi84SmtEN2lI?=
 =?utf-8?B?a3RiVmVPM3VQVkxDUE93dk5VTm1HSTZUMEk0cVlqL3BXN3l4clhGSHptZExH?=
 =?utf-8?B?bjNqRGJuVW1OV1pyVTgxSkxNb2hjOFQwYm9TZGc3NlpPTGw1ZE1IeEZlUUZY?=
 =?utf-8?B?OHhlNXQ5cDZvN1NLdHhDQ09nclI5UWdLVGFCYjhYdDNDV2pNVVhTeHlQTXMz?=
 =?utf-8?B?V2llUDBWUE1GOUorM2YvZ2RhUXRWMHE4V2lCbk9mSlVsNDd4MVNqNGNHY0Y3?=
 =?utf-8?B?V2ZVcyt3UXVXMTZ0OENGTHVZMk1BZmRCYU5iZ21BdDJDd1NFMUZ4T3kvV2JM?=
 =?utf-8?B?SmZmTTdVRUo3TDZqa3c5L2Rpb3FMSHUzV3ZLN1hiTnUrdVp2NWV4WWtZQmdZ?=
 =?utf-8?B?cXE5UFVzbmxwYTMwSjdXeFJsRUErOTZoZXZCbGV5VWVneWVOdEEzOTBtNVFW?=
 =?utf-8?B?TUpsb0RZMnE2RWdNeWNaYzFRTmxWVVJhbzZZcUtKTDBQcHc5V0VFdGhPZXk3?=
 =?utf-8?B?NEJZcklvRHJLMGNjR3QvY2NDQWUySU9zRm9hT1o1eWRSMktPVFBoL0hBV2hT?=
 =?utf-8?B?YXBZWm1YL1Y4bTBVMkF2NXBjakk2YzhSQUZCTkdzbkIrS0lRaTlYcFErMExS?=
 =?utf-8?B?TzNvQnVGY0lGT1VqUGFlWlJRcTd2enBlR2l1bVcrM3lNQldKUHdSa0g3QklY?=
 =?utf-8?B?YmFzMTNLY2o1VGg4NjhmUjFDUlNKZjlqZW81TjEwMVZMOXJhOEdoVnkwbWZL?=
 =?utf-8?B?WGxQNC9DbDAxUUlWSGdiV2h0am1oa3p0QTM4WnJVUnl0VmdWYjFSaFJBVDRN?=
 =?utf-8?B?MlVGY1ZQUTZmTmorVVRuc29Oa1k3VWRMUTZzdU1BTlJoQmZZQTEwdDdkbzIy?=
 =?utf-8?B?blR3UG9EZUxpR1ZROEZ2VUw4aFFYUkt0SWcyL1hVcUdKWWE1aXRkejg5UjVr?=
 =?utf-8?B?SmRIMXNtckwxeUZMdjlXSXdWY1NmelNOLzlSb1hER2Nja2NyNGdmSU1BUDBs?=
 =?utf-8?B?UFdYNDRscU9jNENLZGw3Y055QnF4VXpBY2pwcHY1YmdybFBGZk9RRHpCbk55?=
 =?utf-8?B?ejZkS2ZrY2JyRUpEeVcxbkJ2bWx4SW5mWWdwdllBOG0yWHFIbDl0c2k0WEQ1?=
 =?utf-8?B?RThscjc2eUJJZnFUM08ydDJ4SlJuZ0U0cWp2aXdCdTQ5UW9GRUMzaDJzaFNM?=
 =?utf-8?B?RVNlbVJJREV2SmxHT1AyRklmSUl5QnRvT2VDd2NFQkt4UXVhNGhiMXozbzgv?=
 =?utf-8?B?WjZ0NjRDaTZIZm5wS1REYVl0bk8zY0l3NU5kWWxnNTVUa1hBYTh0QUtlbUlo?=
 =?utf-8?B?RnQ2L29kYnJ3dE9GY09QeHEybjJVcStRNnIwU05mUUkrbkZwdVZKSnBMWXU3?=
 =?utf-8?B?MHZOT0tPVVRINHFiMy9EWDFrVzlEdEhyeHZUejgrbmZjZ0FHeDg4Zkw5eVRp?=
 =?utf-8?B?ajBOb1lVWUhZZWZTVUZCQ0F2LzFhS0N3MHpuODFabmxJLzErZGkrTVJ3dXlu?=
 =?utf-8?B?cWs2SGlFeXEvYWJUNmlLOGtJaE5ZZDBTZ0xZMFlzWGdMSThmWXcycjRnZVRV?=
 =?utf-8?B?QzFxSGE1RVVPT0pvSTRPTS9JWkZEZ01oR1FnZ2JPQkJ2T2JqUEdoWXJqL0FP?=
 =?utf-8?B?K1BzM1dkZStveSticXh4dmE4UklUcFQ3SVVELzYwWEw1ZndScCtFWW82bUd0?=
 =?utf-8?B?SFpSZThab3hSQ1lGMVpNL3E3aFZ6c21Ld1lMYW9aWUpNM1RzNm1DcWRNQW9i?=
 =?utf-8?B?dnhwZFZyQU91RSsrVnhwMCs5N2pwZW1jTVY1ZDNldzlYeFd0OTRFZnA5ZUc5?=
 =?utf-8?B?NW5YSnZzMlVmdXdzdUt1U2JLZWhXYlRVK1dSbi9aUVBLeEwzbG5RTnkwVk04?=
 =?utf-8?B?M0laWXFOL3lnUlc3RDR2UXFiNTgwWFlhNWxQYlJuZ0liSDhyN1k2ZlJvTUZS?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fec6d1-9b74-4a82-deea-08dd66d23c11
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:38:49.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFvRUUvkoRjDdT03rqysWDAqamTwMe1yVhdu80775CZrJn6cNGco2IYLDf1iXsYghMXXDnNh1dM0tPLWUK6SLFV3BFBQE/FZfcXj+gZM54A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7518


在 2025/3/19 16:26, Krzysztof Kozlowski 写道:
> [You don't often get email from krzk@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> [ EXTERNAL EMAIL ]
>
> On Wed, Mar 19, 2025 at 03:04:49PM +0800, jiebing chen wrote:
>> Add basic audio driver support for the Amlogic S4 based
>> Amlogic AQ222 board. use hifipll pll (1179648000) to
>> support 768k sample rate and 24 bit (s24_le), 24bit sclk
>> is 48fs, use mpll0 (270950400) to support 705.6k sample
>> rate and 32bit, use mpll1 (338688000) to support 705.6k
>> and 24bit.
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
ok, thanaks
>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ...
>
>> +
>> +             dai-link-12 {
>> +                     sound-dai = <&toacodec TOACODEC_OUT>;
>> +
>> +                     codec {
>> +                             sound-dai = <&acodec>;
>> +                     };
>> +             };
>> +     };
>> +
> Do not add stray blank lines.
>
>>   };
>>
>>   &pwm_ef {
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> index 957577d986c0675a503115e1ccbc4387c2051620..83edafc2646438e3e6b1945fa1c4b327254a4131 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>> @@ -11,7 +11,11 @@
>>   #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>>   #include <dt-bindings/power/meson-s4-power.h>
>>   #include <dt-bindings/reset/amlogic,meson-s4-reset.h>
>> -
> Why?

The following files are included that the audio driver depends on

it is same as sm1 chip

>> +#include <dt-bindings/clock/axg-audio-clkc.h>
>> +#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>> +#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
>> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
>> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>
> Old style was correct.

I didn't understand where you were referring to, I'm guessing that's 
what it was about

the following changes to tdmif_a

old:

clock-names = "mclk", "sclk", "lrclk";

new:
clock-names = "sclk", "lrclk","mclk";
it fix warning

it showhttp://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
examples:
   - |
     #include <dt-bindings/clock/axg-audio-clkc.h>

     audio-controller {
         compatible = "amlogic,axg-tdm-iface";
         #sound-dai-cells = <0>;
         clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
                  <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
                  <&clkc_audio AUD_CLKID_MST_A_MCLK>;
         clock-names = "sclk", "lrclk", "mclk";
     };

>
>>   / {
>>        cpus {
>>                #address-cells = <2>;
>> @@ -46,6 +50,36 @@ cpu3: cpu@3 {
>>                };
>>        };
>>
>> +     tdmif_a: audio-controller-0 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_A";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_A_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>> +     tdmif_b: audio-controller-1 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_B";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_B_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>> +     tdmif_c: audio-controller-2 {
>> +             compatible = "amlogic,axg-tdm-iface";
>> +             #sound-dai-cells = <0>;
>> +             sound-name-prefix = "TDM_C";
>> +             clocks = <&clkc_audio AUD_CLKID_MST_C_SCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_C_LRCLK>,
>> +                      <&clkc_audio AUD_CLKID_MST_C_MCLK>;
>> +             clock-names = "sclk", "lrclk","mclk";
>> +     };
>> +
>>        timer {
>>                compatible = "arm,armv8-timer";
>>                interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> @@ -101,7 +135,6 @@ apb4: bus@fe000000 {
>>                        #address-cells = <2>;
>>                        #size-cells = <2>;
>>                        ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> -
> Why? What is happening in this patch - why are you changing so many
> other pieces?
>
>>                        clkc_periphs: clock-controller@0 {
>>                                compatible = "amlogic,s4-peripherals-clkc";
>>                                reg = <0x0 0x0 0x0 0x49c>;
>> @@ -134,6 +167,17 @@ clkc_pll: clock-controller@8000 {
>>                                #clock-cells = <1>;
>>                        };
>>
>> +                     acodec: audio-controller@1a000 {
>> +                             compatible = "amlogic,t9015";
>> +                             reg = <0x0 0x1A000 0x0 0x14>;
>> +                             #sound-dai-cells = <0>;
>> +                             sound-name-prefix = "ACODEC";
>> +                             clocks = <&clkc_periphs CLKID_ACODEC>;
>> +                             clock-names = "pclk";
>> +                             resets = <&reset RESET_ACODEC>;
>> +                             AVDD-supply = <&vddio_ao1v8>;
>> +                     };
>> +
>>                        watchdog@2100 {
>>                                compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
>>                                reg = <0x0 0x2100 0x0 0x10>;
>> @@ -850,3 +894,327 @@ emmc: mmc@fe08c000 {
>>                };
>>        };
>>   };
>> +
>> +&apb4 {
>> +     audio: bus@330000 {
>> +             compatible = "simple-bus";
>> +             reg = <0x0 0x330000 0x0 0x1000>;
> That's not a simple bus in such case.

these code base on old dts like sm1/g12a, we didn't easily change any of 
the relevant properties

To be consistent with the previous one

>
> NAK
>
>
> Best regards,
> Krzysztof
>

