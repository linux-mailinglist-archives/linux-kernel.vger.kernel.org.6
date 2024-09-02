Return-Path: <linux-kernel+bounces-310621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E13967F2D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB72816BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39F154BEA;
	Mon,  2 Sep 2024 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Bh9SGXJG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2091.outbound.protection.outlook.com [40.107.244.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E71AACA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257567; cv=fail; b=M7dtmmAVMPObqhDf3ERYcpBXgtITvva6NIBuUG3n4/nRkIaVqDA2TPiZYdzfLwf0HpLa+K3gyqYwLQKFki4gLxafKocF9bogEjVlRqndMP7IwEipDj7z12FcQqqEAnvAMonXu0Vu45AK9c59jTiHSZ2yLHSJLeegVsGpTyGfnlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257567; c=relaxed/simple;
	bh=1kJezd43iEJemC9kddMwSfaI9nEk30lgtYKybPAio2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YkE8T0YHIrNAIhmbtZ24jintDGLMLxuAXYLbsL+CYie21m4FUb+SArglulR7shrrUoSvTZpS0aC0RSW6AXsph+LFSDtq/GVwowSOuMOV6h67zMr0dhQmxHNEtnFoU3GMUSnYIwk0V6W6pWr/cVq55gJOx2bdQ51hGJ1EbCFhYZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Bh9SGXJG; arc=fail smtp.client-ip=40.107.244.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nM5lJDtQm9ikW6zU5bL4XLtZ9nKgJNyKdj8npRRJjM06OSH5/hXDIL+gfMrnnHYBvtRA9Bpa6hehSwObi+mNIpIu3T1HUdJyCE34OX5ZuXNpwCkvFp+56D2x/FeiaIy+Fkz6IcmQOoQOTnQgQup6GDayQCd9rATVfpsFIFPXHqtrK3gwLC8kLG9W9kmqSXa9elpT8g0XVUo+ylPprGB82vQZx2/1HdcVP8J1RdWJ/Rf9Mo12CK9TqlonRgvlpwN+r4neCWS0i9iqZk1vecbGbLlH2aZbygvpVd+uMInpCTWy/802Ww3ZT5LlL7H9ZTE4ueNOAGNGhEpfGw69DTyDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI1XeVIHAZv+eblKj9JjZxPg+OPJagsQLxYS8LNb7lU=;
 b=ow6BIn+tAJtVAUb4VfW5nxm9YWw5ryZyptKocZjhohli6mMRV3/hXPSHSqe0e+Ti/eH0vondIlRf5MqQYBuhClzYQE2cnQ1WUgZgwWLalzO7m7Cx7ESOgKyQEoXgAugyG1+xdSP+Nqr7WPKcFFCX9sydQPQlNvJTjXYa7dDrYj7t483QYxRnQkRa/2WDreXmXnkcvbD+rkH5KqrAwqExJEY8BdlBHchd/svQnBtxsFPLl0Z3E7JSmcTwGViVrrvaDTfuJ/kzc70LOpyVcpATJjyiTKnKQOvsJnPJDV4bPg0RSLx0Eo1aW+gOz+1ecwgLr+snGs4OkrWc0TMrLgPTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI1XeVIHAZv+eblKj9JjZxPg+OPJagsQLxYS8LNb7lU=;
 b=Bh9SGXJGXTtp1XfCH116SD1z2l1THGVDsECpIsztK1uqRmk160pCsZ+/D1cmHUE+xXvxLWwYI3pfPSx3cOS6jUZbwH7Ond5UKYYKPFohy7DZJftbhyxRhRO3+KBPkYJK/nIn/L0k8HU52Zj+6aeWdm9uUlmf7VumIJYe+iPP/Jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 BL3PR01MB7132.prod.exchangelabs.com (2603:10b6:208:33b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Mon, 2 Sep 2024 06:12:40 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:12:39 +0000
Message-ID: <d58dfe42-5888-445d-979f-44bd59148079@os.amperecomputing.com>
Date: Mon, 2 Sep 2024 11:42:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, scclevenger@os.amperecomputing.com,
 acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
 <4dd7f210-c03e-4203-b8e9-1c26a7f8fe79@arm.com>
 <c73573e7-206e-4a6c-b6c6-27903978d0aa@linaro.org>
 <CAJ9a7VhJFNxPCVva5tS51SBaxx76nFq9in0MGJe2jEwbVdSTkA@mail.gmail.com>
 <27912fc6-8419-4828-82a7-dacde5b4a759@linaro.org>
 <CAJ9a7Vg3W0NseXes3_irgkyeDKjhWqw5YMRghguHJZS73p9SJQ@mail.gmail.com>
 <36f947ef-c2a7-486a-b905-f0529308b06e@linaro.org>
 <51661f76-c02a-49fb-8d68-53a8549acd19@os.amperecomputing.com>
 <aa159649-4274-4bc4-94fe-f9d112b198df@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <aa159649-4274-4bc4-94fe-f9d112b198df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::24) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|BL3PR01MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: db940679-bf6e-49c1-6f2e-08dccb163f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Smc4UHV1K3BRQ1NrTDEwWDFtaFNGSGVUaWIxMUUyWEZXS204STRraGJTUDBZ?=
 =?utf-8?B?ZHdTbGxTTSt2cjJhRnl5OFJmY2E0VEs1MlZvMXBXUVhrTkhHRzVvMjQvQU5E?=
 =?utf-8?B?L2pzTGhmWVdrSlVBSzZQdmtqeDZxenc5dHl3Q3M1SXpueUh2R1J1M05TZU1t?=
 =?utf-8?B?NTQ3TFROamtmTVM0Q1NVT2p2RloraDR1ZVVHcW90SFZ6RzUzSEF0ZG8zZWVI?=
 =?utf-8?B?RDA5NUV6eWgvUk14eFV1WExlMHZGc2RiVHFDVW91N1B1Qy9zd1ZhTWxoSjg5?=
 =?utf-8?B?UjdwcDhZNFBRbDdSWm9VZE9LQVEwd3lqbXJtaGNudDlsUzBDOFJ2MmdVODJw?=
 =?utf-8?B?bkttTHZXL1pwdWJIN0pmZnNJUkdadkE1R2FzTDg0dWQ3SGZaVTlvRDFVam8w?=
 =?utf-8?B?b2lrNGRiaGgwOHYrUHZCWXBqcVZRQkJXdFhJK2tvY2M4Zk1WMXVVdEh3dnY1?=
 =?utf-8?B?WGR6VDFhNHpPZ2F2ZFRyck4xS0JxZE1SVThmOVNlOXc2WVhYRVJ2cHFaWCtK?=
 =?utf-8?B?c091RkZXckhkZFJibkZvczVJSmVTRkovRFJndUloTldPWmJBVFFSRC96dUR5?=
 =?utf-8?B?TjhTTmtjZUlvenNWck81WGhlcldBREFTaWMyN2ZEZ0QrNjdMVUJhc016TjUy?=
 =?utf-8?B?YmptL2Z3WWM1Wk1XOTRUeFRTUytQWjBRcDF6M2RKdnhaTWNEeG1WaVZ2ejhu?=
 =?utf-8?B?a2xFbFJndXROTDFGeVA1VWE5OFJOS0tFKzJmU3JhaE5iKzZ0d3o1YUErL2Q0?=
 =?utf-8?B?QmNvWnRWTUVzRnowTFdTcWNIN1g3TzkrcHpKemZ1Unk0RW5QcjJ6Vm40QkV5?=
 =?utf-8?B?Z0tCUDhlYVd3a2ZPajRjTHo5aU5CNzI2eFk2elYvZExZQlNpT0ltbFk4VjRp?=
 =?utf-8?B?aTd1VVI5YTRoUlNXY2tYUUEraTNLWm9VTkxpSkFqMTRyYm9JaUFzS1Nsamgw?=
 =?utf-8?B?NjRVdUNDL1ZWY01abUJUYnh3eUdtZlRUN0pQQ2p2cW9SS0lKaW9qZ3NMVkw0?=
 =?utf-8?B?Vng4MTlTcXAyMlc0dHpHV0hUTkprN3Q4ZE02eXVTR3pMOEd2SEdTeG4xWEdZ?=
 =?utf-8?B?MlZ5UUVNb0lIeWI1dDIyR1RFNFAwK1hnb3k3TWwvcmFFWFl5NWQrdzA5NW9o?=
 =?utf-8?B?M2xDSXBucnhSYVNpeUlPV2hPcDlRUUhaMDhoMUZwcDZ1dUdjWDd3dU9hcDkz?=
 =?utf-8?B?VTRkMXNkUmxhL0c0NWdlaXJ4NG45c2drd0lyaDNSTE5RZGFjajNwUVQvbktn?=
 =?utf-8?B?ZTRyay9qZGkwaEVBNmRiMTBJR1NveGVsMUxXTGl4d1IvNFdqZzVMYnBJbGwz?=
 =?utf-8?B?ejNsd2VXeVcwMGJFL05GK285MVNFdWdmRlhSRjQ4OFFUaFdRVzJqekNteTh0?=
 =?utf-8?B?a3hHeWpkV3h2MXN6bkppQ3hPNU9lSkNJNDQwcEkrUU11citTNVVYNjRsQzMw?=
 =?utf-8?B?cm5TVytjcmRSM1h5Y05PQ1ZjNEoybGwxNXpLNE5GSUEyY0tlQjg4WjJCYlpE?=
 =?utf-8?B?dEV0YW8xOFNpeVQzWUFXR0k2OFRRaGpvTThTNFR0TWgyc29namg0TXoyKzgw?=
 =?utf-8?B?a3h1aXZzV2c5eFdhSVZsQW9ZUU05WlFBLzkvRjd1NGxSV0VNNDF0aWprTGpl?=
 =?utf-8?B?eEZiUDRNNzBFUVNoS05FaXc4NTZNK3JtZjZyR0JKa012Q1cwQlREOFhoRk9N?=
 =?utf-8?B?bG9BMXlLN0NDdmpkV0l5Ti9Xb1BuZkNxZlVSQy9odC9HeGFrd0dGQm1pUUlF?=
 =?utf-8?B?NVNiNmtJRUl3V05FSmtWZENCWHE3WWRrblpIWVhtWXRMRHpSbmVpR21MVGNQ?=
 =?utf-8?B?ZEppVzN2ZjRmNEUxU2YrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHlRZlcrYjEybGEwSUFUbW9PRnJudTFJdUNzcE14QnRrZUtUWFVnSlQyQzRO?=
 =?utf-8?B?azFNMGJSK0FJUEdrZ0d3QmN6RFlaQURMdElicTRMYVFHU0Fsc2ZlYUlkZzRO?=
 =?utf-8?B?c1A0VzRxUWd6SFl3OFlZZU43d1QyWm9VdGI4ejJubVBJSTRMQ21zTGNyZklU?=
 =?utf-8?B?R1dKWlB1TjY0ckI4Zk8yVFlneGFQU3RBRXRHZ0w5Q3hNaHNLTDRmUUJCYmk2?=
 =?utf-8?B?eWN0WEF5alBtQWhUdXFrK0ZCWmt4d0MrM0hhcDJYNW4vNk1KaGFLK2NIMWVT?=
 =?utf-8?B?Tk9KbmpEN2c3YWNSYkxRUlEySDdGejFlVytCYUZRN1hpUXIrdnJrSHNiVDgr?=
 =?utf-8?B?TWNhOS9qNUcwb1Z4ZlNsbUFYYlRxeVNXQmhqZ0llTFFzcCtJaHhFcWUxMWh6?=
 =?utf-8?B?ckRrUUZLT2RLMzFiaExDLzd3cWJIdjVUK0J6RVhlcS9sMU9IT3pLZy82bmM0?=
 =?utf-8?B?VVhKRkRjRDJmT1ZTaytzc2Vtbm10bFJBb0RrK25yUy95eGtnY3ZVdi9uT2dl?=
 =?utf-8?B?dHdZQlJoVU9ydHA2VlNEcTFJZncrNnNwTWZuRzJ3c0JUd3ZLVzd5T3VEV2l4?=
 =?utf-8?B?Vk4zL2ROcTVidjRWVlZOWjd4eFArQTBGV2gyTW5VeDlQZkt0R3M0cWpLblh1?=
 =?utf-8?B?aGJNZTgrMlZIMS9lUkszNlNBa2xucTRvaWN4YjVGcks4ZUx4VTdVamd5Tm1X?=
 =?utf-8?B?d1RaMjdvY0JvWFBheGVRRUlQa0hhejlYVXQvSWRoZm5aS0JyYlBaVjVlV3M5?=
 =?utf-8?B?aDg2cERiallBcXhDQThKbW1INHJEbWc2eEFsTksrR2RnZEZiNjFER0Z2dTkr?=
 =?utf-8?B?cHpzSkxxNzRZYzBpd0lQVzloaDdzb091VWhXTzl3MXdZdzV1ZjRqYnZFT3ZU?=
 =?utf-8?B?ejA3bmIvbTFSU3hSUThodU82U01wQmpNUThYM1Y2d2VKckpuM2c1NEZVVllI?=
 =?utf-8?B?SktUUHRjOE5WZUI4R2JHTlRmYklBSmVFbzRjcDVQa0Y4K3FzMzBmNGx2bUw2?=
 =?utf-8?B?WVBXZTduc0hIS2J2UmNlcTE3dFc4S0M4bnRycysvdTV1c1Q2dEpzaUJoNWx0?=
 =?utf-8?B?dm1ZL1RIdUpmWEZzTDV1QTdYYlJnTWFBU09kaXdveEdObjBuS3Rydk14UWFI?=
 =?utf-8?B?YjBOSi9YZlhrQm90aExhUUlNcFk0RDlTRmEzT1VhQzlTdnh6bDlRdDZ2bFdm?=
 =?utf-8?B?VDVpZUY1dkd5dytIOEVKVnBsSDFOc2RQS0FrSTJsWlV3Rks4Wlk2R1ZNbDlN?=
 =?utf-8?B?RVR6ays1a2VwcDZaeDZ5bmNWbTFzUWxUNnAwdFN6Q3FleW56VUx1eTBZdXRm?=
 =?utf-8?B?WnRtQVU3TG1tVmR6T1duNkY1QUIwTzRwQlBxc3EyTEthcTBXRFJqeXg0d01r?=
 =?utf-8?B?N1pYNmlrL1Zlam5IUG5GcTExMTkrUENtc21MaWNKOGFaNEhqSHpDeVhpK1JN?=
 =?utf-8?B?OStLdS96NnJqVWdIS3o2ZVlZY3NRZElsem1UMXUwMk8rM0pUNzVwTlRwL3FY?=
 =?utf-8?B?TlpqbURuUU0rcWtEVlNxU3NwK291QVJrOTlCQWRuYUlVcHVrcTAvS0N5ZUlB?=
 =?utf-8?B?NmdQWWxDTzg1TVdSM0dqM0dBcU44MFU5S3c1TWtoNHBGSGtvMml3L3AwOXNF?=
 =?utf-8?B?Q0t2QmpTWEZGMktXK2Y4cXdOVVY1R0d6WDU1eVEwLzVOTEg3bXZDWUtzeGlZ?=
 =?utf-8?B?dU53UEtGVmFvdDI1elNqYzRsSmIyS0VRQTVmT2V4eXJUQzhBYUxiVzAzK083?=
 =?utf-8?B?WUU4LysxZE9UZngwTC9ZRzdiWDlNTStXTUxuWjNRNFBEYVpvdUxNaVRYS1Rn?=
 =?utf-8?B?M2g0aE12eUE5dzd0TjZsSm1IcGNvZk1TM1Vua1ZTVCswU0ZBM1pPNlZEVWlv?=
 =?utf-8?B?S1RXbWZqMGk2VEdaUFlRUmpaUlFJZC9GWmllUFZhRGJGZXg3M3JCcGpJb2w0?=
 =?utf-8?B?bFlLckVZSlgrbFRxZzBIa2JZdnVUaURPU2diSTRSWXkxa3dUSVNBRjZyYmFk?=
 =?utf-8?B?Y1ZyNmpPb1lRMmtQWlRXSDRqc3ZSRE5iZ1FObERGZHdmV09MQlcyR3NxRkpP?=
 =?utf-8?B?R2FqSlVlVDJsWTUzbVE0RzhYak8rYmZzcExKZ0VhakphLzhnSXhyMXBjTHRN?=
 =?utf-8?B?UHQ3Ti9OUHF0S3JVdFNvL2N3Q2N1UVRqVzV4cGhEL3ZLN1I4L0M5MjdVSXRG?=
 =?utf-8?Q?2+cjN9GPhtBrSPeUt1V/0eE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db940679-bf6e-49c1-6f2e-08dccb163f98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:12:39.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JCuHr6HCvTnnr12igbU6JmWpOl+0KOjpeOnAQy5KNENpGyfrX9Qhry9QxVYCWDlWGeBkJKVa/vzmqWhvnuG60GQiRjLnrSFq45DTOonV5DeREJ/YMhSqzAmBtZmx1NM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7132



On 30-08-2024 03:28 pm, James Clark wrote:
> 
> 
> On 23/08/2024 10:57 am, Ganapatrao Kulkarni wrote:
>>
>> Hi James/Mike,
>>
>> On 23-08-2024 02:33 pm, James Clark wrote:
>>>
>>>
>>> On 19/08/2024 11:59 am, Mike Leach wrote:
>>>> Hi,
>>>>
>>>> A new branch of OpenCSD is available - 
>>>> ocsd-consistency-checks-1.5.4-rc1
>>>>
>>>> Testing I managed to do confirms the N atom on unconditional branches
>>>> appear to work. I do not have a test case for the range
>>>> discontinuities.
>>>>
>>>> The checks are enabled using operation flags on decoder creation. See
>>>> the docs for details.
>>>>
>>>> Mike
>>>>
>>>
>>> Hi Mike,
>>>
>>> I tested the new OpenCSD and I don't see the error anymore in the
>>> disassembly script. I'm not sure if we need to go any further and add
>>> the backwards check, it looks like just a later symptom and the checks
>>> that you've added already prevent it.
>>>
>>> If you release a new version I can send the perf patch. I was going to
>>> use these flags if that looks right to you? As far as I know that's the
>>> set that can be always on and won't fail on bad hardware?
>>>
>>> I also assumed that ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK can be given even
>>> for etmv3 and it's just a nop?
>>>
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c 
>>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index e917985bbbe6..90967fd807e6 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct 
>>> cs_etm_decoder_params *d_params,
>>>                  return 0;
>>>
>>>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>>> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
>>> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
>>> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | 
>>> OCSD_OPFLG_CHK_RANGE_CONTINUE |
>>> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
>>> +#endif
>>>                  if (ocsd_dt_create_decoder(decoder->dcd_tree,
>>>                                             decoder->decoder_name,
>>> -                                          OCSD_CREATE_FLG_FULL_DECODER,
>>> +                                          decode_flags,
>>>                                             trace_config, &csid))
>>>                          return -1;
>>>
>>
>> I tried Mike's branch with above James's patch and still the segfault 
>> is happening to us.
>>
> 
> Looks like the Perf bug is only on the timestamped decode path, you can 
> force timeless as a workaround. Timestamps aren't used by the 
> disassembly script anyway:
> 
>    --itrace=Zb
> 
> Full command:
> 
>    perf script -i ./kcore -s python:tools/perf/scripts/python/arm-cs-\
>       trace-disasm.py --itrace=Zb -- -k ./kcore/kcore_dir/kcore
> 

Thanks James, I could run without any issue with "--itrace=Zb"

> You can also disable timestamps when recording then you don't need the 
> itrace option. This will save you a lot of data anyway.
> 
> But I'm still working on the proper fix.
Thanks.

-- 
Thanks,
Ganapat/GK

