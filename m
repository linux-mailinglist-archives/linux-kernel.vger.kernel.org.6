Return-Path: <linux-kernel+bounces-254090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58339932EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA10B1F22C27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95819F468;
	Tue, 16 Jul 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e4SrYK+e"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBA19ADBE;
	Tue, 16 Jul 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148685; cv=fail; b=qQ4YfAvMkQ5dS0OBh1JPsID9pRqBnHWrurQkmj3pEH1deIdeCIYiWSNM+950iJUbcfMgleoxzDJnng56WcQXJtnDnZ1eZAFB+nML0YP0Ot2PYovex/vcYb0Km/jquBdALqXtnVbQu5vLDD5+h9kkkdHuCdXQ9slcbKACUe0RZw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148685; c=relaxed/simple;
	bh=MnBc46LmB+aI0JklVBoJNmLXyeuLIFfbnK1TFa8MB10=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAIEuEHqnnuqMnPy4JmZIuYXHlZX2DKacDzaBPc0/829DyH1353OJcQlPOYq/5yqYWHdvnbYBgyjzenH2o/PvYIF5abpn/I/MF+r6JWa3BITIiNzbpNdSjhnGXLH1a60IdtLUnJp+s2temt4b+G4wsdwqh3igbQhem6vbQB10sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e4SrYK+e; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVCAhF+Tiv3VD8JW5BhDcexMsoiXVLBV4WDCFSMZYdZQ6hk8kEBKy2hKjLbWEr+tbPcyI6peK176zibdv9cdPBs+vAiKGzj+mfFFiwFu09F4klDIMQ3XxI+6PTdsW+PB1vtDvBo6t/fmISXVgY7anbg79aTkRB0d7g+sIINIrHD8j7EHyQuyETmQDUIIjsU9xM3wkxZPGoZ9Q4KEKZ9qy+hEgk1TqhLOyqvpXfJujtI3lwmeJIS5GLN41bRNBFT4UxzOw3viiyI7bxFweWF6iQ8mNPuSEqZ8/6PAi0mA1H5NmXlFLX2YfuKCCfsHepxI9IdD6dTKjwuLtrPHp04b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBx31m0fw3OosUejhBW/WTG6/MMy8CUaq1aeJkuyA64=;
 b=GLTKZIyCdL26eb4fbX00Jne2YdThYZEz+xKQJfTdRaZFtMYjTJeSEAqB6+OgMdMkFG4yN7MyPfR071vX9WidkEM2PAMYKB7IA1q/pCb/S5/10axY5m+nh921f6KXYRpzta9HGjgu2N9uJyPVOLUasPce1tcHTzZ8Aj3BxM2Ig0YrUoJVII4NbC3Fkz5WYVtIji4rzMlnEWbCS0zc93Tpc/EsGPUGyvKfW/zpyp1bMArS4GLnOLfiTASNgaC6hjjP88sGVEB7xE66Cr4qINTytk3SiUR5TWo7dtZ7WyLz/jlc8pM1pux4IbQH+2wu+5I+sW8wOVFGglMCCTYMvKNQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBx31m0fw3OosUejhBW/WTG6/MMy8CUaq1aeJkuyA64=;
 b=e4SrYK+elxom3hs215XtHe/xtFbOk+i6C/3iFt+FAncjbf7CchP9x7RQCkgzf1gi5nEdT7aK1BqCEMb15dd64NSkQ9FuYX/CytUeG+yM6fCo8OlJ3eQQNgDea6vFc29bDhvOhEC0EpumTMqcz2s9C3v9AfaPckOICz7wa/VL0dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 16:51:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 16:51:17 +0000
Message-ID: <5005f017-a499-43e8-ab3d-cddf7c9d8053@amd.com>
Date: Tue, 16 Jul 2024 11:51:13 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 07/20] x86/resctrl: Introduce the interface to display
 monitor mode
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <4b8e3a4dcd8b6c7d7ce80a54cd2a129cbd2eedda.1720043311.git.babu.moger@amd.com>
 <bad25f0e-8c74-46ad-8bd0-d25f954f1714@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <bad25f0e-8c74-46ad-8bd0-d25f954f1714@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0185.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dffef1-8efa-4bec-e932-08dca5b782e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjhJU2JKRE9YR3BMRURrcDlVdHVIbGcwbVhHdllMVXBzUUtyVGhmV2ExbUJZ?=
 =?utf-8?B?QS9VQ001cUtUb3RycmxlR1RwTnJXMEs3emdzaDg5SEN4NjhtQU5XR2NJYW5u?=
 =?utf-8?B?NEVldzhnMG5DSmhONm9oKzJleTBmS1YzWnkraEp0enl3WE9GRUZWcXR0bDlL?=
 =?utf-8?B?ZGsvQjBnaENTSVh5ekhZVFFPMXJ5VHgxZUdnT04vYXd0MFdGWlhTZ3ZLNDYr?=
 =?utf-8?B?dU8vcnhEcU9uNG9pUENsVWhlTlEyWWlhbjBwMUdmMGx4ZG1pTUpkdzZCOSto?=
 =?utf-8?B?Ui9EMG9pM0l3cW1kSVNnM09DcEV2ZHoyNmpHZ1ZPaDEyeHYyV0JrakRPNTBo?=
 =?utf-8?B?OUlSQ0JORkFhOXZOMW5UUEt2SDdoeVVkQVkrUXdGUTYvWUFjV1RIbEZXTy9w?=
 =?utf-8?B?MzMxZDNHeFFlUit1SmlVeVNDbjg4MU1qS1BxaWdCdUZTK1d3VmJoUU03THNS?=
 =?utf-8?B?Vkcvc25MYVgzZXdza2xUaDFYejlSdW9UZUNheTVsa01Vc00vV2dpbVdFcWNa?=
 =?utf-8?B?Z3QzeVd4R08vYk1IL05pRnhibEhCSG1nQXNhekxsOTZEZit0eFdicGh2Q29v?=
 =?utf-8?B?aDV2Q3RBM09ib2d4TnJpdTlJN2ZadHdiNXJuTFd0d09rNmszZGNXL0F6bk1J?=
 =?utf-8?B?d1Y2SEZ0YWhUTVJpbHBXWkxRK1pOeG9CdmZQMUNRTlFHbEVFZkYrQWtsR3Z1?=
 =?utf-8?B?c1c4Nzl6Zi9ZV0NiV0k4V256Z3k5WGI0S3BBU0FQazAzMEhEVFpRdVJYYm5z?=
 =?utf-8?B?QXduek5ORDU1azRNdXE0RGk1NVlqNXJxNm5ZT3gxRXIzL0hXN3VtTjM4QThi?=
 =?utf-8?B?TERsenV3RzkyVzlPazNnbnZnaTlwallHRG1UWFpkMVBrUFMzNHExaG9LN243?=
 =?utf-8?B?NVhIWHZoeVUyZ21sb1g5Z1QrV3VJRjBJUWc2NTI1bDE4ZkFNbndwbEYrY2hL?=
 =?utf-8?B?bG1FVHRKWUN0WFY1MHZTMndES3JjSzFjaUhlbnkwVldwWVpKU0JhQkEyWUR0?=
 =?utf-8?B?LzVRM3FBZlV2RUROMUhML1JBUkV4OWkwZlA3RHQyLzVwcnpJSWp1Y09idmdm?=
 =?utf-8?B?S0k5ZCsrREM5aXBjQXdCd09iQ1N5V1dNSUkwTm1zMVV5bDBIT3JLeG5QS3pW?=
 =?utf-8?B?TFd3enJPTjRwWmZtWXEwdzZhSklWNG1DeTdaMkdtRmt0ZGVVYjVKZXFEaGsx?=
 =?utf-8?B?MVI5MVd4T1BTcCtoL056WTY0djEzSHhpL0dpbUZCYk1hMUJpZDJKRUpndUcy?=
 =?utf-8?B?a3dOeHFqdVhaL0JhRUplZ1o1U3BuNzhobTJkRVJhZ2haVW00MmVOU3FiZDFE?=
 =?utf-8?B?U2Fsa21oT01sSkp4ZW5MYkdDdmM4eFZyVkgyYXRXL3k1dG9zUStDTWFDNmFQ?=
 =?utf-8?B?cE1ERmVlRm9xWDRIZERmTUhFaWFqd3VoRElSTTlJa2djbG1wZGNhVWxUL2hB?=
 =?utf-8?B?REUrSVo1S0QvekdkeTBqQlh2NFVmU3dqT0F5ZkpNdG41bjV6UUZ1bFh1d1Z1?=
 =?utf-8?B?R3h1THQwU09ja1A1Mmx3cFFIV0dLcGhVMEs2MWpJQk9uWUtLeC82L0p5WVVt?=
 =?utf-8?B?TVdrTW5oMUZHYVhKVFdHOU5Zbm9IL1Z0YzdLNTIzb3VlMnpRRDhNc2t6NDBI?=
 =?utf-8?B?TzRLUFNDOW1senJ4Zk11SnpMYjJyVkdpa3BaMDU0TFg2RG5OdFdCMTZJeU1Z?=
 =?utf-8?B?c0VVUURnSUVmZHFjN00rckhlaGJxakVOeDBHQmk5ejlxRE9CQzJpSjR5aTdr?=
 =?utf-8?B?Uy90SjJvYVloMG9XQnhJbHo2cjNmWkpsYjBERi9NcDdJQU04bHRZK3JLVHEy?=
 =?utf-8?B?eVFLaVpJTXQ4bENyd1pmUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNvTUh6ZCtQYkpRUHkwUnkwMzBHR2k5a2d5cWQ2eW85TXNwWkJ2S0RQbVp0?=
 =?utf-8?B?MTFJMWwvRVh6MXlMbm1rREJKUEhnaXR6MXEyUXZtY3NNcVpabjlCY0d0NTNl?=
 =?utf-8?B?a2RSdUIwT1JkM3MrODZOZzZ6Z2krek5tUVMxRWlrVi9DWWlDUUdENy91NEtX?=
 =?utf-8?B?QVZHdHRjazBjcE5sdDVNdHRZUFRFM0FZaTlPRExRUkpoaEtBMW5mRCt1bWF1?=
 =?utf-8?B?dlJ4UWdweklGdy9GT0piOWpRN01yUU9nWHVwaUNIY0xGK1RNSjV0ZzJOQ1dz?=
 =?utf-8?B?MXR1T1M4OUFYR0czcCtIQkhjRW84SlVuZWwxSnJ0bjJtMWR0N3JZWU1sR0ts?=
 =?utf-8?B?UCtMWHIyMTVSNmtIblJSM3dwQmJnKzJSTXRlNU11dDR5cWJWUFdsZ1l0SWdt?=
 =?utf-8?B?aUthamo4QjhjY3FldE4zS3NmU0FaRk1Fa2ZDVVM3WlFCczM0cUxLc3NST0JJ?=
 =?utf-8?B?S0ExZnhDcEVkUS91eVdxWVVqZzdicFQ5WW5ZSkNwdjNzQzE1ZWx3YkFSRnZS?=
 =?utf-8?B?cHZDL3QreUhTanEyeUo1NHB5TGp6bCtQcmpSemRZZE1kZTFaTjNQajRPYlVF?=
 =?utf-8?B?YytmZ2JPRHhnSEpIdVNKTFJqcFNFYjZiZ3hJZEtpTUE0YzFsVG9TNzZRY2Fm?=
 =?utf-8?B?bDduL2ErL0ZRS3RwdVBLc3BNcFJEWE4yUjcvRmhqaVBCTmIxWHZCV2RFZG5O?=
 =?utf-8?B?Wm9PU2F0QXd3cUtIZ3RQbXYzREdBbHU4QTFlV2RkOXNDWlBBYUwvUG9RdVNk?=
 =?utf-8?B?L0ZBVG1rTDRnaXlwZU5JRzVrOEpHTWFpMFhtUG1QdmtiamlPZ3B1V1lkMS8y?=
 =?utf-8?B?c0xTN0lMVVg4OWhOSk1Da0RrR3hYcmxGVVlYeVlBSjVNRHVrWkZ2ZkxXa2VK?=
 =?utf-8?B?cE1EUllWM0U4eXJLdGcrUE5GUWxBQ1lEUENQaWMweGxBY1FwVjc1RGcvNUxZ?=
 =?utf-8?B?bXRQZ2xMN0lKeTR2eGJ6Ynh1YjZuMG9GYkNnOHB0TzZLZUVIcjJWK0cwKzB1?=
 =?utf-8?B?dXhLc2VzSDJSVW5Kakt2SS81ZVRTdVdxUExoaG9SakovWGhCVVdvNnpIaVV4?=
 =?utf-8?B?WUZQZmJjS0tCcGs2emFqZzhaNDVFeUJxQ3JuSklzTHN2dGQ5UVNzYWZBUHNS?=
 =?utf-8?B?aGd6OUg5Tlo0VXdDc1dGVWNvU3Zlbi82V3ZOQWVKR2RkZVRBMjlyaTM3MzIx?=
 =?utf-8?B?QnRXbVhtVU56ZGJ2QVozMHFkOUdwMGNyZ0pCY28vV1BXYVRIQ2JEaG4xWjdO?=
 =?utf-8?B?Z05tNnBnS1gyRm5BY3VFT1hGZFZlbi9XUW5ZVmxVeUE4SVRpM1ByRTRtM1d1?=
 =?utf-8?B?K0lVc0JjRjZLbW0rMGpEUVVLNjBFek41V0dJN3h4Ulo5RVNSZ1hpTUdrZHkv?=
 =?utf-8?B?c1NLd254ZTdUdkNZeUw5TXZFUmNQbm1SYVBnVCtPNUdDb0tLVFQzZmIvR2p3?=
 =?utf-8?B?ekZWejBMNWE2ay8wYk9vbWI5TFltOElaeGIzWUl0NEFCVldMUisyV1ZUZVV5?=
 =?utf-8?B?cmo5QXVIVE5NcWhkSldwZ2lvUm1GVDdkbU1laHRlUVIxNHovOVM5N1duNjJP?=
 =?utf-8?B?SC9OZDcvYW9kam1sZDR5a1hHcEdIRytBS2FBUWhSM05lOVRqZ1kwbUdHczhx?=
 =?utf-8?B?VllxTnd5akNmNkVNK3BlMVkvVlNNOE9YblFqbi92RXFFakh0N2x3R29uR3d1?=
 =?utf-8?B?OFlvTDdpSWtPcmJOYm9HUEF1cUszZUNhNjFoWlZrNHFuZW80eHhtYUxFV0xu?=
 =?utf-8?B?c29HV0dLZjFJOWhPWEwzSE5PUGxsYmlYV2grMHl6TnprWWg1STJoL0xJZmwy?=
 =?utf-8?B?WmVjeHlhL1V6Y1lXQVlraGJGT0V3RDBERWorZnlqZG1wdWNDT1pZdUJwUURE?=
 =?utf-8?B?eElhd0pTSGVMV0ZldWExbzBlVmFCY2RlUEhpazJLdjBaNzBla08rSm16aUpN?=
 =?utf-8?B?MXVZaDNXM0xxSFVkWlMya0UzQlVZU0hUZnREa0MxdHVwbVM3eGxLK0JocUJH?=
 =?utf-8?B?UHR4MHZKMWd0NktHdmhHcHFTbjNKVjIwaXd0cjFiTjZyUWY0Z2xxZ2RYb3ZC?=
 =?utf-8?B?RmNEdjRkcVNMYXlBUHdnYmVYQ2oyaVpxT2NIWndUSHM0bGFFSzFGdGJtTHhl?=
 =?utf-8?Q?WuQ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dffef1-8efa-4bec-e932-08dca5b782e9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 16:51:17.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enT30WyttS8vMcw1zVy6xLNmo0oiDokKI7dkM2bXaygXgP6jzYxJ7mImZb6TX2Zx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

Hi Reinette,

On 7/12/24 17:06, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> ABMC mode is enabled by default when supported. System can be one mode
>> at a time (Legacy monitor mode or ABMC mode).
>>
>> Provide an interface to display the monitor mode on the system.
>>      $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>      [abmc]
>>      legacy
> 
> <insert snippet about what happens when user switches from one mode
> to another>

Sure.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Changed interface name to mbm_mode.
>>      It will be always available even if ABMC feature is not supported.
>>      Added description in resctrl.rst about ABMC mode.
>>      Fixed display abmc and legacy consistantly.
>>
>> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
>>
>> v3: New patch to display ABMC capability.
>> ---
>>   Documentation/arch/x86/resctrl.rst     | 30 ++++++++++++++++++++++++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 26 ++++++++++++++++++++++
>>   3 files changed, 58 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 30586728a4cd..108e494fd7cc 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,36 @@ with the following files:
>>           # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>           0=0x30;1=0x30;3=0x15;4=0x15
>>   +"mbm_mode":
>> +    Reports the list of assignable monitoring features supported. The
>> +    enclosed brackets indicate which feature is enabled.
>> +    ::
>> +
>> +      cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> +      [abmc]
>> +      legacy
>> +
> 
> "mbm_cntr" mode can be documented here with the details on how AMD's ABMC is
> one example of how it may be implemented on a system.

Will display as "mbm_cntr_assignable".

Yes. Will add details specific about AMD's ABMC.

> 
>> +    The bandwidth monitoring feature on AMD system only guarantees that
>> +    RMIDs currently assigned to a processor will be tracked by hardware.
>> +    The counters of any other RMIDs which are no longer being tracked
>> +    will be reset to zero. The MBM event counters return "Unavailable"
>> +    for the RMIDs that are not tracked by hardware. So, there can be
>> +    only limited number of groups that can give guaranteed monitoring
>> +    numbers. With ever changing configurations there is no way to
>> +    definitely know which of these groups are being tracked for certain
>> +    point of time. Users do not have the option to monitor a group or
>> +    set of groups for certain period of time without worrying about
>> +    RMID being reset in between.
>> +
>> +    The ABMC feature provides an option to the user to assign a
>> +    hardware counter to an RMID and monitor the bandwidth as long as
>> +    it is assigned. The assigned RMID will be tracked by the hardware
>> +    until the user unassigns it manually. There is no need to worry
>> +    about counters being reset during this period.
>> +
>> +    Without ABMC enabled, monitoring will work in "legacy" mode
>> +    without assignment option.
> 
> Let "legacy" be a distinct mode, instead of an alternative to ABMC.

Will add as another mode.

> 
>> +
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 12793762ca24..6c4cb36b4b50 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1245,6 +1245,8 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>           }
>>       }
>>   +    resctrl_file_fflags_init("mbm_mode", RFTYPE_MON_INFO);
>> +
> 
> Is this special flag assignment necessary? With file always visible I
> think it
> can just be initialized in res_common_files below with the flag already
> assigned?

Yes. We can do that.

> 
>>       l3_mon_evt_init(r);
>>         r->mon_capable = true;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 471fc0dbd7c3..3988d7b86817 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -845,6 +845,26 @@ static int rdtgroup_rmid_show(struct
>> kernfs_open_file *of,
>>       return ret;
>>   }
>>   +static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
>> +                  struct seq_file *s, void *v)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +
>> +    if (r->mon.abmc_capable) {
>> +        if (resctrl_arch_get_abmc_enabled()) {
>> +            seq_puts(s, "[abmc]\n");
>> +            seq_puts(s, "legacy\n");
>> +        } else {
>> +            seq_puts(s, "abmc\n");
>> +            seq_puts(s, "[legacy]\n");
>> +        }
>> +    } else {
>> +        seq_puts(s, "[legacy]\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -1901,6 +1921,12 @@ static struct rftype res_common_files[] = {
>>           .seq_show    = mbm_local_bytes_config_show,
>>           .write        = mbm_local_bytes_config_write,
>>       },
>> +    {
>> +        .name        = "mbm_mode",
>> +        .mode        = 0444,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = rdtgroup_mbm_mode_show,
>> +    },
>>       {
>>           .name        = "cpus",
>>           .mode        = 0644,
> 
> Reinette
> 

-- 
Thanks
Babu Moger

