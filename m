Return-Path: <linux-kernel+bounces-177139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F28C3AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7BA281369
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF507145FE1;
	Mon, 13 May 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nxPHq0k/"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5222F08
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715573241; cv=fail; b=lIxigpLSd6GOLR0LGPWxv2G4T6TeQAiuwzIQPYvXgERSW85pe/93Jcc8olHahW3eVfYaWMe5K9QbE9aYN0mA7BOYv7eGGG7svAehkxy2i8H4L/F8kHYPLZWfnRyLvTwFeM8dUJgdzPSxe/70PAsZVuWzFXxc1pEBn6e33m4kEuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715573241; c=relaxed/simple;
	bh=YvfNbOK8qnbOq0N/Mn9qsQSqIBcd+odn4fPtYF5uLQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JWDVhZD4ViFZDaOT2vPZwpcpC378xahpzkhMyJ02tpvd+P91DwgSXTwy4LO3GqUnWNhGYgWJ7jE5e0XwyGmvisUS/b8GIpvvD9NdmHQO+mM1Sicta4XC0Pv6OGEOVVSxpWT4wSN1k9JIXvMJVhtVO3iwU8or7/LlaCCj9HhRUuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nxPHq0k/; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoZpMRujQJcUUtUdD4K9yFaxd9TQkKPzrc7Q5Ch/uFxEl/PM8LAU6PT+dOJue+HcFOOFioujbYNhqTKKiPL3mXTY3ZuyrMakM5IguV0nbrDGW7eoOsdRCnHsYJTOaQ4W6QnMVg4hUKzm8TiSTm3T/Y6YfYd0rHZ9fGaQz7G+B97ZRCjouPUh/rknq4JMxcu82u/AbeP4toQl8/7IepWBblwL0CZt4VBYUwgwbNFJsYzNZwjBZ2XZiWE/VHp8wcNVTyJEyQsHCCQRrq2dYiI1pNWm1M5StIt4pMYleVTrvOCH5sR/MKTxgg7y73n+Ibwyp7t4RGRBzO6fVeF661pC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toxVyaHGbLPc2xvj9W+zyS/18GFYisjbjfcXD0l8c/I=;
 b=QuvakwmstIlYNQ1LhMqCAjJequeYnn/Phfeo6p4np+x5e4ql1omM6aWiN5lkc7Gp2isMgxAj8nfNe9YGD2KVlhRTt3Q/H6Wm+i79KW6EzvjTAIw94u0BPXHinfWq0xxwuZM7rLo4KkEM9WZqAvfa3CkiC5U4+tTZn+7Mw7lWLqWKCyvagVqNnPXMiIetqjyDEUbIiKqJs76G6/uVl4oCfz3qRIDMZ8MEypVOpomwmwIBLa2zdIhV2JmGceTylgnxU+JYTY6047ihGCY/8y8gsvD9KR8XOEFMO33NdPP3hJ4qhMYr0EtFvXNtl/TPIa1AVlkdbu8ts7erWJwSMK52Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toxVyaHGbLPc2xvj9W+zyS/18GFYisjbjfcXD0l8c/I=;
 b=nxPHq0k/e/MHb9MwuIIelK71TKBs4D6m1CO6ajhXpkS9RqNObfXTk/UQHaBQWlEXU2aatulpCFYOL4c9nOicEMPUmHMsTjsxr1bedsyFS9zHaa6n6q5rL0qPdO++JBX1IUBrYIY7ZnAU4f8G5Szg0H6jhxmUFBSC5LOLmCSUAVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 04:07:17 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::dc81:c7b9:7aec:68cb%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 04:07:16 +0000
Message-ID: <422fc38c-6096-8804-17ce-1420661743e8@amd.com>
Date: Mon, 13 May 2024 09:37:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
 tim.c.chen@intel.com, yu.c.chen.y@gmail.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org> <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4ee223-6c7d-4c22-2fb0-08dc73022d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk8rSlc4VDhCUUJ1QnQzMzJzNzM4TCtjNklvamd0UU95MFE2NWEreUdYc3lI?=
 =?utf-8?B?NjFmRVR1Vm1nMDFXTWtnY3F4OURBd0FIdHlaeTlRbXNpTFBVc3JZUnpONm50?=
 =?utf-8?B?YUJHZS82Z1hBVy9KWXU1by9xb3pTYndGanp0eCsxL2FNY1dkdExoTzFQMVRU?=
 =?utf-8?B?VkNlQnJPTjNhSStvZ1RhUCtQNTN4L3h3eXVIeVNDQWpoTWhUK1dnSitocE1R?=
 =?utf-8?B?SSttUWNaV016L1lmYUc3Z1RDZ0FPMDVPQU03MXZySnVtVVVJMkFZQ2xqSVh1?=
 =?utf-8?B?VXhSZmwrdWpGUFVZMUZEU0s5MFRBcWo0YmYzc1lnWTRmMUc5alFGMU9GNEh1?=
 =?utf-8?B?YnROWUFxMVduYUpmei9JdUs3cFVrU1Z6em8xUEVjWFRSV2s1OTBQdWtDQXNI?=
 =?utf-8?B?WE1RbzlncmphYk9IZUxrZStpYWY2Vk1OUFdydjRCRE12WHZpQ0tqQlZ6dE9i?=
 =?utf-8?B?bXAxS1hjV1UxSG40UmF6dmE5T085dWZ0YzZ6K1lyOFA4NTUrakVQOWlyUjht?=
 =?utf-8?B?M3ZERlJ5Y2c5YVplRDkxck4vMkRmUW9ESmpRbTZCUWlHYjNoVXJxVDNaVWdx?=
 =?utf-8?B?NjE4TmlnNnhZZ2pFWW5FUmZzNSs0MkcyQzVsNnRxanduTmFRMHloTHpFNGFZ?=
 =?utf-8?B?dEdXRlZ6ZzY0YUNpd0NEdVl4QUVjMWh4WENHTDNuOTY4OW54NXRMd0I3d09x?=
 =?utf-8?B?SXozWHhMaWEwRzZWdS9GODJlMlFpY1dqaW9Sb01XOE1kTTVJcTZHcnloTVFi?=
 =?utf-8?B?WFM2UmlEa3VOeXVRdmFZMGJHdGJKWTI0TThXNVdVRmlIZW4zSStSbG1oeUpl?=
 =?utf-8?B?cGxSUU41MkplekQvejR4MUxpZGhDc2tlUW1lVUQ5Y04zQXJZdGJxb1ZjTXFU?=
 =?utf-8?B?d201RUkwVmxwK2IwQVlFSzJraUd4clVySGhoQVlXQ1paYmx4NG14Zm01bjZT?=
 =?utf-8?B?MVV6WDUxbUNjaElvYVd5YktxWE5YUG9CVkkzSE05Y1JFLzV5ZTFrcEpxTHZC?=
 =?utf-8?B?d3ZxMlRyUDBBdHNjQ3F0TTJNaW1Hd0pYaWVEV1VvRnh2ZlZtbkl5MnEvYlpq?=
 =?utf-8?B?ZEQzcWhrSTByL2pFb0FrVTZFS1A3VWJ4THA2S0oxT3ZQZWE5SlN3M2NScUc0?=
 =?utf-8?B?VnBVdkE2VkovV2dobmkwNHZZNGY3ZVRDSlVXNHQwK1ZKVXF5YTkzSHhVbkp3?=
 =?utf-8?B?djhZZXl5citLM211bnVPRGc3VzhhaFZPcTBjdnAxbVJyTFFIdVdQNk9mTkd3?=
 =?utf-8?B?dkRCcGxPU2hjS0VBeGRvUVJoeUZRSTRTcGREcTFFK3hrQ3RSWWtTMGZHN01r?=
 =?utf-8?B?YjNhdWt4c0VLTW40WVFSUDRkMFlXSE1ZVW9XTnJ3Zmo4WFpmTVJqUFBCbFVM?=
 =?utf-8?B?Q0piSG1ZdU03aWZQY1RDNXFacHN3cHFBVHk1TVVRMnNwUXFhTkVZTm9ZdjFz?=
 =?utf-8?B?OFIzdThWQ0N4cTZFaDRQVFZqZGxDdzAwNHFELzJKeUNwNUpHU0NUaVFVWSs3?=
 =?utf-8?B?cVJQSUdqalpTUllDYnpVUnRvWVM4V0poc25xaGV3QjY3TVdhalFqU3hXd0wv?=
 =?utf-8?B?UGx3UlV0RGRVdFBiOW0rdXVyUm1FWnd4U3pwd0Q5ZG5Dc3I3R09EZisvY3JG?=
 =?utf-8?B?ZEJabmptbEkyc3JuZ1RGQkV5Y01Ja1FDKzQ5TVhhQzNrZC9YbWhqb1Z1U1FC?=
 =?utf-8?B?OVpPYWYyWkcxcXpselJrMnA4RVU2dWdTR00vZWhxYmkxZzFXNktvMTVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MllpSjltY2Q4OHJqUXF0RUVIdUVCZ0tmRTNVZ1hUM0dWUDRQZTdheGNqNWJM?=
 =?utf-8?B?OTZPVlkvc09jVUJZZGhhQW5Rc3A0amxVMXJsZGM4L2lERlU5VTJXdENjbkpU?=
 =?utf-8?B?bWZCSFR2OTFQNjdNWWFEZlgza21USmp6OTh3dlZPbVVJem9PNENWSU9sZHhJ?=
 =?utf-8?B?bEN3M3B0L0tTSE5HQWcvZCtPN2trWlVYUFZZZUs2QVFWRnZqZVN2OHlGRDNV?=
 =?utf-8?B?ZjJwZlRTeWN6b1NvRTZrVTNKeGFwc2UyVTlYNU9GQTRoLzNOT3EzQW1wdjRW?=
 =?utf-8?B?MU5qWDdjOVFlNVgyMnQwTmJOcEtuSkVrNjNSajhkMXJGNk8reVN6THUwV3pz?=
 =?utf-8?B?YnIwOGJYVUJKL1lwOFFGOTlHL0Y4aXVKLzE3dVl2bXNqejJta3pwYmQ3Yms4?=
 =?utf-8?B?MEV5d1d1Ym9OOE1qWnptdUtacndnbUhNTzdOaDRRT0lwVlpRbTU1NHlCUWc5?=
 =?utf-8?B?Y2hNUTBrNnpONnRPbmptZ1JLYnFGVmdVNUxTZlJPQ1J1REJnYktzWVpsVXpW?=
 =?utf-8?B?QmEvR3NnVEVRTndoRXdUOTI2L2hucWpDNVdJL3hGQTYrZnByeVZIOERaOENT?=
 =?utf-8?B?SlFRM3JKNkl5OWlrWkVQYmVmQ3ZYZHEvdUYreEUwbnBDdlF2azJ5TjZpenlZ?=
 =?utf-8?B?MnVwOVMrUGZtMmJlZFl5Wm14K0dDWUdrRmRYSFFLWStPS1NVd2xqZG9nSEdN?=
 =?utf-8?B?YVgxRkRlaTNpWHF3Ym9iemptR3l1SkYyeWdVbHFTekhON2xkWEYzME1OeUJZ?=
 =?utf-8?B?M2c0ZlpBbGpYaWVKRUl0bk5vbXZxRHYrV0szK3pKVkdPSTJhRnB6clAvM3JN?=
 =?utf-8?B?M3BUeSt4a3kwUk1Da3Zta2UrV1JkVzFCNVBJeUZUamJQQ0hHM3pUY2orQ0ZV?=
 =?utf-8?B?bEM5YkQxWGJBTllmZFpScXBRRC9OQ1JnVDhPQUdTb0pnWHlvR2dPaTFhbFR5?=
 =?utf-8?B?UHVLUWF4R1VnTWlablBHSElNb1lZcG8vYU53T3NORjdrWVZxckxRVjZsM2Zq?=
 =?utf-8?B?U2dORDZqRlNHRmZGTng0bEt3ZFZ5ak9ESU9FVC9kaDg0aFZ1dG1aaGlSMlkx?=
 =?utf-8?B?T3pVcG00L0Z4c1Fzc1E3NnB1QWtxeVk4WDBCSkxLdGZaemRDY05zSnlXZG5Q?=
 =?utf-8?B?bW56VHNxdFdPTGVtUldxSXRSdnJ5aGRpVG5hajViWG42L0VaWlNhWGtWNTlB?=
 =?utf-8?B?WmpYdVNnZVB4cGpWeWJjZUM0K3oyYytBZ2NybGtweUpKdU1aMEk1RXF5WXBX?=
 =?utf-8?B?YTA4azl0b2NxcVVtUWVoYjRleW8vRFVMQ0ZSRm1qZlMvK2V4NmxGM0tYcWxY?=
 =?utf-8?B?cjY5b254Z01OckpWYnlTNm5vL2UyZnREOE95VkhVUnlXazRrVnNma2dEUE94?=
 =?utf-8?B?bUNPUUI4QVdWbTNWVUhaQlFPbDVrWGhtc29sWHlLZVBnOXRBK1ZGSXd4ZDRt?=
 =?utf-8?B?OXVma3oyQyt1MEtzYm9ncU1pemJsRm9TeERDRnZ6cFB3WG1oVDRia3hwWXRK?=
 =?utf-8?B?c09ndFVQQWtsNHIxcHEzRWlGcWFkNmpod2VvWTA4cCttQURvUlFJOUc2eDE2?=
 =?utf-8?B?R2Z2RDkxOExvYWpMdEcyMTJ5Qm9xeHNrNjJ4VzdkalNnV2VLV3ZyMzFuamJ3?=
 =?utf-8?B?OFAvSjB6NWdwNEIweXFYU0U2a2hNU0t2Y0ovYlNoeG1MRnE2aTVLeDhPWVR5?=
 =?utf-8?B?VHhhM0IvODFvNGhNajNHc3lCay84dURMVnh3NW01MEVtK3JiNGpaT3RnQTN3?=
 =?utf-8?B?alNnMFJkanprRVg2L1I2cFZMb3VPOEE4WGdvYWxWUXQwbEVtUnJhM1JtaEUz?=
 =?utf-8?B?RkczRE5oeUYra1pCMTlQQVFLWHBZd0lpcWNYSmhTYTNlZVhhNjNRaUxCbERR?=
 =?utf-8?B?Lzltd1d4V2dvWUZuQXlKNWVrOTZzc216bHhBczJFUFB1dXQvRXdjQkk1cGg5?=
 =?utf-8?B?eGRiS0ZJUFVnZWYyblZLRndPKzdoN3ZMZk41WEhYWTZBdDJwajVoWlhIZVQ5?=
 =?utf-8?B?dGp3OUhQK2djemNvd2VqdEY0b3c3ODUxanUwaWNDR2h5eVdKcWNNUC9QYWRK?=
 =?utf-8?B?eWtHQURYbFhsYmxmL1Y2RXZLZ3dGVGhmUnBVcXY4U09SU1F3ejFOTVBBTnRn?=
 =?utf-8?Q?CNtIMMAhfjF0umzGozGVMUP2a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4ee223-6c7d-4c22-2fb0-08dc73022d0a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 04:07:16.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8/xXW9JsDb1ZDEMytVpDttIt61CjbofpZhceBKTTnZw2IdH8NCHhSUfvBU9LAL7trN6kFB++80aAThOnaQQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444

Hello Chenyu,

On 5/7/2024 8:45 PM, Chen Yu wrote:
> On 2024-04-05 at 12:28:04 +0200, Peter Zijlstra wrote:
>> Allow applications to directly set a suggested request/slice length using
>> sched_attr::sched_runtime.
>>
>> The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
>> which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
>>
>> Applications should strive to use their periodic runtime at a high
>> confidence interval (95%+) as the target slice. Using a smaller slice
>> will introduce undue preemptions, while using a larger value will
>> increase latency.
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
> 
> Is it possible to leverage this task slice to do better task wakeup placement?
> The idea is that, the smaller the slice the wakee has, the less idle CPU it
> should scan. This can reduce wake latency and inhibit costly task migration,
> especially on large systems.
> 
> We did some experiments and got some performance improvements:
> 
> 
> From 9cb806476586d7048fcbd0f66d0101f0dbb8fd2b Mon Sep 17 00:00:00 2001
> From: Chen Yu <yu.c.chen@intel.com>
> Date: Tue, 7 May 2024 22:36:29 +0800
> Subject: [RFC PATCH] sched/eevdf: Use customized slice to reduce wakeup latency
>  and inhibit task migration
> 
> Problem 1:
> The overhead of task migration is high on many-core system. The overhead
> brings performance penalty due to broken cache locality/higher cache-to-cache
> latency.
> 
> Problem 2:
> During wakeup, the time spent on searching for an idle CPU is costly on
> many-core system. Besides, access to other CPU's rq statistics brings
> cace contention:
> 
> available_idle_cpu(cpu) -> idle_cpu(cpu) -> {rq->curr, rq->nr_running}
> 
> Although SIS_UTIL throttles the scan depth based on system utilization,
> there is requirement to further limit the scan depth for specific workload,
> especially for short duration wakee.
> 
> Now we have the interface to customize the request/slice. The smaller the
> slice is, the earlier the task can be picked up, and the lower wakeup latency
> the task expects. Leverage the wakee's slice to further throttle the
> idle CPU scan depth - the shorter slice, the less CPUs to scan.
> 
> Test on 240 CPUs, 2 sockets system. With SNC(sub-numa-cluster) enabled,
> each LLC domain has 60 CPUs. There is noticeable improvement of netperf.
> (With SNC disabled, more improvements should be seen because C2C is higher)
> 
> The global slice is 3 msec(sysctl_sched_base_slice) by default on my ubuntu
> 22.04, and the customized slice is set to 0.1 msec for both netperf and netserver:
> 
> for i in $(seq 1 $job); do
> 	netperf_slice -e 100000 -4 -H 127.0.01 -t TCP_RR -c -C -l 100 &
> done
> 
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	60-threads	 1.00 (  1.60)	 +0.35 (  1.73)
> TCP_RR          	120-threads	 1.00 (  1.34)	 -0.96 (  1.24)
> TCP_RR          	180-threads	 1.00 (  1.59)	+92.20 (  4.24)
> TCP_RR          	240-threads	 1.00 (  9.71)	+43.11 (  2.97)
> 
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/fair.c     | 23 ++++++++++++++++++++---
>  kernel/sched/features.h |  1 +
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index edc23f6588a3..f269ae7d6e24 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7368,6 +7368,24 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>  
>  #endif /* CONFIG_SCHED_SMT */
>  
> +/*
> + * Scale the scan number of idle CPUs according to customized
> + * wakee's slice. The smaller the slice is, the earlier the task
> + * wants be picked up, thus the lower wakeup latency the task expects.
> + * The baseline is the global sysctl_sched_base_slice. Task slice
> + * smaller than the global one would shrink the scan number.
> + */
> +static int adjust_idle_scan(struct task_struct *p, int nr)
> +{
> +	if (!sched_feat(SIS_FAST))
> +		return nr;
> +
> +	if (!p->se.custom_slice || p->se.slice >= sysctl_sched_base_slice)
> +		return nr;
> +
> +	return div_u64(nr * p->se.slice, sysctl_sched_base_slice);
> +}
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -7384,10 +7402,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	if (sched_feat(SIS_UTIL)) {
>  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
>  		if (sd_share) {
> -			/* because !--nr is the condition to stop scan */> -			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> +			nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan));
>  			/* overloaded LLC is unlikely to have idle cpu/core */
> -			if (nr == 1)
> +			if (nr <= 0)

I was wondering if this would preserve the current behavior with
SIS_FAST toggled off? Since the implementation below still does a
"--nr <= 0" , wouldn't it effectively visit one CPU less overall now?

Have you tried something similar to the below hunk?

	/* because !--nr is the condition to stop scan */
	nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan)) + 1;
	if (nr == 1)
		return -1;

I agree with Mike that looking at slice to limit scan-depth seems odd.
My experience with netperf is that the workload cares more about the
server-client being co-located on the closest cache domain and by
limiting scan-depth using slice, this is indirectly achieved since all
the wakeups carry the WF_SYNc flag.

P.S. have you tried using the slice in __select_idle_cpu()? Similar to
sched_idle_cpu() check, perhaps an additional sched_preempt_short_cpu()
which compares rq->curr->se.slice with the waking task's slice and
returs that cpu if SIS_SHORT can help run the workload quicker? Note:
This will not work if the SIS scan itself is the largest overhead in the
wakeup cycle and not the task placement itself. Previously during
SIS_UTIL testing, to measure the overheads of scan vs placement, we
would do a full scan but return the result that SIS_UTIL would have
returned to determine the overhead of the search itself.

>  				return -1;
>  		}
>  	}
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 143f55df890b..176324236018 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -50,6 +50,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>   */
>  SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_FAST, true)
>  
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls

--
Thanks and Regards,
Prateek

