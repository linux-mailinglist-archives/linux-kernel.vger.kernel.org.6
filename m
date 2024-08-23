Return-Path: <linux-kernel+bounces-298590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FC95C926
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D501F23130
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBB14B963;
	Fri, 23 Aug 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="bEiE+HmS"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CD13B5A1;
	Fri, 23 Aug 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404944; cv=fail; b=i60UviuUDUg4Mv04kBVH+RiF2Gl5MAESepQMcDndN34uNbtDzq0MpofULyBKkyFXU4TiB9SiQGuvnqecfctRAkRQwPpvQxq2JQgsYGSbhsU+I1HNiXpNY4+AJusb72orAGHWfz/eCjT101EpBrDws3PbiPI6G5Zkgt2NhjEfIwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404944; c=relaxed/simple;
	bh=DZtWqdfPeaO6lNLSpudUz5C9iDOx9b16nvJXk4h6uzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NzUKPO04/WLUf0lb9s8EuNrMAWxpyH1JyTnXVyhmIqgEAzJEiW5IhVy7Wwzxgb4YEQ2YYPjMihG4V4EnkdFAtj895EnLbtplnWifnUnrimtKIWtz63+8Vvc3/JJiXIPL+Y8xOZWUvyHIuhA0gtcnFk2wI9TMyszW7yXEl4rixtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=bEiE+HmS; arc=fail smtp.client-ip=40.107.255.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKHJd7j1V7aLD2hweTXR20XbOAXqOayTQKKAGCNMi4nRaB6N3jPnCqXJEan4Z5l3J41mRqRp9bE4mEwe5IiS9ZuUQRSOeZFCEfmKVqYj6n0DOQow4O1y+9/BU7y4yAZO9RpYQCz5hmKhIMUxUfnoT16e5B/baTPGjBM02bFe3auipRR+im4lDGF1uSSEeNt5KqXHq89eTi6fAsIEGPnTCTH4OodBwVopasPoFec/k9eBi4mJOVI1h/wQ1Yw2G/CWCq+WRj3WaSoIkFrjO6jbEn+Qbjy1S54LO4A7DOy5cXWklRlN9jRlOmow2u/oyzEeXAuqQR/I6Y8wTPSFQ05xyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8G7cwOHBamVSS8NJ92L7ynGd8FhR+T28sHH1Maobis=;
 b=SR0bxX8lr5mqEF0RaCCChEG/XekKOUBhiWrVyqtqFrBsfGbfZA/9moJqZISiil0YpXxHQMgaJonyRJK+PhATU/eb7cnw6ygUWBmOwjHnEod+p7QXwxBc48zT7f2g65IJWl36UfRSePQZAgNqNurNEN9QWWHCzyjV9kdf/Wl3+gWqX+ptfhKFiyL6F3pl+mteK8viPuObMeJwSLAM+1HhKfVFKIqoq0IWP4gyF6DaV9qjjWd4G8tg0qwBeGy7PLJ/WoVsh5Knn5a+40JcCi9wZ3JH7qFsfsoGMpZ8/+RIuGf6aDE9vniqsAb7LTWBzn1A2XVJhl685ghw1VKJBr7iBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8G7cwOHBamVSS8NJ92L7ynGd8FhR+T28sHH1Maobis=;
 b=bEiE+HmSjXP976GyTmDjk3ZpdiXeXyFjeEV50BoeNGwnxeD7GLFtoTCZDMlIwyK804ZgESQsP7asyfTjssrLyqiOx8Y9D/KdaQYaUXeBAHxHNSvNUhg20lv2RJyJhr5AdREoAf9DaqIpjEpvsDgC+jJKCkXM6MiQlHOHApJx43lJQerclJIAcS+tyQ8+7MnCKYBKhlmGbJ6Z9vTQlW/iunAcER+wAAhiavD7Djso2N6LyYzND1lLitxmQo3I4ZerBzkeglRbGdjUvsn1NVoFUfjnbOU+gzA1CxtLdhKWTB/WYmmU5q498y2co/UCq+W9rDsNTRT2+k1kKZAdpZT/sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB8313.apcprd03.prod.outlook.com (2603:1096:101:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 09:22:18 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 09:22:17 +0000
Message-ID: <b7fe2b5d-1faa-4cd0-8185-1321ada315a8@amlogic.com>
Date: Fri, 23 Aug 2024 17:22:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: fix C3 PLL input parameter
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240823-c3_add_node-v3-0-3648376037f4@amlogic.com>
 <20240823-c3_add_node-v3-1-3648376037f4@amlogic.com>
 <5hghvuv2hy4l2ofve4ghb3nhvg76pwpilulznzja25hurxxwcp@2idkyyomv5w5>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <5hghvuv2hy4l2ofve4ghb3nhvg76pwpilulznzja25hurxxwcp@2idkyyomv5w5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7951d5ed-6e8e-49d5-5dc7-08dcc3551515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGo3MGVJTTZZaFdHV3BLRURJS2tqRmxUWU1BcE5RbEhVOFhFTXluTU53Q1c4?=
 =?utf-8?B?UGtmWkhiZ1ZKZzhuYWZDOGdoVEZzU2MxeDhmek9jUFVuTTJ2ZHR1N0VDUW1r?=
 =?utf-8?B?eFNWcEh5bHhOaExabk42dEsvTG1QU2xSb0t6bEE2MUFUN0NHV25sUFRPZjE2?=
 =?utf-8?B?TVdyS0xydDdOdnByYjlqeUF6Q2tWZVkvbXA5alFHdERCSFFMOW9kdlgwbk9x?=
 =?utf-8?B?eE00d3ZpUXlncjE0OGRoZnN4UTBVdFpoSGRSaTdGLzhBbjVNK0NQT1QyaWlL?=
 =?utf-8?B?d2RsRVN1N2l6cFRqVHI0Z09yOTRxNFc4Y1EwbmlubHBpSmlVMTZwelB5QUpU?=
 =?utf-8?B?T05leU93N0ZJR2lrV2FJK09Sb2Z3T0tQcUNTVXA3Tjl6MmRxdVlHZVFTblpU?=
 =?utf-8?B?WERtRzBnNG9TS1ZFVEorb1BwaU9Zd016ZktWSWk4bGczMUdMMGJFMHRTa09T?=
 =?utf-8?B?MkU2SytwSkdZbEVMalJpVmhjeDM2MnoxTlJLVFRNRGpvVmVOV0VOVmw2cTRH?=
 =?utf-8?B?a1ZXSDRGYmE0Ym5jR1MrWWQ5KzNJYUtUZDJZMG1FdUVudFBQU09qdjhHT0Rm?=
 =?utf-8?B?TFlJNk5uU1RJNDJvTGMzc1V5a1ZwQkVnQXJZOEtCdjljelRCL09EN2hLV3dU?=
 =?utf-8?B?RHdPcWhWaDQ4YXBCbHdUdU5wb0J3RVNCdkFvYWlqQWg1TXp3NnpOajlHZ1ow?=
 =?utf-8?B?aGw2M2pmNHlDRkV0dTJqdEVZSThtUm8rVVQxaWxzekplMVU0cG5nVUFUcWpw?=
 =?utf-8?B?TWVpMGlUZHRZZ2VFQmh4VEZwdXNwWEV5OWh6WTFXTVVIQm9EQmV4RlB0amNJ?=
 =?utf-8?B?K3VrRVI2ZTVOdFBEcUVBcGRjdm1nZjRGZUp2dy9KdGhka2Q2VHJPL2dnS3Bu?=
 =?utf-8?B?bExMbDI2TmFzQ2RPbytkaHdBa0JXaTA4VnFreWxVYUV1M0FIbitQeWE4NHdV?=
 =?utf-8?B?RC95cDZOUlpKY3A1dCtvTWxlSnZ5OG5DWGM2bzF4MHFMcWlVOHZsZWdMU1J3?=
 =?utf-8?B?RXp1Z2ZvUk9EODArNVozRkNFQmZEd2ZUbi9GVVYyM1BhY2dvdjVGWVh5aGFj?=
 =?utf-8?B?MDIrMUF4d0pmZ3V0bE1WUisydDlYblVhSFF3TGUzejU5ZEMxZDNPMDY5czVP?=
 =?utf-8?B?S0wwd1djTWp0TTk5cVFXZTBHa3o4STJDdUtRK2cxbFpjOWR0R1FzdHcycFJM?=
 =?utf-8?B?K0xoL2RxQjRYaXdkMWRObzV6UEEzNFNQblhUaktJc1N6VUNJdmZFNzhsQjVC?=
 =?utf-8?B?WTNNRkNwZG5uNVVaOFAzWHhBdHo3VHZzL201ZVo0UHRpUHljbmg0ckRnYTFo?=
 =?utf-8?B?QnFuNmdFelY3WHdqaEpGR2NuK1VqUE1QSGF4cHlNT0hzYnJnSmFJOVdnU3Jy?=
 =?utf-8?B?ME9hOTM0aUF0UkU4UC9NaXdPVGx1a2s3WjdTcWdjZkc5dm5QNkZrTXFGeU0y?=
 =?utf-8?B?YkFENlJuM2pZRnZnZVB3YzU3bkZRRmNLbjEzR2VVYlNhK01UZjZSK3NnVGg1?=
 =?utf-8?B?MzdnYTZvSStwN01Da0JTNU5yYVZiaWRYN3EvYUZWMHRGTm5WVmFhU0dWY1BF?=
 =?utf-8?B?UThNcTNXWTJubnZnajhyYWZPL3FsTjZFNFVHNVZMZ2NxdUR5ZHBHNElKM0c2?=
 =?utf-8?B?Uy9aUnpyU2tiZ1JNdEJwYW40MG9GdE1WaXltNmpMYkdBVkZQSFlKb2VOSEhp?=
 =?utf-8?B?d1QyWUhQWG5xc1FycGg3ckZkWEhzdFBnY3BoaFBkNDNjK2Zkc3c1WmlVenQ2?=
 =?utf-8?Q?Lg4u0oJRxQ7J6owXb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDdQcE1CSGlSZ3VtbXJHZ0QvUklzNDBTbFN1MElwVGd0REsxUXhJY015VTJZ?=
 =?utf-8?B?T3NtaW0zcEc5OEZRRzVBOWlYd2dsM0VxaVozWGRubzhPSlhBd3owd0Z0TktR?=
 =?utf-8?B?T3BJQ2R4bEhqc0NHWnFUZGNUK1gvWWhKK1owTlBSSFc4ZmdPUHdSU3NyY1lo?=
 =?utf-8?B?OE0yZXB0OXdEQyt0Q0ZYOXZ5UWdMY2x6NStmb1dDVFZNMXZQamZKOGVXd280?=
 =?utf-8?B?ZEJUdHp2YnJzU3JQTG9pYkFRU3JrVFVWMnVHMGZOMDJVdExvckZlL2xpOWFi?=
 =?utf-8?B?SUJLQzBGNlpBejNkQzVub202L25kUUN6OHJnRnhHTFRkd1QvMUJuTWN0YnRU?=
 =?utf-8?B?cSs3bnVnRGw3U3R2RFNjU3dlTUZ0UGZDTGRJYmZWYmZrSU5PbDBZUHR1Y1hs?=
 =?utf-8?B?cENWR1FYUUhPeENnVFRIZnNNN2NIdnRMWXQyMzhlU3lRRHpZc3BuTjRiSHor?=
 =?utf-8?B?d1BCV2VtSHNPQnh1aWtQMjlpQ3JqZVI0NFVNTkRoMlRIb1JuclZOVHY2QnB0?=
 =?utf-8?B?cE5jTE5vYjNZU0hxcTdKTXhiUmNGdGlJRytkUnU2VlU3dmtYdzdTM3NNTFZl?=
 =?utf-8?B?VTdxUDlPd2dNbG5Xd1VJYkV6T2E3aERNVFN4cGM1ZndhL05kb3FNTUVlVUVM?=
 =?utf-8?B?ZzZ1NEVnQ1R4dkppREt6aHR5Z2dqb1BReDJmb21Pa09uSXR0bUhkMFdqamRQ?=
 =?utf-8?B?ZW9oZUdCdElhYlB3RlZOUjk5R2Q3dzFqMTkrOUhQWkoxUC9NRk0reWtCMjJq?=
 =?utf-8?B?TUV3dFNkSDdyNzgxc2FPNTJlTnpHZlI2L3ZwOTVlbDJRVkhtdHNYOXNGM0Zq?=
 =?utf-8?B?M1ZlTHZ1K3p0dU9LVnZwWTlqYkc0SzhZMEtweXA2SDVXYnREYXpBQ3RKbjNk?=
 =?utf-8?B?L05FYVgyRkZzeWYwdDc3UStNVE1vQ0EySVp2dEZQS2lJbG54SXFTMENHczRo?=
 =?utf-8?B?RU9FVjlVMVVFdlM3Mk14cW9RTTBXdys3MTRHa2M3alpqYkU4cTRHa0VqQWV2?=
 =?utf-8?B?VmV0YStKYXpTMVE5OFRCeG9pdE9ybUFaSlp6NHJ3UjZicm9rMzF3bmJXMTJl?=
 =?utf-8?B?WWZpSUhTYWlyVCtNcDhjeDFxR1hyeXd0Q21ad1U2eDc0YTVNRjIvMHpYNHdr?=
 =?utf-8?B?TE02QlBhK2xHNGlERlF3ZzlGT0Rvbm0xU0hKdVNXRDlVSnpMS01uSENadm80?=
 =?utf-8?B?UFIwTnE2bk1EVjd1WXVNSXRoSmF6eEpwOWhTc2pjd0ZIQXpBQW9WMVJxL1Zm?=
 =?utf-8?B?K3RUYzdRSGFuYVlTUmF4MzhyUUZFTUVSNlRuTjJwZEErTk15eVg4c2piZFdX?=
 =?utf-8?B?dW9wZWhwN1Y0b2pWSmxhUVk3by9wMFNubHNxQk5uTFpldjcrM3hlMUMwbHZr?=
 =?utf-8?B?Y29DL1RmRUhSYXBWNG9TNEpBamlFcFVtU08xMFJtcDlXeUVLL3NOcTZtZWdS?=
 =?utf-8?B?LzlNNUlYNzVLNnRKNnV5MDdnRGthL2JZRlZnY0wzcGZPc3hMNUViTDJtWFVK?=
 =?utf-8?B?cUVQS0xYVCs0R0Y1Y3lIdVp2Y09qMHlUbExOOWVtM1dWZXFkSGhydWNIOWNz?=
 =?utf-8?B?bGpTUjg4VXhIbVMrSlJBMjVBYkpoeElHM0RYeGJVeDNwN2NGdERpTWNrRkpl?=
 =?utf-8?B?VmRyQm5FVDVpSGs2WHBZNnpXYWpiTm9sWWR5bXdJV29tU2I5UHVrNXhONGlD?=
 =?utf-8?B?SmdOb2ZDYUFGQ3ZDWUFxaWlLaFZhYmFkNTFIUTZkRnFBUlpGVGVHSFltRU9V?=
 =?utf-8?B?L2o3R0hRSlVNTkVoUVNWS0RKU1dqQksxem5neFh5WWM2anVpdWsvS0U3UnZN?=
 =?utf-8?B?aDdwNDBKVkV5bUFtbHpkd1NNUyt6UC9YMnZMWGM2TmRMQmVIMnRvY25Ccm5y?=
 =?utf-8?B?eW9QeVZWVTZDdXBGaEc1YTR5UVlaS3ZPUVNmWGJmZjNDK2E4VVF4L1RDb1JC?=
 =?utf-8?B?U1Q2Uno0Tjgvbk5Hd0hXM3lRYnMycm0xZXQxVklMRlpkRnFpWklHMGxDc1VM?=
 =?utf-8?B?ZDdMeWpjREtDSTFORjd2Mm5seEJYL21VRzNibmR5ck9ERE5TUUhCdWk4cnY5?=
 =?utf-8?B?TE9tdEg2YjhpajZvNWR5YUV3VWRDMEFtS3ViU0x2YTkraTVoaVd1RnZCVlpJ?=
 =?utf-8?B?bTBYSkxlL2E4MmtiLzB6S1IwYXhxK09DN1FDVVU1bTU4ZzRDQlhQYzBXNnNW?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7951d5ed-6e8e-49d5-5dc7-08dcc3551515
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 09:22:17.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvvPpuAyna14NVd4PRfa9Kcd3yoA7F53ix38CTfdF093FF0llMN01d7ndmtnz1yTOeijyvSbQXO3hhegDyTK5Oe2NJcjjehGeFgJDxMSKsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8313

Hi Krzysztof,
     Thanks for your reply.

On 2024/8/23 14:41, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Aug 23, 2024 at 10:29:17AM +0800, Xianwei Zhao wrote:
>> Add C3 PLL controller input clock parameters "fix".
>>
>> The clock named "fix" was initially implemented in PLL clock controller driver.
>> However, some registers required secure zone access, so we moved it to
>> the secure zone (BL31) and accessed it through SCMI. Since the PLL clock
>> driver needs to use this clock, the "fix" clock is used as an input source.
>> We updated the driver but forgot to modify the binding accordingly,
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 

Will do.

> Best regards,
> Krzysztof
> 

