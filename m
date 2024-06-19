Return-Path: <linux-kernel+bounces-220707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACD90E5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574B71C212CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA05379DD4;
	Wed, 19 Jun 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OcGb9+fT"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE25FBB1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786153; cv=fail; b=uE5DWC6a0radMUw1Jr9WuQYfRKpb8PkGrHEw/yWvbVd0CK/rfaVPeDqBp5Dh+sxYGS7uAPlqj6hao3gpuc07mlY/5Mw2VXzWVdqAYFtjqcQFbdJ2B/IlJtAC9zlDn3pSbUgmxlS/RsmpPygCP6N/YVZ9zoeQe/lR1BAZ6cLnAT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786153; c=relaxed/simple;
	bh=3MqxEqtEptb3S9DPNe179jAirIIJeniI/5mqeercyns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjTGiGm+Op99gOn+xWLDbEsd+0EZ4180WXtCvkCCIH9BnmpwUmI7oAoTn5Ot1QCURCbtXm4mxrWXI5oVo07yHbPlTgOmgCNFdKvPJO49P0SUaLLLzOGFc4QjM/kwJHBPTUZtdccCcY8tb4Z/VcIVyiQIRo2rCDUc9jfumaD9yrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OcGb9+fT; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2TElEyVvpFEliIAZhFkzlAFKNuJFAASc9xFk88jxadlHXWSAQmvCQxLgnE3XuuLo6DKJF6s992/CgcQyevEyokAkdDP6XsLQlq/Q8KGLyjiOcZD5uA9Vj1LgQpm2amOcSESV+zYA1NSB9xbk9bhdl/VW8KvI4h7m0v7Dm+CbQmtr+Mz/bNQaJ3kS1Pxy4l2l5W+h+J66vBc8yPKyV1lGRr2aboyYCsSuqD0tJudjt8kWkDQVN0bZz/3Zi/espM8x/I4RD6esCVLGiUQLDHZt7EbFz438S6HwSmafaWzOHXw0GH0IWaLttJuvueSDKCzewi9lilRL5Z108oA1DlFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCz4wdOE2ZNVQOLoV/sUqmOWBbfb0rgGVG53dYo1YLw=;
 b=bMpdZzvr28ipF+S7PKo8ZGeEd6O7NdUfgCrWhoHWHSDstE2qx5efHcMBCHA7hlgVXJ6fy2A988FK8v+a3UmBuvL7OsMnXn/OlYegxNmhsjkV9HBEGPf9FhYdJiGKO+D/BPZjbM7WEj163pTXa9eikNsvaTHQXExADVBN/npB1er5oCjBjxZnHykaDS6jqpbMyah7FPcps50cfQZdMFKa1Nz4T9vfcbed4m4O4TkiFnluvl5q0Mrw2GG0C/uHTQikea9HyUJpSr+KvCtksRqeZg3cRCmR14oE6YYAHo0rCzx44xGYY336DijaAd1/BpE45begPGTfHXec1dUjXKEhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCz4wdOE2ZNVQOLoV/sUqmOWBbfb0rgGVG53dYo1YLw=;
 b=OcGb9+fTuiENEKimpPx3qVROTlGXQXOxbzt96ex3Hv4MIsnkEPcFf22CG5yFifJY5Kdy+9l/w0MvJ7zvCnoJeqwPhiKXg4TKSLOAMtdlpgBrRCFuvhYbYZeXFIwK+3rCCOQKnn8exx9b882XV2n8Z4LPFPZZbHRh3sEdXnORIKcSZ8JyoFRWgZdkRcHhHXoBJgdCmJJxh2ZpFGWx0W4Db5WOWqo2CLhwbeBr33pFxPPLFYiuK1oYUpeG+YM8JqWCxF6+sUzDIeIyeybjebdOOr7LF5oqK5cJ9N+Ed0x0DjHMt54WHE6OaUiuafnPSFW5pff1RscbR3HrTBasuXs+hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYSPR06MB7159.apcprd06.prod.outlook.com (2603:1096:405:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 08:35:46 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:35:46 +0000
Message-ID: <5c425a99-2b51-49a6-a3e5-1f2ef8b5254f@vivo.com>
Date: Wed, 19 Jun 2024 16:35:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com> <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
 <ZnCDvpFveS6X0a1g@google.com> <32e0c2ea-6035-4ec9-b99c-e6b686f04cf3@vivo.com>
 <ZnEO8X-7pjeTFTur@google.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <ZnEO8X-7pjeTFTur@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::16) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYSPR06MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cd38f3-a95f-41ff-8b89-08dc903ad07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTJoWlBYdVlWemZRaVRDRFVKbDVuRmI5YmZSbWNpb0dNdUJmaUc0c2tMVFNG?=
 =?utf-8?B?ZzM5U0dJZS9PSlY2eVhTMXRwenMwMklUOFZqZTk4b2hJNCtyVWxTTHRZSlR3?=
 =?utf-8?B?V3B0WncyQUh5OE4veXhrSDRzaUx5NkhIcnJma2s5eXd0bjk1ZDE0dHBVN2Rh?=
 =?utf-8?B?R2MreW91THZ2eVpFbXVXNExlY2JXOHdtd01TZ2pkL2xLTUlQVUh6WHpQSlJM?=
 =?utf-8?B?ZnVhZENNM3BFcVZFZnBVMVRwMVgrZVZzMWVFSXZWWG4rcUJ2TWFCOS9nckhx?=
 =?utf-8?B?RXBHVGpPWmNwaUpCQ1RSVmxKSk9kUEVYOGdVL2NMV0gzZGlDYmRBdnd4UHYx?=
 =?utf-8?B?a2tLSjZaWlM0Qnk3RFhEUkcwWnBMRVZrVGtMVUpJTDA5dTVkaXoxOXIreGcz?=
 =?utf-8?B?TjdmelZjelRiOFg4RlM2SXFUaGVPVFh1bEg3SnVSVUFNUXdqU0NPbk5oNk1F?=
 =?utf-8?B?NWVkWXZlQjNWN2c1VE5TMG9kbHJvb05ISjd1dG9YaE1yUktHdXdaR3JjMDR6?=
 =?utf-8?B?NmU5RHluajExblE5aHJJRTN2bHpvWFp3ZlBlNnJ1NExEdDVNQk40dUFVM2tG?=
 =?utf-8?B?WEJiRGwrZkd1Vnh1bDRpeHpOTXBHeURHVlJVVmRJa0h3QnFIZnZJZ3kyU05X?=
 =?utf-8?B?cEladHh1N2lIRTFxL3BHZzVQUlF1YzNWazVZMjVjTzRaS2VoY0NXV0Njd2Zj?=
 =?utf-8?B?RTVPSGhCZTZJS2REMjdSZnU2REZBaXphTkQ5bGZOb1pXNG9vcVhNMTR1Zms2?=
 =?utf-8?B?R1p0L0svT2dwUnBFcDdIYTZzMVZsa0xkUHNhZUxzUEExVFpVczRRblpHQytZ?=
 =?utf-8?B?aCtrWGROd2xkbW1obmFpOHNSQ3o4Si9lVUFHMjZPNkpTSmI2NWYxWXFITVVG?=
 =?utf-8?B?azBucXBKamxtTTF4VUhBc2JxTzF5bHUzdWhIclRzQmU2WkZieWZnOXFSRmZN?=
 =?utf-8?B?L1hVZ05LRDdDd3B5OFJZK1I5dzFnTVprN1V5QkZJem03K2lIbXB6VGpaSnY2?=
 =?utf-8?B?Q1dRNVZySlRlYzYrSWxNZkN2WkdET3owUUJCYXV6RGF6TnB1QW1YK0Q0ZCtZ?=
 =?utf-8?B?bTBVakRwVmV4cnlweGlhc2V5Q004enBNTGJ6YjVQTGJqU1dUd0VuWWxlZ09M?=
 =?utf-8?B?ajY4NzdtbndzTHgzVFA3anNWb29LK0RWYTROL1NmUG9iczJFVy9CUUl0NGtD?=
 =?utf-8?B?RjIzVzVNclQvbVhETEhVQUNCaXJoRkJCTnVRWStHQTB2MkVBQm93bkZ0WkxH?=
 =?utf-8?B?by92d3k5RW9OdU1yY3c1S0gvSzQwMFZWU0Nham1uT0laaGQwcGR6K2xEMjRV?=
 =?utf-8?B?ZDhPYzd4bnR0MC9OM0EveVd4MXAzWWp4a2ZWWGJDdCtLTFlCODRyamtFL3li?=
 =?utf-8?B?b3RCOWJHMUlYbUE3UndOc3hZQzhRd1JsMzR5QmFZZ3NmMk9UbnFsOXB2aXJr?=
 =?utf-8?B?bXdPcmJPZW1kV0l1TmRTdjRYNjYrVjRMMEFidXQ1QnFTTHgyTkU2UGE1YWRR?=
 =?utf-8?B?VGFpZmVpQm10U3dvVDUrZHhNVG5zVm9wNGQ4bTBZUTB5bE45VkJpL25kMDRL?=
 =?utf-8?B?SWZMN1gvS1hKWHBHZUZkRzNFUlZZWS9yTm1EUWFHMS8ySDBXeDJaSXBFSThu?=
 =?utf-8?B?RUtoRWU3d04xaS9RdFltdW9zMTZNWEFPSEZISUlNZ1R5dFhiajdFNUVDdC9i?=
 =?utf-8?B?MDdIT2hGK0NiQlhzdVErQWtLZHhOeHAzZ0xIRXphLzZuSWszaW5Kb2FMa3hv?=
 =?utf-8?B?azhYTUR5amd0eWpKNFlqM01lWkg4Kyt1V3UzV0twV3NqdnBLNFBvOWptZFRw?=
 =?utf-8?Q?6EScKlieKfZTSoTeT4I1DG2AnMIWN0iW7nbOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2YwQTZMV2xmYmZsSnpiTGFRVzJqSlBaV3c4bnJPUzJJWm9YZCtCRnhOSkYx?=
 =?utf-8?B?NlA3b2NDOUs4TzljNkNrZUhJQ0Q1Y1BRZkJYRUYwcUh4MnFVeEZIaU5OSTcr?=
 =?utf-8?B?WVMyVXlsQTQvUDVPOGg2dG5ZVE9Ma0ovU2tZRlcrd1RrMDQyYktYSzFFbWU1?=
 =?utf-8?B?WDE2TzEzdXVuWGFsb0FmZzl3U3RqRmpqeklSVTR5TnE0SHNDemsyMGdDMEZa?=
 =?utf-8?B?citlNWJGWXlZSUxUaVpIaDQ0MHY5S2F6TDRQTjBDOW9zVnJ3UUJicCswYWlG?=
 =?utf-8?B?U0ZsRHJRWU1yYVdKdzZwaGxsQVpSV0FCYThuK0VyOXA1c1lnNnJ3Z0tEd0Iv?=
 =?utf-8?B?V2h0SkVJQ1ZiUGxNQTRCVzJNejdMejZIYUFVN0ZmUGNnQmt2QlByYlFQVmM2?=
 =?utf-8?B?VDRjMWhHOGsyZHNJM3R6MkZqZElNNzBXa2VNUTVZakhqMEY0ZjNvMEhabEJ3?=
 =?utf-8?B?STJnRTV2ckhFK2ZtR0JqcTZUeGtuaTEyclNyemwzclBYUVExbnhLRmRVSlVz?=
 =?utf-8?B?UFpUVzhVZHlUSGZCeml2ZFdhQzJQeGZlK01CZmFBaUY3SzN6UHdCYWQzV1Ni?=
 =?utf-8?B?YXBnSWNZVDkraWJ1enUwZ0V0OEJmUzU5ZGJoQjZHVnpyWVBGenpKNUF3UlhG?=
 =?utf-8?B?ekdPNjcyTTNwb3Y5aFI1b2x3Y0N4VHFOUFVKSUtjZUd3anVMaG9VaHh5dW9a?=
 =?utf-8?B?aytkSzBSYmFObzVwNG9TM0dFOGNnWUNvVk9ySW1zOTVoSTJ4TjV6eDYzMngy?=
 =?utf-8?B?VDdBOFo4elVrTTVuaEw0WFk0SUl0U1pQYUdLZ0pVZ1Y2a2dLdjJvdDZsSU5D?=
 =?utf-8?B?Vkh0NmJmeTVpeDNHc04yM1FMWWxGaytKdkF0RTgyTFJROUJLZ01Cb3FEVlBH?=
 =?utf-8?B?WTZ6TGkyZFd1emRVVmVkU1pjd2RKTnZjN2dyS1JpNUlXNDRqYUVQMER3cDdH?=
 =?utf-8?B?ODhWcGF3RmlMTmluR2tlWVlXM3NmVml5YXlNQ3pGTGxiSjhhWGdMSWFNU2lv?=
 =?utf-8?B?ZnFUdGFvcGxtMHEyZTdzRC9GVVZMNS9LUXdWWm9BcVM1VDZabXRHWjhyVWFu?=
 =?utf-8?B?dE5leEtQRzBYaUhmOTZyMkpXM0k1MmhNT25XcWpHVWNwN0hhTFVXOWs1emMv?=
 =?utf-8?B?T0tYSFNZbTVDanBEUjcyVHMxOUdwZWRMdDdId2krWmpQMEpFekdpTU9jZWZr?=
 =?utf-8?B?WjJXbndSTzQvdE1LYUNPcWVNeG1OWW4yd0ZST0hjdjVZZzhyRUJNYnVNZkp4?=
 =?utf-8?B?Yit5K0NPZE8wMURWbTM3RFFHWlZHLzVra2h1bHIrRDNEbTV1a2tDaW5xUWds?=
 =?utf-8?B?Ukd2bWhCWGwzcElHTDZGVjB5ZUtsQ2RsYzVPa1J5NjQ2d3FucWdJL1BxZHVq?=
 =?utf-8?B?TlBFQ2NBMlhPU3dQcDl1eHI3SC8vMjdxYlRQSnpqRGlqQ0hDT1FCYUlDZmFi?=
 =?utf-8?B?Tk91a0JSR2tkcWRGT3lDN1hiOTYrNkkvYTg0R00weHJ6djhIZXFrSi8yblpK?=
 =?utf-8?B?VHkxNzZpbjlkYWdhaEZkNklMQ3UwUFhxdSsvVGp6VG9kU01nODRpcndoVW5p?=
 =?utf-8?B?aEpVUS83MDVsNklCNjZNdEMvK2dDVDcvMHk1aHhBRlJFd0JRREJULzE1WGZk?=
 =?utf-8?B?eExJejZhbnYxMHJER055akpQK052cEJCTjhnQ2c1anhLVCthUXhMMDB0Wmk0?=
 =?utf-8?B?MVZveWZBS1V5ekpycGhCTmtySW1FaWVVS1BzZi9NZTFScm02MFJOUHhmMVZz?=
 =?utf-8?B?ZU1LLzE0eWJNRHhXdnRlQ3V4K1RKTlRPWjR3TVdhd20zOVYxRldlRlNKQWEz?=
 =?utf-8?B?NkI0cmZmdUw3Ynk0VGdKNzRtckkrVC9pdG9vVXBxVGwrM3Q2R0dqdmt2SFBs?=
 =?utf-8?B?d3FaME5ZeU9FRDJ3WnpGK2U1ZzBWU2dhTEZxOForY1hzMzR6OTNLM2Y2SlhC?=
 =?utf-8?B?QWVKZUc3T0svL3dHelQ4M29VNUxSVy90K3RLTXBZLy9VRDhUSHU3S2ZicEJx?=
 =?utf-8?B?MlBibWNMN1kwakdXMmtyOG1Wb2Y1YXRxTXhTVnNHU2tWcFBocjduVnFLZUNq?=
 =?utf-8?B?OVY2NTVZWTFKbXcxUXhwM3M4R2tpT2IvSU5ZVzZvV0wzQzFJK3VTZy9EemlO?=
 =?utf-8?Q?J3eP+xAAVi4OEZ5FV81ReLC9A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cd38f3-a95f-41ff-8b89-08dc903ad07f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:35:46.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr3Gjjj4nEYrjb9HONLdCLOviCw0vXOyjYWM/lfwAUmxdUpMHABJiGpVDqK1X3oOqmhirqtxCcTiqehLxjf21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7159


On 2024/6/18 12:37, Carlos Llamas wrote:
> On Tue, Jun 18, 2024 at 10:50:17AM +0800, Lei Liu wrote:
>> On 2024/6/18 2:43, Carlos Llamas wrote:
>>> On Mon, Jun 17, 2024 at 12:01:26PM +0800, Lei Liu wrote:
>>>> On 6/15/2024 at 2:38, Carlos Llamas wrote:
>>> Yes, all this makes sense. What I don't understand is how "performance
>>> of kvcalloc is better". This is not supposed to be.
>> Based on my current understanding:
>> 1.kvmalloc may allocate memory faster than kmalloc in cases of memory
>> fragmentation, which could potentially improve the performance of binder.
> I think there is a misunderstanding of the allocations performed in this
> benchmark test. Yes, in general when there is heavy memory pressure it
> can be faster to use kvmalloc() and not try too hard to reclaim
> contiguous memory.
>
> In the case of binder though, this is the mmap() allocation. This call
> is part of the "initial setup". In the test, there should only be two
> calls to kvmalloc(), since the benchmark is done across two processes.
> That's it.
>
> So the time it takes to allocate this memory is irrelevant to the
> performance results. Does this make sense?
>
>> 2.Memory allocated by kvmalloc may not be contiguous, which could
>> potentially degrade the data read and write speed of binder.
> This _is_ what is being considered in the benchmark test instead. There
> are repeated accesses to alloc->pages[n]. Your point is then the reason
> why I was expecting "same performance at best".
>
>> Hmm, this is really good news. From the current test results, it seems that
>> kvmalloc does not degrade performance for binder.
> Yeah, not in the "happy" case anyways. I'm not sure what the numbers
> look like under some memory pressure.
>
>> I will retest the data on our phone to see if we reach the same conclusion.
>> If kvmalloc still proves to be better, we will provide you with the
>> reproduction method.
>>
> Ok, thanks. I would suggest you do an "adb shell stop" before running
> these test. This might help with the noise.
>
> Thanks,
> Carlos Llamas

We used the "adb shell stop" command to retest the data. Now, the test 
data for kmalloc and vmalloc are basically consistent. There are a few 
instances where vmalloc may be slightly inferior, but the difference is 
not significant, within 3%. adb shell stop/ kmalloc /8+256G 
---------------------------------------------------------------------- 
Benchmark Time CPU Iterations OUTPUT OUTPUTCPU 
---------------------------------------------------------------------- 
BM_sendVec_binder4 39126 18550 38894 3.976282 8.38684 BM_sendVec_binder8 
38924 18542 37786 7.766108 16.3028 BM_sendVec_binder16 38328 18228 36700 
15.32039 32.2141 BM_sendVec_binder32 38154 18215 38240 32.07213 67.1798 
BM_sendVec_binder64 39093 18809 36142 59.16885 122.977 
BM_sendVec_binder128 40169 19188 36461 116.1843 243.2253 
BM_sendVec_binder256 40695 19559 35951 226.1569 470.5484 
BM_sendVec_binder512 41446 20211 34259 423.2159 867.8743 
BM_sendVec_binder1024 44040 22939 28904 672.0639 1290.278 
BM_sendVec_binder2048 47817 25821 26595 1139.063 2109.393 
BM_sendVec_binder4096 54749 30905 22742 1701.423 3014.115 
BM_sendVec_binder8192 68316 42017 16684 2000.634 3252.858 
BM_sendVec_binder16384 95435 64081 10961 1881.752 2802.469 
BM_sendVec_binder32768 148232 107504 6510 1439.093 1984.295 
BM_sendVec_binder65536 326499 229874 3178 637.8991 906.0329 NORAML TEST 
SUM 10355.79 17188.15 stressapptest eat 2G SUM 10088.39 16625.97 adb 
shell stop/ kvmalloc /8+256G 
----------------------------------------------------------------------- 
Benchmark Time CPU Iterations OUTPUT OUTPUTCPU 
----------------------------------------------------------------------- 
BM_sendVec_binder4 39673 18832 36598 3.689965 7.773577 
BM_sendVec_binder8 39869 18969 37188 7.462038 15.68369 
BM_sendVec_binder16 39774 18896 36627 14.73405 31.01355 
BM_sendVec_binder32 40225 19125 36995 29.43045 61.90013 
BM_sendVec_binder64 40549 19529 35148 55.47544 115.1862 
BM_sendVec_binder128 41580 19892 35384 108.9262 227.6871 
BM_sendVec_binder256 41584 20059 34060 209.6806 434.6857 
BM_sendVec_binder512 42829 20899 32493 388.4381 796.0389 
BM_sendVec_binder1024 45037 23360 29251 665.0759 1282.236 
BM_sendVec_binder2048 47853 25761 27091 1159.433 2153.735 
BM_sendVec_binder4096 55574 31745 22405 1651.328 2890.877 
BM_sendVec_binder8192 70706 43693 16400 1900.105 3074.836 
BM_sendVec_binder16384 96161 64362 10793 1838.921 2747.468 
BM_sendVec_binder32768 147875 107292 6296 1395.147 1922.858 
BM_sendVec_binder65536 330324 232296 3053 605.7126 861.3209 NORAML TEST 
SUM 10033.56 16623.35 stressapptest eat 2G SUM 9958.43 16497.55 Can I 
prepare the V4 version of the patch now? Do I need to modify anything 
else in the V4 version, in addition to addressing the following two 
points? 1.Shorten the "backtrace" in the commit message. 2.Modify the 
code indentation to comply with the community's code style requirements.

Thanks,
Lei Liu


