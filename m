Return-Path: <linux-kernel+bounces-279340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A194BC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A3C1F21EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F810F9;
	Thu,  8 Aug 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="I7MV3xan"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020117.outbound.protection.outlook.com [52.101.56.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C1146584
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115702; cv=fail; b=MI7sY0AlxywUEyqEYuCvy1GXxPGCfY8fduDK5Kgd4GOfW3knUc91vseQi0ptDEMvdCzsBGXaa4IMOSYlW9+gY5d8amlXSkaBeYpI+RJYKyLqKC9XYR8wrHY9XlfLyskb4vPlBvMExFCIhgLXbA2hD/vmEKhnWMAIwOmyNZC28qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115702; c=relaxed/simple;
	bh=mOSxOIv/9zAofpNIMBF1fRLXyluDndFwM9ojfj68ctg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxQn4Po9LsdkdVu0++T+BvSyQUe6+2ag/PX3kLGg98luDfIp4T0nGw7ggNq5ZsB4F14+zIprxpWF/zjXbBg5Fjfo5B2A09ikgB/01ePwH57y/npAUhO9eo79GBVMR7Aektx5Qgj3LCWJaHmQ9gJNN7tmp/qX1vfWeWAeCRyzJMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=I7MV3xan; arc=fail smtp.client-ip=52.101.56.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KokB+tJrxc90q6b7L/d2j/h+vJvDU/clFIA1tvAR7kkjHEPwBcyKSIEjFU6axFIGZne6xbcKIDJsHU3H9vrfDG+uW4S3APT76jClezLoj5krx2f5P6wecWVRnumNuQWBkDEJW8UqzSVDDVbhJZiVdWKSJZs4SETqRCX3JfM5o1+JjaQRgwhvz2Gmcke4TU739xMlJdxwaMF6etWm8NThIx06/QRMni4diuuUd+wIqpHBtSrkS3wie+xr4FmWs9d/gk4+IWhN4JnMu2xTWw2PXfqKzqhq+PiEwJeX7Q0Nssp3exkD5S4/6NVmMBWilNSWNO5AVNMpgq+ExFjFPpxLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyxiIO3xBlOnTzSRuCYStxoycyaqp9aMBc4nFTko3CE=;
 b=ndUTRSAPsL9iD8n9AvOFghNlLgeaAiPyXsFqJxtF6M8nmOBC6NfiyZHRVj6OfdZpEbRUOKhqm9bh+1Iz/LgpaynDgL/WbpmI5Py1Cc/LQaCL5P1tFTqwTJWgVHrj7ymM5+gfxIAsBnm3fsyPMPn2/qFV7a3khMv6fqaXpVy8n5l6HAC3Lq2VDkX1JlFXWwh7ITQ0pvsaG79+5QDqxwNu/Gq0Xl3UVdP7QSubxx+53BzANU2TEulCYYkAKHzcbi/vsd9qbvK8HjeX782yuBMVPg6HMBtihAfDOsU83D+wApZexhc3YwVwftoGjDwxoeAi+QfX/uD7DskwO6udCS5YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyxiIO3xBlOnTzSRuCYStxoycyaqp9aMBc4nFTko3CE=;
 b=I7MV3xan/MuTHI58+0VWfnZL2vbsI8vf+eh0mfwK17fXnSY1cDIQkebaFd4mquPVP+z/ZbbJmB9Ml7STr03xkphriQeZudf7jxrpZwlsrxRvsLNgSBDkQFhF6YlmiIDDv/cSdnssWGAnpK+45yiKZpim+8vtWPKcgzq8LFxpSj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8174.prod.exchangelabs.com (2603:10b6:a03:4f9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Thu, 8 Aug 2024 11:14:57 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 11:14:56 +0000
Message-ID: <3ef38bf2-39df-47c6-aa6a-7e65d3909564@os.amperecomputing.com>
Date: Thu, 8 Aug 2024 16:44:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 scclevenger@os.amperecomputing.com
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, james.clark@arm.com, suzuki.poulose@arm.com,
 Al.Grant@arm.com, Mike Leach <mike.leach@linaro.org>
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
 <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
 <00fac24c-d664-4ebb-8c60-f4697b7f76c1@linaro.org>
 <8b53a424-19f7-4042-a2db-e1c5d051f9cc@os.amperecomputing.com>
 <6adf84fa-b755-4d7a-957a-9bf01e442238@linaro.org>
 <d71dff17-6f1e-4a67-89c6-7ecc86af0f3a@linaro.org>
 <6f535bb6-2cee-48e6-93f1-ea19887bae74@os.amperecomputing.com>
 <027c76a9-9bd4-43e9-a170-8391a0037291@linaro.org>
 <3d7a6f93-0555-48fa-99cb-bf26b53c2da5@os.amperecomputing.com>
 <d6170beb-754e-4be3-8ff7-18acddccf077@linaro.org>
 <4ba157c2-4a56-4d77-9a15-071e46adc33b@os.amperecomputing.com>
 <d3c86965-090b-41c5-85a9-187704754072@arm.com>
 <915fefb2-b0bc-4306-83ec-22570719e8e4@os.amperecomputing.com>
 <d34d402c-7765-41be-8a7c-b9d564c5bedb@arm.com>
 <2c0cd5b7-1ca6-4088-817c-209026266d58@linaro.org>
 <16ea091e-0f3b-44cf-b3b4-b07efabe9c02@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <16ea091e-0f3b-44cf-b3b4-b07efabe9c02@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0360b7-d620-4039-3d40-08dcb79b55b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTNXQTJrbkZMRmEwdUhJaVZ0TGh0WGR6eUM0NTRJbVUvUmVTblNxTktwbldW?=
 =?utf-8?B?ck1vWkhjNml4L0ZoeWNlV1JFUjEzQWxOQWUrQlNSTmlFbEp0Rm16VXFvb2hT?=
 =?utf-8?B?SkkxbWpvUmhUQmlvY1ZwTjNEMVlmc28wTStyT0xsMmlLZFFUc3dlT1ltRUFp?=
 =?utf-8?B?WFhPVFg4ZWtlRElGdWRIZElva2s3SllXKytwTGd5TUp5RXhZWmxsc0IzRFVW?=
 =?utf-8?B?SnVPa1UwU1JaaXRSVzRRNUN6MXdrY1dnejJaWnNYZjZDY29rT1R6cys5SUcv?=
 =?utf-8?B?QTd3cTVkL2FaSXJpUjVlNDJIcDc4UWo1b3hHZUk5YVNUU21KK3JTVlVBUkNz?=
 =?utf-8?B?ZGMwU1NiZ0FxSTJUMkgxcU9jRHhibHFwaDltRk1CamxFSmRNa09KajNsTHN5?=
 =?utf-8?B?L2p0SHJCckhHV2t4dHpwQzFqSXhCQzBnaWtjdGlKV3kwR3A4REh3elZsMk9W?=
 =?utf-8?B?V0VkR0F1a09BQnZJR05ldE9tKzVtVDkzZ0JoVEJDbFpUejBDaWFnNXlZbHY2?=
 =?utf-8?B?NExRVmxmRnFIbmV4NWVZNTJ3aENlcGVITjFjSHRIZVZwS1hhNlAyeHJYN2xp?=
 =?utf-8?B?WENTTkRISXNNZEdpVDRQdVZTNkZOSVQvWVpmZ0F6M1JpakZVeEVCV01sVEc5?=
 =?utf-8?B?Yi9sNmZwS25qZUxHS0RZRlZLZzJKTDNDSDBDOCtvQStBTzVUNDFBQ1YvY1do?=
 =?utf-8?B?SGw5RFU5TGxGZEVKbWdSYTFkMnU2Q1pXejJqalBjK1ZnaUtGWWlzQTBtQlFw?=
 =?utf-8?B?QlJnZi9oOWVCc1Q0WEdQVjlNQVFYeCtwK2xTTXEzNEZUS0RkNHl1NHhqWGF4?=
 =?utf-8?B?RTNOR2FjSDI4RXZJTnBNU0VsalYwZEtqcFUzMXRiQk1NZWxSL2diS0FIU3Jy?=
 =?utf-8?B?Q3ZxcjByU1hId0N0dmQyMmpybHF3cC8weVdSOXlNbHVzVU1QWG9oZy81SkFC?=
 =?utf-8?B?aENVdHRhcEswSjFyQkxISDFnbm9rMkVVaktkYUVQOEh6NzhnYzdGZGd3NjlZ?=
 =?utf-8?B?T2RnOXVTWDlFTFQyaTFTUzVObzBuME9LR0NUeTlIRW1uTUJnQlZlZlZFZFIz?=
 =?utf-8?B?bXl3S01XcFArMzYzeEY3U3Q0R3R0blAvbktqZjlvRkdVTGdUUjJqMzhqaWNa?=
 =?utf-8?B?QXU5UWQ2ek40eFZpb1FDMlJSSUFhYXBaUktEYzZrKzAyaHpsZmZkSFdSMDM5?=
 =?utf-8?B?MlI5citPeGVmR3ZhZ0pzODE4MEpTN24wek01M2pQUXdnU2RkRkdmMjU0VUMv?=
 =?utf-8?B?YjRJRHVreW0yYkF1U0N3RXZ5NVg2NXlvR29jNTQ5ZzZDUy81UmxCWjIrRCsr?=
 =?utf-8?B?YVRmRGljdU5NZ0tKa2ZBU0pkME5hUW5qMWpTZzY4SFducHdBMnFMaDFGNFlN?=
 =?utf-8?B?K2FVMlhDdFdodnQrMDYvVGxZR0NKN3d0djFlakozMUFUWUh5TDNlK3NSbVV5?=
 =?utf-8?B?RnpUaXpEMnpHT09YRkN6ay9hSmVIQllDZjFRZXdGOWJQbGdmS0F4SDhMak5Q?=
 =?utf-8?B?M2U2c1BGbk9iOTduaEhRK3ByaEsza3VTUlJaL3I5c0dKandxYWFLU2hKcWxm?=
 =?utf-8?B?MTJLVWtvWnd4eUJkOEFZOU8yWTluOEZKYVpza0hrQjd3aUMzbEtZb0lmdFA5?=
 =?utf-8?B?dFdzZTIzbUxUK3JXQW4vaUZhT2J0R0tvUXZudEFTUm9xbFhmWlBUdW9paUty?=
 =?utf-8?B?UVlQVGdaWWk4Z1RTSkxRamY2aEdIc2pIOXF1bGx4aXZXVlF6cGZZUHdYY2xM?=
 =?utf-8?B?bmtCVzg2RGpvbkYxUjlWUGlKcG15RCtIb1RjMkZtWko4WkZPZ0V3ZFZFVUhO?=
 =?utf-8?B?OURsK1U5SzhHTDFxR2ltQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFY4bmcxNCthT29tRDl4TFkxazZGTWYzUWNDTlRiVFA5eEdpSzdQZXkrMmli?=
 =?utf-8?B?bHRHQWkwZXoyemVxU3pzUUNmWnc5VDVMOW0yUUxMdzY2U2xWZGZGRElpTHNv?=
 =?utf-8?B?TG80a25NYmZ4VFJ2VHBIS2M5eFpxajR6SVFxRHp0eUQzSzNqZHo5REtNaTJJ?=
 =?utf-8?B?a0NTb2dCZVlSdnpsYkwvL3U3eVhzbTZrQU1xb3IrV2lEdWc2LzJDT3NQakV0?=
 =?utf-8?B?Y3d4NllkOUJycmMvWEYzME4xaGFIY2xDNHV0Ui80eG5CR0dERnFXVm9ZUUF0?=
 =?utf-8?B?ZjgzNWV3MnZuQ29zYjgwZFhCYlFxV3FYdVZWdk9JRVpRTDE1L1RDdkdveU1v?=
 =?utf-8?B?VloyUE9pQTBqTmdvck82UTNyMGdnRGZSSnQ3aE9lRVpqL09QMDRSWGVBNTNp?=
 =?utf-8?B?V1d3YStobGpZVG5GUVZzUFVYSUhlcHZUcUFOSWltcGlsUzJKQXMrdzdkRitt?=
 =?utf-8?B?OXA1WFFmekw2Sndqc3FJQ1VQQ0lQWWRiUmV3dytvaVhKT1JJcnlOZ01BQ1hU?=
 =?utf-8?B?S0NxOG5KenAybFJOQysxVmV0U2trRnRGeStSa05QbDBrQmVodlNKRmUyVUlO?=
 =?utf-8?B?UHdXVExVRDdXZVNPcEYyZEhablI3SjVxNlpMVy8xYnJzNkJSMFlrRlBWSUps?=
 =?utf-8?B?TkNPazFseEVCZDNNU2V4bll1ZHVnY3lkVCtrWkhlc3lZSW8zOXh4QVVVSVN4?=
 =?utf-8?B?Qnozc2l6MVJWVjZ0K2EzMSsvRWszRzQ2VGJDbUh3OEtGWVl6VytmQjNZeitC?=
 =?utf-8?B?alZ1eGtzZmJZT2dlamI5YURmMDZucm5pUnZvTk80aS9DSTAra3AyZVdHMnFK?=
 =?utf-8?B?elJ6UXhLK1JPVzVzMUNrWUx5ZlcvOU1EaHI2WEZrdE8wY3dDT0NpNjRtQ3Q1?=
 =?utf-8?B?eVgvbVYxY0xWMkswRWtybkFSdWlkZUVja3VsdHVROUpTQ2o2QWtRdG1TRmZ3?=
 =?utf-8?B?SnVPTVBUODE5M252SWJPdkcyTUt6V09CeWRkVWlqWnhrdTZuWFBaUklWSlB2?=
 =?utf-8?B?VDVkVXdZdXNVN2RORWYwVEU3a1ZmY2s5UVJOWWs5ZElJQjE5ZFVKcGRTcHVJ?=
 =?utf-8?B?bEN1Mmp1ZzFZeW52WE5YS05DUzhSalZHWWgyL1U3QzJNcWxxaEVNenNNWGky?=
 =?utf-8?B?cUhOYkUxYmNZbktyVW1XaG93Zkd4Y3N3MkFKUThuWGRhay9NMFN6cWNNMEt1?=
 =?utf-8?B?MXVyc29xSWRDdjFDYmhtbWNXb2x0MVcrVVg2dlc2clBoWGE5ZjNKNGpUSUJ5?=
 =?utf-8?B?Y1F5MmhUN2dBY25CY3Jvb09hVndXM2xIR00zSlBYVHZueDdxcUNLTEI5ZGhj?=
 =?utf-8?B?L1M2Z3VuR09IclRwWDh5a201MVF0UVM2Tk42eE9XcmpMeEhiV2l4ZjhNNVJU?=
 =?utf-8?B?NDBBYlh0YUUyNmhvOG9NcHp2dnE3TjJmeEFLbm9KZ29nekRwemQ0TXQvUE9j?=
 =?utf-8?B?dEZkS3VZVkpneVJQeWxTSmJmWlhtSUEvVllPM1A2Kzl0N1NwSnJqZ0JwNjhZ?=
 =?utf-8?B?YkJVUzNuN1lkWWtjZSsvZEVYN2tSVFNpa2s1Z2p3OFNBMlZiaWx6MDRYaVJk?=
 =?utf-8?B?a0lwWWU0eDlUbHZwcis0VUVPN3ZwTWlzeEJwWXpCT1JwN21Qbm9OR093ZUlp?=
 =?utf-8?B?dy9VUjJNTXB5UkdHUnZ0Sml2RFpQOVhaeWdvL1ZjbU85WDlnYXc0dVZGV3VE?=
 =?utf-8?B?RnZ1UDMvbUdpdjNsZkhyMmp1WGdSZEpmMEVSelJYV2NBdGpsVWFOK1FSWGRo?=
 =?utf-8?B?eDVacFhBR3VOWTNvd2x2NHZYS2RzQ2wzRzRnV3duaDdsVC9SeXg0b05OMEdE?=
 =?utf-8?B?bmZBZGdkUGhsNmxrNkliREU3akpYQkZJOWRIQVh2cVQ5WXBnaHQxdFZiZTY4?=
 =?utf-8?B?VEFQOXdpbjlqMGdkUGttNE96LzV2RC9wbzJ2OWRmSnNiS3hRcE4xcVd4UGdm?=
 =?utf-8?B?cXE4dncyUmdmeFA3dVFqM3RPQ3RBQzZEeDVTUVgvUGNHU3BKZFdzYTFaOXBF?=
 =?utf-8?B?cm1XNm9JMWtqektTTHRMTFdMelg0U2hLQTJOSE9HRWhTQVAxMS9GYzJBSmhW?=
 =?utf-8?B?NHdzS0tCMnRBL2JKMXl4eDhTbHlUS2hNaTQ5d2d6enFuTlVQRFo5ZW5uM01h?=
 =?utf-8?B?MmorZGJCbUt3aEg1YVQ5UXpBTjJ5N01lVDRud1JyLzEyUWRhcm1GL0p5aGwy?=
 =?utf-8?Q?sRzr71BF5gM2798DekL3tTmVIUk//g8yUuj0SBwfiadJ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0360b7-d620-4039-3d40-08dcb79b55b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 11:14:56.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF8PlnH8Wg0hwjvFkY26hLhayeUSbCAfr32KJjsezlopQaFTQaq2859KvmJzVlak8gdN9ykogXvfCWdRwUx5TeYJfHt9FI4X5jLsMcIc3orfN1lIwuqEyN63MOoQuFaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8174



On 08-08-2024 04:21 pm, James Clark wrote:
> 
> 
> On 08/08/2024 10:21 am, James Clark wrote:
>>
>>
>> On 08/08/2024 8:42 am, Leo Yan wrote:
>>> On 8/8/2024 5:36 AM, Ganapatrao Kulkarni wrote:
>>>>
>>>> On 08-08-2024 12:50 am, Leo Yan wrote:
>>>>> On 8/7/2024 5:18 PM, Ganapatrao Kulkarni wrote:
>>>>>
>>>>>> Is below diff with force option looks good?
>>>>>>
>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> index d973c2baed1c..efe34f308beb 100755
>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>> @@ -36,7 +36,10 @@ option_list = [
>>>>>>                       help="Set path to objdump executable file"),
>>>>>>           make_option("-v", "--verbose", dest="verbose",
>>>>>>                       action="store_true", default=False,
>>>>>> -                   help="Enable debugging log")
>>>>>> +                   help="Enable debugging log"),
>>>>>> +       make_option("-f", "--force", dest="force",
>>>>>> +                   action="store_true", default=False,
>>>>>> +                   help="Force decoder to continue")
>>>>>>    ]
>>>>>>
>>>>>>    parser = OptionParser(option_list=option_list)
>>>>>> @@ -257,6 +260,12 @@ def process_event(param_dict):
>>>>>>                   print("Stop address 0x%x is out of range [ 0x%x 
>>>>>> .. 0x%x
>>>>>> ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>>>>>>                   return
>>>>>>
>>>>>> +       if (stop_addr < start_addr):
>>>>>> +               if (options.verbose == True or options.force):
>>>>>> +                       print("Packet Discontinuity detected 
>>>>>> [stop_add:0x%x start_addr:0x%x ] for dso %s" % (stop_addr, 
>>>>>> start_addr, dso))
>>
>> The options.force for the print should be "options.verbose or not 
>> options.force" I think? You want to print the error until the user 
>> adds -f, then hide it. Unless verbose is on.
>>
>>>>>> +               if (options.force):
>>>>>> +                       return
>>
>> Oops I had this one the wrong way around in my example. This way is 
>> correct.
>>
>>>>>
>>>>> I struggled a bit for the code - it is confused that force mode 
>>>>> bails out
>>>>> and the non-force mode continues to run. I prefer to always bail 
>>>>> out for
>>>>> the discontinuity case, as it is pointless to continue in this case.
>>>>
>>>> Kept bail out with force option since I though it is not good to hide
>>>> the error in normal use, otherwise we never able to notice this 
>>>> error in
>>>> the future and it becomes default hidden. Eventually this error should
>>>> be fixed.
>>>
>>> As James said, the issue should be fixed in OpenCSD or Perf decoding 
>>> flow.
>>>
>>> Thus, perf tool should be tolerant errors - report warning and drop
>>> discontinuous samples. This would be easier for developers later if face
>>> the same issue, they don't need to spend time to locate issue and 
>>> struggle
>>> for overriding the error.
>>>
>>> If you prefer to use force option, it might be better to give 
>>> reasoning and
>>> *suggestion* in one go, something like:
>>>
>>>      if (stop_addr < start_addr):
>>>         print("Packet Discontinuity detected [stop_add:0x%x 
>>> start_addr:0x%x ] for dso %s" % (stop_addr, start_addr, dso))
>>>         print("Use option '-f' following the script for force mode"
>>>         if (options.force)
>>>             return
>>>
>>> Either way is fine for me. Thanks a lot for taking time on the issue.
>>>
>>> Leo
>>
>> But your diff looks good Ganapat, I think send a patch with Leo's 
>> extra help message added and the first force flipped.
> 
> One other small detail about Leo's suggestion print out. Can you add an 
> instruction of how to keep the warnings as well:
> 
>    print("Use option '-f' following the script for force mode. Add '-v' \
>      to continue printing decode warnings.")
>

Thanks James and Leo for your comments.
I will send the V2 with the changes as discussed.

Thanks.
Ganapat


