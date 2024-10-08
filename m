Return-Path: <linux-kernel+bounces-354508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11DE993E70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47847B22AA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B252E13B580;
	Tue,  8 Oct 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="arSkMMCB"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1197DA8C;
	Tue,  8 Oct 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366335; cv=fail; b=FzjOd1k6P4JO/LsUVtXyAXYdG71FBdO3SEMNvNVSQPKGQwDjDFNEqSnY+oHlAYmpUQsulOAcuqCIuK+HZTlk1fqCW1/+WjVvCovSroxJ/B+LulocMdBLMkjmmZqJIgkoyjsciNR2kQL20Hfw1nwCLrGSy8f4nyWT2YXDJuIunF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366335; c=relaxed/simple;
	bh=R/PxFrcZeAjlAAfbGHAgXgTDQFt+ghALtCGWb6i/R1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eoPYTgKIEtpNeIZd2o2PWruH0QcQmWxO8PGMck+LLZxCPh0ZSx5WhxIIIKQyvI4y5nQZlH3LRaL/ZOBH9n23HO9H3VrDarGD4tXBBEYSozQMkQ0mMUqdErdFvY/+RJeg0AwOjesX5f9MU2LdsUvBpmhBo9Ep8A8MvQHaSftGu0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=arSkMMCB; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJaXt3e+rE2aP/8Z94KyJT4xT7R3dDDfLvX8rzJOXK2T/bTXraEuteIvoMLi7Dtn78B0Aj1wUcpbDZOU0JSdwuu0BWAo0maCwXeOyVOu2RykOAqBpvasl79HokIUdZlX4yINWvxLqaMj5UOcWb5rPwFKaVX9qY/4LsgiSKtKCXkKwsjkVm1EFXKYSpnQFvgDpzjV9GzDKJNcb8ate7aHH7jQHs+7PsZLcw/bV50hzm0JpZzMRFXhf+5taeHqnmrTyyFQpuXsP3m+7Pmpeq4c9WBtgkmwlWfecMsF0ilpvIqSUCUjWxARekihpXjFmWGgaDcu+xX19S4W6BKdbuIINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/PxFrcZeAjlAAfbGHAgXgTDQFt+ghALtCGWb6i/R1Q=;
 b=thrUey5ljiaSwVamMCyMZYs3DSEDJZv5cphJvg90DXMS3IjAqG2REJHtI7f8CBogJhf+Oe2KcCAgCVVeZuqW7e9Tgux1fcsnSG1t+TKxm9zG+46+DVfmLo80na+0dpja5RC+G07SqLoe/T7sTS4rp7MCqk3vLuBXM6ehqKJOAV77/rxE+0royp8eCmI9bDGsbX01RCLL2iVJmhwTkjBTM1Sbtl3Ms8R9MFlX+BL0tqwD9j/oGCqZIztLjQ4sl1kYeWmPq8dp7khwj+kzOD+XIKSVtUVdo4yTbbtfLkRITgZP5LLggnkRSu+cLp5TtbTV+pLh2e0dLqFXoSxFgL6p5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/PxFrcZeAjlAAfbGHAgXgTDQFt+ghALtCGWb6i/R1Q=;
 b=arSkMMCBHTGeUvom86iZYomreItLrC5VupNZvnlvIYp421mOCDy00xvs53m1Z4tTPcrZbnx8nawaxYrCQ1PB8OBDYg3wXGCMLI0FAOnDMYd36w05sFdy26uUvkfwrhHRV+kikFkTu6fHd+BKAzKUpIq81IfFvectj6JVVmj8Z2f44v3WmvdwoDJWHew6P6fjk2HwV9EyZk13Q2sboLE5AfPIoY5uSZ1uvBGBtcfQRNX1avACVc99DdPhg93MCjormyTb1yxhuAUucYLCm/8utP7jlVwM1mMTXpfSsZ27XfiJvDXSyZ0u9G5cqB4oLdmgvWBDKiPU+VgF60llpfiURg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB8739.apcprd03.prod.outlook.com (2603:1096:101:219::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 05:45:31 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:45:28 +0000
Message-ID: <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com>
Date: Tue, 8 Oct 2024 13:44:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com>
 <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dcf9d0-4d3a-4e87-dbdd-08dce75c6a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnQwMCtIUG1XMEcxeDJFbzRhZ0tHU1laemg0aGR0YW02Y0tQQmZoVWdVT3pj?=
 =?utf-8?B?V2hKUk56S2hhTFRPU09WWG56SGpwSkE2Z0xaRi9JcEVaN0UzazhHUDdLeWFN?=
 =?utf-8?B?NThUM0NGRkFlU2R4ZzFLVGJiK1RYcXovVXhTa01lZzUrd2pBYlJjNUN1YkR0?=
 =?utf-8?B?WnhRZERtY3NNVnhUL0Y3azlpY3h6VXhJT1Rnd0FoeTZ6V0M1elFrOStYSllP?=
 =?utf-8?B?ZUU0L2FKS3NTaUhEcGZMbEtBY3Rid2lqeUhCL0xIOG5RQy8vUjBDSXhJUUsy?=
 =?utf-8?B?Z0MybytwaDl4aFlPekg4ZkZyQU82dFI2dzhRUFJESEIrMzRMV0d2UjIyQTFB?=
 =?utf-8?B?TUV5eFh0bkNzN1cvbi9SV1RrYS8rTmx6Mm95TEhxSUU2eUhlMDRkbjQyTkxE?=
 =?utf-8?B?aWErd2pwWWdUTk5RbWU3MzRBNHFiT1piZ0ZjWEQrSXJDV0hUL05BQVVOelBV?=
 =?utf-8?B?ZGUvaHAyQlBaWThRa0VIaFlIVWxZemlUMFdTZ2Z3NGdzazhmMFhvRC9PcW5h?=
 =?utf-8?B?bDdEYVpEVm9tSjN5TjJYUEhCQmkwRjllUmwwOURITnVwSEJEUzNSWnVNK0d4?=
 =?utf-8?B?Tk9MalBiOHZCTEpjTVZhVzVxTjVQalVKV2ppNEZ4Q1lWMEY2eUxoby9vNytp?=
 =?utf-8?B?dmZuS3dSWFd6U0tCLzMrUjRTbHFWOWVUcVF5WERpMTJvNFVUeWRVeFFXTm14?=
 =?utf-8?B?R1BNalRUOXJFUVZWNGtKbjRkYXd1L3ArMzZuODhTZUR5L2V2K093RFdNeDR5?=
 =?utf-8?B?U3pXUm5zUXNBWVJHOGVPNXJkMDRjZ1ZJMUo3RzhBdW1xdTBLUm05b3pDenRI?=
 =?utf-8?B?d2tlOXN3cm01RWpOZWd3NXZFeUNsS1Joc2xSeXNmcXZ4Z1QyNXpteVlqdEl1?=
 =?utf-8?B?SjBHSi81YmNZb0Y0MlphT0dWRmxPZGFTVXJUVTUvYlJMVG9qVFdOVDhpQWtp?=
 =?utf-8?B?TmkwK3FVTGs4Q2Ztb3BxZ0x0aFRxaElXNjNadUw5U0wyaUpNSUVVVmJBVDVw?=
 =?utf-8?B?SVhPd0kxaW5VcnlkYUxqdXVQV1ByNUo2dmo3NUk0QWwrSUhNVnRweVlYUUNq?=
 =?utf-8?B?dFc4YlRndlIxeTg1aUlFOFZmU2RQTkRzdzZ0VW10blJMU0VZUzE2T2M1NEJr?=
 =?utf-8?B?RktUdFUwS1pzVEFBSjR6S3VWUmFOYWpjWEhZNWRocFl5bS9GOWp5Wm96MlNP?=
 =?utf-8?B?NUozais0WUpidXpnQTV4eXB6V1liaTQ1QmorcGNwcmdqZ3FnZ2c5SXRDZEkr?=
 =?utf-8?B?L1FBKzFJa2FGQjFtTTRBeGxjWXZSYTdoekVla1VvL0ZBMnFSR1RDOHNRUEwx?=
 =?utf-8?B?eHlYZE40aE84TVZFT0xRM0FDMjROOUx6ZWJiN2NudXh6NU1pZUlPdDJUZ0Fq?=
 =?utf-8?B?dzA4UURhaEJMcG1xR3pSdGFOeHd0aXgxdDhiZFpRYnArbUtsYy9HRmtrSy9h?=
 =?utf-8?B?RTVzaXpMNEJ6WW1jSVRRVnk2V0MyaXYyY1Fqc2dsOGpyZnVwNWFNV0Rpay9k?=
 =?utf-8?B?cnFDQ3ordTNPSUZzc0JMckllRS9Ld0lsTm5YUmJUVE0xVXZFZG8wNU5DWG5z?=
 =?utf-8?B?MHo3UUhKOU9kbjlTdUtCb1hnMWFEVW1oTGxwK0trOHZCclZQWE1IWmZRNXp2?=
 =?utf-8?B?bVJuajZycUkzSnl0V3hNMWlHN2txSlhYOFhYRHA2Y25mQzhzY0FFM3k3WUZC?=
 =?utf-8?B?Wk0yNGRZa0NudUR4TjVTbnEwNWp6RC95Z3U4ckdncVp3U3RzSDdqRFpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnN6SFI2N2JiODQ3Mk9qNjI3cTlsUklhTXNSQjRidGxndWk3THJXRGJWaHU2?=
 =?utf-8?B?UFVWdStzcHc3OVN6TG9xbWpVUElWeXp3Wmg5bk81V2w4Y3ZPWkI2TzRjTmRy?=
 =?utf-8?B?WTNZakJaQlFObHhETGFrZmdtSGkza3NFNW5EYkN3TFNCc0xmaWg3dU1MblUw?=
 =?utf-8?B?T2xqVkZzVTYvbTFUOEJabXd2enRCL0NFZUpUSS8yVGNQaTB0aWhmVU1XUnNp?=
 =?utf-8?B?SEtLMkFRVjlEWnc2Z09aTFhPTnYzOEtrSEU5emFxTUh0TkdaTTFENEM0OCtZ?=
 =?utf-8?B?OVcyWnF3YUdCbldaSUI1OHFmSzVQaXVXYk5USFlxc1pLZ3AyYmF6SmNjZW9m?=
 =?utf-8?B?a1Z4cUpNRkRwZVEyYzZORjJ4YllFOFhVbXNUaEVZTm1wSWlkdS85TkxoQXlD?=
 =?utf-8?B?Y3lSOVEzdnhnc2YxK2ZYdGhwMDQrNkJZakRiNU9teHlqdkZOdkhHZXExZlRD?=
 =?utf-8?B?d2VQd0FhVHhGNEVRdDBPVXV3RWJSQVYrcldaSDRmWXcvOTlSN1Q3T2pHdU9u?=
 =?utf-8?B?ZVF1TVNYZHVCUGI0eTFhOWtTLysxelFmQmdvUUZsWVoveE8vTjJnalo4QnVQ?=
 =?utf-8?B?MEVyOW5ZaTRmdHl2SE5mVlgvV2FBTk5ZdUZhVGxUK0pmQ1J5aXJIVEdBSHJZ?=
 =?utf-8?B?VTJkMkFQQ2N4VlJ5a1pTa2c3NHA1aVNRVU5icXg4S0x1YUZiZGVmdktYeVRu?=
 =?utf-8?B?WnNWbGw4dEJFV25HNDVISGU5YWxFLzhaNHhlWDd6VHdoN2dPaWxvejViS2wz?=
 =?utf-8?B?eHdJYXJYOVlpalVtUlVvUWp5d05HVXNtcXVVbk5SWXducXA5TG10Uk1wQy9p?=
 =?utf-8?B?cXFzUXVhMkJVNG9RTTlMb0hjeUhSd2pneEY2ZTZtYVdSRi9zb2E2aEg5Y0hk?=
 =?utf-8?B?ajBjRzZRem1pTy9QSzFYT3FYR3NtbjQxdGtST0V4YWo0QmhqbDkzMHVtR2ZN?=
 =?utf-8?B?c0djT2lLVzJZRFFlL2lQRTUwdVIwSnJVOFl2RTFpUG1WZ0JDOUt1MEJENEVT?=
 =?utf-8?B?bWFLdDAvK2pXdjRHNGorTG1mUjhQSVlkQUNmc29DVVNvYWQxazJqcGZ0V3h6?=
 =?utf-8?B?S0MzczRlbW4zQndVTGdld2tQcUMxbncvWSsxSGdSWDZtZ0ZsNGlyQ3NHSzVQ?=
 =?utf-8?B?S1plc2wxOHlXekRsYWdQNXFjWFJjdTB3R3lLbEhaZ0JFbERNdFM3QVM2Zm8w?=
 =?utf-8?B?NktZSTRpa21WSHV4VE9CaVBldEg0eHdTZTIrYmJsZzVSS2UzYVFwdDZhdGJo?=
 =?utf-8?B?SDVjejdLYVJNdXFqZkJ0YVJzaUhxWFRoV3hZaUU3ZzBUMzVxSTUzMHhUcnh6?=
 =?utf-8?B?Z0llMjZ4MVlCVEpVaXZFbHR0MnBGZytlWmpKR3RXYXRDeXZZVjB0TE05N1BW?=
 =?utf-8?B?SHFqODRoRjY1ZUVSNHVwRWNzV1NYRUlMdmZiOWJtc0xtdTJvcDNEYkFVTU1h?=
 =?utf-8?B?VHZhVGxveXNGWEZQcjFCdlRlWUhyZ29MTmZ5YzhLb0RnZGt6eHdyL3F3elhm?=
 =?utf-8?B?MkgrUGtna01Ob0tMa2hzNW4vZFZXa3JOTDQzMWg5a2dwdXZiNFJzclZ1ZHdI?=
 =?utf-8?B?aWgxNnlsM1UzeUxrYUJlVG1rc1NDbkFYUmhPK0ZZN1ErRi9sRm8wZGlhT1dZ?=
 =?utf-8?B?WUdiVGJQeHBEMjhkYjA3cnlERjhGMlpKT1NHbmFHNTNHa0paOHJYTEp5Yi9h?=
 =?utf-8?B?YXFpZjJKdFVFcUdDckVjRERsQ1ZBTnVMcjBuRXhjQlB5YW9qajVsRWhYUWNB?=
 =?utf-8?B?eFdRRmphckFPajJtRGtZRVUwSi9BRFZxTDN5QXM5TkV6QjFCT2x0Mk55VlNa?=
 =?utf-8?B?eSsxR1hycVVhTHhPN3hPSk11d3JJbklSNzZDRFlzKzZGaEhBdzZkU3BuZ1Ar?=
 =?utf-8?B?WjdGRHpxSlZZeGt5N2gvK2JRNlVlekRUTHpwbXRjRi9kNnVVeCtQZjBFYVVx?=
 =?utf-8?B?MFp2cWc0bjBsc0szVTZGVHQyeXZhTTl2byt6dW9ZQ1l5WEx5aEVVT2JRYWxV?=
 =?utf-8?B?YVc0ckk5OGlJb21YV2hDQXYzUHlBN0F5Q0hTbHFBVnVRMXY1UzMxM2xrdG1M?=
 =?utf-8?B?aUJ3cTdtNU1qZ3hNUmdLLzlMZnRxRkNHQStsLzVNcEJ5dWdsQThIWTVSNnJo?=
 =?utf-8?Q?gRPBzGgw69slGKrzWdxJN0RNf?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dcf9d0-4d3a-4e87-dbdd-08dce75c6a0a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:45:28.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqRCb6Svbp1k9EINdgMleMClwM8EuTIWjWr77eHODeZu4+JUwmIDMPk1scPp6tmVdObpL90iaWglRHwRjMf81A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8739

Hi Martin,


On 2024/10/1 4:08, Martin Blumenstingl wrote:
> [ EXTERNAL EMAIL ]
>
> Hello,
>
> On Sun, Sep 29, 2024 at 8:10 AM Chuan Liu via B4 Relay
> <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> glitch free mux has two clock channels (channel 0 and channel 1) with
>> the same configuration. When the frequency needs to be changed, the two
>> channels ping-pong to ensure clock continuity and suppress glitch.
> You describe the solution to this below:
>> Add flag CLK_SET_RATE_GATE to channels 0 and 1 to implement Ping-Pong
>> switchover to suppress glitch.
> It would be great to have this change in a separate patch.
> The clocks to which you're adding CLK_SET_RATE_GATE aren't switched at
> runtime in mainline kernels (at least I think so).


Okay, I will separate it into two patches and submit it in the next version.


>
>> Channel 0 of glitch free mux is not only the clock source for the mux,
>> but also the working clock for glitch free mux. Therefore, when glitch
>> free mux switches, it is necessary to ensure that channel 0 has a clock
>> input, otherwise glitch free mux will not work and cannot switch to the
>> target channel.
> [...]
>> glitch free mux Add flag CLK_OPS_PARENT_ENABLE to ensure that channel 0
>> has clock input when switching channels.
> This describes a second problem. I think it's best to have this in a
> separate commit/patch.
> Also you're updating some mali clocks (e.g. on G12 and GX) but not all
> of them (Meson8b for example is missing).


Yes, M8 missed it, I will complete it in the next version.


>
> I still have some questions to the CLK_OPS_PARENT_ENABLE approach -
> please share your findings on this.
>
> There's multiple clocks involved in a glitch-free mux hierarchy:
> - a number of clock inputs (e.g. fclk, xtal, ...)
> - two muxes (one for every channel of the glitch-free mux)
> - two dividers (one for every channel of the glitch-free mux)
> - two gates (one for every channel of the glitch-free mux)
> - the glitch-free mux
>
> When switching from channel 0 (which is active and enabled) CCF
> (common clock framework) will:
> a) on channel 1:
> - find the best input clock
> - choose the best input clock in the mux
> - set the divider
> - enable the gate
> b) switch the glitch-free mux
> c) on channel 2:
> - disable the gate
>
> To me it's not clear at which level the problem occurs (glitch-free
> mux, gate, divider, mux, input clock).
> Also I don't understand why enabling the clocks with
> CLK_OPS_PARENT_ENABLE solves any problem since CCF is doing things
> automatically for us.
> Can you please explain (preferably with an example) what problem is
> solved with this approach?


If CLK_OPS_PARENT_ENABLE is configured in mux, 'new_parent' and
'old_parent' will be enabled first when __clk_set_parent_before() is
called. And disable them at __clk_set_parent_after(). Our glitch free
only has two clock sources, so adding this flag ensures that both
channels 0 and 1 are enabled when mux switches.

In fact, we just need to make sure that channel 0 is enabled. The
purpose of CLK_OPS_PARENT_ENABLE may not be to solve our situation,
but adding this flag does solve our current problem.


>
> Last but not least: if we're running into bugs when
> CLK_OPS_PARENT_ENABLE is missing then that patch should carry a Fixes
> tag.


Thanks for the heads-up. I'll keep an eye on it in the next version.


>
> Best regards,
> Martin

