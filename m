Return-Path: <linux-kernel+bounces-213164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02646906E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7761F1F21D85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642231448E8;
	Thu, 13 Jun 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Z5cqTaEs"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3E44C6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280124; cv=fail; b=X10ld0VR9lyeWbW5sKpLiSD+bZkW1fGVNy1LGeO/071zBGiEcCCCL/Xwi4e79VDwtpizp/N1GZS8IElAYnSMXDCvMh9eHfwQGPDlR+fgWB7nVBefynwxHVAi9ydYgnNWh9FhSecPoDJicGzt/WP5RXwaBPk37QJI/I5eOIoh0Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280124; c=relaxed/simple;
	bh=oP67dxrVeqMF7n8kPKV/bjwaK8dB7rL4uuPCLzYhcnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SUHp7TQo8E135eROX0JsVki6j7snKEF/o95coQoiincVVw2Z1D9RvuZnfZ04axDdJTXp0gYe4pDCexxSNnlMji/UiIArlKCdQ5jx5nOjplczcIxtr3mJDlOVXgYmMIB260MHA23kRKLYRG2GrMKAPAUetmJ6oA/5zc+V7M4pbhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Z5cqTaEs; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsQMmqf34yeO0hVsJ4ir/2S3I5ONnC+bEg5/nSQA8eIjuTAkh0tIH8QVIIrub2KfenX+ekJ5W/InWGMPvQdsU365HLmLjqgHEgbzaRsp/4Kf5Omdx0eBuv9dIw8dFA2YiVMJ6uIjDo5L0upmSxv05+N6zpdW1u8PqdZrdSzUbTeCtlJ7Y/EjvX7TH3R9Y/uvhT48J6CnrZSCWg+oWrk+1MMMpNy/tWcXjmCKCiJVl89YbnpYrz5Jdiv0pvSiQoGaUa+UIZheGD7XrI6kCacJ7Xc0zh9FeiVS+yfXSw2WJ3Tvow3eRmCkMoVyJqCG624XvjgAq853RMC2mGg7xVdvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxLLaOHcstwDnBHjdH0GbchAI6ewLXxU3uFNISC3QZw=;
 b=Hg6evi0NPIrz010ZVSTHaT9WZ8fsW9EgAEYtN99oJyxrG8H2LsoC9HZ4oWZ2EELGQ2xcK5d7TtuUef9L70mk1/eIBC2us9iDJ6t8/1lYoInkeb1FWJG7z8TS93iWIk8v4yOSxqnVL9Uz6zYK2geNWZrF9Zb+GwqqIkBpDQouIw7SYze3K/JeHmjwKVFLr3YZXHHqJu3ZB9mYlWJE/E5zmOcpfv1bHK2MtQrD0eJjuQ/BMcOxbnOc74Ix2IBbhFgGWMNdjuvKXkoFJzvdjP/hAejp9BgIzRmyFmcbG0Orqz0QrRKYcyIZvokpJ3vlKoxGV8F6z+6pwZUPLGLRZ1m+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxLLaOHcstwDnBHjdH0GbchAI6ewLXxU3uFNISC3QZw=;
 b=Z5cqTaEsdD+XJwp9DDT0BylMefA5faAD7mo3xryMr57ZWQojeBPbGOEcSI8IwPFSza+gI3hgIDqozO/VNIzDKVgvLc6HSxP1eUOdBvctPHwUGu39xS0pbHKq6YySVn6Oz+u/4eX2zpWuO9T1vB8x1sNQkbnV1qtalrUmmwUo6vDjcZ+jFBG0h8mI52ZK6tthTW19sWxgvDD6dO0C8rrFUeRdBhQat0wWXxzdCNo8NcmwAnPOUY6OACBkmdPchPBqAdcyEpoa3dT4TtAzjnme5Ekei6xUUSW/0GBLzYX3dvUXxDsI8HqEh/X22YZ/4skEcbXfvS2faxrzBGCzva9UHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com (2603:1096:301:ee::9)
 by SEZPR06MB5788.apcprd06.prod.outlook.com (2603:1096:101:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Thu, 13 Jun
 2024 12:01:59 +0000
Received: from PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83]) by PUZPR06MB5620.apcprd06.prod.outlook.com
 ([fe80::b771:8e9f:2fb:ee83%6]) with mapi id 15.20.7677.021; Thu, 13 Jun 2024
 12:01:59 +0000
Message-ID: <39eaba63-0e18-439a-82ac-834505e6473e@vivo.com>
Date: Thu, 13 Jun 2024 20:01:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binder_alloc: replace kcalloc with kvcalloc to mitigate
 OOM issues
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240611085629.25088-1-liulei.rjpt@vivo.com>
 <2024061216-faster-cufflink-ceac@gregkh>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <2024061216-faster-cufflink-ceac@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0058.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::7) To PUZPR06MB5620.apcprd06.prod.outlook.com
 (2603:1096:301:ee::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5620:EE_|SEZPR06MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a3eaad-4170-4cf4-f068-08dc8ba0a0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|52116008|376008|366010|1800799018|38350700008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnpaaW4xcXlaTnZpdUtnMUFEazR0WFNLeWo4OUx0Q1B2OU92SXgrd2s1NDJP?=
 =?utf-8?B?dHY4VEdyaEJSRXpQVG1jN0xFZml6REJGTFdpREx1cHVWc0t5Mm03Q3k4QVpZ?=
 =?utf-8?B?d3RjZTQySFIrUTRJUGhDS1NxY3dTbFhIMGwrS3d5aGZXT3hic1hYZzFzSERN?=
 =?utf-8?B?OGt6SnZidFFVTHkvbkxONlRmbVZJUjEvSjNGVjFYR2w4Y2VySkVGejhhamgx?=
 =?utf-8?B?Ky9SZFFWVzF0TU9mdm5VdkZETGIyZk5YQnVpUXJyTk9VQWY0eHl1cHhmbUNl?=
 =?utf-8?B?eVA2YlRVVmxjWVpyMndiNDNwZE1WY2Z1ejlNdW9YYmNvdjk5Q2ZTNzhQcHVh?=
 =?utf-8?B?aFExdmtUN1NTVXpvbFZvZks4VDVoSW1EM3RxSndhdGFXc1VLZitUVWJZVDFN?=
 =?utf-8?B?WTdrcHh6MmdNSjhnSGY2a1p1TXJwTlF1MTFpeUhtY0g0V2dLZWtmNmNHTEhv?=
 =?utf-8?B?aFdjbUpsMm1rbHpXWEM3bW1YdVkxN2RzeVVnRzJqMHN3STdXNllzZ3RrSUE1?=
 =?utf-8?B?b1RSVWJlU3p3dTkzL0MyczdGL08yeEsvNHBiSHhvQ3hPVXJzUW45RW1zcVNC?=
 =?utf-8?B?WnBYczRMRkQ1cXFwTjJHV3NkQm8rT2h0dEF3T0ZxYW00aXdEcXpWSy9pa2NE?=
 =?utf-8?B?M2JyWnRKdnlkZ3Z6MUNleXhEU0YrM3pvZUNOSzcvN2I4OVFpOGFHdDJIVDBE?=
 =?utf-8?B?VXNNK0hTRTR5ZEIvZXVsRWcwbnliU0tpUUtCYjN2Nm94Z29XR1RyRVM1WUJP?=
 =?utf-8?B?bUk5b0JNNGNFdG4yMGR1aFk3VGczSEtkb0xRNi80QVRBR2RCQlE4UnZUdzhJ?=
 =?utf-8?B?MFRPSmQ4cGlKZnpsTnd3dXEwNzhjNUthd05RTU1lYS82YkFlaWNVaU1WNGt4?=
 =?utf-8?B?THpJV2p3VHBZNGRudmtYc3ZCMzB4b1ZaVTI2RkRRekkwQ3lzWTZnSVNRdGtL?=
 =?utf-8?B?RmZIZUIxSWxlamk0b0E1M1YvUVNaY3pMaFlpeUVtWUFVODBXVWZ0M1pWaFNB?=
 =?utf-8?B?Skh5VThPRWlzY0psZ0ptN3ZjOFlsRHhSdDNBMUJwNDVSZ0RMeTAzM09hMGZK?=
 =?utf-8?B?ZDlkQWF6QTdkQU9KcDNrVzNtd2lwbHVzWnU5dVhBU3plUFB2SS9vNDg4YVVo?=
 =?utf-8?B?Rk9mTDdvWkpjTlJlenM1VHNxcUZxU2YzZVdBaGhMK3pZWnFRdGhPUENnTnBD?=
 =?utf-8?B?TkVzdTFXS2kyU3hMc2ljREFrdEJYcmo1REhjTEtuYTBvV0NtQm8zOFRFazJt?=
 =?utf-8?B?MHFqd0cyRzJIVmN6QUFiT3EycHF1d3A0dWtXcGhwWHpqKzYrM0FHMkZWRkRG?=
 =?utf-8?B?bUgzZ1Iyc04xYytianpxbGJxZ1pSeS9iSXFkRkd1Tm5adlVkeWM4TUdYSEdN?=
 =?utf-8?B?ZGZ0K1pCOHRacW12WGpvNytObzZSWkZiaG5odU1aVHlMMmMycDJDOVBOLzdi?=
 =?utf-8?B?UkNIS2pEalJDNkRJRkJhYUxaNGhvVk9wQjBaUjc5T3ZkSURqQ0hTUHhTMnVY?=
 =?utf-8?B?WkdSclEwSzVaTmppelVkUEMvNVJMWWtyaFRwRUd4VWhjcEFianpqSHJ0bE5G?=
 =?utf-8?B?c0I3WldWTkVicmpQU2g2SnRlZFdOTzZiMzZXRnl6TEd5MlBsdHg0VjVycGpQ?=
 =?utf-8?B?M1QzMktaNXFOZVVhTGRTbjAvNlQyVS96RmV2VDZDSjQ2S0Z0NXdHeTZTTGVu?=
 =?utf-8?B?VW44YTNGUURVb3F5UHUrcDlYbDc5Q2NyVks1YVByanZyRUhUd3NhVDJQTVYy?=
 =?utf-8?B?OHUvL1ZVdnllTzZFMTlWNUk3Q2dkRHBHOHp2SWdReU00V09tYkJ1c01KTWx4?=
 =?utf-8?Q?8+CEFcSZU+yaSycfZgpwox5L5164I5xA4tAA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5620.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(52116008)(376008)(366010)(1800799018)(38350700008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFltRHlJQW9YanFEcGlaN1c1U0J0UDN3TElmVTNRZU1ZY1RpV2xDakljZkQ2?=
 =?utf-8?B?eG1kejNBSE1vY2ovaldMRHQ0TTEzaVVsMnJCY1NqVmpBR0FtcEkrejJkZUh0?=
 =?utf-8?B?VWtONjhNWFM3eEgyVWdhK3NQanFQMno0L3IxdUoyYXhIS3lveXdMOXh0VE9R?=
 =?utf-8?B?aHduOHF4QndMY1NuYjZjb0djdW1JWXRaNjdva1RKakViMThhVmFLSGZ3aVlM?=
 =?utf-8?B?cUVrK1htbUR0a2xRS3Q2blFTL0cydTNybmp1ZjlyRjVaWHF0YnVtT3R4WWRs?=
 =?utf-8?B?Tk4xUG5KNEJsSERIamw5KzNETTlLVlZKUmtKc2JYUG9JK1Uza2VvK3BBRzcv?=
 =?utf-8?B?Z0tRNXBDQ2gvZ1NEVXpOR2ZMcE56b1dwTGMvYUtseXhoWVJHVzRDaXcxalVK?=
 =?utf-8?B?WkQ1WG12eE1CYy9oVFJGNUl4cWUvT0VHd3c5TU5QUWRja1NidG10NmZSenp4?=
 =?utf-8?B?ZGU1SEVtRHZqVk5rSjFsRVhGL0llTC9rVXh2RTk1d2ZrT1JKWXBBRUpkdlNw?=
 =?utf-8?B?ZXZVaGd4REJDMi9WM0R4NVVHaFFhMmxUMzNIckxiZlF0bC9BSkFKRnhpaFRP?=
 =?utf-8?B?bHNybHlrUjh4cE1yK2JNQVZTZVZCT2QwOGF3NkRLNHAwVFJFVjNndG9PZnRr?=
 =?utf-8?B?bUZRRTFKcW9NK3pCdzhGYTRPSkNXSU0rVm55NGFrVUZmS3lsTDFxZUw5NTU0?=
 =?utf-8?B?bTNGVkhMWDFDYm54N2NuOTF5a1lOYUpFdjZPOWxFOTg0ZzlLZlYvWEYweXlK?=
 =?utf-8?B?T1hldDJNSktvNHJLbktHdTRzTzRTeUlSTENOTmwwVlU2UzJmYkpPMk96VWUy?=
 =?utf-8?B?czN6QVVNSUczMXRDeGlSWUtWc1d0WW9vbWo1THBhbjlXWGRJeXZGSHhaaWxT?=
 =?utf-8?B?OTFDZHRkc0xBeGRhbVVrZURPYzhoSVd3RkJKQ1dxYU5xbnBVOU5Kc0ZuNkU4?=
 =?utf-8?B?Q29jQXFKbk5YRDQ2eEprc3lvQkpjZXpmMGNMSlRDVGtidlRQVVE5elJsTGNt?=
 =?utf-8?B?b1F4ZmNvUHRXZnh0Y255aXJvRER1VTRhVkcyZVFOMHM1ZXFnTGpJeWNtSjBE?=
 =?utf-8?B?QkUwSFREekRQLzdGZVQ4WnZJZEFMWFRDOG1Xb1cwWncwdDFwaENsVWY2NDVa?=
 =?utf-8?B?S2c4ek4yelRRUWhiQ2hYYlNUcDdSUXI5SWJQYlJMWHQ1NnRxSXRWOUptVWln?=
 =?utf-8?B?Q2xXWlFLcUNSWHc5aVNGRExqK3l2NHg5cVFEeCtLbmp3RjJtamJBWGcvYmhQ?=
 =?utf-8?B?Wmg4Ym9zSktZYit1YkxhRi9SbkFvanVmaGNKN2NtN1RxRk1EaWdhbXY5UDd3?=
 =?utf-8?B?RlJpTmxDSEdURk1xcS9XYnpscFg1QXQrS3JxUWpvTXB1aUUyR2lFckg3VmM3?=
 =?utf-8?B?RTJlaU5MZGp0azNlR1R6MWw4NWNKVVhGTDZkZ05SQWg1c2dYSDUwNGV5OTlV?=
 =?utf-8?B?OEFvVGRFOGJFaTBaZ2hFS0hIcVREMTZ0T0M1UHNtcjlPZ3NIOGI4RHhNN1hj?=
 =?utf-8?B?VEJ0WFF0OVpkRWtuSUlia1ZxV2tEMW1zVXFDc3NGZlAwOW5IU0Flc0JQNXMy?=
 =?utf-8?B?OFFnaFhrSElMbnR1eWRldEU0NGFabW5VcHlxUkp0eUxESjdkYTk4ekFPaFRM?=
 =?utf-8?B?VC9HMkIzTlhmaHF2MXpkZlpheU1mNVNicTNKVkU1c3M1blZRWUt4NnVXN2ZL?=
 =?utf-8?B?aWRWNU1Menpyek1KMDkrSlpHOFduTnRYYVV0NkprbnZudmxtNEZiZFJGMlBy?=
 =?utf-8?B?MjRVcis3TjhabUxpd21qVjZWbS9LZXlNTFIwSkVlQmtWZG8wUFB0SWF4UFdV?=
 =?utf-8?B?VUJFK3JRT1NrWm5QcWVjQ2JsSzVGT2NLN1JMUFZyaEVqZkVkaVhHcmZPblFJ?=
 =?utf-8?B?L0htem5PQ2ttYUtxN050d2pLTmRHeTJ6SVFWV2dRRUI3V0xlRGVTbXUxWmYw?=
 =?utf-8?B?clFVZFZ5ZzVQMExHelJIOGdlYlErc3FNU0FKYjRuSEZtUHdkTFhSUzZyRmJx?=
 =?utf-8?B?RVgrU1lnTkQ1T2FuTENzYUlIUzFUZjRWQndNWm1GbkFhYUs1dkN6Vi9hNmhO?=
 =?utf-8?B?a2Izd1ZuTGZLMGcrYi92aEVuUC9FWExxYmtyV0xWN203Q3k0cFhzRktVdGor?=
 =?utf-8?Q?LcRyX5IJzBxcemybhkZ+GsMXI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a3eaad-4170-4cf4-f068-08dc8ba0a0c9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5620.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 12:01:58.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fry1UJesxJm/He8ZcHx+z/2QFZX53UONED5MLe5PsMRAS9hDBN9O87FUOTSMcrPwVYc9rKRcTZ9sKa7Oqh88/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5788

On 2024/6/12 17:58, Greg Kroah-Hartman wrote:
> On Tue, Jun 11, 2024 at 04:56:28PM +0800, Lei Liu wrote:
>
>> In binder_alloc, there is a frequent need for order3 memory 
>> allocation, especially on small-memory mobile devices, which can lead 
>> to OOM and cause foreground applications to be killed, resulting in 
>> flashbacks. We use kvcalloc to allocate memory, which can reduce 
>> system OOM occurrences, as well as decrease the time and probability 
>> of failure for order3 memory allocations. Additionally, it can also 
>> improve the throughput of binder (as verified by Google's 
>> binder_benchmark testing tool). We have conducted multiple tests on 
>> an 8GB memory phone, and the performance of kvcalloc is better. Below 
>> is a partial excerpt of the test data. throughput = (size * 
>> Iterations)/Time Benchmark-kvcalloc Time CPU Iterations 
>> throughput(Gb/s) 
>> ---------------------------------------------------------------- 
>> BM_sendVec_binder-4096 30926 ns 20481 ns 34457 4563.66↑ 
>> BM_sendVec_binder-8192 42667 ns 30837 ns 22631 4345.11↑ 
>> BM_sendVec_binder-16384 67586 ns 52381 ns 13318 3228.51↑ 
>> BM_sendVec_binder-32768 116496 ns 94893 ns 7416 2085.97↑ 
>> BM_sendVec_binder-65536 265482 ns 209214 ns 3530 871.40↑ 
>> Benchmark-kvcalloc Time CPU Iterations throughput(Gb/s) 
> Both benchmarks are the same? Or is this labeled incorrectly?
I'm really sorry, I got the title of the table wrong, here are the 
updated data:
throughput = (size * Iterations)/Time
kvcalloc->kvmalloc:
Benchmark-kvcalloc    Time    CPU    Iterations    throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096    30926 ns    20481 ns    34457    4563.66↑
BM_sendVec_binder-8192    42667 ns    30837 ns    22631    4345.11↑
BM_sendVec_binder-16384    67586 ns    52381 ns    13318    3228.51↑
BM_sendVec_binder-32768    116496 ns    94893 ns    7416    2085.97↑
BM_sendVec_binder-65536    265482 ns    209214 ns    3530    871.40↑

kcalloc->kmalloc
Benchmark-kcalloc    Time    CPU    Iterations    throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096    39070 ns    24207 ns    31063    3256.56
BM_sendVec_binder-8192    49476 ns    35099 ns    18817    3115.62
BM_sendVec_binder-16384    76866 ns    58924 ns    11883    2532.86
BM_sendVec_binder-32768    134022 ns    102788 ns    6535    1597.78
BM_sendVec_binder-65536    281004 ns    220028 ns    3135    731.14
>> ---------------------------------------------------------------- 
>> BM_sendVec_binder-4096 39070 ns 24207 ns 31063 3256.56 
>> BM_sendVec_binder-8192 49476 ns 35099 ns 18817 3115.62 
>> BM_sendVec_binder-16384 76866 ns 58924 ns 11883 2532.86 
>> BM_sendVec_binder-32768 134022 ns 102788 ns 6535 1597.78 
>> BM_sendVec_binder-65536 281004 ns 220028 ns 3135 731.14 
>> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com> --- 
>> drivers/android/binder_alloc.c | 6 +++--- 1 file changed, 3 
>> insertions(+), 3 deletions(-) diff --git 
>> a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c 
>> index 2e1f261ec5c8..5dcab4a5e341 100644 --- 
>> a/drivers/android/binder_alloc.c +++ b/drivers/android/binder_alloc.c 
>> @@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc 
>> *alloc, alloc->buffer = vma->vm_start; - alloc->pages = 
>> kcalloc(alloc->buffer_size / PAGE_SIZE, + alloc->pages = 
>> kvcalloc(alloc->buffer_size / PAGE_SIZE, sizeof(alloc->pages[0]), 
>> GFP_KERNEL); 
> Nit, update the indentation please. 
> thanks, greg k-h
The previous incorrect table title has been updated. Please help review 
it again.

Thank you!
Lei Liu

