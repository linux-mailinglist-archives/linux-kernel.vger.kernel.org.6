Return-Path: <linux-kernel+bounces-425023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EA9DBC92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CAEB21D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA751C1F38;
	Thu, 28 Nov 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYS5xJ9Z"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE41C1F27;
	Thu, 28 Nov 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822521; cv=fail; b=W8hq56q7gqyfIe4QTPFMiKDU3HPWguPjOQpW5KA/9QfRdpwai2mQFnZRlx+7Y1fZmlR+1qrANj/jtzGOnn7RXbAIdSXRrVWNmZ5Ydhf1vN92Te5OkDwQ8K35YxQSgFoO9IS9jtxIESl39m6gkHzUZu82aLnfvneElze3ba3Z1gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822521; c=relaxed/simple;
	bh=N8TG9iOcVGQxqf4+SmXLhz2KgCoc0sWby1KOuHQz4QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqerbg1zaZqNo8BHukSaz8Onfp9+gjfO/2KOVbTCnYrQs61+CD6yID3loT3ewqp6DvXMBxqKWN/2oDIsFAw5ZTNQ+AzK4Tf7U5730JnSpbxKlfJjGeOe2bTMfMMrGO/MgGJmIqOxkUk5327hAl/B1wQaEPpMtlerpYESgNXmvh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYS5xJ9Z; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFiCLpX+xJYVpR2QNsXgE50Sxd4zj20zfMTjryX5l9iPfaMUzT1tNG9dh8m5g83ZhIzE7D9VKhYTbg8zMOch6N8Y+nqgXwjMt7/QNdbfOHawnenkbXmH0Di2uKfjUzvw1LSgyUV1B/PwJHeB5GdmaFT3Vay1V0uwmXQ6O8FFO7cYIGOFw5aXKrja0ySKUko0kGcVVJ7e5CEILzqPgbo08Gt91e0OzE+VSPrKljq3hA8/z9EBMxjWxYJioSj+ttftxzEdFM7IkVmHNTU+C+wrHjd/N6LTyY4Gs1qoExcUUfXbHAGRKJNN+cWIue/sM8NlbMvJjkbqGiNrusk8T7UlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYOdqISJxuXpB9+Aw5y3ayuocdtfv+13o31fkiNCMKE=;
 b=Jm9QCayLSSXCQQ7P37oI4TJT41ppiDp47TnSfYpnJsxw8SnbMbUsftUqYsu8QX15BDWlWZOPzbMrJfl2Us/HggAo+iUmc2xG9lI59yLVOKPmEFIYsjR7sgKqbJh7WjmKHZx45P2HTnZ7kMoqypPfPRzsPny90jKk3tVxaSoY+5xaT+V21WdJmbnXrOevBHo9uz816RptWaTMmAJj7VJ1ZA0dDPZqp+5uq3nFCvUsk9JH4kiYIh30VSYjEEdPId2PJ0n0unX6jWTP5rFtKeFLgYib7futZrth2BsBnTC/0cR1hQEaj/qbGle/YCMqLsoDSLT3pvvlGOjmvWqW9EVwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYOdqISJxuXpB9+Aw5y3ayuocdtfv+13o31fkiNCMKE=;
 b=BYS5xJ9ZwgDF2YM6cRN6CMu2enM5RaiQ44geUzMXoHuBsjyctctpcat22ZSY1eEo3ms70nAUuhfO9l2+vXdfIVOwHIHvljT5RHNJrZh2gAdrff7bxjJJX/TZEOp1tN+vfwhBlfdddSP+S9te4xeA3mBsc+Pi5Tjw6sH9CgPmaEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 19:35:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 19:35:14 +0000
Message-ID: <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
Date: Thu, 28 Nov 2024 13:35:09 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
 x86@kernel.org, hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org,
 rostedt@goodmis.org, akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:805:ca::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f07d90c-82e4-402a-8008-08dd0fe3c7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnlGSlh6QU5Sc0pQemdNZEIzdnZzZ2t0ck5KQ0VEa1l2NThJdTEwMG5zTTQv?=
 =?utf-8?B?SVhSS3JZcTkyVEI3TlA4MllZNlpYYTZmNHIrZmEwZDc1TnE5b3FkOTN4Ujh1?=
 =?utf-8?B?MnJLVWNLVjBiakI0SFEyK2V6T2VWb3M1L2ozUVl6MExoQjJPeTJFaHgxTGNZ?=
 =?utf-8?B?YTVSc3Y2MHllcHpvd2ViUHB2UDBmbmJ1Qi9DcUs2UytpcjJIckx2dXVyeURy?=
 =?utf-8?B?dEw3RElKNTVPZ3FibHVUb3Z5cldKbGZwclpYYUFkcGc1VnI5cEx2QTl1NnRo?=
 =?utf-8?B?bFJoMTR0RnVLeWRKRmNwdnNDSHZZMGduamR5R1pTWG5uc21hWlN1dEErSElJ?=
 =?utf-8?B?bmMyVDNvcjhQemVaTUlRaW56UjJTTzdpUk9HYnFoVDAwbGs3THJJL1lOb0Fh?=
 =?utf-8?B?NUJuSXRqN1IySTRoQ2JPWTV6eFNBMnI0ZGRtVVIrcEpQRVROeU51OVViM0R5?=
 =?utf-8?B?NWNRaTFBMEJaZ2ZtUktPZWsrNDZRVExyQVdGR2xNWmFmUG43Nkowc0ZvbUtq?=
 =?utf-8?B?UFRQVk15UVFBSXlpbVpNRG5SbkVDeFpTMHg4QWlSaGVpY3JYYkhQMTZuSWh4?=
 =?utf-8?B?NVE5aUVkNUJ0by9GQU9kZjF5cnpQR21iRDZ0TWNkRTIxS1V5amF2OHlCUFRD?=
 =?utf-8?B?eWpHQUJWOTg1dDJ6UFZWeHZPTGRIcmRqdzRaSmQvYU5nbWxOOUJWUVFtOHFj?=
 =?utf-8?B?eDBlVHBHTFhxOFkxUnkrUFhlQzZkN3ordnNpLzVpT1RkVWRkcDJiSHRROEUz?=
 =?utf-8?B?em05WXZKcVlNQjhMbmR4N3VES0RoSnZCWEdJN0FWdTBqZmNGUTRkcnA2K2R1?=
 =?utf-8?B?TXZLR3lXakhSelcydFVJakZTN0ZkSHZyaW5PRkJqcnVCdGZFVlBCdWlFeWNt?=
 =?utf-8?B?ZkN3NVZCbHlyQmluMGEwczZ4amVmUG56TGJNRi96Z0ZPbzQxYk1tQWE0TmpW?=
 =?utf-8?B?ZGhFeU9xdFJsR0RCYnpLd3FtUkFxWEovRHpGN3ZNS2V5SVdJRlRwZTliWFZP?=
 =?utf-8?B?U0JTVi9KWWgzd1BOcksvdmV3QktkSnpCT29MK0tlYW9PaHpoN2N4aW9oamZ3?=
 =?utf-8?B?YVdWRnEwb2RuU0x2M3FZcHVGVmlIWWJtUWJmYzVYWG92NWdwU1V4ZldRSGk4?=
 =?utf-8?B?aTRWRDZnNEJpa1N6cUFPOHB6aUh2dzdvbXBQSS9ic29jd3hWTElVQlFjNFNz?=
 =?utf-8?B?UHE1UlNmZzhsRktvZy90VnNRM2hVcFdiQmZCZ2cyS2ZoZ1BFWks4eWpoM0Vr?=
 =?utf-8?B?RDNNMEQraEdjOFZKYkxwZFFrM3hlcXlWSVlPZ0Q5S0ljV0N3RW45bmJQeGVZ?=
 =?utf-8?B?TnpDRnhLeXg1U3JsRG5lbDRiMUFzb1U5T2ZCZllNRzRzVkFROUpVcmhJUDlw?=
 =?utf-8?B?MFBYNzJVeTBmSVdRV2ZjM2RQeDVGMkZMcnZXSjg3ZGxHU2N1bGtGNXZwR2M0?=
 =?utf-8?B?UVQ3WVloQnRJaDZ0T1FHcXdEaXVBNG02SFJreDViQzlqUWcyLzNnMHowYzVu?=
 =?utf-8?B?aGw5dlVxcFF5dE15c0Q0L1hrNmVPVmRVcXNQWkUybGVIKzVuWXFpSnZFWnlQ?=
 =?utf-8?B?ZWd1N0wzeUJFZlBLTlFSMVIvSUtCdlE4Qk5kNExtc0twU1NVbGpoUlgzYUEv?=
 =?utf-8?B?emR6L21Jd1lYQkpPK1pHV3JtUFNzbGtKTnlXUk1oVEtPS1ZqYUpvYWdRWmYz?=
 =?utf-8?B?ci9ZbjlOa2hnNzN4Tlg2RlQ0MGhYS05xN3MyV0VoZDY4ZzRaMEc5SFJ5RFdD?=
 =?utf-8?Q?ABybhvhSbfgzl3aRXBdoNCxp6jbXQCb/PANpPTg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1Q2YTR3UDBhQVlNQmphZ3J1c2IzRk9uTVdHaUtNWElpMDNpMDJsblVkVlFD?=
 =?utf-8?B?MXlzTWVTL01DaWR5VVVXK2xHdFp4VE81Z3lOZnFXckpnOCthM0pQbUo0Y3VF?=
 =?utf-8?B?dXJFTUxtY3FwMHc4NXo4OEsreEk0RUswa1FFSktnVEVMY0Fqb21JVmpUK1Yy?=
 =?utf-8?B?ZUQrN1RId1grQ0dIMU1naWZBajlYUjVrc2VTaHduK1BUNWZOV05jM1hoY2VZ?=
 =?utf-8?B?VGlxWGxwWW1lWkdCVVNoeWx1ZnJEOEZVanNabnhYUjdlZXM5blFKMVAzQkNo?=
 =?utf-8?B?NHpjMUVtRzN1NzQrWllPM0d4M2FrZ0VDOCtyblk2S2Q3anZTelViQXpHcGU1?=
 =?utf-8?B?a0Qrc3Ixa1I5SUlBdytsQ2NrZDAwTXVpOXllK1hKSmlQT2F2VGJCNzlxcmFW?=
 =?utf-8?B?alhEbVE1aUNxK2RLODF5ZytFdEtuT015aHRtNmlFcXVTbE1ON1pVNnVMK25o?=
 =?utf-8?B?S3RNbmJXTVg1SkYvL1lDWkYvL3ZiemlqTS9sbEdINDkwenNPNlFpelMxTEZl?=
 =?utf-8?B?R1lkK0lsWGJ2MG5MT3F6N3J2Q2REQnVMMVl1VzVCWGpoZFFQVEwyRE5uUStB?=
 =?utf-8?B?bnBYWE5TeHV0L0RuVng5b0t6TEdOTVgvR09oU1BwdDNwckJBbStyM1lWdnQx?=
 =?utf-8?B?dkpWazVTbzFjOEFka0REMEpSS0NVemlWRWNFeEc2WGNnNUpPajhYelM1RHE2?=
 =?utf-8?B?NzkzSGNDc1YyWW1TclphL29VUlozT25kTzlxYzFOa3RoSHJMOUZXYUorY1ZN?=
 =?utf-8?B?WDBFU0EreHFoSjJWeEJtMHlsaElGcDdvenFtRE5nL2QwaVFoeUhIRmpTeHpQ?=
 =?utf-8?B?VzJOVjB1OGphN1pRaFBqTkw5QTJCR2MyTGtIUWtMV0w1ZWcvdElveG1hQXFo?=
 =?utf-8?B?azNaUE1OamR2Y2VaNmRWS0ZYdlpvMkUrcDZXYnlRUHk2ck0yTEthcjhmZC9N?=
 =?utf-8?B?czFJRFh4YmxoZTFSa3ZqYzZadGdiVkEvQVdNNkZzNS8rUTFuRE9SVW9sM0M5?=
 =?utf-8?B?c1RWQ0dJcVdOMjIzVFVScERUYi8zUDk2SVBWTHBnRzBMSDNMeHNrUFBNaUF5?=
 =?utf-8?B?a3QxTUsrRFhadG1JL2RRSTFHZ1hraU5FS3BOL05UWnRFbytBWFRNMzRSRzNw?=
 =?utf-8?B?VklZc1dYR0ZYamgzUzNQZktGbVQrQ2RqS3Y2WTZ0SEcvWVMzSURSWTh2eVhQ?=
 =?utf-8?B?OHJPdEowbWNYOUxtNVVEeVR5OHhBY0F6Z1hEaVcxcTBlMUgvYnpWekhtSDIr?=
 =?utf-8?B?MmphOEV0ZXIxZERWSUxTOTVjVGRZOVpNc01yQUpoU3o1dVdkWCtRTlBnSmp5?=
 =?utf-8?B?NnFNSDc2cElCVzBNdWYyQWpaa3JoRW9Ya0tsbjBBNEdpYjdhWlRoMVRBd3M5?=
 =?utf-8?B?VkhaZzBPUHVieUp2U1ppSk9XSG0xRVlmSWtoTVlOMXR0bE1TZWRUTEljeWc5?=
 =?utf-8?B?ZlgvS0NlVDRhekNUNnBSb3NrdnRnQVFid25YTkVTamZRMzJWZXUvbVdFUlRz?=
 =?utf-8?B?Nml0R2kyY0VqZWJvQTdldnlTb3MwOTBkSWJhM2dCM0k2VWR6dDNIQ3pUSlV4?=
 =?utf-8?B?TE5tQ0VpTTJrTVdHTVlkQTIwalA1Q3Jpa0Jxajh4OE9Xa2FFcmZMMklYZDFy?=
 =?utf-8?B?Y3BqdXkrdmdBbWJzaXhqOEFMeXRjaElRVTFHOFR1ck9sbkFBZTVGaHBwWDdB?=
 =?utf-8?B?R3dZMmErVm9hSjhIMFZQWWtoSndEajNPTEhuTnd1aVhvZ3p0UFdwcStxSHZH?=
 =?utf-8?B?MklseG1ETnoycTNkNG5vc3RESm5nNEFINHBIZVlxeVVSVDlkNkdNVkR5Vi9K?=
 =?utf-8?B?dTBxcnQzZWFvTWZlYklWWkV1RHJ3Und5UldKbXc0YzdmbmZrWjRIa2t0SllI?=
 =?utf-8?B?elY0OUdtK04wS3N4OUwyMERsZzRlUklPdW83NHl5Uit0b0NMek5MVllrdEpx?=
 =?utf-8?B?R2lHaTBvSGF6T2twbHdWamtjd3pPeDZwV3dEdHpOMGl1NzNoL3lLVTVGaFVy?=
 =?utf-8?B?d1JkK3dpN3N1eWdrckFPK1pVM0s1Y2YvZlM0YXlBUHFEa0ZOcmlGOGM3SVVm?=
 =?utf-8?B?bTFHMGRPME1zenVUODFMYmdoY2RwQ0c4M0xydkt3OW1UWnN2UVp2T0VISlI1?=
 =?utf-8?Q?Q5tk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07d90c-82e4-402a-8008-08dd0fe3c7e6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 19:35:14.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU/zdfsXC51TG5mWS3oHjpRAwMeRDngFrH4QCCtnDb+8rV06H69IptB1HSFXMNAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

Hi Peter,

On 11/28/2024 5:10 AM, Peter Newman wrote:
> Hi Babu, Reinette,
> 
> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Babu,
>>
>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 11/26/2024 5:56 PM, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 11/26/24 3:31 PM, Moger, Babu wrote:
>>>>> On 11/25/2024 1:00 PM, Reinette Chatre wrote:
>>>>>> On 11/22/24 3:36 PM, Moger, Babu wrote:
>>>>>>> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
>>>>>>>> On 11/19/24 11:20 AM, Moger, Babu wrote:
>>>>>>>>> On 11/15/24 18:31, Reinette Chatre wrote:
>>>>>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>>>>>>> Provide the interface to display the number of free monitoring counters
>>>>>>>>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>> v9: New patch.
>>>>>>>>>>> ---
>>>>>>>>>>>      Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>>>>>>>>      arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>>>>>>>>      arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>>>>>>>>      3 files changed, 38 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>>>>>>> index 2f3a86278e84..2bc58d974934 100644
>>>>>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>>>>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>>>>>>>>          memory bandwidth tracking to a single memory bandwidth event per
>>>>>>>>>>>          monitoring group.
>>>>>>>>>>>      +"available_mbm_cntrs":
>>>>>>>>>>> +    The number of free monitoring counters available assignment in each domain
>>>>>>>>>>
>>>>>>>>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>>>>>>>>> counters available for assignment"?
>>>>>>>>>>
>>>>>>>>>> (not taking into account how text may change after addressing Peter's feedback)
>>>>>>>>>
>>>>>>>>> How about this?
>>>>>>>>>
>>>>>>>>> "The number of monitoring counters available for assignment in each domain
>>>>>>>>> when the architecture supports mbm_cntr_assign mode. There are a total of
>>>>>>>>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>>>>>>>>> assigned or unassigned individually in each domain. A counter is available
>>>>>>>>> for new assignment if it is unassigned in all domains."
>>>>>>>>
>>>>>>>> Please consider the context of this paragraph. It follows right after the description
>>>>>>>> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
>>>>>>>> I think it is confusing to follow that with a paragraph that states "Counters can be
>>>>>>>> assigned or unassigned individually in each domain." I wonder if it may be helpful to
>>>>>>>> use a different term ... for example a counter is *assigned* to an event of a monitoring
>>>>>>>> group but this assignment may be to specified (not yet supported) or all (this work) domains while
>>>>>>>> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
>>>>>>>> needs to remain coherent if future work decides to indeed support per-domain assignment.
>>>>>>>>
>>>>>>>
>>>>>>> Little bit lost here. Please help me.
>>>>>>
>>>>>> I think this highlights the uncertainty this interface brings. How do you expect users
>>>>>> to use this interface? At this time I think this interface can create a lot of confusion.
>>>>>> For example, consider a hypothetical system with three domains and four counters that
>>>>>> has the following state per mbm_assign_control:
>>>>>>
>>>>>> //0=tl;1=_;2=l #default group uses counters 0 and 1 to monitor total and local MBM
>>>>>> /m1/0=_;1=t;2=t #monitor group m1 uses counter 2, just for total MBM
>>>>>> /m2/0=l;1=_;2=l #monitor group m2 uses counter 3, just for local MBM
>>>>>> /m3/0=_;1=_;2=_
>>>>>>
>>>>>> Since, in this system there are only four counters available, and
>>>>>> they have all been assigned, then there are no new counters available for
>>>>>> assignment.
>>>>>>
>>>>>> If I understand correctly, available_mbm_cntrs will read:
>>>>>> 0=1;1=3;2=1
>>>>>
>>>>> Yes. Exactly. This causes confusion to the user.
>>>>>>
>>>>>> How is a user to interpret the above numbers? It does not reflect
>>>>>> that no counter can be assigned to m3, instead it reflects which of the
>>>>>> already assigned counters still need to be activated on domains.
>>>>>> If, for example, a user is expected to use this file to know how
>>>>>> many counters can still be assigned, should it not reflect the actual
>>>>>> available counters. In the above scenario it will then be:
>>>>>> 0=0;1=0;2=0
>>>>>
>>>>> We can also just print
>>>>> #cat available_mbm_cntrs
>>>>> 0
>>>>>
>>>>> The domain specific information is not important here.
>>>>> That was my original idea. We can go back to that definition. That is more clear to the user.
>>>>
>>>> Tony's response [1] still applies.
>>>>
>>>> I believe Tony's suggestion [2] considered that the available counters will be the
>>>> same for every domain for this implementation. That is why my example noted:
>>>> "0=0;1=0;2=0"
>>>
>>> yes. We can keep it like this.
>>>
>>>>
>>>> The confusion surrounding the global allocator seems to be prevalent ([3], [4]) as folks
>>>> familiar with resctrl attempt to digest the work. The struggle to make this documentation clear
>>>> makes me more concerned how this feature will be perceived by users who are not as familiar with
>>>> resctrl internals. I think that it may be worth it to take a moment and investigate what it will take
>>>> to implement a per-domain counter allocator. The hardware supports it and I suspect that the upfront
>>>> work to do the enabling will make it easier for users to adopt and understand the feature.
>>>>
>>>> What do you think?
>>>
>>> It adds more complexity for sure.
>>
>> I do see a difference in data structures used but the additional complexity is not
>> obvious to me. It seems like there will be one fewer data structure, the
>> global bitmap, and I think that will actually bring with it some simplification since
>> there is no longer the need to coordinate between the per-domain and global counters,
>> for example the logic that only frees a global counter if it is no longer used by a domain.
>>
>> This may also simplify the update of the monitor event config (BMEC) since it can be
>> done directly on counters of the domain instead of needing to go back and forth between
>> global and per-domain counters.
>>
>>>
>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>     For example:
>>>     Resctrl group mon1
>>>      Total event
>>>      dom 0 cntr_id 1,
>>>      dom 1 cntr_id 10
>>>      dom 2 cntr_id 11
>>>
>>>     Local event
>>>      dom 0 cntr_id 2,
>>>      dom 1 cntr_id 15
>>>      dom 2 cntr_id 10
>>
>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>> static array. As an alternative it can be an xarray indexed by the domain ID with
>> pointers to a struct like below to contain the counters associated with the monitor
>> group:
>>          struct cntr_id {
>>                  u32     mbm_total;
>>                  u32     mbm_local;
>>          }
>>
>>
>> Thinking more about how this array needs to be managed made me wonder how the
>> current implementation deals with domains that come and go. I do not think
>> this is currently handled. For example, if a new domain comes online and
>> monitoring groups had counters dynamically assigned, then these counters are
>> not configured to the newly online domain.

I am trying to understand the details of your approach here.
> 
> In my prototype, I allocated a counter id-indexed array to each
> monitoring domain structure for tracking the counter allocations,
> because the hardware counters are all domain-scoped. That way the
> tracking data goes away when the hardware does.
> 
> I was focused on allowing all pending counter updates to a domain
> resulting from a single mbm_assign_control write to be batched and
> processed in a single IPI, so I structured the counter tracker
> something like this:

Not sure what you meant here. How are you batching two IPIs for two domains?

#echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

This is still a single write. Two IPIs are sent separately, one for each 
domain.

Are you doing something different?

> 
> struct resctrl_monitor_cfg {
>      int closid;
>      int rmid;
>      int evtid;
>      bool dirty;
> };
> 
> This mirrors the info needed in whatever register configures the
> counter, plus a dirty flag to skip over the ones that don't need to be
> updated.

This is what my understanding of your implementation.

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d94abba1c716..9cebf065cc97 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
         u32                             *mbps_val;
  };

+struct resctrl_monitor_cfg {
+    int closid;
+    int rmid;
+    int evtid;
+    bool dirty;
+};
+
  /**
   * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor 
resource
   * @hdr:               common header for different domain types
@@ -116,6 +123,7 @@ struct rdt_mon_domain {
         struct delayed_work             cqm_limbo;
         int                             mbm_work_cpu;
         int                             cqm_work_cpu;
+     /* Allocate num_mbm_cntrs entries in each domain */
+       struct resctrl_monitor_cfg      *mon_cfg;
  };


When a user requests an assignment for total event to the default group 
for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg 
entry.

If there is an empty entry, then use that entry for assignment and 
update closid, rmid, evtid and dirty = 1. We can get all these 
information from default group here.

Does this make sense?

> 
> For the benefit of displaying mbm_assign_control, I put a pointer back
> to any counter array entry allocated in the mbm_state struct only
> because it's an existing structure that exists for every rmid-domain
> combination.

Pointer in mbm_state may not be required here.

We are going to loop over resctrl groups. We can search the 
rdt_mon_domain to see if specific closid, rmid, evtid is already 
assigned or not in that domain.

> 
> I didn't need to change the rdtgroup structure.

Ok. That is good.

> 
>>
>>>
>>>
>>> 2. We should have a bitmap of "available counters" in each domain. We have
>>> this already. But allocation method changes.
>>
>> Would allocation/free not be simpler with only the per-domain bitmap needing
>> to be consulted?
>>
>> One implementation change I can think of is the dynamic assign of counters when
>> a monitor group is created. Now a free counter needs to be found in each
>> domain. Here it can be discussed if it should be an "all or nothing"
>> assignment but the handling does not seem to be complex and would need to be
>> solved eventually anyway.
>>
>>> 3. Dynamic allocation/free of the counters
>>>
>>> There could be some more things which I can't think right now. It might
>>> come up when we start working on it.
>>>
>>> It is doable. But, is it worth adding this complexity? I am not sure.
>>
>> Please elaborate where you see that this is too complex.
>>
>>>
>>> Peter mentioned earlier that he was not interested in domain specific
>>> assignments. He was only interested in all domain ("*") implementation.
>>
>> Peter's most recent message indicates otherwise:
>> https://lore.kernel.org/all/CALPaoCgiHEaY_cDbCo=537JJ7mkYZDFFDs9heYvtQ80fXuuvWQ@mail.gmail.com/
> 
> For now, I'm focused on managing the domains locally whenever possible
> to avoid all IPIs, as this gives me the least overhead.
> 
> I'm also prototyping the 'T' vs 't' approach that Reinette
> suggested[1], as this may take a lot of performance pressure off the
> mbm_assign_control interface, as most of the routine updates to
> counter assignments would be automated.
> 
> -Peter
> 
> [1] https://lore.kernel.org/lkml/7ee63634-3b55-4427-8283-8e3d38105f41@intel.com/
> 

-- 
- Babu Moger


