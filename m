Return-Path: <linux-kernel+bounces-416241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3F69D426B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BACB2358E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00611BC068;
	Wed, 20 Nov 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jgpYk63"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F92158A13;
	Wed, 20 Nov 2024 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130100; cv=fail; b=D4Q9IWSO8L+TJKp4RTLLXEOYmnbOEbxPYv3QWWRcFWmIG5M6g6Ahr2B4ObwvwsEsEGQAQzKxNnkD/9xGbfegI9k8AII/gvTR5DUpI+2NQgd8CoCo6fLkzCl9t1VHiUtYODj0cfA5bSkPWob6ygFsnH1YF7VZnxDCoyY/WOlk3Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130100; c=relaxed/simple;
	bh=hPyGsBLSFQK3R46SceR6rxnQ/bob7Du1nzxOahyvYcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsrTk2twOIotb2FFbnXpjSC+C3799Q5kwAz4BElwNUJc4XIJV+Qg16WRBM95wo/paZK0lEC80JnEX7ZST/CMi6nXNemjcCDv4Y2m0uC1WtCb8wDDO3vLlNknSGLNzQG/sIeUL8auXm6QQVmfhb57k3Bay6/3ENGucagwT2zznvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jgpYk63; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niZ8F6x6Tle+PV1TEgsJ942aRQHU+qDySMp44Vg7ZIj6W78CiUyMIGqCcy5qtkI/19j1Pb/ipTyo8ZNXmjGgt87I9BA4dGMXRdhUpqOdEAO9GNjGnColhMKhbsGo4qG0FvpFK9Xg7yD4zjq2+S8afFIBsXoa/rR2hd3/+lAYpLnw9jQOmWX6F/41BhAH82WDTMVNEJbW42NojxyDfBxCaCt3JM4aOh6rxDFcggAAPMMgMkNEEIeVYtbQz+c3u5VqQPhM/mUgSbuJ1/j8TIDclVpQ6NMci7YBUSuLUXJoZ5pewVruD/UAh/9VnLRJpmdf9tMEc8cOb9403Fi+ZaZ4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drSQvMHrXJc5cSOVtPUW951MMv08DMxRZ6LhGin/pJc=;
 b=JqZzNjbuUxjgRi14DPBenexV3dKW0Q+q43kD+9j+4ofMjXJoPtPNfG0VAAgepcwIP/sv9nFoCQiZyRf9QwVshjqc/SuG2NdsmSOudZTLr+P2rqwb6tlBJCBC/aN+TdjB6PLLbQIsO8jsKj4dZAoCdRx32ai6LWB2l0SuhlCOdWp3D1GYKJDYfy1X/q3QpnWep8H2oGMSyv+xblmSjvXDo081iIfW3bh9CAvpDi2RNe98hDmMTvINHsS2+LLfrTsX4P9F+pQuFJ9KesMFV1FP2uP1OsqCJ6fPvMFHSewTIT5G7ba0bFWyny4ZANVinPZfa5ZDUJpV+iKwS7Ngozc51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drSQvMHrXJc5cSOVtPUW951MMv08DMxRZ6LhGin/pJc=;
 b=5jgpYk63NNz4O6rgNfbsz554sF+Z71WJ3DZpGRgH8j/1zNbz7jdeMgcVwcRo8Cxb78OPK44F656Wl3NSqB13Gcaw1G5k9x+klEwTpaoKXAzHEl82ZNnLCs3FNhCPHwnILcila7WCksVoB4jpcZZriFs9xePl0a4FzQ6Hdyi2LNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 19:14:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:14:56 +0000
Message-ID: <4ab51c97-6802-47a9-b748-1f71ab66e81c@amd.com>
Date: Wed, 20 Nov 2024 13:14:52 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 21/26] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 vikas.shivappa@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <fcc0d1cc4e0f60626417b0c3bffe7638d6de9071.1730244116.git.babu.moger@amd.com>
 <ae12f5d7-2f38-4f38-ab19-0875bd393443@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ae12f5d7-2f38-4f38-ab19-0875bd393443@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:806:28::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e51cdc-70f2-47d8-1e2e-08dd09979e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVJOU2h3NDIydjBTbjdOTmZOcVY1cW1SUjlKYnlpbTEyN0tUam9Jak9OR2ps?=
 =?utf-8?B?MVpGcllpbDByVDBEdytFN2k2ZkkvUHREZ29lU0Q5VWVKSFN5azRlSnlqZVhG?=
 =?utf-8?B?WHh3Nm1RMWMzbFROSXF5K05SbW40bWpwdGwyKzdYbk5CNmxsL0NpN0MxSmNr?=
 =?utf-8?B?QzByYS9seDdSaVpJbUJhV2E2UCtIbWo1VjNZTGtjSSttcjhMVktuZnVpU25I?=
 =?utf-8?B?enk3cVh1UEdWSERQS2gzK3lVRU43c3I0MlJaSUhadUdiOWlsZzgwUit5SWlL?=
 =?utf-8?B?Zm1mQXI3Mkt6aTBQdXE3RGY0Y0hnbndKZ2hxeHlCL0pzQUU0aWZia1EvNlBj?=
 =?utf-8?B?MEliclJEWEtuenJ5MVkvZUdYaHR6V1lRQ3JUTnRiWjZVR1NuR1RPZEhpcnhC?=
 =?utf-8?B?azJDUmN1UFZ4WDJLRURmU0ZPWmV2c2U2b0kyanowcFhWKzRNWkVZcEpsendo?=
 =?utf-8?B?eGFTZTlDaU1jL0J1WFNtMEJuWUN4WVpmSUJMcUdvN1BCZFNKTzBPSnBFK2JV?=
 =?utf-8?B?akQwNllZZlFiaWNEOHBqTXEveWQyK2V0MUNtNUpuN0pDc1g4eHFBYXpLWUQ5?=
 =?utf-8?B?WmUyS2xJQzQ0eXZBK04yK2RuNjRSdDluUSt3djR2Q3FjTWVXYnk1Z2tXMXRv?=
 =?utf-8?B?ZWlwTDJNOFc0R21RT3BDcUpUWW8vdnh4OVdlVXIrc0VWMGIvajA1bUppQll1?=
 =?utf-8?B?RmErNGRSWnRra25xdHRwWFAyUHN6OGdONWtrWlg0R2NPRzJLYUVEcEVoYTlE?=
 =?utf-8?B?QzdkZ04xVHk0MWc3RzlDWnRPeEZheW1jQzM1U0M2dUlSQkdMUWhrUlN5Sy9x?=
 =?utf-8?B?VkJpY1JYMnpPSXVVc3JrdENlSUJwMmxmUzc3aHdxeWIxTXNwemlJc2F6Nm1S?=
 =?utf-8?B?b3V5bndLWjBQSUxCWDJSdVJZUCtTZGNDTS9XUVhmdyt0YkNoOVlXbkNqek83?=
 =?utf-8?B?TW81T0ExWld6cEVmMUdISS9WVUsvVlYwTm9aR1B1YXpSN283QWNldHlKQisv?=
 =?utf-8?B?NjdvRU0vSUVrNllrR0RWSWU5ZnAxRU9CUFRlVXU1RlJCOTAzZkpMc09IVGZC?=
 =?utf-8?B?QmhmYkwxZ01FSzhKN0dUV2hBU3NQWjhzR3g4eWNuNUtsb3ZnMndqT0RrRVBw?=
 =?utf-8?B?bnRWbXBWYWNTcDdwbGRDcXV5REJlQnl1TWd0UUxaT0NzTGRob1hSeXc5YURJ?=
 =?utf-8?B?dlFXV29iOVVYNjNkMGo0RmJ6bE03NENtNWJ6KzVYSzNlZEdSejdFVG4wbW1M?=
 =?utf-8?B?Zk82TnVHaXlMVXB6QVVqSk02bjFncXBzdTJTSUZTaDl4QWJyRlNSWUk3akdx?=
 =?utf-8?B?TnEzcjRXMTJRNGwwSGtFTmsxcmRwK1Y2TGNZbm1QdFBXenpOSlhpWCtuR2o3?=
 =?utf-8?B?UGRjZm94WnIxbHpINC9sajM3OE9Hdmc4Uk15eEdMRTVCMjc1a2hJRWRNMkR2?=
 =?utf-8?B?akZGVnR3L096Z0kzYm9PY2RzWjNDQ1JhMURHUGpXeTFSU0xxR2ZtK2pic1lW?=
 =?utf-8?B?eTAxTU5tdFVmcWp5aklabk5zN09WTm5CQjlkTXRoN25jcHdkMHBKMFVsSy94?=
 =?utf-8?B?VG0xcnpoSEdybWpkNFovWHRoWjU0TUhPcVNlckdMSWZ4dGJYd015T05Rcldr?=
 =?utf-8?B?M2dYYitvekZEaGlCa3YvTUZUdmZTLzNmRzk2YnNSd2pYbjZubjVUL2gvWDVl?=
 =?utf-8?B?WVp3cU9LakREMWtDRnNiZGQ1MjdEalozUGFSbk1YWUhwcGltMGJETUcvRlRx?=
 =?utf-8?Q?uDeuEuNg0hXD+C4UasPZaaJ8DkDGfEOnSALiZtj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkhDZkRNaG5ScERXak5mc0F3OEtpODR4SDk5OFU1RkZpb0hDYXJvbzFlNkVl?=
 =?utf-8?B?UnpJaEpuQXFTYzBab3dqK3p3bFJkOWQ4YlVUbnBhKzRGNGtLdTVxWnJIY0k2?=
 =?utf-8?B?ZnAzUWQxWGRxeC96RkFPTHdjaHMyTlhFbjlLV0ZoM0FmMmtuSXEvU0o2dExw?=
 =?utf-8?B?c21EVTZDbkFqRndvVnJac1FFZ1N3aHhWZFBSelgxa2FPWkVnK0tKR2F2Tk0y?=
 =?utf-8?B?YjhJNFFsRXBtRXRwRTFWc0FnVVR4Ymg3djRGTVM0TE1sTWR0VG43bXl6Q1p5?=
 =?utf-8?B?eFh4a3ZvQzU3THR0VDQwcERaa2xBc2M0MGFjTnpwTTJLUExtK21zck4yRE9W?=
 =?utf-8?B?aHExNm81Sm5XVTlpdFNUdlZNVVQrS04rUmNOZTlXZXg3UXpaeHlUODRXcjRu?=
 =?utf-8?B?YzJQNzhXc0txdm9IYkk4UmxTbW5HUGxNUHllZVk0Q08veG1BdE9ndWF3cllG?=
 =?utf-8?B?bWJ5czFKUUR6cjQ3SEdXZm1qTk9kdGplT3VaVUxLNHo4MFowTkZFN1UzTnFr?=
 =?utf-8?B?TnhFNjJ3cW4xMXo3VTF4SFFyNDRhK0w3Ry9KVmpIdjhhbFVNdWRKZUZOKzU2?=
 =?utf-8?B?NzFLSU9BVS9XUzNsYUlSWEZSUmtjRDlqK3lvZzVlNkMrSlNoZW5UZlYzTzhq?=
 =?utf-8?B?Tnk5L05ieEtKMWZKUmJhSzEyMjB6a3dLdE1Qc0tZb0ZWcjZUQ2F1dk9GSk9U?=
 =?utf-8?B?dlNxaHZYWktHY2lWSU1xWVU1dll1UVJmNlJTRGxjYWxQRXhuRGpSS0ppMEpi?=
 =?utf-8?B?MTdBbzh2cDVzQzFMRVppT1VPQzdMcnNyYnNuZTNiblZDVUYrRUcyTHYzd3Vq?=
 =?utf-8?B?OE8wQ3dqVjJOS0ExMW1MZEhJb3BnZTY4OE5qeWExeS9FTnhJcFUrS2dOdzFJ?=
 =?utf-8?B?WDJCVWRtRkJFTXZXbldENzFHZkJoMzhoUUtuRDZiQTZYMkl3bkp3WHlxZ3Zq?=
 =?utf-8?B?OEhxZzhWY2tsU29kdkhoUkRlbGhRUXJHaEpZUlNYUXZ1TWF5K0F2RC8wOVJl?=
 =?utf-8?B?c1loc0tSQkZjYmR6RDJ6TGYySHc0WnF2QmZDL2FaR2FEdStiQi9MdzZ3L1pE?=
 =?utf-8?B?SUszblNvM096WFdhdjI5QS9BdXdsQzdFTkJ5ekJNWEtjQzN4VmJNNnFIdE8y?=
 =?utf-8?B?ejB3YXV6TnN3eEh3MzcxZS9MZ3hyZWhKSitYYUxIRjZiOFdOL1lDampBRDk5?=
 =?utf-8?B?R2E0OHV6VEw0Y0gzZ1BKaG50aENGTW5qZEJ2MVFzV1FabjZGR3RReXlJMTJW?=
 =?utf-8?B?OHc2TGVQQXpTTC8vNFRHYUQ1V3MyZjZ2RnN5U2ZQUGtJZ1JzSmROZjNzUGwx?=
 =?utf-8?B?K2tPaW1kT0FYNSt2anF4aXdtb0xobVlucUIxbVZUUUNmZHdFYXdVOS9qWVRZ?=
 =?utf-8?B?cWdFcndqY2NNQlBndWNxaU5KN3d4cTh3TkplSDg0ejNSblZUTExFWEd5dVF6?=
 =?utf-8?B?VkNMZDhWMUcvYmNnS3E1NWR6cUtzb0E0SXQvcEp1VVVhNXJaUHlOWU9oNm5B?=
 =?utf-8?B?M2o4V0xHcGJrMXlEREhOaFJUUEM1OGlJVnRQK3J4ejRBbW5TaGRoRmRKR0Vi?=
 =?utf-8?B?bHVjcWdGRjJIRko5YU9kUEtFNDlTVmNXNk5BQWxtNmlXQlBwc05VclQ3QS9X?=
 =?utf-8?B?T2JVdzhnTVFNdHZZU3FpeW5CV25aNzlJbVlYRDNuZ1diYnQ3dmdwMjRYdHY3?=
 =?utf-8?B?K2poN1UxRGNtZUE1c1M1cnRhZzFkamtNUUlYWWVzMGV1cUwyYkxzbmlnY2ht?=
 =?utf-8?B?Z291K1JmcjE0cHptMDA4OUVUeXJKSlhvVVU3Nk1oWTFtMG9FaGd6dSszVS9B?=
 =?utf-8?B?ODJyNzcwRURvajVTTFdMSCtId0N2c3pZM2VIMmhBTVhXd0tFWFdNNzJXZ3NG?=
 =?utf-8?B?RkRnSW4vVmtvbjNuRjYvbjlaMm04UGdhYnV6dHRYZHZDSG1UbXYraXZmZ3lU?=
 =?utf-8?B?ajIwaTE3WkRqQTgrT3ZyUkFnckpva0RwOC9LL2JLeGJwSmxJZ0pPWFFSc0tK?=
 =?utf-8?B?TUtVZUpYOHZFc2VTeS9GTDV5NkVPdU1xajRRbFdWdUtZU1l4STNVbjQ0b0JS?=
 =?utf-8?B?UHhQVCtsUjJXSThVeENib2xQVWJHZlRMVHE1cDRtNGpmMlk2WFJFbFVkblF1?=
 =?utf-8?Q?sr0Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e51cdc-70f2-47d8-1e2e-08dd09979e96
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:14:56.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCWAa01OdAfacisEQIWekkhyHeynwqzTQCiYCEybSd0k2GMzPSbs6q5JlY7vRBBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

Hi Reinette,

On 11/18/24 11:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> In mbm_cntr_assign mode, the hardware counter should be assigned to read
>> the MBM events.
>>
>> Report "Unassigned" in case the user attempts to read the events without
>> assigning the counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Used is_mbm_event() to check the event type.
>>     Minor user documentation update.
>>
>> v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
>>     Documentation update to make the text generic.
>>
>> v7: Moved the documentation under "mon_data".
>>     Updated the text little bit.
>>
>> v6: Added more explaination in the resctrl.rst
>>     Added checks to detect "Unassigned" before reading RMID.
>>
>> v5: New patch.
>> ---
>>  Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 12 +++++++++++-
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 2bc58d974934..864fc004d646 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -430,6 +430,16 @@ When monitoring is enabled all MON groups will also contain:
>>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>  	where "YY" is the node number.
>>  
>> +	When supported the 'mbm_cntr_assign' mode allows users to assign a
> 
> Could you please do through the documentation changes and make all the quote
> usage consistent with existing styles? For example, in this series "mbm_cntr_assign"
> is used in doc in various ways ... within double quotes, within single quotes, as
> well as without any quotes.

Yea. Will do. It should "mbm_cntr_assign" in all the references.

> 
>> +	counter to mon_hw_id, event pair enabling bandwidth monitoring for
>> +	as long as the counter remains assigned. The hardware will continue
>> +	tracking the assigned mon_hw_id until the user manually unassigns
>> +	it, ensuring that counters are not reset during this period. With
>> +	a limited number of counters, the system may run out of assignable
>> +	counters. In that case, MBM event counters will return "Unassigned"
> 
> Please review style for all quote usage, for example, "Unassigned" above is
> also not consistent.

Yes. Will change it to 'Unassigned'.

> 
>> +	when the event is read. Users must manually assign a counter to read
>> +	the events.
>> +
> Reinette
> 

-- 
Thanks
Babu Moger

