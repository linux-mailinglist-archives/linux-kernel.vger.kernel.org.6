Return-Path: <linux-kernel+bounces-175037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D1A8C196B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985381C21E60
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B243129E76;
	Thu,  9 May 2024 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BggxEPAa"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AFE10A0D;
	Thu,  9 May 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715294053; cv=fail; b=LYsaDKJO28+5c2tolCQxZD7C+9UqWmbJ8wjp4RVgAVpDbS/jBUJ0yFkzbTAgT53G3VHfgZcCGOLpzS9reWpvK8fBry6JRXDviYXOJEAoNTMHjvxVSbUyCgFu4gVT6n1kgiJLPw93CgIuUszDiwVh2WpcH92X36j3zvHGYvl1PP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715294053; c=relaxed/simple;
	bh=91tDDQxVWbGxoW684vTyZkD1af4O738ApFVFDVPOwg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYwEZm8xsKd/BUmKTV2tPmNrgqJ3sVy+WYybsZ7FCLTEt0XdMHFAetHXAZsGQfhF88c+Fsa++qVC8LOvTx9cZnsJndy4+8itQGr47sPEybJdXe8fzs8of5lRV6RyOfFia7L07T3fSW0SovXx9H09YPFkvbxdHGnNG8gvRFSeY8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BggxEPAa; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/WeqWc+wmzYaX2Y/Z5HeEF/D/WFPud3TJAcfU6nRphUTBUltdKsiXLNvKmn9kqHMxgGodqnF9JDTZoAPFTXydIz8V16evjJhnAihQuQ/RMhDqQ+m74YnyKmcY8aS6qBf9wOaMILwFpl0kBcpSWnwi5zJ1UZekyOgKEOIU1b/qzRcZLkdfFgodvKlmuG4bQoghXNLyEbP5mmCwsafLyECRF7RsKVW/Pj4S/Yk3khsFlXzheMPn86CRXtKUg8AGu91OJmlDHwX0qnyLOBRlaaVDMTxaPPUWDdV0tWzrAznHZOH6gqvcs6LlnqVR9lHnkFkKeWRhcIplKV+d0vZYBQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgWKzJbZtkCANVkL5WCFFj1DJtqomMWao1GbUp4tLRQ=;
 b=SUt4wiu1Biwl1ugfa9MDa6dISfMrJYtNpqo4tUu0dqzKz/bYueDNuDnUxLCIgavJIk4hzc8a1pFWAsy0IOxJO8atjSfMpfHjEupkHVst7S7u0GQm/U5RUeI2ynOS0bLzeEIOpfNXVAju9R+YNeoeQhha5VDL+8QJHM2pvGAIwavvyh0uSVbKZwSKGLH31cLjD7Pj+KLQ1FMih8zlfy5zUVU+EKOWPE9e4dPVoXrabx7OV/YMn4zBqB3OYv+nTORqXn2N5ASeQdSzvJkpIlc7WS093PHX306NefxyHUE6ZSbgNMIEaP4ZT383m9t9gu8qJVt93oUMoIELfUw7+FxIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgWKzJbZtkCANVkL5WCFFj1DJtqomMWao1GbUp4tLRQ=;
 b=BggxEPAaoXdGXprlj1lRuwyyehjm4FXIo5g0wMumubZNr0Qcx/yr9r0u8pZAMhXl5fCGJTlJMThlKby86WBcOWrM30kSvCrCSi6RtVFXz3y/7J6NmtcpoGtXsIjuooiBST5qPEwGtajLayiX5+SF46nIrvtS0Evj/TF4HQiNJAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 22:34:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 22:34:07 +0000
Message-ID: <be20ffe1-ef8c-41fa-b359-9ebfaa326ebc@amd.com>
Date: Thu, 9 May 2024 17:34:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
 <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
 <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:5:54::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 046b6866-b9ed-4eb1-11d6-08dc707823a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVFOVWlCeFpKTUkxbzhOUi9RcngvZTVXaDNyVnJiVktsN21BMm9JeHZxRFd3?=
 =?utf-8?B?eGl6eFRMRkJCRlpEaE9mK3ZyVjk4TkJjVFROWk5uelNWWGlpR2JEMzQ3RDBn?=
 =?utf-8?B?MzdXdmpyRzBCWlVwVzd0dlhYaTE3VFhKaUZTMkZ5WGpLN3hwcWM2Wi92N01s?=
 =?utf-8?B?RTB5bk1UNkhZMGVYdUdjcEFiVGU3Q3lqbUNHMmhvRWVmNEszanpaZXhsUzJD?=
 =?utf-8?B?S0EvbTY4dlgxUktqYkl1ZkV5WThCMStVOXFjcmdkUlN3KzFvYlkzb1RCMFQy?=
 =?utf-8?B?UjRhRHg3MUdDeFo2Szd5eUsycGE5R2pReXZLL2x1MlpYa2NIQUp3RDRrc3cv?=
 =?utf-8?B?U3dCeFVnazJZaTJIeFpCTmJMbVRpMkc4Z3NaOFAvcE9UR3NISTdEMHpUZUZJ?=
 =?utf-8?B?bTJrMDF6YzhKU2I4aFpFelhQcWlvaWdwbGlldE1seXR2azQ2NzEwWVZ1RlJD?=
 =?utf-8?B?UFdlZjdMZll4bGF6eFN1bGU5aUd1UHE1NDExR045NVJ0NkxMV25oUU14TWRC?=
 =?utf-8?B?NE1aUDA5Nm9VcnNvVW5Pcjk4dHBtUFBaU0puYWdwVUhIQkpNUGc5V2tLRjJF?=
 =?utf-8?B?STd4VVM0MWtSUnYvVG41UUpSdXYzZ0krZ0htZ2lBYWJuSUtTTFZGczJXSmFB?=
 =?utf-8?B?YjFQRTRzbHRBeUpYb0lhTnBGS2xUWUM4U3JUZCtzdlhXd0R4eG5oYzdFRHBi?=
 =?utf-8?B?b04wOEdmR3dzQ0dUQjhKV0Z2ZWRMNm5KWjlIclI4Q0RpV09FQSsvTWZqdDh5?=
 =?utf-8?B?WlR0MElIdGJWaWJSSEFabXF6N2J4WUlvbDI0NmVGUDQwaks4ay9RVW1ZY3dM?=
 =?utf-8?B?RWtFSXR4WnI4eDZzWWlsSmU2RGNGcEpBeE5Sekx4OFRNVjVTekozbnY5ZzF6?=
 =?utf-8?B?SHhNVlB3QmNoM0ZsQjhNZnhFYlNXZzdiMUhMcVRiYUhXbW1PeTQ0bjZESTdN?=
 =?utf-8?B?QVpPNFZYVVdMc3pYUHNhV21tSVpBdFQzS1Z2MDQyOGYzUlFCamJIeHZlWUJn?=
 =?utf-8?B?RkRJMmdLVWJhL2VQRHp0SGJmUGN6TVlValRQWUJvNlAvaWpEbldNeDYwVEsv?=
 =?utf-8?B?TWxLRjJDN2theldZUEIxRC9rem9ubGxOY09HRytwTE5MR09QOTQyaWovUGJJ?=
 =?utf-8?B?Y3Rxd3B4VktuNXFhWFl1MUxoclArcERjZ1pVR1h0RzZjNTVzQTVVUUtXR0pE?=
 =?utf-8?B?Uk1iOEdsc3FNamxEcGZtQ1ZSODgxbUdTVTFuMU1yZ3BmUWFJRFBIWndNcFNh?=
 =?utf-8?B?blJmcVVoTlZZdmRqQnU3RFlsbGVkRm5tRVZ4U3JIaXBQa0liWnVpZ1RCMGkx?=
 =?utf-8?B?azdpdGxxOHdlZ2FxWVdyTTEzb3VOS0U5Y3FSUnFSV2lqcm9NbVZEY1E1bTg2?=
 =?utf-8?B?bjlJZmZjanVzRmlnWm90VDljNzVGSzJXYlVabTY0bks2c1RQRVhsUHRvQ0RK?=
 =?utf-8?B?TE9HdGJxTVh2ci95UndJU3FoQWMrUzhTWTNEQUxXSjlNbEdSQjVWSmlVYzYv?=
 =?utf-8?B?UjZZZmNWZHdNT0N1RjBjZXM3VUV2dmQ5T2FzQXZtNitvVWhzUXBIcGhaZ2N0?=
 =?utf-8?B?eFdwSEdONlNGcjl4dk5jL0ltclhFTk8wVnpmc05IYllYS3FzUFFlU0pEN2Ny?=
 =?utf-8?B?QlNYYzRCYzVRd0RRNGhPQnU2SEVVMk1mOHg1UDBsSFZ5TFp3TXpGY1QxWUh6?=
 =?utf-8?B?bi9SRTRpUzdEUWt3alR4VDB4Y2hoRjdXTFhjYVNnYSt5M2Qxc3JmRy93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Z0V3NFKzZNSUVWREU0bEpBYXJhMVdPeTd0ejNEZTdGRThrTjMweDVmekxI?=
 =?utf-8?B?VUQ1bkZuTTZxM0NZVXlmNmNCV1pvdjVTaGZkWnNDREJ1Y3ZVQU5Ca3JCcGZy?=
 =?utf-8?B?aFBJSUtrNGtjZlRIQ1lBV1V0OHRVU2RYZ1VmOE1MaU5Rbkc4czU3QkhJWWht?=
 =?utf-8?B?NTM4QTBZbWVEVFh4cE1KdUJRS1BJRHY5eCtvNDRMbmg1eEJ0WmZhS2xyYUh5?=
 =?utf-8?B?Zm5sbmhkYjVDYXFLV3ArUDhLYnpZeVdTY3hMQ1VlRzJIYmJraFFmSXVLRXNw?=
 =?utf-8?B?U3c0dGJ4MVYyZzZ0U28vNGlWV2NPYmNUd2tuUHlGZjY3ajNzSy9mVVZWOVBC?=
 =?utf-8?B?QWpYbThLMUlpTXBva3VCVVBVWWZOeXFYSGYyWE1DYXdaZStKSWk4Wm1iZG9V?=
 =?utf-8?B?WlBsNUtTOVNQc0s5dE9WQ2kwdWFaVUI4WEZJaGN1MTRhNWNNNmc3aGR6ZnJ0?=
 =?utf-8?B?YTVZUDdUSFp4cUorZkpjRmEvWDUvQi9JWnJxMjZDTUhBSnJsZHFoTXNjV1U4?=
 =?utf-8?B?dFZWSGtlaHNjTFRlY0g1Y0hKVnB4eFAwVmJ0ZXZKV3h1TFJvNlErZFlMR2hx?=
 =?utf-8?B?MFdHRjhqOWt3SWZvdFVmaWZXOHpiS2d0VTlSZ05BeE1lb1J1V2pzdngyRFZ4?=
 =?utf-8?B?OW9ZYSt4bGFvVFpML0N5SUFXbFdLR3luRGpsRnJPZmI3M3RoMFd1cTdUL3VZ?=
 =?utf-8?B?aTdVVnY3a3ZST000SEtEN3doTUhUSXBWTC85TjZNdEVJblRXcjBXVHQ3NGVl?=
 =?utf-8?B?SmVhZ1JrWEhiUnNlbDhNWkZDVU1RT0pWM0M2MG5GRDhCREhrUUFkcWNaVTZt?=
 =?utf-8?B?MXpDd2VDUnBkb3VZeEJRL1ZmTFZUVERjbnhqODdHbmhWNUpIbzlvUGhBM0ph?=
 =?utf-8?B?UjQrWnF6T1E5ekkwVGt6YmFKMitkQUFkUTNrK2U0KzZUK3kwQStBSXBNOXNo?=
 =?utf-8?B?ZnFaa29VT1lkRXQyR0xpdlVzUGJkblJ1Z1IySTU4VlBuSTFta2F3M3RZNCsw?=
 =?utf-8?B?b1l1TUZQMjFwTkoxOHlsajB4NmE2TGRQT25OYTZKSUN3Q2ozMXZHekM5bFRF?=
 =?utf-8?B?MXZGdDk1Y001elNwWUZFTkpPWXpnQi9wRzY3UHNIbUJabXk5Z1JxNFZacmtv?=
 =?utf-8?B?Z2VQT0dpc2krUXpLc0FZY011bmo3NFRtdHlHT2V0STVacXNEMHdmK1BVM3FD?=
 =?utf-8?B?cXlTVTNKNFRwR1VaQkxSRWNORmpoazY0a1lzQzI3V25SU0UrTU9jd2lxbksx?=
 =?utf-8?B?Z2dqdUl3TEFWNzAzcys1OVgyRmxQd2x6VjUxYVcwZXJmWm9VaVpReW9jS1Fh?=
 =?utf-8?B?dmdSU3IrTTBINmJSczcyK09iS1d3SytoRHBraTE4UktIZXZ0c3VuNE11WkRC?=
 =?utf-8?B?bzB6ckMzd3RtVXJybXY5KzZTMzZvcFlIYUVsODg3OGZIU0lPREFtd3pLQk5n?=
 =?utf-8?B?WWlQNzZvUjlCdEFFRDFRMFoyV1BTQVljY29SUmNqbENRNHAvQ1pqckpTQzFw?=
 =?utf-8?B?VjhzMFM5VWJ2clA0NnNuYlIrSENMN1k0RmIxa2pvT0J2WFVFZFhOaGxMdjNF?=
 =?utf-8?B?R0lTRlMwQnMvckNpTnRIbUh3YUlnYmdHdmpuTjZXQ0FrVzFZL2NSNmMxa3lC?=
 =?utf-8?B?dWtPb0tCOUJFbFlyUEZrUWdHMDd1YmQwNEI1YlJhWnR1U0xDd2pGb2l6NXRH?=
 =?utf-8?B?RzNYWjJCQmJWREJsNit6TUJMWXp6czI0cHBZZmJlT0lkN1NjTzlOVENxSHhl?=
 =?utf-8?B?T1JlUWJ3aHNjYis5RjB3UmZ0S21yWVcrUXhqbmFnQmd3VzlRSWNzK3gxYXFh?=
 =?utf-8?B?QnF0YlhvNURaczdIQnZtblZmekNsNE9ybm96UXlKVFA4RGlGa1N4TjRTTmRk?=
 =?utf-8?B?YnlRVkViQ1hyQm80NXNCUUtYZzQxRTd2ZWtGNU4rdU1aR0dwY0ZjMDJuZ1A1?=
 =?utf-8?B?RVQwYlRhS3JNeTNiY1ZlWmtGMERTbCthOFNRcVZuVWtRbStaU1ZNd2lscUZy?=
 =?utf-8?B?TFJZNWhlOEJ1akM5Z0NSMG85RjlNWXlGOVZZYUdCWmcxeFRFY211TGdtWUEw?=
 =?utf-8?B?Z2xWRXcyekxXRTA4bVdwUHUvd25xK3RacENTYjdsQjhvUnFxNmhJdmR2VjB5?=
 =?utf-8?Q?YBJc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046b6866-b9ed-4eb1-11d6-08dc707823a6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 22:34:07.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugZh7yhlfB3J64JxQJ0ahxRy/dgQPtWkAIxXVy4S0nF/VO+qzOPxvbNaAt1OKiO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161

Hi Reinette,

On 5/7/24 15:27, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/6/2024 12:09 PM, Moger, Babu wrote:
>> On 5/3/24 18:26, Reinette Chatre wrote:
>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
> 
> ...
> 
>>>> + * @mbm_assign_cntrs:	Maximum number of assignable counters
>>>>   */
>>>>  struct rdt_resource {
>>>>  	int			rid;
>>>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>>>  	struct list_head	evt_list;
>>>>  	unsigned long		fflags;
>>>>  	bool			cdp_capable;
>>>> +	bool			mbm_assign_capable;
>>>> +	u32                     mbm_assign_cntrs;
>>>>  };
>>>
>>> Please check tabs vs spaces (in this whole series please).
>>
>> Sure. Will do.
>>
>>>
>>> I'm thinking that a new "MBM specific" struct within
>>> struct rdt_resource will be helpful to clearly separate the MBM related
>>> data. This will be similar to struct resctrl_cache for 
>>> cache allocation and struct resctrl_membw for memory bandwidth
>>> allocation.
>>
>> Did you mean to move all the fields for monitoring to move to new struct?
>>
>> Struct resctrl_mbm {
>>           int                     num_rmid;
>>           bool                    mbm_assign_capable;
>>           u32                     mbm_assign_cntrs;
>> }:
>>
> 
> Indeed, so not actually MBM specific but monitoring specific as you state (with
> appropriate naming?). This is purely to help organize data within struct rdt_resource
> and (similar to struct resctrl_cache and struct resctrl_membw) not a new
> structure expected to be passed around. I think evt_list can also be a member.

How about this?

Lets keep assign_capable in main structure(like we have mon_capable) and
move rest of them into new structure.

Struct resctrl_mon {
           int                     num_rmid;
	   struct list_head        evt_list;
           u32                     num_assign_cntrs;
}:
-- 
Thanks
Babu Moger

