Return-Path: <linux-kernel+bounces-415145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FF9D31FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A95B22375
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2C2E3FE;
	Wed, 20 Nov 2024 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="E98S+wS0"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020083.outbound.protection.outlook.com [52.101.85.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E23A939;
	Wed, 20 Nov 2024 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732067942; cv=fail; b=Il4WqeDG409hmGkam9zBeBiB5HBH6oZ3hazZ8uQmGLSHg2Ud2GdaFl4awfGiCFmBfd29GyCl1fDL5BEUiJf6c2T0tbTlMb6pB94Z3iQQ7q5spcejTP048p1aOoIab/Qddt4uMz3U7BtYMoO3A7oMtgimxlEV0R/TB8sbP2sWwqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732067942; c=relaxed/simple;
	bh=OmSf5ZnrjWByzzIbbgTdIgEJzPL0q6zFw8ZlKbr5b3c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/HyTPWBgwcWCWsl+GUzvkzko5zdTMPGXyYXXn6kIy99Y0QgEESSJ+pD2WEr4oe1cE3EIXqsuxfdntE0OjYxg1mNVnvUrBn92Uq7bVeKJO6VAXRgkh8R6D1nphvyYxNyr2xhyMEkhomRhG+fND+Jbj6aezngIBCTCXNofIB9Crk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=E98S+wS0; arc=fail smtp.client-ip=52.101.85.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daCppwaT73zsVclQij1uzfBInCNWWJ+wvL3x7nCEZO5oQg+/CVF0w9WOfEqMlNALUAAo8vTjT0RDPC1OVytH9RcNqeTDD/+gymO4VMJiwPIqF8Mg9D/5rDJi8Nn1PKOdrLVKOpX2chlcZ3m2ZAC0fxBYwmJf7/NzdopDVMNrtRVOh+b6GngApUt8ks5Ig2FjuhLcsI4OrHPnvEWriHDSL8DR0EZ2UsiTJmzKJnkpqxyVeJTi3c2H01Qi5wRzyna2Dq+yKgF8c5j1A8WRNChXuW7kTnytJaFVXtnQ4GR9bj4yYPqm6PbGJSx58AF2Twv7v5Rq9lYaXuQxvt0GLwHO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeFj+xKcr+dL8SAHAVuk7a7EFI97loZL7nCoBFgnwhI=;
 b=Vx+6FCcBVHmId2sUnvVQHbTCVV8jpWA8TZpsVc1wivss8xvXT3VEAHWRjr2kOhh+CuTzBHFsbIvaNTc6VEJVbSAc4SNqDmp9DORTup+jdptH9vLg0kPnGj5UpYo3UqDtkHzGQnMO4yP6MXhYOEk0Pp23I0QSf1NruCKgnNqPFiEVA6abDP8ZWtgeDoV7ElPuj0YIYserlvOoC4uiWfBPc3kwm85PXMq5JY9Qp8ONllsI1VKn/xFYi2VKSrQTGWffuRZdtAPWl5JYCvtVhAo4b50KVBhLLuyPlHwWlthT9/6Zk23Nfp43whHSa2aMSdRsOQeaWDl3uG6DOuvvf/0USg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeFj+xKcr+dL8SAHAVuk7a7EFI97loZL7nCoBFgnwhI=;
 b=E98S+wS0ad76K5KYBhM/Hb69jB/8jvsyvmt6fp2kZ07/NvXnpzG2zw+wpcQYGLrBmEZVyIqYkTEaLqpyFlA+U9c/81kDPcIR0q4axsQhs2c1SSl0+23l+8FVMTaccfWeTtUMMIOUV8XvUiw0SeT+yFgVXPmj1QPUbg+6+S3A5dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8193.prod.exchangelabs.com (2603:10b6:a03:4f6::15) by
 LV2PR01MB7766.prod.exchangelabs.com (2603:10b6:408:171::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.12; Wed, 20 Nov 2024 01:58:56 +0000
Received: from SJ2PR01MB8193.prod.exchangelabs.com
 ([fe80::4167:3f60:16af:411d]) by SJ2PR01MB8193.prod.exchangelabs.com
 ([fe80::4167:3f60:16af:411d%4]) with mapi id 15.20.8182.011; Wed, 20 Nov 2024
 01:58:56 +0000
Message-ID: <b2441bab-304b-4983-8780-43671e8add4b@os.amperecomputing.com>
Date: Wed, 20 Nov 2024 08:58:47 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
To: Corey Minyard <corey@minyard.net>
Cc: Potin Lai <potin.lai.pt@gmail.com>, Corey Minyard <minyard@acm.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Patrick Williams <patrick@stwcx.xyz>,
 openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>,
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <chou.cosmo@gmail.com>
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
 <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com>
 <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
 <CAB9gMfphfY0H721G9qV8_3sm1d_RTnKkWbEOeqC-0ox9p4cfCQ@mail.gmail.com>
Content-Language: en-CA
From: Quan Nguyen <quan@os.amperecomputing.com>
In-Reply-To: <CAB9gMfphfY0H721G9qV8_3sm1d_RTnKkWbEOeqC-0ox9p4cfCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To SJ2PR01MB8193.prod.exchangelabs.com (2603:10b6:a03:4f6::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8193:EE_|LV2PR01MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b40bd21-e459-4532-db23-08dd0906e440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2FDUWNnWHZSOUNKRnhSUFZZK0haaE8wc3pKazJOdnBjVnc4MGdDdEZta25h?=
 =?utf-8?B?UURPa25FdlhCbjZNZ0dWaFRLR1dlaE1kYkM3eHpBQnJ6M0VxMUJVVFRmWFJK?=
 =?utf-8?B?WFdCRFhKU0VyVEZxSUZFRmg4L2FkekN4SUM3VmRQQng0QVk0RGxhZjJqOUty?=
 =?utf-8?B?U1A1R0NhdTh1VzVvVnZNbCtBaG9PSU03Qk5reUtQbHgyaUFXTjl1NkhUNXQz?=
 =?utf-8?B?T2xSZlI0cFg2UFdOY0RWRm41ZktQaEx3VWJHUmdUREZ0WnhzYmhjbXlNUlU0?=
 =?utf-8?B?V0gzQ1FJNDUraGVIQjlaNDdDaDVTTllhb3RCRGRPNCtueWVFQzBwdE1jSU5r?=
 =?utf-8?B?b1dHRlBFaVpYWUlna1lIdk9kTlVIZmxXN0xkblpoWERmQ08zd0lEd0RTT1V2?=
 =?utf-8?B?NmxwSUZsMjM1L3o5M01uWkNlZ0R3MUIzbzVRRzUrNVgxSzNjd0swTXJCZ2Rw?=
 =?utf-8?B?Z3ZiT3dOZ2lnRHZJK2hIRWJSMituMXZNN2tUR2JaRDdUZ0FadFI4ZWY3aHdF?=
 =?utf-8?B?OTkrcU9xOEI4Q1owYmd5ZmlsOHB5RVNwS0tEK2lDUjc5ZldHM1AxNG56QkRq?=
 =?utf-8?B?SGhGdkVDQ0NyYTBMenJWUmFJTW1ZTnQyanU2aTE3bjd0cG04VE5wb3ZsSEhV?=
 =?utf-8?B?S2tMcTR1cXZ1NU9KdTViRzJrYUF5MUFwRUJGc2tEMXkzMFZIM1IvK1N0U2xj?=
 =?utf-8?B?RUVoOXJhUmJjVGh4TXdiWEhzaEc1Uk1URWdFZ2tvTEt0ZVhLTmtyMkl4Vklh?=
 =?utf-8?B?Vm41UjVKM2NoSEFhNE5xUHFGN2JkS0gyRXFqYW1oaEwzdFV4OUlqZkVWQkdX?=
 =?utf-8?B?OEVvOSs5UXZRQVhQK29Xc0pHNDhEbVhXNE9mNklJTm95NGg0NlNVY1pGRkZl?=
 =?utf-8?B?Z0wyTS9Ma2Z3ZVc2Wm01SUJzM2gwMnZWWWpWSThaSU4rSGRTWldjanYvMkpS?=
 =?utf-8?B?a29uS2NsZVViV2daV0Z3ZUtZK2EwQ2RxYUY2aUQyQ3ZVTzJZdUlVSFlVdmxN?=
 =?utf-8?B?UG9nRmoyUXcyR0FzRnc3RWhFalh2bis2V1FwRDNpeGszUksvVzdlWEkyM25u?=
 =?utf-8?B?K2NMU2tLK09HcG1XaDF5OXFWOW9zRDlLU2pCVjN6b2ltQUlKM25CVW9nZlNk?=
 =?utf-8?B?OTJ2RGc1SmQxK2MzTHRGSktnMlZYRHJSL0NjQmo0VjFvSUtFb01iZE5rRjhO?=
 =?utf-8?B?VlZhbTdKQ2dsb0NhMGMxUDF0NGxPbXpuMnlFSEVHVjRnK0JVTFlpVmU3VFNw?=
 =?utf-8?B?R1VxekhLWWVqVXhKN25HWnBac1I4T2w1L0I4Y2tPRTlMa2VwdzJ0UzdoYmoy?=
 =?utf-8?B?SDJ0ZzN6eGFRNW0vb0hvUDMzTW9rN29HZWp6aUF5M2xpVDRFblFwNW9IRzBk?=
 =?utf-8?B?d0hsSFNOOFo1aCtPK1JBeXVFWFVvRUtoU3RlMUlaeDhVOWliOXFUc1ozTnZx?=
 =?utf-8?B?N3B2Z1YyTkNYZisvRkE0ZUF0WHVrTlJEYlJzMTBzb2NaQ3BGYlE4VWtHWWt5?=
 =?utf-8?B?aHhoWmdiUmhVTVVRRTd3YVZhN1BRWmRVYnV3cjhhdXhmYVpXNFlHZ0ZxRHFv?=
 =?utf-8?B?OHZNbk5QNU1NYzhiR1hSS01rbUcxdWgxNW9ZWnEvNXQ2OXlheWlBYzl4OGw3?=
 =?utf-8?B?UjBYU2pZRXQ5Q2Zab2ZlcHNsZk9YZDFWTHdpOWM5SFlTQlNXMkRYRkE0RGFr?=
 =?utf-8?B?YU5JcDN4L3NvOW5kb2Nyc2JwSHRmS21NMjNsWDIxK1lFV29KZDVzVTdtT1lL?=
 =?utf-8?Q?tmCVjUh2q9ADvGxOTNEdU3066nh76aM0zPW2mia?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8193.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkkySlJUajliWFhEYVdyUllHeG5XZE5pdXdvVUtOb2ZQeVdmeS9aWmpCRDBQ?=
 =?utf-8?B?TVJZNnhXRXUwckM3T1RyTXQyQXJvVWZhbGxIUjFOcm5QdDBxNTUzZ2JtZE1O?=
 =?utf-8?B?NEVZK3ZrazFCTnJ2OGZKMW5wRmp3LzlRUEwzRmVCTzhoUGMxR2NadmhWZ0Vx?=
 =?utf-8?B?b3VZUlJPUzdTaldzZXV4UHY0NjdURU5yZXFSNmZsMDBIdXFUTHFObnhwcWRL?=
 =?utf-8?B?N2k0YkgyRnJuUlFNU2RJVjVaQWRyUjdnWDlYRnplNWl0QW9CS0pWa0twTGJU?=
 =?utf-8?B?QURZdkw4enBEZU04VGRPMU5iVU8zcHdNTTlmb0VySDFBcWVhRnNDVlhvOTZE?=
 =?utf-8?B?REVTK2Fhc2hFV1hsNlpuOEpHSWVjTmI0SnFiUFFpVzJGUFdRcVlTOFdFZXV2?=
 =?utf-8?B?Z1lDUmVMbmJ6c0h2RVlzSmhFOW1qcWtQMjFxOFZ1cGxCZGFIOHZiekdtUitQ?=
 =?utf-8?B?dTV5bTB0RUZQbTdWb0pRNmMvTWR0MzA1bHFXMnBPNGxWRmpCbXJ3OGpyb0g3?=
 =?utf-8?B?Yjl3YUt5a1FxdmxreHNsMjlPRDFtUXVEaEt1TWJuYTQ2d3RlTEVQL3B1dEpR?=
 =?utf-8?B?ZmR0cFBFdVErcEM1TkJSeU9uQTYxdnoreEI5QnQ3WjNXQVZ3Rm9XU1lmTFpT?=
 =?utf-8?B?ZGpQWFNjbTV2djQ2L0NxTmJSanA1WjZjcnVtUFdWVzZoUmJjVUl0SVExL1FU?=
 =?utf-8?B?d2RtdnN4ZnprZDdoTWUyQmxrVEx6THhNRTFmd1JoWVllYmxVVmR2RzJLa2JU?=
 =?utf-8?B?Sld5SmpWMmZBNkw0SjRtekllWmcvYkZIaU9RNVBlZHZxUHN2bUlZSHRlVFZI?=
 =?utf-8?B?NUNOQzR1a1RGVHp3akdJeTZhbjBOaWNBL2RJR1NFUi9XTkVwTVVVeEplcTRn?=
 =?utf-8?B?TFg4N0NibGFzd1Z4WjRJclVjcXZQWk5BRkRCMFExMlFPU24yTUxqc2ZHU1JK?=
 =?utf-8?B?VStlTlRDSllVWG9uZ3J3RVBkbWZIMnl5M2NDQ1RaaGNkL09zaTdvWU9BZXJW?=
 =?utf-8?B?NkJVMTQ4bzRXajhSNWY4em12b2hrUG1ULzR6YkxYdGxoV1dubGtBNTBFSEp3?=
 =?utf-8?B?OG1kcHpFVDhUNzJWeVV0akM2NmJaeC9MUHZ0TkVLWjhYUnVjeDlRK1d1c3J2?=
 =?utf-8?B?N0g1eEVmczVSd2hWSDBIdGhkWERRSDd3czJsMFhwSG9za0diK3BhMERnZ0VX?=
 =?utf-8?B?OEdKbkFEanBJVWVDKzh0bklLZi9IMWE2TXFjR3JaZGJDUkROKytYbVE2K1hH?=
 =?utf-8?B?cjlXWENINVp5d2tFSUYrZzU0MmRsRmhTc3hqR0dIV09wd0l2UmU4aTFLZlZh?=
 =?utf-8?B?OW9aU3FSS3l6RHNkNk00YVIvRURKRDAxZWNJaFQ5dmlSR0tnOUZMOUsrVGIw?=
 =?utf-8?B?TThVbHhjZ3ZtbFdlRnVYWTB0THdkMDk5cWhKRVJuUnc2dmVORFphRVhzNEdz?=
 =?utf-8?B?NlMvN2psU2dqZ1huWFpPU2pJanVQcjBGaGZvYXZwOFBBeGFHQVhvVWk2Wlg0?=
 =?utf-8?B?RUtNSVY3SFlpYmFkRXp1WTljTEhnZEdNWjlTWmhlYTdXQ1pxcTNlTHpFYVlT?=
 =?utf-8?B?djJlLzFwbWpJcGEzVWk1U1VqYTI5cnBzY2pKa0JRdTk4WE44OVkxYlJHMDI2?=
 =?utf-8?B?QUZYRXZRcVJCdVlUalJmcENtb2FhdDE4M1RWM3hjWHBFVUhPdlRmdk13Mmwr?=
 =?utf-8?B?dnFFeWlteis3Z01zOGlPZXV4WncwaTNyeFlwVUJlL3V2NFZ2VnJkT2gyYi93?=
 =?utf-8?B?UTZQdXkyc0dVYUhOOGlNdmJKNWI3SU42Um01MHdPK1RkVGxMc002U2huN3Qv?=
 =?utf-8?B?RDlJcU9GVW1hU2wyeXJzVHl4b1ZxS2NzTXdYMXFzSWtXSlQxMXc3WHNCSWlq?=
 =?utf-8?B?OEp0bUFmY2toTjZQbVRaUUhLc2ZOVUhiYkxTcHYvN2ZuZTdSYTd6T3dzamZF?=
 =?utf-8?B?WDh4VjY3d3FDeUgvYXZyeHJLQU1mLzVkY1JmVGovM1hiWEhWNkNHT3piamNO?=
 =?utf-8?B?SmwybU01emdpZ3ZlelFuWnY0NUJ4ZXZYYmVXNmFpRWwxeGJ3TFBQSUdSdlht?=
 =?utf-8?B?UldacjdiQ1ZZVjFaRUhCcEx6aVkySDJESjdSWG5PL2UzNmxCVEtCdUxMdlFj?=
 =?utf-8?B?eU9KanEzZ01XN0tqc3lqRjQxVXhHcE0vZFQ1Q2pvV2lLbUtkd1gxdTZtVzJ4?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b40bd21-e459-4532-db23-08dd0906e440
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8193.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 01:58:56.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aitxK45pA5CiWxxtx9nrlVjCAqYl2YWB7APwAy5GAaIF2n2M/f4fvMFwPchah/XullZBuFOODeTgF9fEnEoA3DfWXn+LhCB2Ybdrbkio5TQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7766



On 19/11/2024 18:30, Corey Minyard wrote:
> On Wed, Oct 23, 2024 at 11:30 PM Quan Nguyen
> <quan@os.amperecomputing.com> wrote:
>>
>>
>>
>> On 22/10/2024 08:20, Potin Lai wrote:
>>> From: Cosmo Chou <chou.cosmo@gmail.com>
>>>
>>> Implement GPIO-based alert mechanism in the SSIF BMC driver to notify
>>> the host when a response is ready.
>>>
>>> This improves host-BMC communication efficiency by providing immediate
>>> notification, potentially reducing host polling overhead.
>>>
>>> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
>>> ---
>>>    drivers/char/ipmi/ssif_bmc.c | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>
>> Thanks for adding feature to this driver, the code looks good to me.
>>
>> Reviewed-by: Quan Nguyen <quan@os.amperecomputing.com>
>>
>> I'm just have a bit of curious on how the ipmi_ssif in host side to work
>> with this mechanism? Will there be patches for ipmi_ssif to use this
>> feature followed?
> 
> I just saw this.  What makes you think alerts are not supported in ipmi_ssif?
> 

Yes, Corey, I see alerts are supported in ipmi_ssif.

My apology about the unclear question, I was just curious about whether 
this gpio-based alerts mechanism is confirmed through test with current 
ipmi_ssif without any extra patches.

Thanks,
- Quan

