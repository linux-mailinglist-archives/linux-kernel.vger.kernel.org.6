Return-Path: <linux-kernel+bounces-536812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ACBA48477
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2313AE378
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C885F26E97B;
	Thu, 27 Feb 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SRePMonh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3726E976
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672313; cv=fail; b=NHadXuELNcfHLowd3xNuqXb9riwqNY9Ahr3p6VZ2bm1Y5Kf9YsiYqm2GxERk6H8A27RFtqZbifIAfOX6CqMFIqTIYDu+v6utSQksL0wXgu1xIQ6U6wfUcjuaeUxuksM9W8TiH/TipZqXOFZx7F+zPfblKcb2/ToC7p2t3dVlcbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672313; c=relaxed/simple;
	bh=/oWVRrqNv5UdETRFqpyQxWdrpzKqSK8UD+aOZaxFDgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VAZ/gvnagzYm2gSn4wznNRe+ulDfuIZ3kGq2dDLftgx5AhH4BLDWa9qpOmHdVb2XtlWPvFqgBgX13EPM2DfZbQhylanGJA5uZrlMrBROiB4VYS1t1I4VMtFpgQbOMz4yRWbFtrRdj3AJJBY5V4bZwJaZq8s+SwZKEIuNCY7/xyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SRePMonh; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy1/F3hcIAhEmlDSRtDlR1lZjaIVpZsRDAOUdW1w1+EZL/RknOTVoNNY1CdCPO9eQiv6Ve1LFbmZ9JwssK8y10ptXPtJuvIKRqwtvXzT7BdbgsT82/ninlOli7DY5nP3gCaX8z70Xz6OAKTvAJutRZO39CVXTntel5hsr/7TTx5hPp1sfhGatwZWZTTwtjHand3Zc8fTiKkBuD8sQhe9qTcUymMw34YrOmO5md+FBWK3A/ASYWN3/IheaT/8gy0xj/504UIQOCu5RJPbElub8pgNj65jCv2WdVszp17cGXfUUUf3aai1RH+FON6rQtmSrJGh7quOxVKcDWtVFn5fGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oWVRrqNv5UdETRFqpyQxWdrpzKqSK8UD+aOZaxFDgw=;
 b=Kjm84j5FQJ/xLA53MUlqRSs2ScJg2qpAn1oFMDd+/EicnPcTNJHL7wwFnS34vjraf4bKiiwJWk59w4TBX134dv0bfcoGZSyGRSC8/6RtJJRbua4MLU4rPLHnQi30u1fYMc3uKKW74dSaDM/leMwSDcVrMchQ+ryUcqPK6YjHGGE0AWrTvu2VO/iztlXhxXnMPknEHoAPTq1Qo5Mq1ZYh3C2C6ZoEGMZDI4/Ot0T/UpeA573zrk+HK75kI4LT1/IKZvecmfY4G0NWq5bBCFIkSWE2N3O0hPDI7wxBh0nMRFIoWNO6YO0Dizgt7QNdcNpfWDWXVYna6UiydMt9mHl4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oWVRrqNv5UdETRFqpyQxWdrpzKqSK8UD+aOZaxFDgw=;
 b=SRePMonhzT+aDIAnJ7JXToC6YYECupjB7c4COlZq5wyEb79Kuyye4JCb8QfueLwUrMra51QWwmqUkLIZTJKIvTOuiGuMiVT4U9ga+kLcb8TxvbwklxQpr9ltuFYmACBVYyyVcm+9qj0q7DV8N011GExN5MhYxFTalycjnYaAugo=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:05:09 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 16:05:08 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index:
 AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOwgAA3cwCAACLxwIAAWYuAgAAd6ICABAIeAIAJN77AgAAXk4CAAAqGMIAAFpcAgAAZgACAAA4xAIAADWqAgAApHQCAAKzDAIAAAyFggAALnICAAAQqkIAABbqAgAAGO0A=
Date: Thu, 27 Feb 2025 16:05:08 +0000
Message-ID:
 <LV3PR12MB9265078444D6B1B4258849FB94CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
References:
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
 <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
 <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250227150143.GFZ8B-V8nIdSlV7ng7@fat_crate.local>
 <LV3PR12MB92651F3CE777A3723B61835594CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250227153707.GGZ8CGoyaSgX6FkVWY@fat_crate.local>
In-Reply-To: <20250227153707.GGZ8CGoyaSgX6FkVWY@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=68d67d8d-e8e3-47e6-9b61-0e547d74398c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-27T15:59:24Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|BL1PR12MB5946:EE_
x-ms-office365-filtering-correlation-id: 3976f02a-951e-42e1-bbce-08dd57488210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFgydGs0aHN0aS9hNGJwVnFWb01OVTE1WDl6M1lOS0JHbVZSUTRsV1Q0UjJZ?=
 =?utf-8?B?emNTdU5vbXM2bXF2VjcvSFVpcFV5b25CSHZxb2dqelovSFVyUnJDWDNNajFM?=
 =?utf-8?B?ZmpoZW96aGZOTUFkeGlkb2dXZVdIZUNIV0p4dkpzQWRGSEtnZjdWSWpURDdX?=
 =?utf-8?B?WXZtT0lQREpUaTF6eDYwTlU4aVprdEhOTytQNG82QlJwdDlYUy9WWFJoR29r?=
 =?utf-8?B?TTZZbmZwSHN6ZnBnTWxhaEk3RVdjUHlzcXBEVGdJMktsNDdDaFJXL2kzeGVC?=
 =?utf-8?B?SEIxWHpRQ0dKK2xDZUZPN0Z6ZDlabHpFdVJTVVl3TFhpQnZhOXZGUDJjMFIr?=
 =?utf-8?B?OWdkNGY2elJqSzJBSEE0bmkxdjVENElXbzdySmZBRGtoYzh5bmJXMXptWXdu?=
 =?utf-8?B?ejN1RVR5TlJVUFNxcnRYenQ5bkxVTEFyaURVWTFwdVBKUGc3Q0hkenBPU3B2?=
 =?utf-8?B?aUJ1ejc2UnErenRkN3ZsVXBWZUk5clY0U1hDdjYzczY1NWRPYldhaE80TGhY?=
 =?utf-8?B?Sk04UkxFSDE4UFYwVG10YzBzcW9xejNHcW5SS0RuQ1p3MkJibGdQVU1vRFkx?=
 =?utf-8?B?NXplak9rZUNmRXJ4VTkvMTJQcGh4SHdrQWV5VEc0Yml5USsyamR3MGtLK1U4?=
 =?utf-8?B?Q280UUVYUncwK2hyaWNJWnI2M01ubGdHV0E2K1ByRys2M3hONk51Z0JnWWti?=
 =?utf-8?B?MFFMY1JRSzR1bHJ5SkhXR21Na1RES2J3RkNrMFkwaUFWcHlyaHg2anlpb0gz?=
 =?utf-8?B?Y2l3M0ZWenRyS1k1OW1JalFnV3ZBbDhTYU01M1BTRTRQd0MvM0RLbWY3U3o2?=
 =?utf-8?B?SXZkR3pQcnkrQnFnak9Nb3hvRnFZdFhBMnFRakxHRW9UREZpQmQ1TWxMd3NY?=
 =?utf-8?B?aUVVa1BBa1VxUDdVOHNGdlpJRkIzNDhEVE1oL0RPcUZVQ0lzRXJIQkJ1Y3Nq?=
 =?utf-8?B?dFRNeWtKTWQyalVVbHJiWWR1ekJwemIybDJFa1hEU2FKQmNCZVRVV1Jic1ov?=
 =?utf-8?B?alQvSGhNQ0ROMUcxK2YxOHdqVlBueFhBZk5zMEltcFpsaW5DRERVTVlBRTNq?=
 =?utf-8?B?UDZaL2swY0kzVk1KQThqZ0tCT3ZFTTliYm5JNW8yb0wzaXVXVFRLUGRLN0tD?=
 =?utf-8?B?dFpTM0E1UktrT2xWYlRoalNSSTNhT1JxcEtBcUhCMXdmclNQcTBzamZucjZX?=
 =?utf-8?B?dUFLOXV1RTlMOGpLMTJhTXdNdkw5eVhmd09XTE9YR1hRVWcra1NUWTdxWUxC?=
 =?utf-8?B?SUpycXVlbjU3eDduN1oxeUJPRENPK3JoL3NtTWVQYTVSTnVscUZrbGpNdHhP?=
 =?utf-8?B?SXlYUGlFblpaT0dRa2hsOGU0aHNZdEhQRGpzTUw0SVU1VWt3QlE5NXJmbFlw?=
 =?utf-8?B?MlM0VVJlWTlUbFlsVE9oN2h5enpyNnpmdXNZOTVKZ1RRdWsxNHVJNC8xOGNG?=
 =?utf-8?B?V082eUEyRllBTU41N00rRGxIUWtKMEczU2NkTFM0L3J0T1BxanZGV3ZlK2pp?=
 =?utf-8?B?OWJBejc4SXptNEUxclFBYWVZbm00Vnh5aXFvZW95Wm0rbVJjdmNhVlZwTlZo?=
 =?utf-8?B?N0puZXBPeGpKcUNZbzhRUlVsNkNhbEtxZ2hCWW81S0lEMVFRNFNRb1pqVXhE?=
 =?utf-8?B?eGo2ZXBTQmNmbzl2Ni9oMW5zRCt3bG9vTFQ4Wk5Qd1hnN2NzOGhPdEFjdTZl?=
 =?utf-8?B?RnZacTJCQjgzVTg2UFduYUFkaVQ1c1RheVFjdHRaTnhYUHV4ZUhwbFpzckhR?=
 =?utf-8?B?UXR3OU1KR295cFdsY25DeHd4SG1yZVNmU3pkV09aSGxYNkYxS0NORjlvRnpi?=
 =?utf-8?B?dHd0Vm9UYVlvVlhhRTV6YlN6UGxtd2lMN1hzUlVMWHdFUTZNN09OUWVqM1Y5?=
 =?utf-8?B?WG5PZFBUZndIby9sTGtFb0F4TmRTKzZlQVk0YjNQN3RRN2hFZGJoV21SVEs1?=
 =?utf-8?Q?POkmF9Rfti4d27JmTkhlZt4yPqpbjzZ7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1Q2WWRoUkl1QUg1QWN6R3Zza3lwTEdvYTRjbjBWd1EyZGcvSWo1dERxaW5U?=
 =?utf-8?B?YW81ckNsK1lGbFBiUkRnZ3FwaEhINmxoNnNuOWJvQkdZMHRMVnc3U1UwTmxy?=
 =?utf-8?B?K2k1bFdmZ0ZCUjZmSWhJcUFTRTQ1RE9TWEtIWDBNV2k3ZU96WUdLZlQxeXNJ?=
 =?utf-8?B?Z3owcjlVbXZQRmcwaW1jWnd2bkVoM3JPUjh2NmVVdjBIdWhYbFdmLzlPYVpp?=
 =?utf-8?B?dmJJc2pPZVpvTkhmY2ZuTEQvSjNiVTNzaW51UnY3QVplY1p0TU5VN2VWaGk4?=
 =?utf-8?B?ZVFqamtDdW5vN3Q5VWViTzFwTlFCQ20xYThvNVlXRUwwaUplZlhXZ0hHWEIv?=
 =?utf-8?B?eFl6ZkZaajN6cVFqaHpIbkxiMlczNDc3SEFWU1dhdXhNbllUa1NmNEFhUnBY?=
 =?utf-8?B?L2Z4OThCNzhsRkdxQWIxUG9CdTlGT1pDbVVZZmdxa2Zkbkx6SlU0U2UvVGxj?=
 =?utf-8?B?NG0vQS9jSGJscjRtazAvOFY4VjZGVjdtWkdyUFFOWS9pYzY0VVRwM0wzUjdI?=
 =?utf-8?B?WEZWckhUWTNmVmVJL2VMc2NoYWZGN2YwNk4xQnV2czV5VGp0c2k4T291SWQz?=
 =?utf-8?B?dmk2dzVnTEVWVFdpc3VVVDYrRE1ieS9aTVNkTzFQdUJzL3BDeXdWa0xxeGxo?=
 =?utf-8?B?SW9RZmNveVloVU14am1uN2hpUml5VGlQeVlEaUtKbG96NTgwSGNzSUc3UWVs?=
 =?utf-8?B?dW9nN0tHaHhZcFJjY1hJN1lWcHZTckZZb3lpZEhnbkF1N0NoU0x3RE1aU3cy?=
 =?utf-8?B?VjRsSkovYUZNR0p1ZDl0OTMrNks5QWpwQkR3a3BiU2NlQVVYQ2l2SEF6dUpy?=
 =?utf-8?B?bnR6eEllOGhIeXRhUUQwUUpIKzMzK3Evc2lBZWsvLzc5eFV4cTRTNnl4ZElo?=
 =?utf-8?B?QWR0ZGNtYTQ5Ty9tbmoxY2UyMlVFb0ZzVHBIU3o1b0NOeTNKVjZheWNNMGFM?=
 =?utf-8?B?bTk1SXhyRmVLaGRpZUJ6VWovZkY1VVhkRFB0clBkcTE3amZSL3JSbnlhRitx?=
 =?utf-8?B?bWNhc0ZmVUdxeWxQeDFsT2VScFJmcWZveUFORERmMThBcWZYUGxvTlVHVjli?=
 =?utf-8?B?TktlNlUxRXRHTnFQekhOQkpMQ2NpQW9ya3hVdWxvbDlpamNISlNvR0NqSHZp?=
 =?utf-8?B?SmRkM0NNWjBteFlVeVlaM25NRzJHdmdZbnVTQTV5cFhHZC9jNjV0NnN4bHhS?=
 =?utf-8?B?Wm5TZ1NVVU84SVBTRWUwZ3RRNENNTTFZTTFZYXUvUEpHcjZCN3htd1lyQmhR?=
 =?utf-8?B?M3Q1anpPcjhEekdGbWlxM0pJNTFza1JlN2hURi9HLzJwaFlrM0RVYlk1RXFx?=
 =?utf-8?B?SkF4cEIrNmlLUmNQQ0E5UHRCTlVjWTFyTW9MQmIxYzZxeTVtSk94UExqRFBL?=
 =?utf-8?B?V1Vkbk9kQ0hrS0xTNGhkeVgxQ3NibFdWOVJqTzdTa0x6ak1ZY1dEa3RXU0JS?=
 =?utf-8?B?eHU3ZG9IYUlhSzIwdGM3aGl2cms0SFMzT29ualFXWXhGY0tGd05RZnZJUVBv?=
 =?utf-8?B?ZW1memNVZDVVdis1SC9HRVdLalpaMzBXdU02UFN1NS84cURmRjlHOTVUZmpk?=
 =?utf-8?B?czY5cjFjVkVGQ01nbldsWXJBamU1MGVrOG5pbEgvVW85dTFXcHlOWTd1b2No?=
 =?utf-8?B?ejdzbFF5Q2plWll3TStXWmN2R0JWaDFVVEdRWnQ3T3JyQ0tMRUpsaG5GNjJT?=
 =?utf-8?B?S2MwQmdQUXE4MGlNbUZUeVZaSGFiaXNMWTV5UW5qeFNpNHQ3a0ZmZXVKZ3hV?=
 =?utf-8?B?bnQvYzVuU3BxL3M5TDlabEtkU1NOZUN0RnEyNmh5bldDSDlCWjFrZVBnTzg5?=
 =?utf-8?B?cGlZVDREeitodE95VWFTMW40b2JBTGJoUlgwTWVKVjl0alBEdnVHMmM0V01H?=
 =?utf-8?B?UE8xY2lzaG1sVk9LNnUwODN3b2QyNTB3eEZKS1Y3UGJteWlxdS9VYjZmNFhK?=
 =?utf-8?B?bTI2eU4yVU1xOW1pQnd5MjFyV1M0a1RZcldVYnRQWml3VmFQUGlLdWxmUG0y?=
 =?utf-8?B?bjQraWt4UlhpMVMySDhMODJ6VmJIc3BrT3huanVGSHlPRTdqVkptZGxOVTNJ?=
 =?utf-8?B?cTJvZUZmQUJOVjcvNjVEaEtqbE0rZ3I0REx4a3VWcUZ4STg0a0xWamtHeUFM?=
 =?utf-8?Q?37/s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3976f02a-951e-42e1-bbce-08dd57488210
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 16:05:08.7321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1d/248XB4yFz+7gN3rz+yGeG8aOmpnmWDsXhtSfOVcAyPjWZ+NEMpyTVrU0uZ6T8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI3LCAyMDI1IDk6Mzcg
QU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogUGF3
YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEpvc2ggUG9pbWJv
ZXVmDQo+IDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDIwLzM1XSB4ODYvYnVnczogRGVmaW5lIGF0dGFjayB2ZWN0b3JzDQo+DQo+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgMDM6
MjI6MDhQTSArMDAwMCwgS2FwbGFuLCBEYXZpZCB3cm90ZToNCj4gPiBJbiB0aGlzIGNhc2UsIEkg
dGhpbmsgaXQgaXMgY2xlYXJlciB0byBzYXkNCj4gPiBtaXRpZ2F0aW9ucz1hdXRvO25vX2d1ZXN0
X2d1ZXN0DQo+ID4NCj4gPiBUaGF0IHdheSwgdGhlIGFkbWluIGlzIGV4cGxpY2l0bHkgc2F5aW5n
IHRoZXkgZG9uJ3Qgd2FudCBjZXJ0YWluIHByb3RlY3Rpb24uDQo+ID4gVGhpcyBzZWVtcyBtdWNo
IGhhcmRlciB0byBtZXNzIHVwLg0KPg0KPiBTbyBpZiB3ZSB3YW50IHRvIHByb3RlY3QgKm9ubHkq
IGFnYWluc3QgbWFsaWNpb3VzIFZNcywgdGhlIGNtZGxpbmUgc2hvdWxkIGJlDQo+DQo+IG1pdGln
YXRpb25zOm9mZjtub19ndWVzdF9ndWVzdA0KPg0KPiBvZmYgYmVpbmcgdGhlIHBvbGljeSB0byBk
aXNhYmxlIHRoZSBvdGhlciB2ZWN0b3JzIGJlY2F1c2UgYWRtaW4gd2FudHMgdG8gaGF2ZSBoZXIN
Cj4gcGVyZm9ybWFuY2UgYmFjay4NCj4NCj4gUmlnaHQ/DQoNCk5vLiAgSXQgc2hvdWxkIGJlICdt
aXRpZ2F0aW9ucz1hdXRvO25vX3VzZXJfa2VybmVsLG5vX3VzZXJfdXNlcicNCg0KKEFuZCBtYXli
ZSBhZGQgJ25vX2d1ZXN0X2d1ZXN0JyBpZiB0aGV5IGRvbuKAmXQgY2FyZSBhYm91dCB0aGUgbWFs
aWNpb3VzIFZNcyBhdHRhY2tpbmcgZWFjaCBvdGhlcikNCg0KPg0KPiBXaGljaCB0aGVuIG1ha2Vz
IHRoaXMgb25lOg0KPg0KPiBtaXRpZ2F0aW9ucz1vZmY7Z3Vlc3RfaG9zdA0KPg0KPiBlcXVpdmFs
ZW50Lg0KPg0KPiBVZmYuDQoNClJpZ2h0LCB0aGUgcXVlc3Rpb24gaXMgZG8gd2Ugc3VwcG9ydCBi
b3RoIG9wdC1pbiBhbmQgb3B0LW91dCBmb3Jtcy4gIFdlIGNhbi4gIFdlIGNvdWxkIGFsc28gc3Rh
cnQgYnkgb25seSBzdXBwb3J0aW5nIG9wdC1vdXQgZm9ybS4NCg0KPg0KPiA+IEJ1dCB0aGVyZSdz
IGFscmVhZHkgYW4gJ2F1dG8sbm9zbXQnIG9wdGlvbi4gIFNvIEkgdGhvdWdodCB3ZSB3YW50ZWQg
dG8NCj4gPiBsZWF2ZSB0aGF0IGFsb25lIGFuZCB1c2UgaXQgYXMgdGhlIGJhc2UuDQo+DQo+IFRo
ZXJlJ3MgdGhhdC4gQW5kICJub3NtdCIgaXMgYWN0dWFsbHkgdGhlIGNyb3NzLXRocmVhZCBhdHRh
Y2sgdmVjdG9yLg0KPg0KPiBJIGd1ZXNzIHdoYXQgd2Ugc2hvdWxkIGRvIGhlcmUgaXMgdG8gbGVh
dmUgImF1dG8sbm9zbXQiIGFsb25lIGFuZCB1c2UNCj4gImNyb3NzX3RocmVhZCIgZm9yIHRoZSBh
dHRhY2sgdmVjdG9yIGFuZCBub3QgYWxsb3cgIm5vc210IiBpbiB0aGUgbmV3IG1pdGlnYXRpb25z
DQo+IHNwZWNpZmljYXRpb24gc2NoZW1lLg0KPg0KPiBJT1csIHRoZSBzZXQgb2YgdGhlIGF0dGFj
ayB2ZWN0b3JzIHdpbGwgYmU6DQo+DQo+IGxpc3Rfb2ZfdmVjdG9ycyA9IHt1c2VyX2tlcm5lbCwg
dXNlcl91c2VyLCBndWVzdF9ob3N0LCBndWVzdF9ndWVzdCwgY3Jvc3NfdGhyZWFkIH0NCj4NCj4g
T3IgdGhlIG5vXyB2ZXJzaW9ucyBvZiB0aGVtIHJlc3BlY3RpdmVseS4NCj4NCj4gSG1tbS4NCg0K
QXMgbWVudGlvbmVkIGVhcmxpZXIgaW4gdGhlIHRocmVhZCwgU01UIHJlYWxseSBuZWVkcyBhIHRy
aXN0YXRlIG9mOg0KMS4gQWxsIFNNVCBtaXRpZ2F0aW9ucyBpbmNsdWRpbmcgcG90ZW50aWFsbHkg
ZGlzYWJsaW5nIFNNVA0KMi4gQWxsIFNNVCBtaXRpZ2F0aW9ucyBidXQgZXhjbHVkaW5nIHRoZSBw
b3NzaWJpbGl0eSBvZiBkaXNhYmxpbmcgU01UIChjdXJyZW50IGRlZmF1bHQpDQozLiBObyBTTVQg
bWl0aWdhdGlvbnMgKG5vdCBldmVuIHRoaW5ncyBsaWtlIFNUSUJQKQ0KDQpUaGVyZSBhcmUgdmFy
aW91cyB3YXlzIHRvIGVuY29kZSB0aGF0IGluIHRoZSBjb21tYW5kIGxpbmUgb3B0aW9ucy4gICdh
dXRvLG5vc210JyBpcyBhbHJlYWR5ICMxLiAgQW5kIGp1c3QgJ2F1dG8nIGlzIGN1cnJlbnRseSAj
Mi4NCg0KV2UgY291bGQgdGhlbiBhZGQgJ25vX2Nyb3NzX3RocmVhZCcgdG8gc3VwcG9ydCAjMy4g
IEkgdGhpbmsgdGhhdCB3YXMgdGhlIGxhdGVzdCBwcm9wb3NhbC4NCg0KLS1EYXZpZCBLYXBsYW4N
Cg==

