Return-Path: <linux-kernel+bounces-520262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ABA3A7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD611893FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D921E5200;
	Tue, 18 Feb 2025 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="psfg2N+S"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E721B9C7;
	Tue, 18 Feb 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907163; cv=fail; b=a8eefYXrlrmKM7S+IFcod8eY0Oe8Lhyvcr/+w1WFC9gfS1VVepsoUmlU67pqCPRe39CvflEQ/xo5G5M066M6ln8iVXM1bJN0W1b9OUjCaGJ1Huk5q77oxDWLZBZm16VoqEHosvhKE69TCTgaKC+lONv+yIT/VvybFply2DAT3OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907163; c=relaxed/simple;
	bh=j1c+vGFdT+ARmaNba9I2GU722OujLLiXAfd8CDtkd4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z21ppYVBEiQVlghf4XdZKMJrGjprXBDG1fH2N9k1OOR9sFZr52YUs99Xg4dBdXKpgkWNJUadd6Po0/hX19VEStic7z9yrjPT4cakbu0hk55qHfnq+YiAkvzzhL0tucOYkZHC7MARjbZuNjQw5j7/QNVEgDJ/IrBdsP/8GuTvI2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=psfg2N+S; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImE1fWnZSnYCj0Zg7JhrwCayDgK8fnDy5kF++iu13ocbuPOHtfAKyzHis64O9CJpSCxofoCqdUplvMZL7aSAvqAZCyZ2rhPwfI4N8kVVEE7CpAIfJJd89DOeYcVm8dZ4P5XK9raTWqnucyJOMzRDyB1EWeX0lS6Ac+U7nXswKcabWrZNxMmuYL74so45yM8S9D+sKJOdXdENhVtIZUVZUHg5FLbP9nftPLze/kCZcAIanowzrE47oaPDkAxEbx/HMiEEmKTbTNhwG6x4rB9Fcxg1jVPBc+lusMRHJPd14KWpFXmeN2RoDZ/C9oQ+b7jFwcXmm+ZSQdCJadFmCvaDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOpfvbRVvT2VBGSEEDxxsXeWqaCRQCAG7aewYJ451mo=;
 b=Y1lQygKhpOWbGvZ2veqtePXLZGyUUNqx+dN2ORwCxP0Wk2n4ELYPLuL+qE/rfZCRWxsDeCCpY4krV2y89WIprla0NLa8lcMP38zdk5KGr5c4gYzGYq4lS+m2sU7KGZfXBHTVshR4uKm3LDbvn54VwzmOf0g46WEL6LPS2zhEKCgQW1IAAT6jog54ij+Hko93r6fOdWfbkWUSA+HbkJZ0KfcU4e32XqVKKrD9nja7x/435Ip0poB82VJhQWP/ZfI2nwTBy3GdYOjZv0QlCTQ/Zf19D/e5khTCDv6C0GesIullhL94dL6vESTPwv9m7MHml2LUOqRlrr1ofs2ET+nsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOpfvbRVvT2VBGSEEDxxsXeWqaCRQCAG7aewYJ451mo=;
 b=psfg2N+SACANXRAqjCZWXyMUCtcK0vw4JqvvTBIu04+Efw2sugzsdIFXFVbHLL0WHkew6NWRcRNM2GqCehYzivPZypNrySP8a3TqtNjLSfdDHwLR6a3aPZyAYIx7XLu6y8CpdrC6Rmbg7R99qDL7d91joslg4C980RHTtlShKG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 19:32:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:32:38 +0000
Message-ID: <698577f3-00c2-496c-b787-506cef589d26@amd.com>
Date: Tue, 18 Feb 2025 13:32:34 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: Peter Newman <peternewman@google.com>, "Moger, Babu" <bmoger@amd.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <Z7R9VedhOSp64W7X@e133380.arm.com>
 <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
 <81e3993d-2f00-424b-8cf4-341c321149cd@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <81e3993d-2f00-424b-8cf4-341c321149cd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: c6abbe6b-d372-4fee-2b6a-08dd505300e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFBGTFFSM1F0bjczS000d3FFYjBZQ3IxTGpzZ2l5SmNteG5XUXJGUjJaMmpl?=
 =?utf-8?B?U2RVTDEwcGpqLzRUZXpoNk1JckEvUTZyYmJEdENHbW04SllvOEduaW1oZENp?=
 =?utf-8?B?dVFLNjNSV1o2UzVDVm5xN3JJcjhWRFoySWpjYTZudHd2SXB2R3J4YVgwNmQ1?=
 =?utf-8?B?TUg2b3lGazRHdjBBcDhEOTd2bm5yVC9KY3g5cTlYVCtUOVI3UEVHNFYxNGY1?=
 =?utf-8?B?WEtPUHhlUFpXOWpTVFByb2FzY0tXTEZTY1crUnNOUnJVSzYvbGtRc09rL0ZV?=
 =?utf-8?B?RmpXWi8xNWdLVlNoVkxhYzNQb3RmcDBIS0QzellnekNZcUJZT08zcGc5dytY?=
 =?utf-8?B?OHhGM2I0bVhtcEFxMnBmdUdZeXg0TkFZTkdsazFremNsd0htZytvUmNJdUhh?=
 =?utf-8?B?Umt2eWJnZ3k4QmhsYk5ZK2crcVlhd21VdHF5KzU2VGZKS0pqVEliZHl4WHB4?=
 =?utf-8?B?MjZuWE1OVGl2ZGg1cTROV2pSUGkyaFB6cldGU1hweWpkcG5SczA1QlJwaVNS?=
 =?utf-8?B?SWdsdVlNME1RT0p6aHR5TjZpU2JHOEhzQUxqUEdlZEpBZWtWOXE0UWovSEJt?=
 =?utf-8?B?QkcrUEdmM0czSDhjVGJHcU5EMUpNZ2lxV25Xa0ZuUWF1YS9nV2F5OXQ1QnRh?=
 =?utf-8?B?S3pTZkVRcEVxbExRM2NJaHdlQkZJOWxUeU94ajNYMDV0dTJJbDBKeUk3czJC?=
 =?utf-8?B?Q0YybURoSGZyOHNROUhMNTBVb05SdmU3RTBPWVJFczRKSHBka20rTkR4S2Z6?=
 =?utf-8?B?WENuTVVvajkxaTV3clVaNmhkOFhxc3VWamZWTDBrNzBMdTVmWVMya1lVUHFJ?=
 =?utf-8?B?Z2svRStRY1VOSmRPRGM2Wlpwb3A5RzUvdEtQOWNnYm10UXdqbDdTbVJwOVhX?=
 =?utf-8?B?V1RKZDZUR1dhelQ1M2Z2K1R4djFKOUt3RU1MQzdPclFXNzhQMnZ6UHE4a3U2?=
 =?utf-8?B?Tm5EajFQenhQMUI4ZFc3Nnd3c3dtKzFyZmFuUEdXS0hISWF3V0pBK2o5NlNQ?=
 =?utf-8?B?cmkyWjRWR1NZZThhSUt3cEVzYkcyc2VNUCtod01jSnJUcU9UNElWNisxaFRT?=
 =?utf-8?B?bHA3SGRSbjFFRGpHblQxUzVTOEFpa3MzazZzS01YZ1hTR2NQNjZoVHRHWm1G?=
 =?utf-8?B?RzNjVGwyckIyRkk2TDZXL1dkSUdQV1J6cHhiUTQvUFM3MisxbW0vQncvK0xz?=
 =?utf-8?B?K0ZORVF4RE9PUEJKZUVUNXo4ZVZwZGc0bUVkK1FCWEF4NXhuWGU5dFVYTHIy?=
 =?utf-8?B?aURwNWgxM2xDK0g2M1ZReEx3MmxuK1RURjBPZGNHSCsrb0tEQWlXeE9jUEVv?=
 =?utf-8?B?YWNyZG1VYURla2tGTi9RL0ZUUi9ZZ1N6S2NMa2RYZmxJNE9OY1JCSVJlYkNO?=
 =?utf-8?B?YVBmK3hvejZ3U2JOUjh5ZXVWS1k2L0d4Y2l2SmdFNGZQU1pYRndzeTE3RFJJ?=
 =?utf-8?B?K0RDajVEWGRjN2FjTGQwYUVycnFrM05PUXFtY3h6SHhpaW94ZlB2TlZnNFly?=
 =?utf-8?B?bkd0dXozR0p4dFc4dlYvWnpaMTFMek9HcG9iSVBZbldpNnRsblFPL3BUUHpZ?=
 =?utf-8?B?Z3ZSWGlXWEhqSWt3amNLa2xMb2IzbHJHWkpGeko2eTE1SWFlVW5RdnNPc2Fj?=
 =?utf-8?B?bGE2cm9ZclczczdoV05oT0Y0OE1pUUUra09VYUhlOE1sK0MrcDEvWEY0S0E3?=
 =?utf-8?B?dEpkYUl0VmRKOC9sdncxL0JMTEFIZWxWYk5wNjV3MTFVdUdXRmlXeWtQcmgz?=
 =?utf-8?B?dnpTdFVDcDF4eVlKUG9CaUQwUlFhTG8yVXNXVWxlL2FBbmtZbW5SUVhWcnJ6?=
 =?utf-8?B?dm41cnB3LzFLaVF0Tk5SUmlZWWdzY2JJdTY2M0NJYm8wdWFNL3BJcElKYXVz?=
 =?utf-8?B?QWZPK0toYWRQTSs5WVhGRlYreDg4OUw1amhhK3VXdjRvVFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFYzUEFmS0RpRW1kc3JIU29UWXdxc1lqYlM1NWdZZFZmWjlnOEw5QnoxRkU2?=
 =?utf-8?B?bms3QmRwbFBRZzV6LzZRTFNRMXJoUTZJV25aMEU1bExJK1NTSHBzdmo1ZGMw?=
 =?utf-8?B?L0cxTXZkNHZtNVUvNWthM09YSEIwcnJyR2dPNU5nSFpFbGdjd05TNm4wcDJ6?=
 =?utf-8?B?SWFKdUkrTlI3bVFsbkdYYjBxTzMybllwZ1dTOFozbzZMTG0wWVV3b1JPYmQ2?=
 =?utf-8?B?NDhsNFk2RDNLdWJDVk54K0JCKzgxY1JsbVV5dFJIYzFxc0hqZXZlbTQzQlVu?=
 =?utf-8?B?UjduSVNheHNlL1VlWnZXdlA0WG11VUZXQzYvL29vaHh1c25xdFI1RThFK1Na?=
 =?utf-8?B?NWlzUmZ1bndFU0Y0ZnBnR0lQNlpVRlJFNk4zakdrb1FkQ3o4Rk5RaDgyYTNC?=
 =?utf-8?B?dXhvaFhIa1FnbHB2V0VHdTB3ZDFzVGdIemNoRmI4Mk9KWnViSEhXVUJIY1py?=
 =?utf-8?B?ekpEZXRqY2pJczVubUJLa2NRVEp2NFZPSFRsbTFWOGl6aGpMNC85MkozaWZ0?=
 =?utf-8?B?R2NTSFlMVHpSbmhoQkZpN1AzYTR3V3NkeVBIck1iSzQxZVlKTndqVDlqVktI?=
 =?utf-8?B?NmZ4V3FwWFgwMlRpQS8zZUZ1WmQ2K2lpTFBsTE9rTHNjT3lzcFdFdjNFd2dH?=
 =?utf-8?B?cjRvaC9HNnFJeVBCVzBIY2VINFRUTVlXYk9ra2FwMGtDbnJ3RXhZL0hIaWRD?=
 =?utf-8?B?bVdjMjB2cnJVT1B3YTA3VWpSLzNiRm5JMlZXREZsRTZ2UUU0YlRZWGRKb0pG?=
 =?utf-8?B?QVNUY2hYZ3lwODhoeDh0YjkvNTVpbGFzVWp1Y1V5eHlpV0tDSWRtRWhvbTN0?=
 =?utf-8?B?SXJ5ZFg3a0J5ME1IVDhrQzFsd1JqN0gwajdERWxuTE1XOGJaOHZ6NHlWQlRo?=
 =?utf-8?B?Z28zZHpFNlhnR0o4U2k3ZERQQllWbU5mRFVXOFlLYkhMMHlaUDlTa3VmM3Bi?=
 =?utf-8?B?MXhib3JDckUwT1BUN3Nmei94N1Budm1IWUl2aGxodGZvMWttSmtCRit4VWFv?=
 =?utf-8?B?WGE0YVJYT200RTE4SU5UNUtiakJlTTJXZE45eGpDanlvUWU4dzFJblJCa000?=
 =?utf-8?B?aHc4MjgvbnJYZTRtQld2cFVURi9sWHEwMEpUZ2Erb1FwZ3VmOFBZUVVySGZl?=
 =?utf-8?B?VHErZnZjMWxJOGRsa0E2bjMzeW1XUVFUS09VbHRTWmdLNTlvdkRNU3hOemNl?=
 =?utf-8?B?RUpaYVJpYlB1eEJsRTBUNEFhTjZlMW15bTE1M3dqdlpLNWhaaXN4Njd3TCtJ?=
 =?utf-8?B?cFR6R1FhSFFBMEREb1RTbVFoN21rSFcxYnVTSm54b2pmUHFBVnFqZFRiQVFv?=
 =?utf-8?B?WE52dUNZdzlXeEl5T0hjWHBqcW1BbFV3SkU2RlVzb0I4RHQwTzZnYmRNQ21T?=
 =?utf-8?B?aWg2YjJtYjlob1cvTVFmWG9vc25RU2hrYzREZUJoQ2JkNGJ5czFLMUpGQy8z?=
 =?utf-8?B?YUk0UmlHb3A0Y2x5bzhVazRqKzE0ZkVMNmxadnJNTk1TMUk2eUF4Q3NzVFZP?=
 =?utf-8?B?WmJjb1U0ekdJZ24zK3Zac3NGTEFoSjF2UTEvUFV1dDhlSlRqNDZTYWFydFk1?=
 =?utf-8?B?VmRUdTNDOE56bmM1R2hnNG5NRVJCQ1A5QkNBb2RpeHhvRVFzbVVxTFZhS1pn?=
 =?utf-8?B?ZjhKQmx1bTNKM2hiR295Y2c3RlVBdm5SeHVHaHRsMkc4SEpldmFRL0FTSEYy?=
 =?utf-8?B?TmVlWGtqd2tJa2gwMjZscG1XcDJHL3ZYQURLN1RzRHd0MFdtVnNYcGkwa0Rv?=
 =?utf-8?B?ZThlOEdjOVVJWlduRjNDcVRWVjdkZ3hxRHZRQ250Q2pxYzZBeTh0bXhUTGRB?=
 =?utf-8?B?SlgzN3RqMWdIVVgvaDdaN215dTVpakhUYk16eHgySTR1LytNNGFWTDJxc2F2?=
 =?utf-8?B?ajlhOEo1Mm5ncGx0YWVvOXFwd3hkT3lCWWJlSVZDbU9GeW14SWVCdVpKUVAz?=
 =?utf-8?B?NGRVQktIV095Q0RxM2pxc0FIWVZLN1l4RnFXTXJINlpHNnVnNGxvRWZOZTRm?=
 =?utf-8?B?M2hOZlltemxRUXNSUnpQUmpZazNpVkE5dWduZzNqSHFtVExNQVNrY3VQSXdi?=
 =?utf-8?B?aVRUY1FlRjlmb1AvQWorK0ZJelFsWC92Y2JGVy82SUtxdW9OZnBOd2M4SEZt?=
 =?utf-8?Q?gg94=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6abbe6b-d372-4fee-2b6a-08dd505300e9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:32:38.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toHbvtTlT6d3vxFibZj9kWx7qX2I2/EnUUXjRq38iEDxk+kjrPS6l3Oj0TFSAD4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

Hi Reinette,

On 2/18/25 12:14, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/18/25 7:39 AM, Moger, Babu wrote:
>  
>> 3. Use the actual events instead of flags based on the below comment.
>>
>> https://lore.kernel.org/lkml/a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com/
>>
>>  Something like this.
>>  # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}'
>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>  Are we ready to go with this approach? I am still not clear on this.
>>
>>  Reinette, What do you think?
> 
> I was actually expecting some push back or at least discussion on this interface
> because the braces seem difficult to parse when compared to, for example, using

I am yet to work on it. Will work on it after confirmation.

Here is the output from a system with 12 domains. I created one "test" group.

Output is definitely harder to parse for human eyes.

#cat info/L3_MON/mbm_assign_control
test//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_total_bytes}{mbm_local_bytes};2={mbm_total_bytes}{mbm_local_bytes};3={mbm_total_bytes}{mbm_local_bytes};4={mbm_total_bytes}{mbm_local_bytes};5={mbm_total_bytes}{mbm_local_bytes};6={mbm_total_bytes}{mbm_local_bytes};7={mbm_total_bytes}{mbm_local_bytes};8={mbm_total_bytes}{mbm_local_bytes};9={mbm_total_bytes}{mbm_local_bytes};10={mbm_total_bytes}{mbm_local_bytes};11={mbm_total_bytes}{mbm_local_bytes}
//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_total_bytes}{mbm_local_bytes};2={mbm_total_bytes}{mbm_local_bytes};3={mbm_total_bytes}{mbm_local_bytes};4={mbm_total_bytes}{mbm_local_bytes};5={mbm_total_bytes}{mbm_local_bytes};6={mbm_total_bytes}{mbm_local_bytes};7={mbm_total_bytes}{mbm_local_bytes};8={mbm_total_bytes}{mbm_local_bytes};9={mbm_total_bytes}{mbm_local_bytes};10={mbm_total_bytes}{mbm_local_bytes};11={mbm_total_bytes}{mbm_local_bytes}

It is harder to parse in code also. We should consider only if there is a
value-add with this format.

Otherwise I prefer our current flag format.

# cat info/L3_MON/mbm_assign_control
test//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl
//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl


> commas to separate the events of a domain. Peter [1] has some reservations about

Yes. I would like to hear from Peter.

> going this direction and since he would end up using this interface significantly
> I would prefer to resolve that first.
> 
> Reinette
> 
> 
> [1] https://lore.kernel.org/lkml/CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com/
> 
> 

-- 
Thanks
Babu Moger

