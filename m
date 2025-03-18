Return-Path: <linux-kernel+bounces-565617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCFA66BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C78317DF13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5751A202967;
	Tue, 18 Mar 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z9hijtL3"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E471F0983;
	Tue, 18 Mar 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283423; cv=fail; b=PohbOHNNNs+uaT/RnV1mN68EgGVPXGoKdtDsMxyUUHaPihwf9adAjfPDBy1JLW2498RnmXJxxPASKgwNwSODyumVM1ohZhdngAkIQUWpS7/HteokD8csjGYWVJWInrqhRsVzroe+Jwuq7bNGXdIawbuZMz6ura1G7M/TAEq9Tg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283423; c=relaxed/simple;
	bh=xMuqMTZNxhtsX/VfqZwgtq7FIIsP34TfNrMfuYzzKvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RXZgXhTZeLFNy3lVT8JnvhVGFxDX19mHKMhol0V5bD7f/xD7n0zGma3nROgiJJsPhOqw92xVUy63JEvLvtqVUheSi2hqpTlSorVMaJmgQOkrxH0VzY3qe0IxkFR+mOmiSURAhQOmCu64jew93/0bpT2dso5vsC6MCQ7gfl+z5ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z9hijtL3; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXTRAuSQMvoFUDebFv+YSlHL7rWa+Rn4tOpGUVLPiPULpU0Z1AToCQ7l5Rf+UorgEyJzBx68fwWLDWlNaWzvu3Py+zPFOs9EkG0gqNXoIHIno0/FCFoqAuj+2ZhcXzBvwC77/5Xljl72cfMlgpdbMIf+fJd9VimzEkwD2P8Ln5+VnCC6zCgBvvgqTISts6/ZJZrZPu1G8iIl0a7SN8I4gUel+ojz84ZthsvMNcu57k/F0UEQAkK26FHgGiV6L28OC/M43ooTdbjik1d1gzeYZlCWb9aCCiwgp43xXfl6DcWPDSOJoRc15K+S6wwQFEo0i7CUNO3KcwG8Re2AcQMRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMYlhe+/Q5JtUxhtPdCRzbxVgXC1OjTHVGZ/OeJSaj8=;
 b=gxQa62yMlBL8pG4fDH8OGkdy2vJs1kyh2mhWtmjiUZRw6u38G6CujsNTYuYH9Vhbwb60doXARHo+90OKi/QhvmVa7NFf9/G6v3yipTZiDJui3e/q2iS2OgvZVQXq4ksepdVlQ4OJb80ECpGofv+zCqFH3nqIUrBIszShxvvfhp/oadsCfptSDTiBFXHh1nAKEpzIU91OJ3Ui9nkLNMs8OZ3Aw61lHldugwTXum7Jgn8AV3ar4+66MtEzTiwvAE43ZDOwE1O/53TlKnSKjtjE3mFjq81em4EVS24QmUWNpDQH9o/cwx6+Irf3goB4qleguAYj/kGt4OrLQ2fQJBnnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMYlhe+/Q5JtUxhtPdCRzbxVgXC1OjTHVGZ/OeJSaj8=;
 b=z9hijtL3gWcLKBeNklcGhLh8gctF86q7Y8cLhGqQuT6u/4BGSfoi6pMrf+NVGPIuyA1neKl2tKpGAqMT1uZxBGlWa3CXVOTLkfhV+yquFeJ58P6VqcmFhvaJsI7nphXG+s/zRmeUYUWAsyP+8tHgN5IyValmC2qKiopd38PJl7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:36:59 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:36:59 +0000
Message-ID: <b106b46b-f00f-40bc-aafc-f57a879fe090@amd.com>
Date: Tue, 18 Mar 2025 08:36:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: xilinx: Prevent spike in reset signal
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-usb@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.92a20336-7677-4cd7-9893-b0e0da853ba9@emailsignatures365.codetwo.com>
 <20250318064518.9320-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250318064518.9320-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CPYP284CA0005.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:68::10) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c72ba84-0155-4588-3b05-08dd65efaa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFRsUkhsWXZkZFRTcFdZZW1UZzFuVjhQUGFRbEJjbDl5TE5wSDFnU0JsK1h6?=
 =?utf-8?B?VGRJeUlBT0hZNTVhd0x1TGdDSlBOeHpKMG43WkJSN1RKWGRGbUlzckgvTVlZ?=
 =?utf-8?B?QkJpS2t1UDJuRkdXRExNeVQrMXZBdy9halIwc1IwbmcweFJ4VVhiWmlmL01P?=
 =?utf-8?B?K29GWUxUV1A4a0NUSFUvVnkyNXg3WU1lcnlTOUNZZHVaT3UrbEMzYzN4SlJI?=
 =?utf-8?B?N3JzQy90WEk0QkszcjdDSEdSY3l1WGVFNDM5bjR4UW5uV211bEtRL1pIKzd4?=
 =?utf-8?B?TlBtQkwvaUNFWjNlRDRyak1KTDZVRU5Gb3RJWnNKazhKTzlkZFVHZS9uWU1n?=
 =?utf-8?B?ZkhMcXNLY2xhaFJ6YjM4SjZLS0tXakhnMEc0dDh4eG1wamtCUW1YczNYRWxw?=
 =?utf-8?B?MTU4LzFQbUZKUGZVUGwvSzdnU1o0eWNhRmJlYzRnelBtaWt5QlpQUDIwNnVl?=
 =?utf-8?B?Y2dYRU9xZWlJQWdOQkR0eDJKWDdqNFp6N2x3MDVCTVF2QWtCSldjdkJMQmpH?=
 =?utf-8?B?T0ZWUmxIWE5MODFmSmNUYnc1bjhZSzVYUysvbmxXMW5GYjVkTlUrQ0w3SEFI?=
 =?utf-8?B?MFhuOXNaZ1gzdUR0akNOblZjMTQ4OUk0L1BwNzRXc2Nra3krRThFRWNtQ1oy?=
 =?utf-8?B?d1J5N1M5UnNMOWZNLzFPOHJMM3U4MEh4RE5VRjlPbXUwYW90Mk4wc0pqVGdX?=
 =?utf-8?B?WWZaRkZNYklTMjBxejA2NHlyM3hORUhGb0xkOTNrNjR0VmZpcXVGblR2S0M5?=
 =?utf-8?B?L25tczlOeTJJSyt1TzhnMmsxOHFEaHcrWEt0SVpCM0FjSWJZMS9HR1hDUWJu?=
 =?utf-8?B?NnBUMEt1SWM0SmlpY0Z5aGZ5ZGxtSG9WVHZPVWQ2MU5wYW1OMmg4TVBxQmRo?=
 =?utf-8?B?c043NHNDYjNRYUd4NlRyc1hoYWFTeERSbzJNdVJMYlJwWkJCamhIQXU3bk40?=
 =?utf-8?B?d1hJbFVjNy81VFE0VlREVjBGVkZvUVdGeFRTUFhSTlFiVnZ6SVBoaHV0VEhv?=
 =?utf-8?B?MGFrMU56aVNCNEc1Qno4cVdSU01ZYkk4citUZ2J1QzRpQ0lQVEtybXYyL0RG?=
 =?utf-8?B?WnNuSVdLNC9XZ3NhV2E1ZndpcTBqdFN4T0hWcmFjenhQTENzL2JRTUtWV3lw?=
 =?utf-8?B?akhDd2F5dGE5N0x1ekpuK0FFV2tqNVhYeXYzU1BGN3lEZzBhVEx0V3luQzhF?=
 =?utf-8?B?WTVwckNPSXhBTVdRMDBKbWtoSFo5d3p3RkpoWXlLdGhiMmFyN2MxOXIxalJw?=
 =?utf-8?B?SWR5Ui9WUjBZM0YxWnlhampoQWRNb0kwZGRjd0dRNXRPUzU2MHBiM3lvZjdi?=
 =?utf-8?B?cFp0RTBjZ0tIV2dtSEpNWm1nVlB4NnNLNi9KTlZkbURlcS9NTlZjTCtOQVkr?=
 =?utf-8?B?WFNsMWpWcnhONUMxUlNJeVBZQzFtbGVieVc1dnROOFVlSUVJcys5Z2tuRTlF?=
 =?utf-8?B?WFNkMnJlVCtGUURqM1NRT1dlWW9tcmc1bWdQRDdnOWRVWnk2V2V4RHA4cUNi?=
 =?utf-8?B?Um84aWJrb2xSN3QwUitVamR1UWhWeW5JNFNReldmUXhBSkxRNkd6d2Nqd1JB?=
 =?utf-8?B?elJwZjBMUXE5R0szajJyMUIyVzM1eUFJOHYvZllNRGdiTFFLQi9jd1lQbTlu?=
 =?utf-8?B?Q1p1cWpYRGxzZGdWZ3U4Qzh2RTBqY01DQmFud3dwNkVUcGRyNEhEd2I4dk9D?=
 =?utf-8?B?eXhka0NkOUxRdWc3bDZpVGZLRFg1QTREZkxYZkpDWEZ4T29GOTlHQjNSck5T?=
 =?utf-8?B?VkdyWDZlWXlybzI5eUt0Qk9FTHpTQVdDRThxekZEa3BpQUlaazU4OHluUDRj?=
 =?utf-8?B?V05XQmpuMHl1bkFLek1iaVFCaWQxMVluczJyalhpY1F6cWtGdmU3ek1ROGJp?=
 =?utf-8?Q?PXGhKlnSFTVTT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWREanV5NjIvdTBqNnFwMFV6L3VIdnlVVkcrOTVjR2VINlQ4LzU1cEczdURk?=
 =?utf-8?B?dUVqczNmNTY1SG9jb2dqQmtNOG5hVHpZcnlGZ0FBNVZuMXFzNzkvemNGc2FR?=
 =?utf-8?B?dVFPbU1SRHFqclRhTmQwNytXVW1QL1dJY1FqZ2JXRFRoVkhVaFl3eW9hZzJr?=
 =?utf-8?B?TDA2MXFrbyswZTRvVnB2LzB5aHJHQkc5ckU3LzJIa0ZNYzhZSkdWc2g4MTBs?=
 =?utf-8?B?aHZpeDlUQUtpaUdzaVJrbEtycHRDdERETm1UWjNVa2l5Sk9uRDRUb29HTnl5?=
 =?utf-8?B?eVJUTU5iOWUzWHNJYytPcFV4SlY1VDU2V1YyV3Q0UDZ6Y3ZrR25sOWlWVktV?=
 =?utf-8?B?MEE3ZjdzMWVzSUtrTVhSTHUwMnBRb1pXZ3o4NHdPZG5QdmxWNlpTNHRNMFpJ?=
 =?utf-8?B?S0FxVE5NU0RJckVacktUd1ZpT0huRmoyWW1XeXNiSGY5QVJNenJidmRoZzdR?=
 =?utf-8?B?UTJ3UThRR0l5bmwzSkhibVJHbFVqTnk5OElBQkRpT3NxMWJVaXUvTm16NnN4?=
 =?utf-8?B?SEdsak9JYzFvUlJXR21KYWlCVStTYnJvOUJpZGJEUmxFOWNBYVk2Skh3eDl3?=
 =?utf-8?B?Nk5qbm8yVVRORldzeW5XY292Z1AwZHVNTTZjejNFZjlBUkdVUXF3a2V0NDVv?=
 =?utf-8?B?ZTFDcEk1d0ZNd001WXB3ZVE1K25SR3ZCWFZhRjZWditsSzRtK2V6bmFDODZp?=
 =?utf-8?B?N1R0d3d6YW9MbWxORmswaS9OK1hJNHB4dHVXQWtVOGU3dDczQXpqakNwckk2?=
 =?utf-8?B?YXNPWnEvVHNReEhDS0JGaWlxejVOZG1RanI4SzdKWW13aDk3Q0pqTGhNRWsr?=
 =?utf-8?B?c283TzN1K0lzQnR0d3VHOC9kTVhrcHdGbm0wdi9NMUlTaFplUWtTM1dINDBX?=
 =?utf-8?B?ODRHbnJYVkEvZzZOZmJ6MTRLKzlXVEZueHBpckhsQmUyMHlpNkVHQkJTekxF?=
 =?utf-8?B?ZnJ5YWlNMXAzSEsxbVJJeHptTnQwSlp3RG5UQTk0RWZHQU1IL1N5MWdUaFl5?=
 =?utf-8?B?aWU0aVZXMTJ2WkZacWNlMmN6bjNERUpsSUhHK24xTmxPclBxL0dnRzVvcDFu?=
 =?utf-8?B?SzFPVDdMQW9WbDdVbnRCSmpHRUxWYlI2dHJRWU43Mjc1NCt3UTh2Y1g1Y3BR?=
 =?utf-8?B?dW14YmZQUENkZzEvZ1AzNUtBWjRkVEQ0aFQvbHdjVTZRc3NqZHowcGpGdHBh?=
 =?utf-8?B?NnljUmJpQnZmZG4rSzF5VEZoZFhVdVBIOS8zaElCck9oQlVqNUVRT01yeUkr?=
 =?utf-8?B?LzRzaStUK0xZVGtjeWRDTmsxRjlXL1ljMkxNMk9ZOXN6RzI4QnFCZ084QUlv?=
 =?utf-8?B?ZTliRnVZQitTeFpUTmVXeFVENWRwc1FiSEtXVFBoN1A4UmZzbW1NeGtibzNu?=
 =?utf-8?B?T1ZRMHRUd3NSZ0lLY0Z2ZWw3QitucHVYNHAxdDR1QmdtMGlDRjNtTlRvQlFo?=
 =?utf-8?B?MytSd2pSWTk4N3NGdEZVVEZyOUcrbGpIYXowWUkxMGx5ZEN4U2xGUmtGanAx?=
 =?utf-8?B?ZzlxdnFhellIc1NadndtekhMNVVsdFl1dHcrSk1pMlM1VGpHWXROMFljOUJa?=
 =?utf-8?B?NDQvU0JUcjJuK2N3VlE5MXVwdVJHdUFiTjh1MjBtMXhJOUZ1MkJqSUJ4M0wr?=
 =?utf-8?B?ekFqTzhjdjVFdDNPZVk0YmVVQWl0UkdxWVNhcnRHRms5MEMxV2VUSms4Q0Ex?=
 =?utf-8?B?ZDZBc3B3d0xXZTFJMndLMjF2RmI1b2JmUXd1QTd3YlpmdytnTENCVVZkakNu?=
 =?utf-8?B?VnI5SGZaVCtjd1FPK0xBSG9CWmFYZEVGQWY5UnJ1SlJhQ2x4MENxZlJzQU5h?=
 =?utf-8?B?WGhJc1BVMU1LZFhuTVhxMVM4NlQ2aTJxUGFVL3hWWHdmVEdoQThibENIWFJQ?=
 =?utf-8?B?bVp2akR0eGg4blRreUhCQUVsUFVtVU1IOFNHSDlnQUlKbmVyQ3owNGJ5dGdr?=
 =?utf-8?B?R29SbHpPaGs1NHFqWDk3MENFUHdQVGdBYm94WjA0dWxSVXlTRzBDeEZRMzh6?=
 =?utf-8?B?bDRyeFJEaGIxVFZXZUdHRzZTRGxaOG81VE4zYk9NVkRCY0Q0RkdkZHpoSlM0?=
 =?utf-8?B?a0tOcDNRc3d2bUdRMjZwY1VCZkU3VjkvWFZWeG5nS0N1VVVXTDBKN0VzWGtI?=
 =?utf-8?Q?urPNCbL0TH4HHiH+VhceWE6Ls?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c72ba84-0155-4588-3b05-08dd65efaa92
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 07:36:59.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CvJUfkJsTHGhD3NJ7x7BL6QeNY/pC+57hpjCy87wZvOxYrvoO62/fu9Y3Sm6cw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186

+Radhey

On 3/18/25 07:44, Mike Looijmans wrote:
> The "reset" GPIO controls the RESET signal to an external, usually
> ULPI PHY, chip. The original code path acquires the signal in LOW
> state, and then immediately asserts it HIGH again, if the reset
> signal defaulted to asserted, there'd be a short "spike" before the
> reset.
> 
> Here is what happens depending on the pre-existing state of the reset
> signal:
> Reset (previously asserted):   ~~~|_|~~~~|_______
> Reset (previously deasserted): _____|~~~~|_______
>                                    ^ ^    ^
>                                    A B    C
> 
> At point A, the low going transition is because the reset line is
> requested using GPIOD_OUT_LOW. If the line is successfully requested,
> the first thing we do is set it high _without_ any delay. This is
> point B. So, a glitch occurs between A and B.
> 
> Requesting the line using GPIOD_OUT_HIGH eliminates the A and B
> transitions. Instead we get:
> 
> Reset (previously asserted)  : ~~~~~~~~~~|______
> Reset (previously deasserted): ____|~~~~~|______
>                                     ^     ^
>                                     A     C
> 
> Where A and C are the points described above in the code. Point B
> has been eliminated.
> 
> The issue was found during code inspection.
> 
> Also remove the cryptic "toggle ulpi .." comment.
> 
> Fixes: ca05b38252d7 ("usb: dwc3: xilinx: Add gpio-reset support")
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v2:
> Add "Fixes" tag
> Remove "toggle ulpi" comment
> Extend comment to explain what is happening in detail
> 
>   drivers/usb/dwc3/dwc3-xilinx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index a33a42ba0249..4ca7f6240d07 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -207,15 +207,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>   
>   skip_usb3_phy:
>   	/* ulpi reset via gpio-modepin or gpio-framework driver */
> -	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>   	if (IS_ERR(reset_gpio)) {
>   		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>   				     "Failed to request reset GPIO\n");
>   	}
>   
>   	if (reset_gpio) {
> -		/* Toggle ulpi to reset the phy. */
> -		gpiod_set_value_cansleep(reset_gpio, 1);
>   		usleep_range(5000, 10000);
>   		gpiod_set_value_cansleep(reset_gpio, 0);
>   		usleep_range(5000, 10000);


