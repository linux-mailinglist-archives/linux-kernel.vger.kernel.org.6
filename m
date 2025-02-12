Return-Path: <linux-kernel+bounces-511355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E32A329E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFE61888BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A0621149C;
	Wed, 12 Feb 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yi5oRAwk"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A611D5176
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373899; cv=fail; b=bvNGLCbBW1TzB2chDn1orEv69nuYa+8TdAwUyM5laiiBVtQxbUgNXxaSgu3WXhBQSTzgYNWo2LkHt/mm/v4FKXpVJMPMiq6eKbFHsQFL9tmKhZZMep8Uc1v9xtrA9ACmsG2c5UbtUWsvLJHNcY0YAd/mKRlV+Nwk6l0cdGrJpoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373899; c=relaxed/simple;
	bh=hNU04ScSC/GszSFphi3AqZ/A6am7SX/0zQcKptP3uOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h59t91eGiV3Kn4Ai9Y9Sw1iB7AlH5Pja1y399uDEyklQG8tBfwLijF02lO3FMLCqEY+JBsgBMayTdyjDadtFuh+UWQ7ncXtY6wYiGOb1YRH2hR8iF6tayPnxUXBRurp/6irLvMXJA6mQPULWCtD3DPvgEX2qIxDDK8KY9ExWsfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yi5oRAwk; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWdXgt+Rc4nEKSOndWBeJNm3Hfx/WqszoWDLZgPRnE6d4r5/PYbRgQVQwA2QiWARxF5+8I7Hg3//0pQd+9JjENDUV+aOaOiMMDwQr3/ZorrYOK3GMKlsTiWU6Cm+dXAH8sP1iGjmx5wKHNdDFJOK8z71caMMj7tNiqoivddIS2NlTh0Zn6u0FNH9jR8srw5RmaQ7powojHnHgfW+z88KUeJvDiLK9t6KzUvH81s6hDd9IXPuhKJgqfsZEm3746I61UwtyuIMphM0RYCbistb+MKRLSJNjse3vyF5qX3L3zb2P9iTaHECa7Wwyb3JyYQFDMg5FesMBiheBrTUWgtaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmIHMQh9J5vA0YOkBcEJOOzsVRqp6NW6ZFkm6cLw+9s=;
 b=yPgF5B329t6AjgBmt8lSs7u5b42t5lrFv/N6OAd1n6jwhfA91OFw5Loa0PKjRPLxYTUrNimKmFTnGsJLlNDGr2lA37ZdeP47h997qavlAWh3Lx17kRSXpE+d/6MYmfZ9C/3AJWthUWfEjEeHDsBQ6PxT/1uk7iQ/niWMhcPYWAW/5it62rFq7rcipr/4XuGotjbZMLwjBu1UYzXj9xoV0qwvCISgjKPT98myC90bw0xu3Wo4zn5vx2PsZdcDhlH/vAzqZC/lFKU4iNbeOrlU1qWOfOopL50ZLexprXyBUlz1tb9knPvq/LqdRp/QScVyWNoi2+lJvOGiQSQk8cKjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmIHMQh9J5vA0YOkBcEJOOzsVRqp6NW6ZFkm6cLw+9s=;
 b=Yi5oRAwkbmC9cXrr/fkgykbuUI3nwOLT6DOJBn4jOjHx8tAZGpj5qPIHX6xQi7WyD+lQ5j/r7hmGpvAoC6RCqZTjT36Ck+DF6MxtdhEBCHl3Sg29zfSMNrlL7VDyjByv/+h5+o9XFCsznPoB3wAMFxOWn+6Mqo72r8H7tT6D6WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 15:24:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 15:24:55 +0000
Message-ID: <7d8e5269-f270-4aee-befa-3131d36ce4ef@amd.com>
Date: Wed, 12 Feb 2025 09:24:52 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 00/42] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com,
 amitsinght@marvell.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <f600712d-d089-4285-8d04-e12f53a61572@intel.com>
 <CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCjY-3f2tWvBjuaQPfoPhxveWxxCxHqQMn4BEaeBXBa0bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:806:121::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa7f73b-4ac9-441e-2f30-08dd4b796783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0d2eWU1b1pHVWFzbU9DeXB6UGZGWDhWdEE2TW1UNGpsOWdoYURrdFhpRFMz?=
 =?utf-8?B?Y3h6RldKbEV6MCtOTDlOSVhvc2p1VWE2cWV4b0w1YkhBWDNodFlPWjBka1h2?=
 =?utf-8?B?MzlWdzh0b3I3ODluaVRHSlFyN3FYc282UWRlZFhpZ0pwU0lCb2xtODFqWnBy?=
 =?utf-8?B?RS9VZWxjS3JMeWYxYmVSTm1LdTRrZ2o5SVJNRDhBVTd6Qk1YWXNraVIwVEdh?=
 =?utf-8?B?U1BnbTN2SmN5N21nWk1EMnBiU0FKWkNoSDR4WWlsNXlrb0ErTkJZZHlGVDBX?=
 =?utf-8?B?YUFRUWoxWGFzRHY4elVWNnhLcTRZdzFKU0JrNHZpS3RTbEFPNUVMMVUyRmg2?=
 =?utf-8?B?d3Erb0J6SmM4RXFFK3NuRFU2UmUzZXJCaHBUUktjcm5NS2IxcTVIOW1BZEla?=
 =?utf-8?B?UTV0QndEOFpGMjNJNzNRblZQaGhnYlFYK0xGamppZ0l2cjltNmpXeXVuT3Ax?=
 =?utf-8?B?MmJFMjk4SG9hWklISW92NU5mUUNQZUtqaDNWVmMrUk1LMGt1WjB5eUJIajZN?=
 =?utf-8?B?SkxodGlGK2RyZHBDS1BhcGx1cUp1THhXTlFHb3ZIbll3QW9tRnFIZnZSaG5r?=
 =?utf-8?B?RHAyV010NzNnRWtuKzhWQk9Pbjh4NHpuc1p6dDI4c21yS05wQmRuTG1xQVFN?=
 =?utf-8?B?dmozaWc2SDdWSFFDOWg2YzJKWWVtZWlCOXQ0dkx1c3pRbWQ5aDlidXRib3Ew?=
 =?utf-8?B?bi9MbDZaRmxEZHlqNGxUditPSDZwOUdKaHMyQXBpc1B6bU9HbGY2M1dpbXUy?=
 =?utf-8?B?WElLRklySXdKWURoWmJVT1JwNkdiVm9NV0Vmem9xdVV0WnMyazgrVHh3MzBk?=
 =?utf-8?B?Sk5GY3dPNkNJaDdGYmZwaml0QTJJZFpGbzUzVnh4YmYwMGxsT2dJTEpRSmpM?=
 =?utf-8?B?aHJ4Y3NaK1lRVi95VnRBL2M1ZmZTVmRiNHpmVVhqanNRUTdSWEZtelZDMWN0?=
 =?utf-8?B?bmVOaDFtN2QyZVluNXBWK0xIcHdrUFdEWTVQRDZ0a0FoUEhTZzNuWTBUbFNN?=
 =?utf-8?B?eDdMc0ZjdDJlK2RkalVMSXo1SkZqVkNTK3JDLys5WjJWMVhtcmgxTXJKd09V?=
 =?utf-8?B?cG9mdUdnR3pxUGJocVZwNFp4eElMaWJGRUpDVVIrUVJxUmdUVU80dUc5V0JU?=
 =?utf-8?B?UFV2VERnRU5uWi9YTURDQ243SU00djFqR1Z6WVI2dEx0TDNFUWx1Z3FxSUdk?=
 =?utf-8?B?SVRld0RkSDJqK2RBTzlLNm4waE9ZSWl1SHNZbWVFWk9wS1ZrYmtQTTNKRmNy?=
 =?utf-8?B?M256UzVqMHJua0djTDFHeU1hUGdWaWV0TlVxdTZtTnFDaW1qbllWZWlIclI0?=
 =?utf-8?B?T2psRE0yWTd1T1NpU3ZlVzNHbldkeXNRTCtUeGNPQXgrYThja2s5d2lpUnhQ?=
 =?utf-8?B?SVhxci8xcXlXYytpRXFEem5hRHgvY3JEN3VySDREZDJJTldvU2lMRjZQZy8z?=
 =?utf-8?B?RnN4RFBTWTJJTzZuTE5EYVlMbGwvV1BuMElyMUlsNlkwQzc1cXBCWUQxak9J?=
 =?utf-8?B?akZ3c0V4emQ5aDhzRmI0Ri92NFVGdXhlSDJSVU1zZGY1SWQ0dTEzcTZNeFlt?=
 =?utf-8?B?MWJyUzBkeGpVbHE3OFMxVXFuUnV4TSt5Y1NjdlRobE5ZakU1Y2xFN3AxbG5M?=
 =?utf-8?B?SW1oR1ZtQ1huSTdINXBnN3FGM3hIWE1Md1AySDg1U0ZkOXA5Y0RycmRXQVhx?=
 =?utf-8?B?VnAxOVhHcGhQZy9pdXVkc1l2NkU2cnIxQUZ6MWtOajhFYmlJKzZTVHk0ZjE1?=
 =?utf-8?B?QzhSQ0tseTRuTldWa3ZzMzVKU2pIaU4xWEFZbVpDYmRnZTUyTzN4c2FwdFhy?=
 =?utf-8?B?L28zRmc4ZnowUmF2aEFJbjk1U2NQdXVoVXgxdWRNU21nckJNbUVDMUxSZjFZ?=
 =?utf-8?B?VXJacVpEeElBN0F3OXV5dXl3U2NtZnZleStVQmpmaWZVV2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1g1V29NM2tlTThXSSt5S0YrVjFqaXZRWGx3R3lwTFRrY0dBdUtKZTREWUkx?=
 =?utf-8?B?QTR4MGR1c3lJSlkyVElmd3hkSEk4RmdEMzZGMWxBVEw2RVU4RHFiU2xDTFQv?=
 =?utf-8?B?OTJGU25RbkRvVlpDNFFWd215VG5lcmNMSEp2a0lGUUo2NnRBelpMbFA4U1hP?=
 =?utf-8?B?SkpBK1NrZUZ6T1ZtUkpRTGw0eWlHKzhTSGU2NUJxdjQwL05VM2VycHBOeURt?=
 =?utf-8?B?ajZSbEFHNjZmVVUyMlpnU0IrTGhKUUU0Wkc3VGIweTVNV2ZHTzBzZU5BU3E3?=
 =?utf-8?B?aDJUcWNJRHBlbE1Ya0xCL2dJY3VNRWVLbFg5NytrYjN6TlNtcFliSDNRU2hE?=
 =?utf-8?B?R3Bid0hlZVByVnhBQlR6Rm00L0wzZ3ZtY085b2lOL1NqU2ZobDBURjdvTVV4?=
 =?utf-8?B?WWR3KzBlNy8yUmtjc1c1a1YxeWUvMFVIcWk5bU1uOGVTNGIxSlZ2b0p5ZVFF?=
 =?utf-8?B?Q2NhWjlQRDZzSUpoNklGUzd2OGd5Yk92ZTQ3ZnRWVDY1aE9nVjZVelVSTTBV?=
 =?utf-8?B?bmRqYkQyQXZyODNmbWdSZEFsLzF3Z2wyQS9qSGVOZFFuZjlmY3lkRnJaWk8x?=
 =?utf-8?B?eUR5ZVhFellCTE55Q3NtOTFJNXdjeGRPM29aeFBOWnV6dXh0YWFoZ1pUMEdO?=
 =?utf-8?B?anlXdHVyOElqTmEzclU4MDlxZjRIL3BXa2Zmc2lPMi82aUZFRkpuRFNjMVg3?=
 =?utf-8?B?R0l3aGdaR3BRL3ZKdzcxZUNpZTJRWU1tS1d3VThiYzBXRHMxL2xsOWNyZ2U4?=
 =?utf-8?B?K2Q1c1pTNGhYdkx6M1dCRXc1NzdLaW05SDRnN3Y2QWRBNGxiN1FTWjY2K3hw?=
 =?utf-8?B?K0puSjZueDJvVGtVblBONGVVK0h2TXRIVWQ2RDkvbXVjNUdlUGRla05DZi9h?=
 =?utf-8?B?WUVqZVlac3YybkZmY0pPS0JiZXhMYzJVM2RtOUIxK2VxU2ZKVFNaTllDZGtq?=
 =?utf-8?B?YzJHaEFxWkxPUkhHUDFkZ1Y1YVhMSDRickhFVzhtZDZQdWJlY1diRGVYK1Zl?=
 =?utf-8?B?bGdCK21aSVBRZ05HTDNFNVdxSWpjU1BtZ210YUlkbFY4QzNMVlFwUlJZbHFO?=
 =?utf-8?B?QVNGLzBTVGYxTk1KYzVIN3dPOTRaT04vMFZYc3VxY0FId08zOUdkTnowTS9H?=
 =?utf-8?B?OFY5NEFWenRJY2lLVVZwaDJxbzcvZ2g5UnZFNDRoa2hIZ0JSVXRtTFZlOFJr?=
 =?utf-8?B?K3dOcitOUytMTTZoWllnRzBiblV3bTVPOVhFQWxWTTYxR0ZacU1sQU5FWjgz?=
 =?utf-8?B?U2UyVmxtWkZFNWhNcFJvWGNLUTBLd1FxTm5ENjJoc2VWNytvdHd2MlN6VDhJ?=
 =?utf-8?B?M3pLUmVNcTFxdHlPZjFodTVMWDl4RlFNR2FXNmRqTm42T2g4NGl3eU5LS2F0?=
 =?utf-8?B?QnQwRm1UVnBUL25ZcG02VDlzRUpNdWVSbmJGVmVWTTZDTVc2RFJTQjNhdEpM?=
 =?utf-8?B?YzZmZmVJdFlrOEJ2MzBpME1aWHJ6Z2lYSThrSDNnTys5Zm51QXNXbGRQaXpD?=
 =?utf-8?B?Z05QY25VRWxuempyd1E4a1V6QUxTZVQ1b0lDQnJ5V1RVZHNIdDhhVzU4dm82?=
 =?utf-8?B?MzZFam1zRVRIOWEzeTF0R2JkMFlSR0NVNjQyUFlQV2VzekNuOHM0K09ZZ3J4?=
 =?utf-8?B?UVN3ck5XdmIyRWl3QzFkN0lWUGszdWtzV040WjdZRjltK01DeGQxR2QvNGov?=
 =?utf-8?B?QlJMMnhtYkZnRHdsdzA2NDg2bGxhczZwOGFnVGlGU0lIdVFCNXlsSDdaczUy?=
 =?utf-8?B?VGFwQ3VwbHpUOXIzUUdOQ2E3NXVMQW9vZ2liQUpUSmliUHZxang2dmI1MXZJ?=
 =?utf-8?B?VWhWcWtSaVBtWDV4UU8zNHdFMGlzYk13QzVIeDNwRXFHSXVXeDZ1ZGgrTHNJ?=
 =?utf-8?B?bTAxWEMxSkRtV042TGFIbndUdnJsOFQyYWxNdWFHRkFiNmw2TnhUTEdHdDdN?=
 =?utf-8?B?M0IvaFV1ejR0MFh3ZmhhZGQ0Z0ZuL3pJd3AyL2JxODFmcWdKZmtNNG8wUUNM?=
 =?utf-8?B?ck4rSjlsQU1YL2d3VUhmMWQ1bWhCSUlyYlZMS2doZWNqUXVxblUxZzhNSG4v?=
 =?utf-8?B?QVFCNzFkc3JxQzhzOU9WZkpKc3N4eU5CVU80ejBhbmd2cXA2MnUvNmNKZWQw?=
 =?utf-8?Q?3y/g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa7f73b-4ac9-441e-2f30-08dd4b796783
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 15:24:55.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZwB62+mIy6xOgULaO1x/x6GeJqWjTrrShVqnUIsEa/vv+GvGfswSuSvSsAhPDkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337

Hi Peter/Reinette/James,

On 2/11/25 08:36, Peter Newman wrote:
> Hi Reinette,
> 
> On Mon, Feb 10, 2025 at 6:24 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi James,
>>
>> I'd like to check in on what you said in [1]. It sounded as though you were
>> planning to look at the assignable counter work from an Arm/MPAM
>> perspective but that work has since progressed (now at V11 [2]) without
>> input from Arm/MPAM perspective. As I understand assignable counters may benefit
>> MPAM and looking close to settled but it is difficult to gain confidence
>> in an interface that may (may not?) be used for MPAM without any feedback
>> from Arm/MPAM. I am trying to prevent future issues when/if MPAM needs to use
>> this new interface and find it confusing that there does not seem to be
>> any input from MPAM side. What am I missing?
> 
> I've looked into monitor assignment on MPAM a little, so I'll share my findings.

Thanks.

> 
> Like with ABMC/BMEC, MPAM's counters can be configured to monitor
> reads, writes, or both, so there are situations where it would be
> useful to be able to assign 2 counters to the same group to be able to
> break down the bandwidth between reads and writes. However, a group's
> two assignment slots are called "local" and "total", so if MPAM's
> resources only support one of the two, then only one counter can be
> assigned to a group.

This can be done with current ABMC interface. Only one counter can be
assigned to the group.

> 
> MPAM does not support any filters that would differentiate between
> traffic serviced by local or remote memory, so it's difficult to see
> an MBM event other than "total" ever being used. Multiple MSCs
> measuring memory bandwidth at an interconnect and a local memory
> controller could potentially be used to together to infer the "local"
> and "total" counts, but this would require the implementation to
> understand the platform-specific relationship between different types
> of MSCs and somehow present them as a single rdt_resource to resctrl.
> As best as I can tell, the MPAM driver today will choose "local" or
> "total"[1] for what it will present to the FS layer as an
> rdt_resource.

That is still fine.

> 
> Based on this, I would prefer the arch/fs refactoring changes go in
> first to give us more time to think about how better to abstract
> counter assignment on a non-RDTlike implementation. I believe finally

I don't believe this series is ready for merging yet. It still needs to go
through the review process and a few more revisions. Based on our past
experience, the turnaround time from ARM has not been great, which will
likely delay this series by six to eight months.


> settling on an arch/fs separation for the currently-supported feature
> set would make the counter assignment work clearer for everyone
> involved. Also, my own users have been using an implementation like
> this one successfully for over a year on ARM-based platforms while I'm
> still just experimenting with the usage model of ABMC on AMD hardware,
> so I consider the MPAM work to be more mature and would not like to
> see it delayed on account of ABMC.

We've been working on ABMC for the past year, and it's almost ready for
merging. Now we have to wait? For how long?

On the higher level ABMC and assignment in MPAM looks similar. We added
the assignment interface, assuming it would be easily adapted to  MPAM.
We've incorporated all the requested changes—at least from Peter—but
haven't received much feedback from ARM.

James, could you take some time to review the interface and see if it can
be easily adapted for MPAM?

https://lore.kernel.org/lkml/cover.1737577229.git.babu.moger@amd.com/

I was planning to post the next version this week, but I can wait for
feedback.


> 
> Thanks!
> -Peter
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/arm64/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.14-rc1#n824
> 
>>
>> Reinette
>>
>> [1] https://lore.kernel.org/lkml/9479c799-86fc-4d9e-addb-66011ecae9c7@arm.com/
>> [2] https://lore.kernel.org/lkml/cover.1737577229.git.babu.moger@amd.com/
>>
> 

-- 
Thanks
Babu Moger

