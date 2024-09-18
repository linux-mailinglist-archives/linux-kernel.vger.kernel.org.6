Return-Path: <linux-kernel+bounces-332773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A607997BE94
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128A1B21044
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8D1C57AA;
	Wed, 18 Sep 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bk8B3rtO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B179FD;
	Wed, 18 Sep 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673267; cv=fail; b=Fe9CgX5uBcQrf4OKHfpk/KWT+XfQ2VPTl5mU/eogTO8BqX5A8mp9WZ3t2E1oKCJEno2sSuwdeL+7xqg5M08IEfeQjouU9ud2KgQRy0di6T+PuynlrOWZpHexYBqNv+WDIsvGKP3gsDX1g2aFw9mLGjPZ073NoDQvjt6mx4G6e0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673267; c=relaxed/simple;
	bh=9SI+QAQtTbQdFJu5TdqICSa7JpPivB2C+jSa/DzPWU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q08esKHfgngwIF/IharsIWSdO/0XHNn8asBPVhKhuov6fAqZOUkDT/yQrrXcw3QAxXGQOxXJih9n9IvX1BCwuh6ihBDlXd0lqigsbf99O2KtVKa2FCMD5thMpUJt+JD9bA0N4BarWPXmFRVX9JYnU87eAJKEs2nGwkUx/5L7ZGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bk8B3rtO; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkbgN418x7KNKTFKWcobx23KCjW7LQHhFunsADN+jgMbXYGpmEKvqMKb29mRVwDfjRDW2S4yESrjhjp7/PEvYqHOdCQBRaxTGTfIenNa4Fm5FUEY1UNmwSP1g0DGj9YqRJ28HN1736z0M/L+nCtB+zeKJAawaz09rJGZAMAcrwnw5mRDK/KXz0cdt8AHHQVIm1vASHQ0dxiflWw2wxAr8ur30a0ZtRDWU00H6v9Ld25GKDRDA8hZhasRKOWmCQWqypX/lip0atbOAVfd9qFWcYx7PRsgtewc4YlkvdZCVDYBWY11Ck0L13THDfqF77gPqgsTp2/fezBb7VPvGkW3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPIySEnUXaR0TWOPfU3XQlVV54gN81ukDFBFYYOwCqY=;
 b=btHjGMb5XqlPxTUxqezDXAiQA0WDXI35hQSUsZ6j/0BaoEhMxFfoET8jgQ3praXofX1O56cq1Ud1z7xrNyQ68NsZ5nJti6JT6CHSxHinn1ZKM1NZVf5Rvsr6bZQh+wj6gk4jx5IiAjmaoN+2MwWOJnssatjjZaSUBbK0GgxXOQX/3KKYzZ3kaKluAF0HP5TjwrpUmkZ6db0y0qHbOSu4D+5IVj6zFy7HV8sFDxERdx8m5t0bALN3HB3mX4OISZUoorEgIm86fssMpEgIoydV8hyqZeHFGqvUEwLRJnVEx0iudDQajA+8QGPDiaBB7Ab7FIQpgoUq7VLgR8Iwng25+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPIySEnUXaR0TWOPfU3XQlVV54gN81ukDFBFYYOwCqY=;
 b=Bk8B3rtOY3nt32Zng6R8idc5fFvzMvFEkoferpirHG2olbEKO45cuHwGfxxBC31EIDEyx8Pd77r95G7IzCYoUivqPgRpzYFAgixLcTM9geImDaO9nKQ42WYZdXb4NlTjWoi4++LSm2mGd8rmRMPt+C3eOf76R1cOXfKGqiUc2kY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 15:27:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 15:27:42 +0000
Message-ID: <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
Date: Wed, 18 Sep 2024 10:27:38 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:130::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: f807ba4e-c913-40f3-d989-08dcd7f66fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2VSRDRIcUY5bGswbVFLSW00MGRSTm5adDRIUzNoUCt0YlRmSFp1bkQwWWhG?=
 =?utf-8?B?VFAyMWdpd3EvZVBBV2pkNU5QT0pmUlRKRWY5R21WOXF1bmpMbHFyb0x4a2U3?=
 =?utf-8?B?ODlROGg2NmpxMnB5bzRtVkUrdERmbnVvZWtWRUlOTHc5eFZxQ3BnYkxpZWVs?=
 =?utf-8?B?K1Q3dXVLYzlnN1hyb2ozckJvblExbjNGWHZsdXZmZVVMcEtBcTlVWjBuREM1?=
 =?utf-8?B?bGtIOElMKytHeVpIUEVWZm10S0NlMkpXdFlSakMrL3FQejNXcXR2TGptTHVK?=
 =?utf-8?B?ZWd5U2tFZ3lBalpxWEQ3bGgvaktZcTl1cThqZnhWUnFYaWdHVlJKSzd1bE9C?=
 =?utf-8?B?VFJZK2duVVVWWE9hTHFvdVpnM2hNUllaWVVmdzZ6d2JUY1dJcERlYmx3Vzlx?=
 =?utf-8?B?RE4xaG4xU3dsc3dMTlBrUVErVm9kZzd4Z0ZMNlU2aXFVbmw5dTY2MGNFVjlt?=
 =?utf-8?B?ODhQb3ZVSkN2bG9aeEtOQUIyUitPc1lZUXA2R3JFRWFMWURKdmJ4Q21WYmtu?=
 =?utf-8?B?YWRHT1BldFduUUxIZEI3QlVUN1phTVNHbkpubXVzSVdqYXpDTVpPWGhmclBU?=
 =?utf-8?B?TTZ6NUtJWkNOSHRLQmQvMXRQNXlsTzNyeXM4Z0w3U2piWEtwY011SDc3YXFQ?=
 =?utf-8?B?anYyVWJIU2V5WVNCZWpjcWZ2RjMySi9oaml0TzhDUE1JamYzY1lsR09NamFr?=
 =?utf-8?B?dGlLbHVBSkx3b3l5M0RxVmFIQVpreExRSjBEa0JyRU1oZmh4SWR1VHBKalpI?=
 =?utf-8?B?blBQS1BrR2NEcEVVMlhhSEtPREd1b0l3Z2xrdWFNbUlnSVpSL2pIL3haSXps?=
 =?utf-8?B?TGhVVGdNZG10bTYyVTZUUmlaMHU2L2RBUlNZMmd6SVRrdTRhRVVSMmRvSEVr?=
 =?utf-8?B?enR0R2pOeHVIalY2UGxFV2tBQ2w4TFpkdmNkOUNlL3g3ajFkNXBYeGpJd1dX?=
 =?utf-8?B?UDl6T01jbVpDZDdPc1JMWW84QndkMVRRbVdvR2lLb1FDUWk1bDNMYWt6ZFhn?=
 =?utf-8?B?RldWZ3NucTFOQVBtRldCWVJvMWN5aDRMZ25TWGRSSFZwbmFlRzVFb1ZxOVFE?=
 =?utf-8?B?aXVSbkNPYUhuUkx6MUo2cW1tV1U1WGl0bTRTM0V1ZjU0SjF1L1FLVUwxdnRI?=
 =?utf-8?B?dU5VVitmaXErZE9pVDJkNjl6blpsOU9XK05oMnhneSs2T1o2NkdHVjFlR1Vk?=
 =?utf-8?B?ZXIzYlRqbDlSVU5uU0ZIWEE4RnVlcFRGWFJjTE1TYnBza2Nodkg4dlJGbTVU?=
 =?utf-8?B?L05TTTBCY3NnVjdqaWpmQ3Nwd1pidU9rK3dxdUhjdXJnR0gyaTk2cStKOUhu?=
 =?utf-8?B?a25LcnFQL3BvelBxN2NaLzdPeWx2ZmhhZ1dHRExQR0xVdWFLWkc4L1BFTXVz?=
 =?utf-8?B?L2VZL1RTNXArWklpZUU2MFFpMkdFWE93WEZiTWc1TE9WanlXOFg3N2FlK25W?=
 =?utf-8?B?N1dGMnl0VDBWOTFpeUJoT2RJeWJObURkYXNUU25EL0NTbEFBVUN2RC9JSG1D?=
 =?utf-8?B?OGFMRFV6WDhPc2Z3ZEhqcjlVdkMwRnVpWXVUb1dEcEFoa1ljcGQrakJiNHhi?=
 =?utf-8?B?dndqTCsyUGRReEJwdUtGT1hiMktBcC9BN2YxWTJoYUdQMUdZbGJyeldkSHJ5?=
 =?utf-8?B?eC9WV0lTUGtZZmdRbU9acDdBbUIwK0EydlRPR0NKSGtvblZNTlo0UzNyQ29K?=
 =?utf-8?B?cGdZN25DYXZzREsvUGM5OHFISjF6K2dxTkFCeWtDUjhGZERzWGhIaVFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajA5eGh5NmEreVJKY1Q1MStKT0lIbjZtYWlyVng3THlCNDJxNzZKWEpSZTc4?=
 =?utf-8?B?bDhJc1hRY3JoYXJXOFlLcENBaHltTlFWTHhlSEswb1kyamdnN093ejcxeUlE?=
 =?utf-8?B?enYvdllpbmVUQS9jY2NPMTMwcDJWN25ZRUkxbnpFWlZ6NC9XNVU2KzZKK2tx?=
 =?utf-8?B?NVQzSnROTkszeGJkSVk4TjdTcS9VM01sWlg1UC94WVZtRTNNWm1DTHJlSGVp?=
 =?utf-8?B?d2JPVVdRTHltekJGNjNrWCs1cDN0RzFDQjl5SEVEUXc2VGFOczA2NjdGblVl?=
 =?utf-8?B?Qk81VHlueUorQ3V2a1ZNY0t2WFVFeGxkSFlhejRCNFYvLytmb05QVFo3QWxv?=
 =?utf-8?B?THR1SnlZbWM0NkN4QllXalJlQUFIQW9lbUdlN0kzUTI5cWsxUXR3c1RJejZz?=
 =?utf-8?B?dzRUa043bGdma3Z3Ynh3NFJTQWtMRjRPMTFpQTJuSTFBY05rWWdiT1VwZ25p?=
 =?utf-8?B?dVg1Q2c3TitPQ0tQOHExWFRvNmR5TUpxR0hTaW52S3k2Vk9FNFU2VmJXbVBH?=
 =?utf-8?B?c2VtWmF1c3FKcjhSUkFrbWZEbUd2b1JDZFFlb0dLdVJDSjE5RWF1ckx1QmFY?=
 =?utf-8?B?NWs3emFIVDVFZjdkQkp3VnZCK1k5b0o4WVpvUmZvN3J6WGIrZVBIVldzRmQ3?=
 =?utf-8?B?RnU3YjNOWE8vc2xUWFVHT0xWZ01pSStpZlJuQlBWVVRUOFRPcGlVczJCUER3?=
 =?utf-8?B?azNRblVZeGk4V0dqZWVjOTVJUUFYcVBHUVkrSlBjMGRDaGp3U1NnanBVOVdn?=
 =?utf-8?B?TSsvMVpuZk9PQUpxZUZTSjZrY0Y3WDJJRWZFRFdGTnpUamJYRVhjaUduZVJz?=
 =?utf-8?B?M3pOWTZvckxFQ1RPNEtjTzczc2ZTNk15NHpOV2ZiaHlNbzQ4VlRpSDNzdTFj?=
 =?utf-8?B?emlQbG9selhaamMwZDljVGhCOG51VHo1L0haYnNjNDRKQnN3MWpDNmR5TEg2?=
 =?utf-8?B?YUNHZGdZR3hBdXRUd0p5S3cxSFE3eUhydXNYTFFCTXJLMFBuOUcxYmptcUl2?=
 =?utf-8?B?K1RpMENxZ2xRV0Mva2RUTnFmdmxuYjdzMmZCTTRUM3F4cTVURXVkNGhIdlpH?=
 =?utf-8?B?cDNGUWhXZTY2S28rVEJHVm9tM1FuY01Bc1BPbHFBRXQ5czIzY1QwSEtIVlRw?=
 =?utf-8?B?ZkdrWWdsVURtQjRhOVhSQVZRMDhQclZVV3hEMHloQVJvYkZPb1ZWemhIUnQx?=
 =?utf-8?B?NnBXNjlIUFFldnRCRFk0aEw2cG9HSUpDZlBqV1NaRVpvek9GcHZVWnppV0Fx?=
 =?utf-8?B?b3ViU05uWHJOTmhjS3k4MGE4MXNRT0ROcGVvQzZsMVhUbU5wdDZwbExDUThN?=
 =?utf-8?B?b3B6dFoxZ1RuRFJCKzFoSkJPR3JLMnBENk5XdnczZkppMEdOYlZnQTRMR3Fy?=
 =?utf-8?B?N242VC9IR09JWjllSFA4elVwK0lhZTJBbEtkc210WnQ3Q3B6SjV4ZEh3azhQ?=
 =?utf-8?B?bUp1RFRKb2FhMGsrN3l2VG91SUxZb0w4S0Q1WkI2QmJyV1pwY1lDYlkxZ0JE?=
 =?utf-8?B?VTRVUkRrYUExa2xzN1Mwa1lTaFQycXpxN2VlRVhhVXZ5QTU2ajhSdlQxdnZR?=
 =?utf-8?B?TlpHRWp0Q3YwdndSZ0ZWMVdkTzBXRmVyMERrMDlBckVnMjltTjN3MHFSVjBj?=
 =?utf-8?B?YU5TTExKMlB1cDdDMU5ZYjBvZkN6SXR6VG9LcWpzL1l3QXBHNWJ4ZzZzN1NC?=
 =?utf-8?B?akw5bkFZQzlwaVF3UG96ZXNocFRCNjZWVFREZEtBTEcvRUJsQ3daOEx0cTVY?=
 =?utf-8?B?UklvdFVNc2cwalVMYWg0bndQUWdaZHgwSGx1Mkd1OUR6NUhmVGpRRlQvTU42?=
 =?utf-8?B?OTVGU2ZFR21sQUREY0Z1a1RFMW5QM3FwamtrTXROSjlnMHNFbG9oU2c5VWVk?=
 =?utf-8?B?azQ0SkVONlpJWlR3cWFBVXl5akVoNjNEdjB1T0wxWTdmOHZsQVJycE8wZ3lM?=
 =?utf-8?B?dGhqU1lqR2hGdmZJT2w0U2JsVWlIS2psY0Rnck94RmtMMFZpSTZsaHFIb3kv?=
 =?utf-8?B?bHQ3QTV3Z2ZITkZVVG9yUzA4eDBTMGI5VGhEbVljaFFML3grVUJYRnZTQlM3?=
 =?utf-8?B?bWdaWlIyR3M0RTk4dnFMUm9jdTdyK0tNWnpIK29DNFd3WnNXeEdySzFUUWly?=
 =?utf-8?Q?nmjA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f807ba4e-c913-40f3-d989-08dcd7f66fd6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 15:27:42.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BbDgVzELHIMWtY6NHm9qaXoMXkktWfXZNlrcxqPif41RYPYRS7AaL4hp7BEJu0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

Hi Reinette,

On 9/13/24 15:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
> 
> (stray ` char)

Sure.

> 
>> feature and initialize sdciae_capable.
> 
> (This is a repeat of the discussion we had surrounding the ABMC feature.)
> 
> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
> becomes a resctrl fs feature. Any other architecture that has a "similar
> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
> needs something generic that could later be built on (if needed) by other
> architectures.

How about "cache_inject_capable" ?

This seems generic. I will change the description also.

-- 
Thanks
Babu Moger

