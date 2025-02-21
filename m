Return-Path: <linux-kernel+bounces-526571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAF0A40071
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA64C3AA5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6DF25333E;
	Fri, 21 Feb 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VmfaX9iI"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AF1FBCB9;
	Fri, 21 Feb 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168629; cv=fail; b=R7XgiLAIBnqulDohFW67kWyjn6GdSMzBjRVxUeLFPaoT4iztWWS1HEGR7Ff5XzV+prgWVXkeilm5/jK1XGNYsOAwa9WdFX5tHn9X+giUq/HOSP7AbE5aHMefDYO/PKpt+tbcy7FBp3vDmnELJOlNQiZSJwdwtu3CIXQMuS8u9w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168629; c=relaxed/simple;
	bh=xTMVFTE7N7hkhhKK4Xn04B2ktP9MHAChqFfVM9g/5ZM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=or0Y8El/uR7HPINwVk83+Hqu656QQm2Fcu8J5jKPpc0CV3GIBY65bHxccJpcVf5sFRByQhN4i4cQsc2DrD0hEjfi7ExJGKqbnlkc/iPTSR313J4+jdoQ3D7v7CYQmEbvZWU2gaPosYcYnKeEUkGUokDfM3LHGH+LKlIuaxws4VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VmfaX9iI; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym8/ywGhgx1H6xEzecdqETywCV5d+1y48/KW2BBiA4hMvhAm3u/6iUXjY/b3PCktCtNzHTokPf9JXHuaDVzkUInGCAAQr4Qz9UJoEgEmMovl+O0gRHS6RCs45pHxI8+Yu5bxqEi3sWUUAWQm/ClzhM8nOk1g53ajjkDf5kbvPOliCY3SQObVzgY1B/fGQ19JXHJwvxkTKp/tW86CrJtLbp/WgYZW+LXw7XbyJDfwB75zp7zgjUzwxf87VKYz19j72ESQDmkhJs26G335Lww+yi7yvHI409fFoIbUQxXrqV7Zz8/NX+jIkCkBgtAMinCuRaeBgu0KGkEftehWKc8clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IWjpzewkAR4GnU/elzHEVknQoycO703YM+2fRZgiJI=;
 b=GS5FWz5ICnig6Hkm9mjMeIA5rvECTU2gGcHB4qEb5xvfWr1kqGestYlElQ5mKX2aBtdoW28He+Rod7YAQsKugejCcH/oeVJ1S4byDScy9TIGqZn5kfhS2fxqS1XK/BELF/OgQs/ExICJMAEuPA0eHMhY4aZgAwX1yiM9Jy+TPgOHh7x+RsS1DmhWINpmZSEXq0ju1njPwQv0P7hvp1ZbmV+sEp3PhtWCQkxWk2UGTL0yzTSL64nzBiD9FB6WLQeA9htcc3RcswKj1b/4fHvlCuRAhhj8lGvfWyI1dMVN17fbj9DkNaRemLpVc4ZryDflkaWSnU2tEWSTo/tEyiE8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IWjpzewkAR4GnU/elzHEVknQoycO703YM+2fRZgiJI=;
 b=VmfaX9iIC+3yOWwoLoiU8a6DXIVOV7SNtcWN1MfgJxK3lIz6KiViRP89r3ZRGOOymQDxnsgQEHehQflkVsMiqrHMgj84Zs9jCnBomI2N5issdDr2yP3PZw7FWM0GnS/UOVKx5Q3jhV8/zZi5uFmZKoBTUVvQZ3Fzzyjq6bXFzSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 20:10:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 20:10:21 +0000
Message-ID: <d597f2c1-bcf3-4d00-8d48-1ebe95015245@amd.com>
Date: Fri, 21 Feb 2025 14:10:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/23] x86/resctrl: Introduce mbm_cntr_cfg to track
 assignable counters at domain
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, peternewman@google.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, jpoimboe@kernel.org, perry.yuan@amd.com,
 sandipan.das@amd.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 seanjc@google.com, xin3.li@intel.com, andrew.cooper3@citrix.com,
 ebiggers@google.com, mario.limonciello@amd.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <30652061d4a21eb5952a1323b76ca70927412a30.1737577229.git.babu.moger@amd.com>
 <aef8e061-8754-4bf9-86eb-18c0bacc6476@arm.com>
 <dd52a51a-e0b1-4c5d-89d2-8732d4e9e2ff@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <dd52a51a-e0b1-4c5d-89d2-8732d4e9e2ff@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:806:27::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be94b89-91f6-4dd0-a571-08dd52b3c472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmJGa0FxU0xKd3F1QUpKNmY0TFZKbjNBRmFNY3ZTVlFodzVicTQ4RWZENVg3?=
 =?utf-8?B?eURlTHZDSmYrZ2ZUVmxhN21UUERJVXBHSGlWUC9OOFlBdzVZVmxuWmFjQVlW?=
 =?utf-8?B?d09INGFnV25xUnN1R3E0ZytlUjVkWTdiS01oM0hXSHZkd2dyalBzSkZSb3Q0?=
 =?utf-8?B?cGpCU1UxN2hsQ1pDSWpWQTU2K3V6RkIzWStxZERwcm9ma3dvTW1Bemg0bFlB?=
 =?utf-8?B?bDBmVno4WWcycm5lTlVuQmxzbjdZWDhLU1dIVGVoZ0dLVW45Qm9WOG9VUmFu?=
 =?utf-8?B?dXNlejRXRndRVExQNVhMSEZIZU8yTnhiUStuYjRxOHEzeUYxMldWYUw4UGwz?=
 =?utf-8?B?QjhFRE5qQnB1bGMxM3N2UzRJc2lSQnpmSm1WeHFYbEhxRW0rQTkyNDRzQjRa?=
 =?utf-8?B?Y29yQW83cGhBcEgzdG9KUjJ1L0pxRm9UWjB5S2RBeS85dFdub0dDYUptQnpn?=
 =?utf-8?B?TW9GMUNtZXh1cXhueE5ZcW8vbGtqZWlIS1dOeWszaUhHQ1RaakNWQStBYmRr?=
 =?utf-8?B?dlcySnlPMWwrQVV0cFlQcWVSZW9zMVIzTFk5L1pvbWUrOU54VEZOR0pRNE9I?=
 =?utf-8?B?REZFaGszVkozWkJHbzNzMTdHV2EwcTFaYTk4TFpuMFBXdVZocUtVbEprK0NU?=
 =?utf-8?B?c2UreVlQYkFkK1BlVG90L29jb3ZPT0U1aDlIUlhiWitmdlFpd3JZWVEvWkdP?=
 =?utf-8?B?YUd1eDB5elFsTjlqTGx1SGQvZkswdDZzRHo1OG9YNHFIWkkzRmZHcVZRTVYx?=
 =?utf-8?B?Zi9WZkg1cmkycmNOQXV6RTdUOW5uV0JUNmRNYXIvV0RIdStRVVA5MmJOc3Ew?=
 =?utf-8?B?bjdUdTNUL0ZaaDdXekFyUHN4MHBRUW1sZTNFbzdTZUJPT0N6QnVsSHhFMk4x?=
 =?utf-8?B?eFNyaVk4Ri81SnAvN2c5TDl6ZUhJQ0E3MEwxUXVOb2pKZGExQWZVNHhmSCtL?=
 =?utf-8?B?Z2ozK3BQblRiUEovSGFKR1gxQ241N0I0VUdNeHNiZk96N0VjbS94ZElRSmx3?=
 =?utf-8?B?TXYzTGROejRQdXI4ZGw1dHkvL0s3V0RaRmpsS25uOW5xQlFuaW5zZzBCaGV6?=
 =?utf-8?B?Y1VHdXp0NjVaeHc1ZDk5Z2V0QjJ0VkJnck5yQ2hqR01VWDNRajNzTEtuT1Zw?=
 =?utf-8?B?emNldGJnUTNDQnE2S0JJV0dFbWdScjZjbXFXaTNnSXdSOGRZUmdFRGQyY09D?=
 =?utf-8?B?RXlhYkRqNExmRTNLbTA0MkdIQzBTdWhnUVhZNitkcVBZbkNaRWZOYlNXV3NE?=
 =?utf-8?B?bmNKRjJtaDJjWVYraHBmcklnL1ZyeXRBMm9vQk4vZ0h3RlYvNGpZRUpVM3dH?=
 =?utf-8?B?K3BTcjJzMlBaMUZCZUF3NFZsVXowS3J3UlYvR1ZmV2paU2RObmdZTlNBdjlH?=
 =?utf-8?B?UXAyWHRGcHExVEIwT3ZkREhMbG1MUGVJYUpWd2xBSEZIZjJmT2pOZDB4Uy9o?=
 =?utf-8?B?T25qNGM2STQybG13cUpYdWxueXF4L3pMeXQ2SmZESVNGV0o2ZkhWOVZFcERv?=
 =?utf-8?B?V1ZmQ0RpMWduOWkrK1FDV1JhQTJTdUFoTVBENjE3cVhSeFlSczU4UFZLTzVh?=
 =?utf-8?B?YUY3b1Z3TkVOREV4Nk1aRUlVNkVzWisrZHk1dVNmQWE4ZmZmUFYyQkhFQjA1?=
 =?utf-8?B?WUh5Y0xpeFB1aGJvOUhJbTZMNWU1SWtnek9TTVoxYXYyVWFldHlydU9tSUt4?=
 =?utf-8?B?dndSTnEvNDBSNTVpdE5SQnBCR0Z2RUxJNExobUpVTFkvNGY3VnNLVWtWd3p4?=
 =?utf-8?B?NW9KZ0NQUXo5MEhJMUNYTWpCbnpnbGo0OHdyQWF5UE12bVVBK29iVm9BSzBq?=
 =?utf-8?B?VmEvbnh1RTZ2cTcwb1lDSnRGQzhmaUZrWHJOaVJTaFF1aHRQMDh4TWJEcVA4?=
 =?utf-8?B?eVRXZG5GOVJoQUtrcFpDQTRneU1BRGdvM0hTZURWV042WHZubENLTkh0K3VK?=
 =?utf-8?Q?XZwabXS6SOM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG5yQzI2YXNhSjlLN3F1Z093YlhkTUVkbnoyQ2ZwSk1DZmN0ajVWL3VDbDJH?=
 =?utf-8?B?cHowaS9HZHhkZUJIeTRpRFowVlU4UFVpQUtxWlUyNGp0dy9RNWtuS0Rra1h5?=
 =?utf-8?B?VnRBcHdsamt3cm9oQitRLzN0Rmh5UUNlZzNUbytOSmFqdVpUek5CNEF3TWFu?=
 =?utf-8?B?SHpyY3VPNHZZZU1jWmxBU2RaZURlbUxoeFNUSXFuVWVrUDduNHN2ZGVxdCtz?=
 =?utf-8?B?NG9reVNXMXhsa2tpNHN1R21MejVxaDdXQ1k1empNQW5Cd29CNUtBaWxXYzBn?=
 =?utf-8?B?YTdCUlVEaWhzczlySkxuRWNFdXdoYWtqWnlYcnpqeml0aGdnUXliTWtSK3Rw?=
 =?utf-8?B?RkRYQ25nZ253dlFYSWZ0aEdaSmtsSjA0djhzSVIyWTExMmdkTkE4UnY1bW9v?=
 =?utf-8?B?OXdOeEhRbVUwNkdyZnhSd1VZaVV5NFBub0xNQWMyN0J4MDdJdTQyUnVmTXlv?=
 =?utf-8?B?dThQYitMRmdjbVpSNjBBUHFsVjF1Y2VtY2J5RXRxaGVYS2h4L0tHZXlORWhC?=
 =?utf-8?B?SUxvVExaT1p5RjVHaHFDN3VIZGVGNG5qK3BibXZ3YS92K1UvQm5TRS85UEJS?=
 =?utf-8?B?eklJUTVDVzhva1U2bDhlL2xCcGlvU2k0dHlKYVFRY0RiR1VpU3NHL1hpb3N5?=
 =?utf-8?B?NFFGQzM0Wk5NZmQ2OUowbjUrcHFTTFFLbVhIWVpHT2FjUU1hWW5nSmY1Vlds?=
 =?utf-8?B?U2ovTXJEKzQ4TmszUUZOOGlzK1lUelFWbzh3OHhOT05QbE52MkxvTnBhdUh3?=
 =?utf-8?B?SkZLandsQUZtY3BvaTZrVDRGMTVTUk4rUC81UDZjQ2pwb2pTdDhwZ0x1T1VN?=
 =?utf-8?B?aUlYTGUwZ0YzeVBqTmRaYVFpcFhjR1FrbTFwZ0NpMTlYMGpQNkdhc0N5TVVU?=
 =?utf-8?B?ZU03eWNEa0ZBcndURjl5QjBuZ0dtUzRpbEhYam85TmxSTU16NXFNR1BZQTlB?=
 =?utf-8?B?cWxkV1NPWlphblZ6Qm85MDRablhLT2tzWTJlUUkvVE1kZ0tSMDVUUE1qOEhv?=
 =?utf-8?B?a09leUVISVR5U2FnUm1WTHRBNTZCOGV2WXg3Z3BRSjZ1SFFtaG9sV0RwUkhF?=
 =?utf-8?B?SjhWZzlrWlB2ZHhvcjQ5VUFNSUdLeUNUZnJoaUluUDB3SUlFdGhWcStpeUw1?=
 =?utf-8?B?VWx3V2s0SVZSODhOOExUTzJyTyttc1JKTnphWlhuRUZmVlJoZmtrLzdtUHlS?=
 =?utf-8?B?bG15K2NqZVYwbTVWb2JNdGY4Zk16SVRkU3BXc0s4WCtVeTNKV1YrdmIxU1pK?=
 =?utf-8?B?MHR0ZEJXUGFjWGJFOGt1Z0hQR0JDeWorU1Byb1BnaXB1Y0ZoVE50ZGUxUlRG?=
 =?utf-8?B?aHRpaXBwekVCNERMZFM2RS94eldUVDRVakRJOEtiS1VWTllYMWkxb0taUkMy?=
 =?utf-8?B?SlMzQjVFbHRTaWlzTHFsUVlTN25QcE1TSWdPRXcxNVdXQlNxSENCZDNSaFJu?=
 =?utf-8?B?ZTc3Y2dVeVhaV1ZFcmdEL0xVMEx4TlVFVnlxcUdQUndBODJWakdSQ0ZwdzJt?=
 =?utf-8?B?R0xwWk5PYllzaUpCdk1wTDRnZnhzSFh6TURhTEh6amhrM2xUWGw5M3RvdmhT?=
 =?utf-8?B?M3hDYnlIQWRnZGlMN09XZ0VIT0dBekRLcGVEKzBKam5zbDRLa0ZUSDZKNm1p?=
 =?utf-8?B?cFNsMjY3TG1CdG5ENk9pdmZjQVBYZDlsekw4U2FKQjVxM1NPZGtySy9vWit1?=
 =?utf-8?B?WUNENTc1NG45TkNicGFKbWZ6YXBaQWNaLzNSZmZkNEw2T01XVW16ZXA5UWVH?=
 =?utf-8?B?NXozZGtyU2FNcXA4ckcxRGx0YkpmaVRweWx3MkhyWWQ5OG5zMlRFeXpMaEpZ?=
 =?utf-8?B?SzZqdVA3NVFjeWpPaEV2Q1gvUjRMZzBIUFVkOWZBZWxPbkNjMmtCWEo3MmZX?=
 =?utf-8?B?SFZtNjlGMEp4cW03VGNhSnNjbFd6M0grRStDTVBwR3lKNUI2Zk9RRXozQ3M3?=
 =?utf-8?B?Q0RwTnpldW9RUU8zL1JYRkdDOG4wMHExT3AyWk1UZ2ZseHFIckdZdWl0a0ZL?=
 =?utf-8?B?RXdDRmdaRmE1UTBCTGhxbUozOHZLSGpST0Qxd1lnVkt2L3JaOEF2MTd5aENG?=
 =?utf-8?B?b0dNTmFmNm5Nb09Gd29yNlVsd0wvREdQd1ZmVFV0ekh4VzBJUGNxem5WNm52?=
 =?utf-8?Q?ofSJnAe8ejsB08QHIKRP4eE9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be94b89-91f6-4dd0-a571-08dd52b3c472
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 20:10:20.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDPi5pA335V2Ylf9Wz+JZfQsN1BwT7RDxp1BRDLsv+i6Cv2y+jQ9o3ZjP0WGVGb4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781



On 2/21/2025 12:35 PM, Reinette Chatre wrote:
> Hi James,
> 
> On 2/21/25 10:07 AM, James Morse wrote:
>> Hi Babu,
>>
>> On 22/01/2025 20:20, Babu Moger wrote:
>>> In mbm_cntr_assign mode hardware counters are assigned/unassigned to an
>>> MBM event of a monitor group. Hardware counters are assigned/unassigned
>>> at monitoring domain level.
>>>
>>> Manage a monitoring domain's hardware counters using a per monitoring
>>> domain array of struct mbm_cntr_cfg that is indexed by the hardware
>>> counter	ID. A hardware counter's configuration contains the MBM event
>>> ID and points to the monitoring group that it is assigned to, with a
>>> NULL pointer meaning that the hardware counter is available for assignment.
>>>
>>> There is no direct way to determine which hardware counters are	assigned
>>> to a particular monitoring group. Check every entry of every hardware
>>> counter	configuration array in every monitoring domain to query which
>>> MBM events of a monitoring group is tracked by hardware. Such queries
>>> are acceptable because of a very small number of assignable counters.
>>
>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>> index 511cfce8fc21..9a54e307d340 100644
>>> --- a/include/linux/resctrl.h
>>> +++ b/include/linux/resctrl.h
>>> @@ -94,6 +94,18 @@ struct rdt_ctrl_domain {
>>>   	u32				*mbps_val;
>>>   };
>>>   
>>> +/**
>>> + * struct mbm_cntr_cfg - assignable counter configuration
>>> + * @evtid:		 MBM event to which the counter is assigned. Only valid
>>> + *			 if @rdtgroup is not NULL.
>>> + * @rdtgroup:		 resctrl group assigned to the counter. NULL if the
>>> + *			 counter is free.
>>> + */
>>> +struct mbm_cntr_cfg {
>>> +	enum resctrl_event_id	evtid;
>>> +	struct rdtgroup		*rdtgrp;
>>> +};
>>
>> struct rdtgroup here suggests this shouldn't be something the arch code is touching.
>>
>> If its not needed by any arch specific code, (I couldn't find a resctrl_arch helper that
>> takes this) - could it be moved to resctrl's internal.h.
>>
>> (If this does need to be visible to the arch code, one option would be to replace rdtgroup
>> with the closid/rmid, and a valid flag so that memset() continues to reset these entries)
>>
> 
> Thank you for catching this!
> 
> Reinette
> 
> 

Sure. Will move it to arch/x86/kernel/cpu/resctrl/internal.h.

thanks
Babu

