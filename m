Return-Path: <linux-kernel+bounces-221833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD090F935
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2406B24583
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212715B14C;
	Wed, 19 Jun 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UXSUQkxR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89215B142;
	Wed, 19 Jun 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718836708; cv=fail; b=M5fL7yY/QeWfPnr/fCsMv7JVf7Hp23lSijbswe5jtIiBXb7Bn1igpZNpVI2lHD3Z+ibiayADO0y9J4DMnZfCbuEwDdaa8d1V5KvxW2XPFZ6IfQhQGzwVWC2cJFNd1lBJOvDLymGS/1JoONG6lEYQSlIErjqeGXr55gqxf1Yljt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718836708; c=relaxed/simple;
	bh=B8924mSMlc/GrbFoo4mZu/DxdRqE+Gihx89QOtceGd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+vSLZ6aS5lOoZZmq9NB2mlv4UM+g6m+YgJAlscPaw5VlK0S8lVgSQtOaxv2AMHxgdEP9n5Wa5faIuYKt71F9A70urhfx0aVAGqbWwprhapLPoKY26/7HfeG+t4n1HYsbeMn5TLDqU7lZJ8D8yKawnBQH2vetD2i5o9Xi3pOJSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UXSUQkxR; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoIFY59FyKIYjBXH71Lv6gBq+T3IsgBr5RIA4pun8nYeruX1SJybjt4bgpHtY//2CVqjAAP2PJ7wJg9qNmhjIeXZNVTbR+s/yVvN7bMUVx4T71mwWeSyBGI21g1RWk4M1bS8QB+rSFcD26JuGL4mAF+9jAX8VEu2n/Q0Rb3meXcaqitwnRod50h7pLGwUxhH/+hM3noXWmQ0eQUqLleWVhC1TU34L3+Ywn5TE0pvJmrrWqm/AuxnLNLj6Xt93a75824YebzRk6BRDFxv+MAYGuCjKXk1HVqmqWK8htclh21kBVWeWblAGM8I/yrgI42w/4AfvLo9p3dqK2iX3MJXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj1mK6xQcdVZ0HLoz18CVTMKDD04fButfHVnyTM9/S0=;
 b=VI+cubnz2PfiOavX3w7jX1wNIKTgSUBqTE7R12B5D/GNNQyKkjD0LAEMjY0yTzgsNN3gY6fIz2e/vM2G08LX/KtPFfluaL6N6MqqALnpt2zop3nhpKFTIm97maLY51ePWGosHUMkzr8dHZCSJBDNY7VV9jxmH6HK71YRWJiLGnK0LZaAFqSVytuk8J+1v9UK0DIUWtFtYO2nUx50Q5g9nGjrsvOzhBa+RERxk9l2IH9UvgA5Zd5dlW8NdGgAP7FNGsHgyszBaduqyWsWI5IDQy+XAHTEXURc4+Q1SzgvggXQ4IXL05f23qbDTJMXAeQSiQ3HlhcGddKLJVdmVnyj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj1mK6xQcdVZ0HLoz18CVTMKDD04fButfHVnyTM9/S0=;
 b=UXSUQkxRhdZHFY19D+tpm6jZn7FAmJcoU4zfer2Ml6YgYCV+sFl3mIU+p1oQBTGmTZFT5obLIewHj9qyxs1qXI11G0YYzTqg8YFBl6esh4vtVnUofl0bwnLuDW83S5PA0tyjcTCvuwLLqK7FX+pihuPZCV4l2emHRXxaYGgh2LQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Wed, 19 Jun
 2024 22:38:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 22:38:23 +0000
Message-ID: <16b7768c-8f68-65fb-19a5-55a117dd0603@amd.com>
Date: Wed, 19 Jun 2024 17:38:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 14/19] x86/resctrl: Add the interface to assign ABMC
 counter
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <631092558e7fe0ac2e6267070e40c4a97b300f57.1716552602.git.babu.moger@amd.com>
 <e649a49f-344f-4dbd-be2f-d70f932a80f4@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e649a49f-344f-4dbd-be2f-d70f932a80f4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a16d1b-7e54-4de1-2c7e-08dc90b08736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzRKN2tkK1Q3aTZ3NFJJL29qNFJNU2VNUFl2WFhJN2FFK0Y2WFRPR1ZLalJB?=
 =?utf-8?B?MnFjU3FQMHFjUnEvZ1V6elZWQ2kwcWFLbFVNTVkyZStuTmtIQlVKRmtkSkRI?=
 =?utf-8?B?WDRKWmVQMk9QY05WMjRjcGFMN0psUE9jNDVaTWhueENwU2hCdzlyYkoyeDJC?=
 =?utf-8?B?WUwyK2lvVGVPUVhHSkxKaUtXV3pobksrUENxQXdTOG0vZFpJMWlncmtaYTFq?=
 =?utf-8?B?QVBOdlZ4UG1ZTGhHQVU4NjVERWkxVXNFZllNSDNHcU5pQjZCN2o5bEZYSXNp?=
 =?utf-8?B?ajN2TERXMXlBMEFHQmhlemFpVUtOcW41TDNRUVpFcnBVMUxRTUdxMnlQb05B?=
 =?utf-8?B?SWFVeDFVb0VyNGViUzJsd1JPYW4yenpoSkxVSlNGZjN2blIrN1c3SmpLUmUz?=
 =?utf-8?B?bzVXS1QxdS9FRTlOeVFhaGZTZ2MrelJEWk1JVUNvOG51MkdCSC90QUhDcUxu?=
 =?utf-8?B?VWV1cVJDRndnY2xMbklsU3VyeVFQQnUwendjYU5NcnNiNkxBVnVhTGtQTkxY?=
 =?utf-8?B?SGloUCtLT1VPM0RKaEtDTEhrMXZKeXJCaTZwN084OVo5QWtWb3J0b2xVWXY1?=
 =?utf-8?B?UWdtOW9FKzhIQUV5MWdldWRUQTUyRHUrWnVTWmNQQUpEMjZmd0tWYkFmNmE4?=
 =?utf-8?B?aGZPYithVnVZNVVkVHgxdldrRTI1NXNQQjFhWm0zWldNdit5c0JqL3hoOGZl?=
 =?utf-8?B?N0ltTS9vTHR3Q1ZscjlIaFpON0ZHN1ZZdWtuOU1mdmx4VGMrbktDS3YrQkNW?=
 =?utf-8?B?cm9MNXNLd01zWVBLYk44enRmRDQrcVYrT3RxdytDR0Nsb3RtYUYzNFoyZjMw?=
 =?utf-8?B?NW50YlBpTEJVUWpabHQwNzZXeCtLbVVvK1hyZmlDbHlYaTBoeGYzbUlrUXdr?=
 =?utf-8?B?czMvWFYzd2poRURqaTcrS0ZTZ2NWUHg4VHI5UDZoY0dETEYyNHRrRU9LaVdR?=
 =?utf-8?B?S25xb1BydWwybHJMUUpmTFFYdURSL0dkb01EZ3l2eWNKdmltT0hnL2F4UDBl?=
 =?utf-8?B?K1RPNkx2cWFyZHkxZnV2MFRKVGUyVHRJcTJxdzA1STJiTk4vdXVkd214VXJ4?=
 =?utf-8?B?MGp3TmJuSUxUdUhrbFZrN25aaS94ZSt6ZEJUVTBmS1l5Yk5nZGNmZk1UcE9P?=
 =?utf-8?B?QnhpdUgwQnQxNktUb2JvL0YxSmZudTloZHBGRjcvZ1NwODlRSlVCdkN1SUpn?=
 =?utf-8?B?NmMxZXlZOUpacEVwQ3FIVy9vSUxlV0FnN2ExZE94b3htUHlLaThGS0hjeTVw?=
 =?utf-8?B?dGl3MjZWOFFyUExwKzNPRHF5eEttQkp5VnpMRnhuSm9vNldFc0ZDMVk0OW9Q?=
 =?utf-8?B?NEYyTCtaOTBnYklmUnhQaFltUzJ6WUoxaHorVC9MWURJSXFTNXYwNE15aVlv?=
 =?utf-8?B?NjBiWFZXM3JTYXVPWnoxdGVtTFhvVkQ1TXZHMG9wbHEzWTlQbEZZcTkvSEpO?=
 =?utf-8?B?WTQvaE5kNHM3ZFJaa3E3OERqRnVmczltZmVPaGw4Yll6YkZ3OFc4YkVNSkdZ?=
 =?utf-8?B?SmFqVnNsQ2VkYVFHZzRZR3czOTFscGxoNkRCV01xcXJkOTZhbmVsc1pwZlhi?=
 =?utf-8?B?b3BpbDZwWFV3NTFPOW5nYWVNa2VMMW80aXk5dzJlZVRRYUUvSFZCZHdSNWZQ?=
 =?utf-8?B?NWl0aGxvbW1Nc0RyeG53bGdPeG5PZ0w3eWsrZm9UNURmQ082cE94ejVhdm51?=
 =?utf-8?Q?R67wndxKjMNKJnNTK6bT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFluaTR2TTZZeVlqR2s4U1c3WitxMDNCMk5KVk1aT3loUWJqa1J4NStCTHFj?=
 =?utf-8?B?RXNVTzdOdWlsVC92WW5CZ3ZFTnFwMnhlOUVvbGk0dEs4OW5GNTY4Z3dFM1FZ?=
 =?utf-8?B?NWhiYXo0MnZYME9HRjdxRWw2MGtQZDBXc2NzNCt3Mkg2a0RweVQrTldRMkxN?=
 =?utf-8?B?NnFQZ2plR0VucHlsY2NiM1hSVUNrb2c1WDFKUDM2clZkQkFyWjRObm9kcWsz?=
 =?utf-8?B?c2xDWDRQT3U0NTF5Z0VxNWZaaEFMUFhpMGpPcnVFK3k5eVNUeStXY2JNcFVx?=
 =?utf-8?B?NkYxSEk1dXlQR2ZHdStKazNUQmhXRzRWZ3htL0RXRlVqTmljWmo5dFFhUkZU?=
 =?utf-8?B?ZzI4QWtWOElKTUtoakpLcHVuR2R0STlEQWFjbTd3VGVXL3NZU0h5YkM2Wkd0?=
 =?utf-8?B?cXpHQXFrYTJJQkVkTW4zZnRCNU00djYxQlQzckxvb0EzbVd1cVVpV01uN01S?=
 =?utf-8?B?WlF2WEhJMWRZOE01QUZvdHBPM0ltUGFWSEV2ZzFyNjhLQzVocWhOZlZSaXpL?=
 =?utf-8?B?OG01YVVRZ1o4REVJc3Nobko1cGZ4NElWZk5pMzdyZFZQVWp2dFJwckJwY090?=
 =?utf-8?B?QjdWSlZIeXF3TXEwaVpOSk8xaEpmSXlCQXgvcEk1ZTl0SnkzelJKYjdKek5a?=
 =?utf-8?B?ODRNMThxYnRCcVM2emFEemU5eklqNWlPSGtucW1Ca3dpbWFpZ0lpekRGKzlw?=
 =?utf-8?B?enNuVEhYVklQQWlYSVluUHFrNjdSUi9FbG53Q2l0M1FsS3BnRVBYWlEvUVI1?=
 =?utf-8?B?WFdWNGZQd2Q0WmVyUWYvYVNNMzBTMzZRV2xLSWdIZXJGVlRzRjN3YXhjMk9z?=
 =?utf-8?B?RmovSlBwOGYzMFdwYUk1TkxYRDJkekFJeHhuNG9uMFRWMm1ndVZmMlhpdE9T?=
 =?utf-8?B?cWJ6ZE5jVjBkV0lNbXZqZWJUYWswbi9JZURhQ2t1N2UreUxBVWlrTWZRUkkv?=
 =?utf-8?B?MDkwVU5RMGVrNVRIekthU2FiNUt6ZWNyanFnbWJzN3UzRytMVURkSzhocWJR?=
 =?utf-8?B?aVBueEd3T1VKcVdKbkd4M09xOGlpcy9VMEs1QzgvTncrMHdaT2k3bEgzNWh2?=
 =?utf-8?B?eUZiMm1XcHNVYlZ0bS9ua0l1L3lCc2tIbzQ5VXM5QTIxL0V0R2ZjSUJRWkxB?=
 =?utf-8?B?RFhIYTYraDRoK1hTbml1YXVIeW81OEsyN3NKbDg0RUx2aXJQWk5sNG55ZEQ1?=
 =?utf-8?B?czdWbG5iSzl6YUVIZEM0YnZHSmhqaVlnY0EyR1ZXTHpONnlNM2wwWFlKS1RE?=
 =?utf-8?B?TExsanNJMGhnN3hCbHZxNWYycTd1UTlWMjJXSG45USt4MmQxQ29XRUtHY2NT?=
 =?utf-8?B?SlRxL3FzbGtCdTJiTGp1NkVYTHZIanN1Nyt4WE1yVE1lYVRpYXNVTENRTytY?=
 =?utf-8?B?UXRwZzRnYTNGSFdZZkE4UVZVbHRQaGkzSnJLNEUxRXZQdjAweE5pMXhTOTdX?=
 =?utf-8?B?ekRKVG1KZ1Z4UTltenh4WnpCSFRsbCtVeDdHM2cyUUJxQmpKWW0raTkya3pK?=
 =?utf-8?B?VVlndDRYY2RaN01yUWVHc200NTlyUERyOGlOUzZpWWtlZnZKbk9ta1N0eklR?=
 =?utf-8?B?SFY5NjZuTDBDamxJOENGWkF4ZzNmYyt3aXRtMXVKa3RsbWtsTTExN2pRazEx?=
 =?utf-8?B?NWNqd1FVMDIyYzFiWDhpbTZWU0FTV2czRVc4VUhPS050RzhoWlJVQUJKdkJq?=
 =?utf-8?B?dGhJZFpvaDRpeklRWUZNR1lwTEtwVDNBYmZzeG1LKzk5bXVSeld2Nld3L3or?=
 =?utf-8?B?N2xyS2hzT25wU0xOUVJwd25TVFM4U2hZbFdqbTdST3NTQktvNVRZRmI1cWwx?=
 =?utf-8?B?K1FVREFFbHEyUVRzdzZCa2pMMVMvVS9yQnFjWUw2TkgrQ0xPYmxWSFN6ZGkw?=
 =?utf-8?B?M0tiVEVTekxBQy95OUJlU0tycXRCZE1GREhPZHVWZ3lNVlN4RzByWHAxVWNv?=
 =?utf-8?B?dVdPc3lselBOQU4zdm1XMEgyVDluOC9ZWWxZZXBwTkFvcnA4QTFIdUEwemdi?=
 =?utf-8?B?ZW51U1VOWDZ0TkhqUVBlTXJYSXlMN0JKdzVFcitSNlAvNEx5b1owaForR2R6?=
 =?utf-8?B?ZlFqK1hQUDVsNkM3MFRTVVRsUldaUDdsYzhFOVowRzhkcFVpRDRBOE4zb2s2?=
 =?utf-8?Q?5R7piSJX4hTS8qIh+hzyD257q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a16d1b-7e54-4de1-2c7e-08dc90b08736
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 22:38:23.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGfrYEMnBnLkMGGd9Z9Gb3T+vXNTL/cAAJOgSQ5r8PwQYToHsAkqccY1xnr3cFDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588

Hi Reinette,

On 6/13/2024 8:48 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> ABMC feature requires to users to assign a hardware counter to an RMID
> 
> "requires to users" -> "requires users"?

Sure.

> 
>> to monitor the events. Provide the interfaces to assign a counter.
>>
>> Individual counters are configured by writing to L3_QOS_ABMC_CFG MSR
>> and specifying the counter id, bandwidth source, and bandwidth types.
> 
> Where is discription of what this patch does and why?
> 
> This and following patches seem to introduce building blocks that
> are only used later in series. These building blocks are introduced
> without any information about what they do and why and that makes it
> difficult to understand how this work will fall into place.

Ok. Will elaborate this.


> 
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable 
>> Bandwidth
>>      Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v4: Commit message update.
>>      User bitmap APIs where applicable.
>>      Changed the interfaces considering MPAM(arm).
>>      Added domain specific assignment.
>>
>> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>>      The function is not called directly from user anymore. These
>>      changes are related to global assignment interface.
>>
>> v2: Minor text changes in commit message.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |   3 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 101 +++++++++++++++++++++++++
>>   2 files changed, 104 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 45ed33f4f0ff..a88c8fc5e4df 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -657,6 +657,9 @@ void rdt_domain_reconfigure_cdp(struct 
>> rdt_resource *r);
>>   void __init resctrl_file_fflags_init(const char *config,
>>                        unsigned long fflags);
>>   void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>> +int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
>> +            u32 ctr_id, u32 closid, bool enable);
>> +int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0e425c91fa46..48df76499a04 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -203,6 +203,19 @@ static void num_cntrs_init(void)
>>       num_cntrs_free_map_len = r->mon.num_cntrs;
>>   }
>> +static int assign_cntrs_alloc(void)
> 
> Only one counter is allocated and "assign" is unexpected since it
> seems to imply how this counter will be used.
> It can just be "mon_cntr_alloc()"?

Sure.

> 
>> +{
>> +    u32 ctr_id = find_first_bit(&num_cntrs_free_map,
>> +                    num_cntrs_free_map_len);
>> +
>> +    if (ctr_id >= num_cntrs_free_map_len)
>> +        return -ENOSPC;
>> +
>> +    __clear_bit(ctr_id, &num_cntrs_free_map);
>> +
>> +    return ctr_id;
>> +}
>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -1830,6 +1843,94 @@ static ssize_t 
>> mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>       return ret ?: nbytes;
>>   }
>> +static void rdtgroup_abmc_cfg(void *info)
>> +{
>> +    u64 *msrval = info;
>> +
>> +    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
>> +}
>> +
> 
> Please add comments to these functions to summarize what
> they do.

Sure.

> 
>> +int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
>> +            u32 ctr_id, u32 closid, bool enable)
>> +{
>> +    struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +    struct arch_mbm_state *arch_mbm;
>> +
>> +    abmc_cfg.split.cfg_en = 1;
>> +    abmc_cfg.split.ctr_en = enable ? 1 : 0;
>> +    abmc_cfg.split.ctr_id = ctr_id;
>> +    abmc_cfg.split.bw_src = rmid;
>> +
>> +    /*
>> +     * Read the event configuration from the domain and pass it as
>> +     * bw_type.
>> +     */
>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +        abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +        arch_mbm = &hw_dom->arch_mbm_total[rmid];
>> +    } else {
>> +        abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +        arch_mbm = &hw_dom->arch_mbm_local[rmid];
>> +    }
>> +
>> +    smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_cfg, &abmc_cfg, 
>> 1);
>> +
>> +    /* Reset the internal counters */
> 
> "internal counters"? This needs a definition ... but since this is not
> a new data structure the comment can be more specific about what is done
> and why.

How about?
/* Reset internal mbm event counters. */

> 
>> +    if (arch_mbm)
>> +        memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +
>> +    return 0;
> 
> If this function always succeeds then it can just be void?

Sure. We can do that.

> 
>> +}
>> +
>> +int resctrl_grp_assign(struct rdtgroup *rdtgrp, u32 evtid)
> 
> Please use consistent naming. Note how the filename is "rdtgroup.c" and 
> this
> function operates on "struct rdtgroup" and if you take a closer look at
> the functions in this file and the header where you add this function you
> will notice a distinct pattern of "rdtgroup_" used as prefix. There really
> is no reason to start a new namespace for this.

Sure.

> 
>> +{
>> +    struct rdt_resource *r = 
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    int ctr_id = 0, index;
>> +    struct rdt_domain *d;
>> +    u32 mon_state;
>> +
>> +    index = mon_event_config_index_get(evtid);
>> +    if (index == INVALID_CONFIG_INDEX) {
>> +        rdt_last_cmd_puts("Invalid event id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +        mon_state = ASSIGN_TOTAL;
>> +    } else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID) {
>> +        mon_state = ASSIGN_LOCAL;
>> +    } else {
>> +        rdt_last_cmd_puts("Invalid event id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Nothing to do if event has been assigned already */
>> +    if (rdtgrp->mon.mon_state & mon_state) {
> 
> Why is this mon_state needed? Is it not redundant when considering that
> struct mongroup has an array of counter IDs that can already be used
> to see if a counter is assigned or not?
> What if there is a new:
> #define MON_CNTR_UNSET U32_MAX
> 
> When cntr_id[index] == MON_CNTR_UNSET then it is not assigned.

Yes. That can be done. That case mon_state is not required. We just need 
the index. Also, we need to initialize the ctrl_id when the group is 
created. Hope that should work.

> 
>> +        rdt_last_cmd_puts("ABMC counter is assigned already\n");
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Allocate a new counter and update domains
>> +     */
>> +    ctr_id = assign_cntrs_alloc();
>> +    if (ctr_id < 0) {
>> +        rdt_last_cmd_puts("Out of ABMC counters\n");
>> +        return -ENOSPC;
>> +    }
>> +
>> +    rdtgrp->mon.ctr_id[index] = ctr_id;
>> +
>> +    list_for_each_entry(d, &r->domains, list)
>> +        resctrl_arch_assign(d, evtid, rdtgrp->mon.rmid, ctr_id,
>> +                    rdtgrp->closid, 1);
>> +
>> +    rdtgrp->mon.mon_state |= mon_state;
>> +
>> +    return 0;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
> 
> Reinette
> 

-- 
- Babu Moger

