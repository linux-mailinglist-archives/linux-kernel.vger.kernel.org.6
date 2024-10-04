Return-Path: <linux-kernel+bounces-350771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE73990970
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8407287B16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E001CACED;
	Fri,  4 Oct 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a3WEKQ6K"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C721E3788;
	Fri,  4 Oct 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059893; cv=fail; b=VIkPMb3Oo8MzaWT2whCTDRP+wDho7irbiYb0uAqHyCm89ORuMMBMfnfZpm7fX/YqfyEscx8wtg12WeZdLmbyml23J7tudtQXs1h/YqjWDk6mKNWcDyj7RiqxAaCmTmXXe3W6Z6ggMcsVWqQAN42nUGxyqFbLxMxsMdKpYl27mj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059893; c=relaxed/simple;
	bh=dLAv2/SyBjGwoD9Jq0NrtQMu3UNalBevlIPItk39nDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J59liPuRYtxnhHkaP2KVHvrXa6W19QKm4iiexHxt7R+1e1QivZYc89TLj5BsmW0hejTdYq4GQ132hIHLy9xbqMSxTHfvBCPaxs25LGO1+IDTvNM+/fs4+LabTQcc/9F30dwcIXT7Yoc012zTMazBnWP/VCPvVcXA4qlJDnHDHbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a3WEKQ6K; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=px1dL43VdaBYYozmV4YlNzyJO+kM1HVKPzh7Ovz30HSkfqWZLU/T7B4cHp3wdTA1TElCag9npD8Yx/uoAwgSZpBTEduxxAyKZupwfWMgVBrNNJnh+EsMaCafJFdRG40S9HQz+WILnUnZx2YkoTjmd1g4+B+CvqUKeH2rczxWfpmTh1tyE3zrOFJf+GtcdMQuqvbnssKObjJvhr3XNVv8AJouwHDA4zooB1nNOj8twEAuvZoQDgRDU4eeUwrl9QJh1yl0JolBx7Kyq4nfLYNSFCT2cqwyd81tTEdSCbOd9nWTUdpm6KEhlFo4bF+ZmqbVnG0noegjWqTp8R2R0APAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHZXRm+VZxVcByj/P3qBfkPBvp9MSq96uyjj3KBqB2w=;
 b=w9MR71U92yx4qJ6esbeenoMQWI3943g/vlxdC8gKOJDUS/FNgU9pkFZeHPu6yqigQTA2zdne56u8Tc2ZiLnBJXFditNrSSUjLNu/ezL4/vt2bFZp2tzxX6VfKCpgEgma4p/GrW+l1J15KbL6RLyjbzuGxF+//efKbjvP3AQZS4Nq6zFdF3dGEpXARWa+oieC7uri8MMEew4Lsf9AawVDN6vV7NAFbzQ8V3w4pjYyfKNNUNzCTMZuQWxNuvswKta0Rw0LWAyZ1n0+WXqynCPlUg1MDGKRP4PFh6YJrBONIVI2aZXw+LSWxnj3G4ATI9ZDxgDHn3yCkrRPdFqo8CLG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHZXRm+VZxVcByj/P3qBfkPBvp9MSq96uyjj3KBqB2w=;
 b=a3WEKQ6KBZswTzx9Jbflf8CS2RRul4d1HeMu/Vm2Kus+5j1WCQNqM7lpW90nE1XxGiHioq6o+HhnbUfgpuCSB3xoDsak1TBVzVOBJN31JKb2fNyNqyGZGy/lZdTQIHOZK7ae/5vtFP47il/o1E94/ziL1d+fXqJZG21dn1t0kL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 16:38:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 16:38:08 +0000
Message-ID: <3b6a8ec9-5e4f-e4ff-cd01-96ecc366565a@amd.com>
Date: Fri, 4 Oct 2024 11:38:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
 <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
 <1d987ed1-0065-4e4b-a719-65af93907974@intel.com>
 <ca7b1d14-e37d-5f0d-9371-32d8506e51eb@amd.com>
 <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <cd2d835b-cc63-4416-b0ee-20334b9b43dd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0074.namprd12.prod.outlook.com
 (2603:10b6:802:20::45) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d07044-5398-4742-755a-08dce492ed5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FvdXYyL3Vkc0NNTHV3c1R6TDZzd1A1Z2Yvb3dBMmdsR3M4VHJ3ZGZ4dFBx?=
 =?utf-8?B?bExvSmNEdm5zNXArMnFGZUxqckRkUE5kQjdCT3EzWXZBbHo4TGJBR1hZOVhD?=
 =?utf-8?B?aXNHVHdxdEowOW5COU1GdnR5ME14d3g4Ymt0dFB1b0FNUWNLWU96dzdEVVUz?=
 =?utf-8?B?NHE5TjVkR3c4YW5pWTdtR20yWHQzUHZtOURzaExDNE9odGg1enpMaEhldTlT?=
 =?utf-8?B?dVpjbG15b28yY2dWTWJTQWRYTkdVTXYxN09TQ2FSUjhWVG96cFhpaFVjbXQw?=
 =?utf-8?B?M1dRRUI4VE9JL2JCZWlXckNpOEdMcWl0anBVVm1DQ1Vja2xPSU1UTVQ3Smg2?=
 =?utf-8?B?ZzQ1VGI2bTRwNzRHRkoxNkxwbVJMcGloY1Q5Um1CaUdXNXU3QXBRdHA5MGxz?=
 =?utf-8?B?SGN3azFvaVN1NnlUMTRDeGVldzRTQWpUblJyOEpISFlvR3pyUC80UjJNVEZx?=
 =?utf-8?B?NC83Z1hFa2kzVlg1WVBhNjhibjZySlFZZVFldFhYMm5CUDZJOVJ1WFprczZJ?=
 =?utf-8?B?b0JmUkhNZzREUDQ1QWpRLy9hQTNLYnRtWTV6THhrclpDY1MyN2VjOFBLVUpl?=
 =?utf-8?B?azRIclVydmdsTmpYL2VjdkZ3cEcxN3pNS1NHbGJsNEpROHZsb2JCSmtpWGhB?=
 =?utf-8?B?cWw4cVRIb0lWVXBDNjlodG5xNi80cERRL1gyOHRmNEh4KzVidFBIekpucTl1?=
 =?utf-8?B?ZXQ1NWZReFBPQ291ZHJhN1hDN0owZUtacWxTdW9JSzFNc2JBNGZPOGhqRS8w?=
 =?utf-8?B?em5NUEhiZ0xRYjZYcXBmai80VG9SQ1l3U3ZiYzdlKzhrTTJUc3pPSitEdkJx?=
 =?utf-8?B?ald1azIybVFReHgvaGJhWDlBeW96TWdCbU5DUTV0UFMrZUZmUG5Fbk5oTVhP?=
 =?utf-8?B?UkU3aVc1ZGtBTFZNK1NoTlJQRDA0YVhMcnd0dG1RMkJLdW1GRXZ2RkRkWTh1?=
 =?utf-8?B?YWtzbkZIektqMXpEbXM0NnU5WEdOenlCWFlkaWNzMHhJa3k4OUFtOGdIM2Jn?=
 =?utf-8?B?eGkyc3ZzVlpDNFEwZG8xbFViVjBTVDNaQ0dpRUxqQnNYRzZieDNRYXZlLzlF?=
 =?utf-8?B?STRhcVk2akJua1NVdC9tWlhVVnlBdVhyV2N3SEdVSU1YRGl4c1VZNENQNngr?=
 =?utf-8?B?V2RnL0g0NC9IZDVRbW5Cc0pMWGhINGVpa3dJZ1NjaWNMVXFoeDllWUdNYWV0?=
 =?utf-8?B?WEZoUGFYTk9CVnNseXVZK1ZDN0tsNWpTbm5jTi9vNmJjUHhSdU5qRjdKM0wy?=
 =?utf-8?B?NmJZVjZrLzNTMjZzKzZVWENzTnk1OXpxdkdGdW8xUm5tMGtsWnArQ0phWGsv?=
 =?utf-8?B?UVRyaFRseUNKQXFXUDRaOTVLYWkwSVBIOVNCOFk2dzM4NXpTVk5SYlJOK2I2?=
 =?utf-8?B?YUUyMkV4empVZFFjRFZxRnNNVWRubWczSTkrMzloUkp4UzdkbDlCQ2ZtdEcy?=
 =?utf-8?B?bFFlTEtQNW9NV1dBb2RFQmlyUUh6WGxmamdwc0IxOWl5MExTQVR1TW5NTlRa?=
 =?utf-8?B?R0t1bEVsbFFpL2QyTERYZUQ3Ym9xbSs5MFZCam0wd1grcDdrR2ZNNG1wWnM5?=
 =?utf-8?B?OUtOT2hPQWZkNFQ3ZTV5UERxUW53YzJmUjAzdVFXREVFbTVWTGZWTVNTTHpP?=
 =?utf-8?B?b21aazFhaUlWWHRxa01Wd09hajY5d0toeXRYRkxScGtPemRNRzhkYncxS3hJ?=
 =?utf-8?B?OWJvWmswVk4zTWFIOFdDVHljZ3ZXQVRlTWMzWExHVUx6VHFveVV3T0t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amlybHQzeWpmSGxNV2tjcHJGMWpUcXV1Zi9yc3AzcDAyejVHdzVHcVo5bjcy?=
 =?utf-8?B?UVQzZW9mQ3RxZlRzUUhRdWxTUDY3QXdrZFVVaE5hNzlwbFBtekV3UFgrNjRW?=
 =?utf-8?B?NzQxdnBlam14RFdQQ3RkMUxIcFl4WkwxOG1xTXNod0F4UE1OamgwTzVzcjlx?=
 =?utf-8?B?di9lVEFFOGdnczJrdEI0bEh2UHhBWEtycE8rWlFkTnU2V2MzWFN2OUVjcnBV?=
 =?utf-8?B?ekFMd3hsaEoxdnBzRE54d1Vic0t2U1JlQW9pdmhKdisrTHpSeC9qcm9TaE9t?=
 =?utf-8?B?QU9oZUtCRTFvcE16Wms5dDQ2OElvU0JKakFFYndLZFdCcjNyUkE1TFdxYmJN?=
 =?utf-8?B?R0FhL0k5T05HVlNsVEVFQWZuZ3JtNjBseG1aYkVWUisxMGxLczMrREJSbVRz?=
 =?utf-8?B?dmpOem5vQ3BvRXFyM1pYQWl0dlYyZHNUZUx1aEVQcThmSU1VQUdQZng1bWZV?=
 =?utf-8?B?M1pocE5kRXluVUdseStUQ0lUd3FSZWd0dUJ6L29mT2hBVFNlakFTaG12ZTBT?=
 =?utf-8?B?Z3pzK0J2T2gzcy9BanNKbVRyV3V6Z3FZdUZRZUZzTmZIcjBQSHgzc3FVUERi?=
 =?utf-8?B?ZUxxTzA2STdMYmNPWmpBRnJHRFp4ZDR1WG96ZTd3KzN2SzRlV1JPTGphNnZW?=
 =?utf-8?B?d1FnWWdJeFlCYWRoSkNkN0d6RHBPOXdaNklTbUpUZFhGMnFNdXBLZExEOXFU?=
 =?utf-8?B?OVpJYWhJTGpheHByMXo1VnVXdDY0cGRXYUtmMGZnOGIyOFY1TktUamxnMUYy?=
 =?utf-8?B?d3ptNWZveEdaNlNWMzZRdlJyMkNJcXRMbTNCWEM3M2ZWR0dObVVLRzZoMDlY?=
 =?utf-8?B?MFJLSjVRbzJLaEd4QVBTcDlhbmlJMUM0cmNEVWFVRm9Gd0RnZ01tYWlaSjEz?=
 =?utf-8?B?SE1WMlpvd2NmdVBUeXNYMTlvUHdnVGtabzkzQUFIbUVobU0yR0hSMzhRdVJ1?=
 =?utf-8?B?cHRBN1BmTTJ5SnBhQ3RLNlpnRDA2eFRHL215VmNWM3F4SCt6WlRscUIrSFF2?=
 =?utf-8?B?anYxZE01RU94RXhEVE5tNHBQNTlPd0dETS8yVjhST1JaYVhFdVRZcCs1aXAx?=
 =?utf-8?B?QWlUWDhkR2h3aTR0YXV3WGplc3BQQnE1aUFzcUlMVjZzdXZ2cjlBc3pHVFg4?=
 =?utf-8?B?Yk1ZalV3cU5VZ0lXUDgvSFpabUMxbEU2c1V4VWVvQ2RoZ0FncE5XLzI1bzBQ?=
 =?utf-8?B?ZWhDL0Z6ZHl2aC9hbGxjRFZyVlJXQkNOMitUZURQMFgzaEVhSHVtRXB4K1Z1?=
 =?utf-8?B?RmUrV1F5WVpCNmE4aktNdk9yRGlEUFBIdHVybG44T1V3a011VFZoZCtOUXdY?=
 =?utf-8?B?VkdmeWJ2K0JEd1lRbjNlQmVsL0toNHdtZzZjZ09JUDF5ZHBHUWl5ZUZPaW15?=
 =?utf-8?B?dWtRcllCT2tLNVAzM1A0SFcwdDhhVlYxY1huamhrMERpdzdkNExMTFNqRllO?=
 =?utf-8?B?Zy9WajZDSlJYTXJnRlFJdE9uTGJPd0xIaStPQmVBTzBLbmhCU2F3RnI3Kzdr?=
 =?utf-8?B?NXNGUWhxZ1dHSlVmaTlKaklucStCVWxoUEZRZXArL1BSbTUvb1p0RjNEL01u?=
 =?utf-8?B?LzQ0Z0d1UDE0Nlc3N2xxUDRNc0FIK1RLcG1kM0dpVm0vdUNQVEE5STUvODNj?=
 =?utf-8?B?dHR0Qk9IeTlxWGtuaXVqbXdBTVRSQkoxNzhlUTBHSVVSSU9tNnJsc0o1bFNF?=
 =?utf-8?B?cGFpMHFyUjVQekJIalVKRktSQWlNYm0rdElUZkgwSm9xZldqNnBIdGhoZ1cw?=
 =?utf-8?B?b2w1ODE3amxuWTU5NlJac0UyQkRyN3RmLzV2VzJXcGdtYjdEaXU0OVZNT1NY?=
 =?utf-8?B?WnpHQWdLS0Y1emhWK0hEcjRHVXRKV2E2SitxUE5zWkMzd1ZJdlZnTTF4S2pp?=
 =?utf-8?B?dW80QTNLNTFTbUhNRElaZzQrZnlOeDJXdzBGdzB4dHh3dXpEc1FDcGpYd3pT?=
 =?utf-8?B?bWl2RkdNK2NYNnhxYkpZRHBCN0RvUFRFbDBjamJvRm5UWWxWY3ZSbFBHNEJ6?=
 =?utf-8?B?Vk1JOVNUSkZ0Z2FCRFlkaHY5VThlY3htMjJMbE00bUdXb3cwSG5kVXU0bDB5?=
 =?utf-8?B?V0JOdFlZb2M4Z0RFNGF4L3JIRGxaYS9OMmFoMlcwTGE2bXQvSDJIVitpOTVL?=
 =?utf-8?Q?73sI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d07044-5398-4742-755a-08dce492ed5e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:38:08.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SZUeq69JAeNUk8AEUqBhlCF862O8+rfeCqWgJ8ka4ew5mtpAAk9XfRVblrDlrAQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

Hi Reinette,

On 10/3/2024 9:17 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/3/24 6:11 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 10/2/2024 1:19 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/27/24 10:47 AM, Moger, Babu wrote:
>>>> On 9/19/2024 12:59 PM, Reinette Chatre wrote:
>>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>
>>>>>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>>>>>        Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>>>>>        Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>>>>>        Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>>>>>        Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>>>>>        Removed ABMC reference in FS code.
>>>>>>        Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>>>>>        Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>>>>>        Users have the liberty to pass the flags. Restricting it might be a problem later.
>>>>>
>>>>> Could you please give an example of what problem may be encountered later? An assignment
>>>>> like "domain=_lt" seems like a contradiction to me since user space essentially asks
>>>>> for "None of the MBM events" as well as "MBM total event" and "MBM local event".
>>>>
>>>> I agree it is contradiction. But user is the one who decides to do that. I think we should allow it. Also, there is some value to it as well.
>>>>
>>>> "domain=_lt" This will also reset the counters if the total and local events are assigned earlier this action.
>>>
>>> The last sentence is not clear to me. Could you please elaborate what
>>> you mean with "are assigned earlier this action"?
>>>
>>
>> I think I confused you here. "domain=_lt" is equivalent to "domain=lt".  My reasoning is handling all the combination in the code adds code complexity and leave it the user what he wants to do.
> 
> hmmm ... and how about "domain=lt_"? Do you think this should also be equivalent to
> "domain=lt" or perhaps an expectation that counters should be assigned to the two events
> and then immediately unassigned?

Yes. "domain=lt_" should be "domain=lt".

> 
> Giving user such flexibility may be interpreted as the assignment seen as acting
> sequentially through the flags provided. Ideally the interface should behave in
> a predictable way if the goal is to provide flexibility to the user.
> 

My only concern is adding the check now and reverting it back later.
Basically process the flags sequentially and don't differentiate between 
the flags. I feel it fits the predictable behavior. No?

-- 
- Babu Moger

