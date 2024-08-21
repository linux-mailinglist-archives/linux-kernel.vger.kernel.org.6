Return-Path: <linux-kernel+bounces-295602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D5959EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490D3281711
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178461AD5C4;
	Wed, 21 Aug 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTyoyRqP"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14FD1A4ACE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247479; cv=fail; b=kk5WkOK5HUfOHfzyUJzVj22UaQodXsl2OS2eIbT77W6CQikW1ua2fcMGe+soVoGfoPGdo8pbRuxDBu29o/hHsP/wlTHjBN/N0MKnEzBi8JZMn6Sa/n3Vwc7yCnzU2vaofKR1ekaKxtvaZSIJtNgbxLAL5kFH63Ku71VQZ0HbaRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247479; c=relaxed/simple;
	bh=pRjkhlhObSV8R3x2DdM9bpawUnKlVYkFs/DCwei3H5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UfA3uUEdWc933uHcmBNure2ykImZ/ufHFCNuFfsmW0l+p6PUWmX3iB5WTqr0oq9ZBh3eG7+lIA8TZjkCAC4NaxrMWnKscyn114pVTc3Cbb6vuqGfDu8sZexzlyrZsc+2vgohyh7JtceQgN4QxBdmroT5HkUKiGHpH9b4NCTkX3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTyoyRqP; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6kt9OLoRqCtrPMfAh7R6/5F9xBPADtKVaAIZhPPTeqMeuqllcGTgj7Qorruz92OlS+bFeaF8ZPH9j8Sulx5GlxurPMGVvHBcbwzd05edCOdPWm6j8BqM03S5agWg48scl0qwg9Z9EeLl0VDDI3VDrxvt8uRPRP/B7vtiPYQySsQkIUOyfNutITAb+wscGAp9NFwNxkgEljWeyHzbqjAsrIU4cH5TxazxUYVqaQ85wzPynGQXSRGz6RCz770usQ5oET6nE6KSSQ3K+GRWNOS1a2h86E5j2iqt4NDvt8qEeRDyQOCGju7+OxFev9qpp9DUy892QyQ7iokyceQITD37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8wYdjjatPyP4W7+H+GY+0MsPsWbi1zBBMf2RAngghU=;
 b=IPiPoGdHQXWFngsI1lUftWi/oIuZFCNwc489nydlCFziig2oxpxy4KFoi1f72wt5TBn08QvPmCHFHzKEM82HAE78I0fhFcxRNTnaNixMXWbTOgpZt6ZFn9ED70yLdIyAGCtI749a0lkg+eAebq7blsDL3PtRNJ2RqY0d5V7JMaLJF1/MOvO2rugoRSwJHpTqzHhlCXkk+CuzFU+HuXG1bGFgJaxjoRWiftMl4Xulo8DUAqK5Z7kwK5ESXfOrutiKRU3PSp/gTPVKWiqLQX9Lq7V4lYcleaYvHh6969e7J8ukzMkVATp50eUEHE5xOAPdYPYPMVvulOoai8vLyev9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8wYdjjatPyP4W7+H+GY+0MsPsWbi1zBBMf2RAngghU=;
 b=BTyoyRqPAWPemIHw+CP42mmb9A+5FTEAErLEnbfRTqOtIKmuif3hBUlswvGv7USLwGRzfE3hqawug1bLlzTi5EwtQSrdogYJW/6TOVp4cpliMtzGOwdw1CR9Aj3LSJUD+kSVFUk9byvopRS+8U//+OchU9g8CJkeemyv5Xn7B+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 13:37:52 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 13:37:52 +0000
Message-ID: <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
Date: Wed, 21 Aug 2024 19:07:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C
 Support List
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 629c7686-d878-43a7-7c9b-08dcc1e674ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdvVU9BekE5THMxekZYSFZrZzdoWWIzTlFsRTVqQU9JNHZqaDRLVFVSenh6?=
 =?utf-8?B?YndEalRUcndKQktSZ3h6U3laajNKZ1pKTkE1ZWUyNWxLeStVMlBRajc5MU8y?=
 =?utf-8?B?a2psZTFDdWh5d3FnT1dXMWEwV2JzWmdWeCtieFRnUndYMW90V1VFUmE5bXJU?=
 =?utf-8?B?dTJ0bVphZkJUNU9SbDdzVk4veTF6bldSN0gzclBlektoeHBWYmRteDRHVnlR?=
 =?utf-8?B?emsrYno1R3orZWw1VTI1RTNkK1p1dkx6WVlXVklsZ0lSenhTU1VKcEhhNWtW?=
 =?utf-8?B?ZktMbWVxT1hlejJwVlhBV0xndG4reEZ0WU1sa2lCVUhFM05PV1E5TTZaMUgv?=
 =?utf-8?B?ZUQySE01YnpLaDNXZ294TENOaVhTbkJGKzZpWjdCWThRaS85azg1N2xnVXRJ?=
 =?utf-8?B?T3dRN1dJbTN0ckI1TE10ZmQ2dFVyZlIvc1hyWVdhVXRac0ZsaUc4VXpwVjJB?=
 =?utf-8?B?eW0yVmVyWjFPT2VoZy9lSERXZExpLzR4dThXeFNEQmorc2t6cVdqZjhiR29O?=
 =?utf-8?B?QXVwbWxjZzNQVWRHVHNhaDR2TTBEQWtVVS9oS3orOW90UDdjeHRyZXNSRDZw?=
 =?utf-8?B?ajNnaFU2UGpFa2FZbGZTaEowQXAwaktjTGljVHZ5Y2tyUDRhNHhnVEJzbzE4?=
 =?utf-8?B?QXNmTlVKU01uQmRiT3ArM3ljMmVjbXBVbmpOYTVzWUJpYUhqVDh6c0Z5SG1E?=
 =?utf-8?B?L21ZWGFUREF3N01FT3M5MWlTeXFqQVg4cGlZNzNDcTRtR3dqRWpiMXZZdDJ1?=
 =?utf-8?B?QTl6SkpVemg5R3JqNTdwNEVzTFh0bFJxbVlKUzZtWjNWdE8vT1RhZ1haYUUw?=
 =?utf-8?B?K2htbnR6RHBRMUpDdXZCMGQzU1ZxVVdCTStIaG1RWUU5ekk1aU1Zd2tXZnNw?=
 =?utf-8?B?VWdVSlh6MUMzaUhoRmN0Y1BOL0hacUgwNjJvWmpDY211bGJ5NFJ3eEljTUtz?=
 =?utf-8?B?NXhQVlN0OXVsSEhqUTh4T01QMXNzSDBTRVMzMEt4K29QbFgxdjU3MnVHQ0tI?=
 =?utf-8?B?SXkvQTduSUZoTXlZUnJCSmNmQXdpZ3hkZFBqTzdpWTBVcFVoYWxlWHVsWkFZ?=
 =?utf-8?B?NkdWY1JETDRoVFRjUVJRRklSMEE5RnEvZjA0bnFlRWJmM0hQRDU5VTFuZ3Bn?=
 =?utf-8?B?T2dnV0YyVThHNFZnUm9hTjh1ZGMvVHZHS0lVd3gxaDhSMmF1Z0ttQUZ0R2Q1?=
 =?utf-8?B?YUJBMDFvcWhEZTYrbXdqd1pMRFR3Uk5qK2loUGJnNWdNZU5oaHE4dTF6Nzhk?=
 =?utf-8?B?RUdiWjNmVFh1WXFLRXhoc0lnOWlzVDlUSndNMVd0a2l3Wm5jdk1jdGdrTGF6?=
 =?utf-8?B?U2xJZmdWVC9rZWlHYTZLM0I1U1oxWklqNTNoNEtLNjRkMk9OUzAyQVgydmNS?=
 =?utf-8?B?RHBCNU5kNTJmYm1OUG03ZHo5UTRoNEVIdDF1bUd5eE5WckVnZXBtZURMclU2?=
 =?utf-8?B?aGRaa1BJUkhGWmVvdnNJS0REYmQvWHVwOTRsSGN3RnF6SGsvQ3BWOW0rYXJK?=
 =?utf-8?B?QlBiNFNZei9MSEwzVjFDcytUWlptQlVTeFVjV1dIRlRwbVFnWTNVL2doc0p3?=
 =?utf-8?B?SlFkZ2xLWjNETGk0VWZvNG5BbGxUYzRWcHFPTFhrZVNPVGtIbG5WVTJBUEZC?=
 =?utf-8?B?d2RQc0RIRHBhY1ErOGJrVWZoZ05sNUNHSXZKdk9jRjRRZFI3Q1UzeGgvaGNO?=
 =?utf-8?B?SUNtaXFnSU4zRDQrVzFxWCtsdDNNdXhBZUg4d3ZjN1B0UDRSbTN5aG9MM1dM?=
 =?utf-8?B?L2RFQVljNHhTOVNjOG1vMlpDMW9PNHN4NEY5VERVd21iUzcxYnVxdnBqQmhX?=
 =?utf-8?B?SlAzVDNqMlNyK1d6ckVqUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVVZdVNtUFhzS3BLNW13anJSSEZTaGY0VU1LM1BnRXQwZTV6emFFMFphTkZy?=
 =?utf-8?B?STlXNlRKby9aZExKU2dRTHpBRnY2U0hGNDVNSEtTdGIwWkVLc1B6L1FhVDdu?=
 =?utf-8?B?ZytLeGlEZzYwZld6V0x1RTBUMUZMSmFPb2IyU1JNaFZ6dVM0ZHdtYWRoWU5p?=
 =?utf-8?B?VTBLb3NodG5mLzdGalRDSTd4RC82YzFzcXhodGdYQThhbkkzaGhiaXk0aUh2?=
 =?utf-8?B?TUQwM2diRitZZy9naGtnQ3NNeE1CU1BrUm9YeUVJSEdlK2JCamZVWiswWFpD?=
 =?utf-8?B?aHh0TlNSc2xYNVZaTGJsd2RkZ2tieVYwTVFNMjZ5ajBuQWdHeDZnMnpUYVdt?=
 =?utf-8?B?d3lFRDdCOE5WTys5bzJaTnl4RTdNYnlRT3VqZGdJTld0YUtsREsrMTdCU1ZM?=
 =?utf-8?B?VXJ2Rkh1VDhzNDVCa3QvMWtjeFhNQzNLenplVFhvMTRIQWd3QzhTTWpQTHE0?=
 =?utf-8?B?VEM4VHR4Y0xReTJFUzZOUm9wbUxIZld0b0R6L2I0V2ZmK3dNaFhGaHJXZ0V3?=
 =?utf-8?B?VUVlcG1CekhDUjdwZXhjWGtJL09GQ2w2NHM4N3JsUTJCOHUwc3NmQ0lTb3Zm?=
 =?utf-8?B?R0NEZlZrM1RqVlM3cUVqdjlCazBER2laYTNRYzlTY0xQeEhaaDYyQVhVQkZt?=
 =?utf-8?B?RFBscFpZWGw2ODJGK3dGYkFYR3YzY3FEZndCaCt1aDVaYXlhQ01WSXVRait1?=
 =?utf-8?B?SnhiQXdUQS9aRjRyc2FBZlhpQWFwckRLYStWQWlmWFRxakV4UmtNT0dpdVBp?=
 =?utf-8?B?Ni9vcXpwMUJ4Z1dRUU1aTmorK2l4MitEa3I3K0hSdW5QS0tndjNISUwreTNW?=
 =?utf-8?B?b2FWY01XUDNvNGMySUowTnlza2VLZjhmWjFmakVmb1R2cUs4V3pNdFUvU1N5?=
 =?utf-8?B?YndiNTVVWUlpbkdKWmpzbDlhdE54Qi9yQ2Y1RWhSckMrd3o3ekVjYVZLQUNs?=
 =?utf-8?B?d1JmeFpwYmc5a24zTW9Fc0lNSGRTcmRLZGpwL1oxelV4d2lFblFMbkNOWm5m?=
 =?utf-8?B?clBFV0tTamdqalIrMHMxQTJkR0VyYWNxSDdLTERlMXczV0xEYkxaa3dzTUtk?=
 =?utf-8?B?UitoQ2EwWFQvUlhSNG1JZVNXMVNWd0RQR1FSYjMvcHpUeTA0bjd0RVRRRmVa?=
 =?utf-8?B?S3dxNTlzZzFWU3RydUN6aDlqbGRMNXNObThMV0diLzZHK3BaSnBRS2QwSHpC?=
 =?utf-8?B?Q1NXVVVwS3FwNHM4d0lNS0lpVjF0OXFuSC83ZC90UkxnNmlRSkJPVHJncFNr?=
 =?utf-8?B?Zzk1VW0wbEhmcWR4VHJVQ1RibmpFcWxubnluakcwZFY0MVkrY0FieTBLUzMw?=
 =?utf-8?B?cngxQzREM20ySmhQVkxPYzNxR0Q5dStJQ1RlK1pUZVk0aFNVTEN3MnZTcDlM?=
 =?utf-8?B?Q09sWGEyeFJ4clhYNElNekF1SC9JTmFLblp3T2NvM2xmbkhwVVVhVFo4YmF4?=
 =?utf-8?B?d3JvU0d4Sk1lNG9sRDA3TW5rcERuTW9vaDBQemZDaVQ3K29VNlE1NFA0RmNw?=
 =?utf-8?B?SU81VzhkamRKWVpURWhURGF5dzVtTzJIaXlBSS9RT3V2SnpSemRsanFVOC9M?=
 =?utf-8?B?TFk1bnhmK2wzQ3dRT2RFNHFLWEd2T0JFam1JOGlib0ozZjY1S09NVHMxQVdB?=
 =?utf-8?B?SEJnQzM5RWwyN0JBZUJUeEtzOEZBemxBUUFsWDQ0elkwM0YrMXFRbXJ5bGpK?=
 =?utf-8?B?dW53a3FIakl6eEh5QjdGUlYyM0N6cFhkeC9qYno3V2IvYS9pV3YwVEwveVZW?=
 =?utf-8?B?STkxcE5rbFk4V3oraEtMU2dJbnNwdmRFdDZEaG03V29qZGs5cG9FUWNVMVlG?=
 =?utf-8?B?eU5UQzQ4b3NEbC9QRStqRWd0cTJsNEJ2RVRvMG5KS2VhRVlMQjRhKzB4NkI1?=
 =?utf-8?B?azNMUENpTUVhNi9DR0RMYXR3RDJmQTU1NkloYnVTaWtucEovUFQ0Z3dFVFgr?=
 =?utf-8?B?NXlwOFRKMTNjMkNwdkEwcTRQK1laZStKdnlkY2VJSHhlalBEUkRoUDZWcjEy?=
 =?utf-8?B?RnVsTldJUkh0bS9aYlFCNmpya3BoNUt5bDRmUDU0M3NFcUNrMHl4MVNCeXEx?=
 =?utf-8?B?eGQwQ2VuNTVXQkJKakNTcGlnMk1oM1drcHkzNnhXL2dwZkwwZHJ3M2RTeTNT?=
 =?utf-8?Q?9YYLGa7mr4voM9A270NeeYR5u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629c7686-d878-43a7-7c9b-08dcc1e674ca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:37:52.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSF5b7tk5zFbcJtegrRxjVUtO1fT+Fom2Xq5naJMYSijEubTSRVyZ3YQKn7XPGsKt+mxKRSgnZHUlScXXNO1hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201

+ Andy

On 8/21/2024 19:05, Shyam Sundar S K wrote:
> The current driver code lacks the necessary plumbing for ACPI IDs,
> preventing the mipi-i3c-hci driver from being loaded on x86
> platforms that advertise I3C ACPI support.
> 
> This update adds the AMDI5017 ACPI ID to the list of supported IDs.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>  drivers/i3c/master/mipi-i3c-hci/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index 4e7d6a43ee9b..b02fbd7882f8 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -834,12 +834,19 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
>  
> +static const struct acpi_device_id i3c_hci_acpi_match[] = {
> +	{"AMDI5017"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
> +
>  static struct platform_driver i3c_hci_driver = {
>  	.probe = i3c_hci_probe,
>  	.remove_new = i3c_hci_remove,
>  	.driver = {
>  		.name = "mipi-i3c-hci",
>  		.of_match_table = of_match_ptr(i3c_hci_of_match),
> +		.acpi_match_table = i3c_hci_acpi_match,
>  	},
>  };
>  module_platform_driver(i3c_hci_driver);

