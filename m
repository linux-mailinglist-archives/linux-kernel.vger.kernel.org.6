Return-Path: <linux-kernel+bounces-341860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558598873D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E849028115F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9A18B47B;
	Fri, 27 Sep 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuuKxXHf"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009A15C150;
	Fri, 27 Sep 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447853; cv=fail; b=WS4MG8j3X7iQ8oo4X7nCQUQEiRpg0S8DBfzKY6eEudxMiV60+uI5yqUCUP5w21rbVN3Spz7sPGpSWSnXkZvcSzHB80/WsFaECfFsT97lZnrFuq4PX1DV2eytIbhjCwXukASBJx8hBIpKN2IiuxGx70QqEHUntcmfyof6wEo4K5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447853; c=relaxed/simple;
	bh=MSDsH6yJtv2gXOnEe/ETcOC7LcFEQitP4hE80hL3EP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uAEvFTjlCxzu+6BQqrPOdstLu71mzRE9NpuMWDCWvPRqrwpTOiw/TKVp+gTSr+oCfDYpv2S4ugYJ0vNMNUe2Sok4QQRNGHBFoquK615iPbAZFTWu97e2YgEtQaFW50TzUnG9IHGwPGb0AWNNCjOrByjM5mR06rP0FVLCcAeXJic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuuKxXHf; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4uppW6CnmWR8PcjVTszicGNWO3G5CGIVolFq4uAtlwdGZReoSjLzFw8uw2gUWArJAS1fZUMPhp4fzmLJ9MAb1+dT5oWvSy2yJnV+zXi9WvOqkYIYqbCcWoLLiM4eQR8rN3dkLg/IhrhDo+o8EuBTJqS5SOPDwU0fe8pdu5Zt9wO3tJhSO4kbbfp6zHkywqliG0QG1MO4Qz69Q29ByPdGsWrXvlXmJKR8irWQvKWiNE1xZm5maqpd6qDPkb0wAviSzzU8eEZnQY18AQRxnpw2uESftA9zCPAncqyltD18VRXGAmF5d8HEzEialBrPtm0FAf4lXoTucwsZMbpbCVOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgdZcvq0J6ZuZXQJWSlBlKgf14YxWCJ/OguaL4IWKro=;
 b=F9deTRiCWAW76ntT2m+lmoOY4bTaa7aHZ/EbuMrhnj9S6GxPXbmftnxfN1RZ1lkPxUdcFT785vaRHfprGnFFR6PR/48acR2cq3SbgTthw2e6r/0l382gnGlm2DYEHG0ragp6/JznuDHc3i+yTO1R077cVsTdlc/SGvoC/FFXWZ23Shkyftog1DBr4oSkEi5nO5j/7dMpPu1f0qrhjtc0c7zExkqYfMrIO4JqoOYoYRCCgbnL5LfN967he1yb6BikL4CkkSBvnGziAoL/MkjDm06+YV3sYLhCe1v7kGA5seMmkzStKPUQoQ/nIQvq7hhJl9IkoGkqCuWZImoeLqV6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgdZcvq0J6ZuZXQJWSlBlKgf14YxWCJ/OguaL4IWKro=;
 b=SuuKxXHfNhauQN992KPU4vei28SiIJ/UCV1xQzXh1AnVhBsJIDVD1aBzuFatBBt05uzBYBK+JZxvo/f8JIwBzLAl4p+qQnCBjgyozTQyLScZNbRYk9W0wbxh/zfZ5cyoIlR6sqfZlvFeUpgZG/O8X5RB/SbTuDRmd/WdYj3298k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 14:37:26 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 14:37:25 +0000
Message-ID: <f1362aab-82e8-8995-fc27-1fdb8e95f799@amd.com>
Date: Fri, 27 Sep 2024 09:37:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 21/24] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <d5687ef178320866b823445176b10a411e0e5ede.1725488488.git.babu.moger@amd.com>
 <baba42e8-022d-4140-9c4c-256fc6b44765@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <baba42e8-022d-4140-9c4c-256fc6b44765@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0138.namprd11.prod.outlook.com
 (2603:10b6:806:131::23) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: df0aa625-d1fc-4a41-b1eb-08dcdf01e7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aS9lZlowWjVONEpiZDRHS0duVUFoZ0VMUXRxMmdsRC9vbmJ4SlR5ck1vbUNJ?=
 =?utf-8?B?QVdQM2F5eU1ZUWVWbFdEQTE5WGxaa0E1Q2UyenRJeGdyZjEvNUJFc1JvRWpU?=
 =?utf-8?B?Ri9zTENwRjl4dXQrL2dJZTVyeDBuL0tUVjZ6Z2VrZmJkSm5qUkRoNUV5QUx3?=
 =?utf-8?B?NGVoVFJTUlF5MVJGWDFHYlNtd0ZxNTlrVFp5algxTUR6YXdYYjdIVTJSZDcz?=
 =?utf-8?B?bU9xdDQ5eG9hajdIZnZpNXhVdEQ4S0JnbnZJNDllc0wveFhLMUwwZzdLNlZu?=
 =?utf-8?B?SXZWelVBdXRqMms2alNBSDlHMGtaUCtwbzVDYkRBUXpHWGZCdVFYWE4rY1J5?=
 =?utf-8?B?TnNpc0kvRDh1d0hHZ21vci9CWVkrUkxTMnlERnFPYXZWWG14M0t5eWVVY1l4?=
 =?utf-8?B?SGwrNFlzTXZ1UUVVTGl0MXFpZ1MwR213b2I1bC9ZL3RTSXg1MDdKWWprWUhk?=
 =?utf-8?B?TjVRaE05aVVlQUZYZ2tEenJZZ0tJQVVQaFZVM041WDZUQnFLWWdDTlJoYmQ2?=
 =?utf-8?B?MFVtQm1zeHFvTHJ5YnZjTVhZWkZ2TDMxZExJV0NQeWdFVnpNNFhNc1RweFhP?=
 =?utf-8?B?bHFaUDBzZHlxOWhab29WTFYxdlBqUmdQWU5NN0RPRG0vUEJYdWt1aHAwc0lR?=
 =?utf-8?B?Yk9laCtkNTQ4b1VBTjBUVW5hWk1yZWxBWnlKbzZpeEkrOUwvVkJwdlJob3NS?=
 =?utf-8?B?eHRBUFFWbSt6cGZNUGdsckowRXRZeE44NmIzcnZGaGExQmRobnZWTUprTERu?=
 =?utf-8?B?ZjBqdURBQWpwcklmcERnMGFEU01YQUZOVExucFpJakg5WkFTRmZGWGJYdWZG?=
 =?utf-8?B?S1pOMFJTbzJhN3I4dHh2Z24vbVhYYkJNUjZvM3d6VzZLbnd6cHdMUnI5RVFZ?=
 =?utf-8?B?c1BsVVdMMVdJT2JYcEc1dnd6WVFNbkNObjN0OWRqWThkUFl5UCt1RzlBOGUx?=
 =?utf-8?B?dW1aa0RnN1lDMjh3b2ZRRWpCeDdKS0lmUnF2RGI1a0lxdHVURlNMNzVLS1Yx?=
 =?utf-8?B?ay9zdUFuWkU4bE52SUN5eERHcVE0dzlBUHhJK3ZVVGc3MGI0VkVYblR1UEtn?=
 =?utf-8?B?bXE4eHZ1aFNTUklnUUpUcVhxZVVKMUIvUnMxZ3MvZzhPK3MwNXR6ZmF4WDNo?=
 =?utf-8?B?QkozTnl2ZHZKUWV2bXlwa0t2ajBNdGpFSGlFWjhCN3ZzUGsrOFJxQkNmK0RR?=
 =?utf-8?B?SzdKNUVXcnFaTzJCem1oWXVBalJJOTdBUTFLbXJZM2IwRE9vbytldFNtVnhK?=
 =?utf-8?B?blRNaGZhbU13SHZTcHpXQkI5L2VCN2NLR0VyZUZLUTk1Y2gvR1A2SjV6SWlr?=
 =?utf-8?B?MVVQK2RzNkZYZVRLVFRiNUlBdE9YL09pd3lzQlhBS1ppN1l6aWllZ05LcWxt?=
 =?utf-8?B?M1orbFpJSUI2bVROVVV5TlhCWjJpUFN5NGFuSkQyc3hraEg1TnM1QzVnNk4x?=
 =?utf-8?B?ODQxYlM3bnYyOUdHRjZmSlVoaHRMWWJCZk9tOUF1L1RNSkpnTFl5VkZWb3Zv?=
 =?utf-8?B?UzhKaEYrWVpMbzFwK205cTQvTzh5a3ZWRmJSWlRTRDdPcTJJeUx4ZFNuVW1I?=
 =?utf-8?B?VWRVbHZZanV0Z2QrU3VBK3hpZmpGTU9tS1RZZzY0UW5QUFZzb2UvOE5iUEhv?=
 =?utf-8?B?ZURtaUYyaDNSeWhqVktpanRPbDNycVcvN29PM0NNRWErS0pLZENEZDlMcy9Q?=
 =?utf-8?B?eEhINUpPdFpKc3p5ajVxclBveGd0UnB1TXVOVXNtNTJuZENnRUd4R21TWGE4?=
 =?utf-8?B?S1BsdDFxTWpJcVBPN1AvS3B6VDhFZEgxSUQrNlRlODc4V3g0aDNhSXlTYWxw?=
 =?utf-8?B?bzVRUjlDZjhLdVh3cUtJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjMxbHd1WEM4RFlPUzF5cnlxckpZMEJCYU5PVTRkckdZNzhRdC9vYllVdGZN?=
 =?utf-8?B?Mk9iQWh5U2JNaWZZQVVRcnRFQnU2c3ZuUVFhb1pzOUFQZzBQaGJvSjkyUXJ6?=
 =?utf-8?B?cGtpcHdnajRzV0tSUjBUUHBsM1dJQ2VYaUpoVkp6OWVMbWtlMXo0TlRDazJC?=
 =?utf-8?B?OElEbW81NzhKWmRvaGlFcGVVdUd3b2RJTmQrUXppOEhSZkRhT0FrVHdIcExU?=
 =?utf-8?B?cVNLdTNYZ0N5RkwzanZuanJPTTVqMWRmSTkrZ2JqRE0wbDBDd2xPdjhmRHAy?=
 =?utf-8?B?bVVQbXhpSkJQZjh1dG9ubmhIL1BPc2hyazEvMEpYSWV2bm4xZ2c5RGtSRzZl?=
 =?utf-8?B?enhEUG1KYmJ2ZUQ1WjFLOFRBUm5mSkE2YzVNMGZ3Q0hSSTk2REcwcWtBaDhp?=
 =?utf-8?B?SWwrT1VkL2d0ZWNWL01PejVYYWdjWmtJcmdhZ0lJdzNUQ3E2WEc2eC8xQm5u?=
 =?utf-8?B?Q0FhbktlTHlaRlhmRGw0Q2xwUkFiRWhIYlhZQUl4RTg5aHgvaW8zWDJJUTFN?=
 =?utf-8?B?c3BhOStnSGVBVnh1K0NUOW1tSjdIWjRMQnZIQkg4Vk5TT3FpdGFJY0FtTzl4?=
 =?utf-8?B?dFZJWW91MXdyL0c4cHJlS3VybjBCRGVETW5Cc1Y0TmhrNzJHZ3BTSGIydmFR?=
 =?utf-8?B?Ry84aG8wTCtXMDQ0RHptNExxLzBWMXBjRElHQ2xNNnBtWkxkVWZTdHdnTmZp?=
 =?utf-8?B?VVdjVnhkUzlBMDhreVRCWFk1SUNvT1lsMGJ0aHZxZEgxZG1MaW85QkcrS1FZ?=
 =?utf-8?B?WG1HOFAvN3dlUWttdS9yQTJQcEJvSStXWEVaeFdmeXo3V1F3UE5WRG1kYXFC?=
 =?utf-8?B?S1ZUNVBxekpFTWVvYjFSVTFpUVZqelZtUDFKN1ZVdVV3R0htMVBXaGVUQnh6?=
 =?utf-8?B?T2tlZWhMRlFQWmZXTnpOSVNPWm11eVZJMlhZNUZmejM0WEtRNVJTNHEwbFdU?=
 =?utf-8?B?T1FUUnMzdFo3TkZGQ0tKUzZ6YjVIaW9iSFM5TzJNZVE4RmZvbHJpYkVXbmxO?=
 =?utf-8?B?Rm1IOC84WUo0U0NHQ2ZGM280RGxtbnZSZDZBYTM0cGw0d0pCSlFxVk42YTlV?=
 =?utf-8?B?VGVkekkyMjlaeHBzc3JoWHdMNVMwWkcwcm9VWlRleVBXOGZHVkFQWHRiTDJU?=
 =?utf-8?B?RVpUUjJFbUZscTJGZWZYamhLUVRDR3NUSHgwVm9pZWpBNlBkMm1YWUZFSDdj?=
 =?utf-8?B?bnh6M0tzMkVPUGVRcjdMY2o5aFlySndpVXhpNTRJYmFBbkVGM0oyWGtwS21O?=
 =?utf-8?B?YXByZ2dFZUdDVnZjZFJXbkFyVEN2Q1NjWVZTWDJXRER3SndNcng1Y3Z6aUgz?=
 =?utf-8?B?RDcySHdxVWlGZkU0cGU0WDdHL3hlWWZQcTVPZjFhUEYzSUNPai9JVEZCWkVI?=
 =?utf-8?B?TE9WRXp0VWVhSURZM2t2eHRwUmhZdW5MOE9tb3cwVjV3a1UzcGt3NmJRM2d5?=
 =?utf-8?B?Tk5rVGVldm1KNHdPUWswVnF1bVZIUXRoZUQvajB0eTFtWFJMeENZTFRPdC9l?=
 =?utf-8?B?dldkNGpBczExL0dNRDZTYTJoazdPSUlja09qcjRrOHRZM0gwaC9nZWN4UExl?=
 =?utf-8?B?ZjZDRnB1ZEdHMUFnSkZjWVNaYjMrcVBmWEpnQ09ISFFaUkIvdzlLV3J0cXQy?=
 =?utf-8?B?b0dLekNOcVY0ZHV1SE5reFVCdG41R2VBRXBWYzAzbnRydnQyWlhMSlE4aXQ4?=
 =?utf-8?B?Z0pOamVBd0FtSUJ0WlBxRWtQMWV2MWNJcUIyS24vZDNnNnYvZDA5bXlndW4r?=
 =?utf-8?B?eld5cVBsZ3grUkJsWVY2dHl1MkZGRUxOYXVLMjBNQ3pBaFBEa0lxZFhwK1BU?=
 =?utf-8?B?cDFHZHRJcWMrTkNsY2wvcGlpam5hWXdLRUxZeUFCc1VERUUvZFpkd0lyS1Ex?=
 =?utf-8?B?OU5NOHdOSnV3VEpSTlFlWlYwV0FOYmZycXBTYVB1WUU3c3A0VTcyK0owSlZO?=
 =?utf-8?B?RGhhUlRySFJKZmRWZWgzSVdybGZGdUEwNjR2eWNwejZtN3Y5SGZZODdyYXQw?=
 =?utf-8?B?UlNCLytSakNrYndBYU8rLzlGdWxtS1Q0R0dpTWRDc2phMUczajc4SWtxSXNp?=
 =?utf-8?B?QXl6d01xVERsZFFlM1IvQzY5NnpVTVNZNHdiYXU2ZTdNRmtXTTBnczBHaVB1?=
 =?utf-8?Q?sesMwg8k2WaC8+dJw58cSMAUI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0aa625-d1fc-4a41-b1eb-08dcdf01e7da
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 14:37:25.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NByBr1Ep2VSNdr/0ACWDD9oB63dhsYz582TP9wM0YXmx3zMok3u2UQXP0wXy3ayM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588

Hi Reinette,

On 9/19/2024 12:43 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Configure mbm_cntr_assign on AMD.
>>
>> 'mbm_cntr_assign' mode in AMD is ABMC (Assignable Bandwidth Monitoring
>> Counters). When the ABMC is updated, it must be updated on all logical
>> processors in the resctrl domain.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Introduced resctrl_arch_mbm_cntr_assign_configure() to configure.
>>      Moved the default settings to rdt_get_mon_l3_config(). It should be
>>      done before the hotplug handler is called. It cannot be done at
>>      rdtgroup_init().
>>
>> v6: Keeping the default enablement in arch init code for now.
>>       This may need some discussion.
>>       Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.
>>
>> v5: New patch to enable ABMC by default.
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>>   3 files changed, 13 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 9a65a13ccbe9..3250561f0187 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -709,6 +709,7 @@ int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>   			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>   int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>   			   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>> +void resctrl_arch_mbm_cntr_assign_configure(struct rdt_resource *r);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 09b1d8bb0aa0..314c0b297470 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1261,6 +1261,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>   			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>   			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>>   			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
>> +			hw_res->mbm_cntr_assign_enabled = true;
> 
> This is a major change to require architecture to set whether this is the default mode.
> That seems fine but needs to be highlighted in the changelog and descriptions of this work.

Sure. Will add the text about this.

> 
>>   		}
>>   	}
>>   
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7a8ece12d7da..1054583bef9d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2726,6 +2726,13 @@ int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
>>   	return 0;
>>   }
>>   
>> +void resctrl_arch_mbm_cntr_assign_configure(struct rdt_resource *r)
> 
> How about resctrl_arch_mbm_cntr_assign_set_one() to match existing
> resctrl_arch_mbm_cntr_assign_set()?

Sure.

> 
>> +{
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +
>> +	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
>> +}
>> +
>>   /*
>>    * We don't allow rdtgroup directories to be created anywhere
>>    * except the root directory. Thus when looking for the rdtgroup
>> @@ -4510,9 +4517,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>>   
>>   void resctrl_online_cpu(unsigned int cpu)
>>   {
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>>   	mutex_lock(&rdtgroup_mutex);
>>   	/* The CPU is set in default rdtgroup after online. */
>>   	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>> +	if (r->mon.mbm_cntr_assignable)
> 
> Needs a r->mon_capable check?

Sure. Will add it.

> 
>> +		resctrl_arch_mbm_cntr_assign_configure(r);
>>   	mutex_unlock(&rdtgroup_mutex);
>>   }
>>   
> 
> Reinette
> 

Thanks
- Babu Moger

