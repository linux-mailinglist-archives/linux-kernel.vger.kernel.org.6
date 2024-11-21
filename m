Return-Path: <linux-kernel+bounces-416481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC09D45B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DB282F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D77080D;
	Thu, 21 Nov 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JubFUqmv"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFF23098E;
	Thu, 21 Nov 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732155297; cv=fail; b=CskxFuQWUmgaMnRlgMJXFSA/k0iQ8xcL5Y+hT78c9LZC8XdCtaQfqTh0UcHZKvcg2lWMgOFWz9c7kZykBtBarX1EBISTniyjEmRn9mtUEJTmFWu5TzLFJwOXHQeXKFHAB/g1rWPu06ysmTq8Zgp8dzwhkV6fr+ML9PhcrNpBt68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732155297; c=relaxed/simple;
	bh=fjPAPEPXSSa+LzxJuLSb31zg6wrod2oxrLWwCuWSH0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e6J6v+jiP2Av/t5nybqrvijt/1FO8zIgYPEMdvdE0FZPQjPCKfFBsdOsQ/zlCIB94CoVbOk1UfqelGl2f5y8dhRsBLLHtj2+PcJHW8/armqf8ubX4gr2sFpK5Ha/o9DmTJABWRd4ym7w0F4ZvUue+jNHsrPK3yrxJIK8JHH8wfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JubFUqmv; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmSmlnUSS4nOmmIveXXbpPJ7xUmKSYiBZ1fae+CKDMb0R3scgE+Hwd2mDg5ztV6g1G0okcafYKQQts6UaSUfC4ya0aN+hCN8LCuHAnmIAznFfrM45E9PwX7OpC2Eap6d0bsGLJTDEH6A/L+GIWaC/lxTokgKCetiJtYF1pBmjoDyVUE+LJKXGsvOLT31F31Il+RI/gxywSpCwwHJffZoFGYxYKVTgBZN+Z8BAmg31RHPWQTyOegoX5v51OMiLd03DXNYLnzCTKI4YpqaYTPAXYwFak0FMAe5D+zIdDrsyMhoKdkvPmYA0lqU6BPRC2TxH3bcpfRdFC9+6+V7hC/rAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTtRIbQwvUTsVVgUrbLZuhu0DLNZgNg1dZaKQ84iYdQ=;
 b=WHwQbX9u4k1EYPsmsszvLhQZ5ZjayLfk1hWz11l34tAX12vt2t5Do5o9Y2nDm2srxvcy7/rjXXSsh+l8/cGeINS6O3Hwm/frRvHCpeGV64D41DzohoaUg+WXM0yJNPo6WlSHqY13arL1AbIMIMdmgoe3cal2a7gvPpZMZkfYxTYL2aWpsEtdaim57Nf60SFwDRWngy78EdA4JMW06sWp0HArxC80rKyUi3orT52ovp3Q/FMAyc/7If9A5LGPFZZHyhWhChWK0YfH0GjAXskaHSoetQW0sx0Ir1RmJFMHjJQJW8zzrlN5bScFXuY5zk0RIPukgt335vmncggkPHanlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTtRIbQwvUTsVVgUrbLZuhu0DLNZgNg1dZaKQ84iYdQ=;
 b=JubFUqmvEQJMAcq916Hg2bDaQoGFbuxff/vnLN8/iMG6uD7+ZrZekHfNHheinMbE8a4t+Qo62ZUREbVp3Z3HwGt7lEspkvACOBhRv/62PJPoAlw9IJgf19/II8Q0S2rjPohUiEcYLkUXMW2rQz+94gmzfpGcr1FJMfIDSWpRzZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 02:14:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 02:14:53 +0000
Message-ID: <31994778-74aa-0b61-cf93-14c25c872e9a@amd.com>
Date: Wed, 20 Nov 2024 20:14:47 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 24/26] x86/resctrl: Update assignments on event
 configuration changes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <89e98891f50d1d57c1cf8bc18c1f562ac58d2cce.1730244116.git.babu.moger@amd.com>
 <b78a01b4-3583-4689-a894-96dab5dfb9fd@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <b78a01b4-3583-4689-a894-96dab5dfb9fd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9fa78a-d45b-4420-fb48-08dd09d248e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnN6NlhadFZxWmZ3cmVkQ1VtVlRjUis3YXBBVm5Fem1aWnpoNitkc213OGJO?=
 =?utf-8?B?cGFNT2x1cXI5VEZycGRjU3B6bS82c0IwS2NDTG5RMzIyUG4xVHB4VTNxNWxZ?=
 =?utf-8?B?S2dYT2lJUkE0SXlmZUVWQ2lMVXg4ZzlYbCtyNW9hZTgzOXFKSDVtcmZvb1Va?=
 =?utf-8?B?K1IrQVNJMENCQzAybTFXU0J3ZndTVW5TVmhGVUtzdlJjSFdFT1N3cXlYYks0?=
 =?utf-8?B?WHcxTThmSnh4YmtKTlpXZ3VQVldYdVRmOHVmdnZLMy9IRzhOYlNPaVZ4cXNB?=
 =?utf-8?B?VVZVUTNBV1pTaDJhRU1lZ09lVDExOGJ0RWlseVRrNG4xMnV3dEJUcis3cjAz?=
 =?utf-8?B?OElwblhucW9HcVY1VHpzZGZLNTlxZnBaZjM3QUdaRHArbWFzREhHZjJSWWRQ?=
 =?utf-8?B?QWdQR3pPeVBuM2dnVnFYOVNuSzZYUFZPbFRNOFNUb01xL0RMQnh6NkZXV2Fl?=
 =?utf-8?B?TUtkU2E1NS9YUlN2aGV5bm9sWWt5WGt5TS9FNTkzUUQwQWxScjZGaUt0S25s?=
 =?utf-8?B?QmpyUTZPMDJVR1JuNzhNOVlEY0ZhNVhzbXFDWmpzL1NGRWxtUGxLN25GOHo1?=
 =?utf-8?B?Z2x3WmtGWDcxSUlNNzIxRWFONEpnWS9mTWVvQmd1WGJ3eFBwR2xtMXR1R0Jm?=
 =?utf-8?B?NTlIU3c0VFJvWUFPdzQ0eWhXR09oVkhENVVESUxkOVVLWU1UWTY5eEhkR2NW?=
 =?utf-8?B?eGVkKzBqQ3dKYkh1TnRpc1k5bzI2RHdkVCtVbDJOOTFueXo2RWEzQTBJS1JY?=
 =?utf-8?B?Z0xmcUFpYURFcjJHV3hhYTFBL0VzS0MxWHRWcm1yd2RMTkhQZUFQNlRwc2ZY?=
 =?utf-8?B?amxWNHB2RTZuc2x4WjNFQU4zTm8zVUl3emJ3RGtreWJJMENJbDFpNU5ZSUNX?=
 =?utf-8?B?WnByTksrM3JVc25KUVVQY3dudS9iSkRLNUVxQVEwWFBnNWsxODlXTGpuRU9n?=
 =?utf-8?B?NUZob21LdWRVQm1KY0J3MWt5dFc5QzM0aEp5MlJKTWQ4aVFsZVRrbjNHNDY0?=
 =?utf-8?B?YWxDbDlIK2EzZmU4V3lid1RpOTQ3RWNNdllybjYzK3NvYklVZndUSVYvaGlT?=
 =?utf-8?B?RTBTc1BCWHpVUERrUDRFU2c4OUZOczk2K21udFJRVmljbzVaQjAzc1BrUkxt?=
 =?utf-8?B?bVFhdGVIYUNyUEZMWnpnQWloRFVrNTE2eTF1RElwTlRGNkcwQjRHZ3A5U2J2?=
 =?utf-8?B?MzdVVTVybld0SVgwemsrNnl5K1NFUzZCWWJvMUtuZysxNGpCcjNvV3c1QnVr?=
 =?utf-8?B?ckhFOXpvMmQ0cEtWWkpkUS9Tc05URFdLRWxHL21iVk1venE4T05vd1paazd6?=
 =?utf-8?B?aXBqNXJoWGQ2V3hYY3hGa3FqaS9CdGI1c3R5NWliOVR5SjNIVlhDWVkxTUo1?=
 =?utf-8?B?NGVJSlJTVUl2NUhrVmhzZm1ZVjRKV291R0RuWUh2NnI1TnArek5JL00vNEh0?=
 =?utf-8?B?WkRwb2EzQXhNRHhncUx3Vys1Vk5YU3p4UkFUWldRbFRiOW5OQTZMck9wbktH?=
 =?utf-8?B?QmRyMkp1KzdUUjROWkhRVVBMc0xCY2VXTUs2SVIzTEZ2M25zSGF2YWJoYmQy?=
 =?utf-8?B?MDVZOWlvQlFzdHRsd1ZLMGRBdXdneFFYeTZHajZTSDNCeU9rODJ6dTdENkQr?=
 =?utf-8?B?ekFQWlhsczJENE0waEtTc25uNWNoR0xDRkY5VWJCMktPYjBIV0IrVGU0c1lL?=
 =?utf-8?B?REpnTVRrNitxLzlVd1JpeUhTazJoa0hKS2U4S2xyQTBQaXpVTThKRUZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmZ1c3ZPdlFUUS96RHI2Tnd6NXQzMG5JODVEbnhZV0ZPdW5aN3M2bWt1NkFa?=
 =?utf-8?B?UGF6U1VTUXA3NU1EaW5PTUNKQklTZGZ5N1dYUVhRQVhOSzd6WXF1cTE2dHEz?=
 =?utf-8?B?TEZQTm05WHNYWU90TXhId2VqOVRhNkNCQncvYVZYM2wwYnVnMmxjTTBLQ1RO?=
 =?utf-8?B?UVRlaTJidmdHbGdqSVAxSy9RM0FNMWNiVFgwWkhiZ3VYaU5kc0k4QjVNaEMv?=
 =?utf-8?B?bTFhRnJkbG5BdTNPTFJyRzZFS1crMHNmZldGRm5qcGxzN3pJbHlVenZrQm9s?=
 =?utf-8?B?WmNhbDFBOGNhT2VQVlpFQk1QOHYzZktuS2crMEhCeHhGeW9RV0M3cmFnSElF?=
 =?utf-8?B?Sko5T042RHBRZldmNUcwZkoxOGFXOE1XbTFhb2ZxMG5BaktqWUJxa3pkV2t2?=
 =?utf-8?B?MUJaczdhNC9rc0dJY1kybUZYaVg4R2lWRXhPWmpYUkxsb25ZSmttR2pFREhN?=
 =?utf-8?B?VTNjOUNMM3YzdUtBR3l2TUthNW9kRlQ1Vmk1UndkTlBNQ0kvWS9yZDJ2TDlN?=
 =?utf-8?B?QkRZQ25aWVVRWlhmUXFPVmtJckJIMFJXT3NjVm9hWWN1K0t2a2dCVFJobVlo?=
 =?utf-8?B?TXRpZWNiYmwyZmdsNFZobFlHNUJlZHlob1dHWGgvTloza1NHK3hWSkNUV2lr?=
 =?utf-8?B?M0VTM0dMdTBXR1JZWWplRjNSY01kS01GdVNrUDU5YS9kNUlkckFNTVVNbGsv?=
 =?utf-8?B?WWV3NU44bkVyU0tNczA0TVRtTGRXTmkvTFhhZHkxaWNUL0M2TjhkL2FrN3Yw?=
 =?utf-8?B?UFVEaWF1eEVUUUNYM1psY0Zreko5UTJpVnpuVXRNeUU2NS94aG9xM1AvcFYy?=
 =?utf-8?B?T3lsNytKSXFqaEthSWhadDZobDY2bFRkWC9Sd0lMNERVRXR1SjB1NnRqRGhD?=
 =?utf-8?B?N201ZVNsY3ZhM3NtMU1SQ3gzaGxubUFoSTVVaHRDbFYzY3BWK1FLRmVtejRi?=
 =?utf-8?B?VDVDRWs2SVVQTk15VzRmZmVvZmZQUk4zd2xpMTBOYmsweVY2bUlTYjJQc01i?=
 =?utf-8?B?cUhoNm12YWRRK3N1ZjVwa0Q1VjNVejMwb0hoK1VSM0F0NVNiQVYwRWtVYUtI?=
 =?utf-8?B?T01BSU1ESEZ0cWxZTDRlMWE2UnZOeFZKYnJPekZGdzVMbzFnWWl4MW1Nc2gz?=
 =?utf-8?B?SWJWMWd4Q0VjSzY4TC9icU9RUlFtYnloOVJhQ24zY0tNUG9NaDYzbDh0dDVJ?=
 =?utf-8?B?VGlkRkpib1h5dVVLVnNEU29nbmhtQTVqYlpnbFdLUnEyRVhaNDlYVkV0MXZB?=
 =?utf-8?B?U09OZVBoWEVySXhPMlE2bDFkZStRUENsZ0w1d2RoUm8zcThuL0NnOGp1cUEw?=
 =?utf-8?B?WU1sUWdPd3JxTVpVZ0t3OEgwcG5tM3Vva2wraWt5ZUN0UEJnT20zWlZ4RjhR?=
 =?utf-8?B?Y1g2bVhvNThGRnhZakRMMVNpMEJDTUswby9GVmJPWm1OQ1RFU1dBbFZxSG9E?=
 =?utf-8?B?TkVsTTBibGxtaXJlRGFVcVRkWVRWNnV5NVBBa1czLzZJK09tcU15ZlVEL3Jm?=
 =?utf-8?B?c29RT1hvOFpVTWdFdVJSWW9yaVh6OVE0OVRSNEloSG8yK2IvbzNsMm5UVzVE?=
 =?utf-8?B?RTZ3RkRZYUdlSWdsY1NSV0ZSdlZoSHJkR0hraG1URnlLTUJPMjB5dVNERU5r?=
 =?utf-8?B?K1E5d21FNVVKWWVvcEtpVkpJR3Q0VEdlTGp4QmJlaUc0aGJlMmhSdTFWenFm?=
 =?utf-8?B?NzNwV1VzeXBHYVo4aENyZjhXcm9uRjFvSVgyRUFldEEwRlI4dWpsZjdTRnBZ?=
 =?utf-8?B?YWRJTW5qODhiUVZ0bi9SaHJiTFpHdjhkS0dVaTNRZWhhVVphcTJ1SHphRGtk?=
 =?utf-8?B?bEtiNjlKL3V3Zlpuc244amxQTlE5aUw0K3E5ZTZURVdhT0J2cm9qUk12SkpU?=
 =?utf-8?B?OVp6K0dySTcyblZHS2liMTd0K2xvYjVXci9vMFZkTTZkejY4OUFjSGVPRFN0?=
 =?utf-8?B?QnNVQ0VaMnJaemd3bXY2WkhuVklBZWw1VE8wOFRTZ09JZzRYYkZWOVRMOVF4?=
 =?utf-8?B?eXU5SUpDRGpGdExmY0xFOW1TalgzaDNaaFBZdTJZbDE4TFRyK3l6TEp2bmZU?=
 =?utf-8?B?ZzNaSmtLY2p6ckY3aWxCUUd3YmF5dmRWczdoK1I2bThzZXdpdFJSQjFoUVgw?=
 =?utf-8?Q?/nyM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9fa78a-d45b-4420-fb48-08dd09d248e4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 02:14:52.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/rnCuIDx7Tzpt1pKG50oih/zUUcDwj66Kbhdk5u+Pd3mjecrPBlWQ9oygJZGUAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

Hi Reinette,

On 11/18/2024 1:43 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> Users can modify the configuration of assignable events. Whenever the
>> event configuration is updated, MBM assignments must be revised across
>> all monitor groups within the impacted domains.
> 
> Please revisit the "Changelog" section in
> Documentation/process/maintainer-tip.rst
> 

ok.

Imperative mood, context, problem and solution.

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Again patch changed completely based on the comment.
>>      https://lore.kernel.org/lkml/03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com/
>>      Introduced resctrl_mon_event_config_set to handle IPI.
>>      But sending another IPI inside IPI causes problem. Kernel reports SMP
>>      warning. So, introduced resctrl_arch_update_cntr() to send the command directly.
> 
> I see ... the WARN is because there is a check whether IRQs are disabled before
> the check whether the function can be run locally.

ok

> 
>>
>> v8: Patch changed completely.
>>      Updated the assignment on same IPI as the event is updated.
>>      Could not do the way we discussed in the thread.
>>      https://lore.kernel.org/lkml/f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com/
>>      Needed to figure out event type to update the configuration.
>>
>> v7: New patch to update the assignments. Missed it earlier.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 +++++++++++++++++++++++---
>>   include/linux/resctrl.h                |  3 +-
>>   2 files changed, 79 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5b8bb8bd913c..7646d67ea10e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1710,6 +1710,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>>   }
>>   
>>   struct mon_config_info {
>> +	struct rdt_resource *r;
>>   	struct rdt_mon_domain *d;
>>   	u32 evtid;
>>   	u32 mon_config;
>> @@ -1735,26 +1736,28 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>>   	return INVALID_CONFIG_VALUE;
>>   }
>>   
>> -void resctrl_arch_mon_event_config_set(void *info)
>> +void resctrl_arch_mon_event_config_set(struct rdt_mon_domain *d,
>> +				       enum resctrl_event_id eventid, u32 val)
>>   {
>> -	struct mon_config_info *mon_info = info;
>>   	struct rdt_hw_mon_domain *hw_dom;
>>   	unsigned int index;
>>   
>> -	index = mon_event_config_index_get(mon_info->evtid);
>> +	index = mon_event_config_index_get(eventid);
>>   	if (index == INVALID_CONFIG_INDEX)
>>   		return;
>>   
>> -	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, val, 0);
>>   
>> -	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
>> +	hw_dom = resctrl_to_arch_mon_dom(d);
>>   
>> -	switch (mon_info->evtid) {
>> +	switch (eventid) {
>>   	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> -		hw_dom->mbm_total_cfg = mon_info->mon_config;
>> +		hw_dom->mbm_total_cfg = val;
>>   		break;
>>   	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> -		hw_dom->mbm_local_cfg = mon_info->mon_config;
>> +		hw_dom->mbm_local_cfg = val;
>> +		break;
>> +	default:
>>   		break;
>>   	}
>>   }
>> @@ -1826,6 +1829,70 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +static struct rdtgroup *rdtgroup_find_grp_by_cntr_id_index(int cntr_id, unsigned int index)
>> +{
>> +	struct rdtgroup *prgrp, *crgrp;
>> +
>> +	/* Check if the cntr_id is associated to the event type updated */
>> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +		if (prgrp->mon.cntr_id[index] == cntr_id)
>> +			return prgrp;
>> +
>> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
>> +			if (crgrp->mon.cntr_id[index] == cntr_id)
>> +				return crgrp;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void resctrl_arch_update_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +				     enum resctrl_event_id evtid, u32 rmid,
>> +				     u32 closid, u32 cntr_id, u32 val)
>> +{
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +
>> +	abmc_cfg.split.cfg_en = 1;
>> +	abmc_cfg.split.cntr_en = 1;
>> +	abmc_cfg.split.cntr_id = cntr_id;
>> +	abmc_cfg.split.bw_src = rmid;
>> +	abmc_cfg.split.bw_type = val;
>> +
>> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);
> 
> Is it needed to create an almost duplicate function? What if instead
> only resctrl_arch_config_cntr() exists and it uses parameter to decide
> whether to call resctrl_abmc_config_one_amd() directly or via
> smp_call_function_any()? I think that should help to make clear how
> the code flows.
> Also note that this is an almost identical arch callback with no
> error return. I expect that building on existing resctrl_arch_config_cntr()
> will make things easier to understand.

It can be done. But it takes another parameter to the function.
It has 7 parameters already. This will be 8th.
Will change it if that is ok.

> 
>> +}
>> +
>> +static void resctrl_mon_event_config_set(void *info)
>> +{
>> +	struct mon_config_info *mon_info = info;
>> +	struct rdt_mon_domain *d = mon_info->d;
>> +	struct rdt_resource *r = mon_info->r;
> 
> Note that local variable r is created here while the function is inconsistent by
> switching between using r and mon_info->r.

Sure. Got it.

> 
>> +	struct rdtgroup *rdtgrp;
>> +	unsigned int index;
>> +	u32 cntr_id;
>> +
>> +	resctrl_arch_mon_event_config_set(d, mon_info->evtid, mon_info->mon_config);
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +		return;
>> +
>> +	index = mon_event_config_index_get(mon_info->evtid);
> 
> This is an AMD arch specific helper to know which offset of an MSR to use. It should
> not be used directly in resctrl fs code, this is what MBM_EVENT_ARRAY_INDEX was created for.

Sure.

> 
> Since MBM_EVENT_ARRAY_INDEX is a macro it can be called closer to where it is used,
> within  rdtgroup_find_grp_by_cntr_id_index(), which prompts a reconsider of that function name.


How about ?

static struct rdtgroup *rdtgroup_find_grp_by_cntr_id_event(int cntr_id, 
enum resctrl_event_id evtid)

Will move the macro MBM_EVENT_ARRAY_INDEX inside the function.


> 
>> +	if (index == INVALID_CONFIG_INDEX)
>> +		return;
>> +
>> +	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
>> +		if (test_bit(cntr_id, d->mbm_cntr_map)) {
>> +			rdtgrp = rdtgroup_find_grp_by_cntr_id_index(cntr_id, index);
>> +			if (rdtgrp)
>> +				resctrl_arch_update_cntr(mon_info->r, d,
>> +							 mon_info->evtid,
>> +							 rdtgrp->mon.rmid,
>> +							 rdtgrp->closid,
>> +							 cntr_id,
>> +							 mon_info->mon_config);
>> +		}
>> +	}
>> +}
> 
> Could you please add some function comments to explain the flow here? For example,
> what should reader consider if there is to rdtgroup found?

Sure.

-- 
- Babu Moger

