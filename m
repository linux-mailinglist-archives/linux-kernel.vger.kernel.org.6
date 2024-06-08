Return-Path: <linux-kernel+bounces-206950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A636A901039
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043C0B21E39
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E3176ADA;
	Sat,  8 Jun 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="lkdzzC/b"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2127.outbound.protection.outlook.com [40.107.101.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381B1FDD;
	Sat,  8 Jun 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717835540; cv=fail; b=ViMHZB3Gx+Uq31q5LaQxVS1nXyCgRSy2VJ5MZT/22xwxPG9eh7CPry4TvlNAli0acF2gtWNq1lkA3s2ixyGoVwTglD/tMJTqio9l1Ppbo1GwKRNkcU/Y2Q+c7nC9GBBa+8DZGPaatzZ+76Do3Rp24tZdyrXTzbpIp1li3MhkGAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717835540; c=relaxed/simple;
	bh=MG+yd2w0ryfEDPjJ4Ft29iqpHnbu+P3CXl9JthbwfhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jORlCODeDK9paTTEnIYtWmFmsquWnJR7uHVysiLhFWwFHCJU29pOthiKJRzzGaIlnYJjV16AHWvLL0/OEa4Wp/e0VUQ1LLSZ8I8tp4OQs3pVWviak3hQF/eTwMOYHjWDXEGUqpPR/WxFZuc7wdI23dOUCz61CXAvgMqVkbr1wdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=lkdzzC/b reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.101.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJM2GbWNrlUJUB+RwsrY1G9EdEC552ezS6EmYFphpdv0EI2ln5AgeNAHmbxLhI1/lvKIuAuTqK7MKpTbYTWRN5rN1EyWcNe+KeX6JPLHO3o49OGbKkjHExQqM8o0lL+aJYyd7Krh1zxH+Jr4QZZMsub1lZ/hrB6JNaObOx3njioH60/U4K4pkSjGSUceu5ZnuhCZTV4hyU1nqSlv6iymYvtv3NVirJfFLwqTF1JNnahsEtSonDDINLQzyTj1u+4u5l91Wjti2ZphZBXnC4H5BslWU+r56PnnmzFgtSmsHWFJ13gZaqojmNMWxDeTuebUSp1/5BRWqSEau8MtPElWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3fMIkoWdChvMSBUch9sxSOXGlCwo+faegs5tqwMh1w=;
 b=lWhOd4Tezfwm9JQyCnFH9PrbiOfvLwDmhLdSizHz5C6cPRfzZIOu+3K6z6Uowiz4hHDSfBHbbhaXrD7JmKTo73Q3OZt5lCe4jE4CtIfbW9w/yjMI27eB4K3fbaexK1fiJiezk89TBX2qHCdkKW0DhNZ8wUEps2Rxp1lIBbsPxG2kDdQLmAuxW3KB+aR5qDM747ndyxNJwbhQvTRHfa2dMpW2WBgnjj1vVx0BnPKfO46a3dWZPrip1GqOzCpD8PyRBm7vB+j7ZAv9s+HY0I6OqxLAmL+W713Tvg7VKidlrdkwLNFM94xv1/LAS5H59uct1IR/7cnmEg+8dzZPqFSVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3fMIkoWdChvMSBUch9sxSOXGlCwo+faegs5tqwMh1w=;
 b=lkdzzC/bqbUXq5y1iA9rp4DHs2FhRAcMXbdX3OVk4krVxcOO3zrBsWnXxrUAnLWFvebfhm8JMYkWg2ejsTNtPnEZfwE56cIZ/+JypEL6EvZbYs3YhxO9p67caoDvtkSlVJc0YKsirdVOh+nerSsEBORdZa6TmEkUaWRhGJlt/Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 IA0PR01MB8330.prod.exchangelabs.com (2603:10b6:208:480::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.30; Sat, 8 Jun 2024 08:32:14 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::919c:7d6a:2069:b0ca]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::919c:7d6a:2069:b0ca%3]) with mapi id 15.20.7633.033; Sat, 8 Jun 2024
 08:32:13 +0000
Message-ID: <94adcd6d-1e66-40d3-b9e7-ef35f79691b6@amperemail.onmicrosoft.com>
Date: Sat, 8 Jun 2024 15:32:04 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
To: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-4-chanh@os.amperecomputing.com>
 <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
 <065243cc-09cf-4087-8842-bd4394fb324f@amperemail.onmicrosoft.com>
 <d549cf2b-a7fa-4644-8fcb-3c420503ee01@amperemail.onmicrosoft.com>
 <20240423-gallantly-slurp-24adbfbd6f09@spud>
 <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
 <396b47f5-9604-44ab-881f-94d0664bcab8@roeck-us.net>
 <0dcc8788-604a-49c1-8c6b-fdbfa9192039@amperemail.onmicrosoft.com>
 <da94fde6-3286-44eb-a543-c2ac4d11cd32@roeck-us.net>
 <8fb38eb3-bb94-49cc-b5bc-80989d7876b9@amperemail.onmicrosoft.com>
 <20240508-onward-sedation-621cc48fa83f@spud>
 <e15695d6-b1b1-472a-8288-dcdfba5d619d@amperemail.onmicrosoft.com>
 <ee94c869-54ae-42ac-ac44-34535141293a@roeck-us.net>
Content-Language: en-US
From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <ee94c869-54ae-42ac-ac44-34535141293a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:610:118::18) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|IA0PR01MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: be17d4ff-0cfc-43db-e82f-08dc87957f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWtISSt3UFdFUUk3YVFBNHBFaWdmVlRPbmROY0VYT3JaclZBdjZNSFA1L0Vq?=
 =?utf-8?B?LzNseEYwRDFtTDJMZmFJemFlZ1JkYmJENzM3NEUrY0JJaGliZWM2UzNEVkNQ?=
 =?utf-8?B?Q2U1eG5TdzRMSGVSeXg2Z3ZvV2p3ZEd6QTRuNmRZcklOTllJTkRrelNMZjhD?=
 =?utf-8?B?Q3ZMTjNrejJ2SGxnWE9XTFAwdFNPcFp1c0hQdXc0cVNQaE9WWmh5Ty9DVHJl?=
 =?utf-8?B?N3hOeWttLzdkOS9keXhVYmRuUVhaVWJnYnFGNHFSMXQ2T05ub0RHWDI1YnNG?=
 =?utf-8?B?UXl1Z3FjZEY5WDVWK0FVSmZ2bGtqbnYzeGpsZEcxdWVzRTRjWCs4cHJIakdB?=
 =?utf-8?B?K1lsU0I4a1RiSTJWVVBLZ2NuREIySWZaeVNTTmdvT2FnMnltV1VRaURXbmI2?=
 =?utf-8?B?V2paVlFiaWFjU0lPRnJIS2lIV2hMUDRKVXp5cWRDUVpTa1NJS2VVWlpsbFZh?=
 =?utf-8?B?RWRTUjFCa01ZdFNuQ1dkZGN3Rk56Qm9WS29JT2dyTExSaldKU2hDa2ZJNmN1?=
 =?utf-8?B?WDVmN0gvMG55Wk5zSmlTVGh2dDdkVE5rbFN6dHg2VzZ5TFYrVUhPbEhTaUZv?=
 =?utf-8?B?TEZFQlFuVURwYTVOMFVQbFhnVjNsTVMyK0ozQUl0NUlEWnRJaWdMMldpVDJ3?=
 =?utf-8?B?Rm5RdjVhbGs5Wk55SE5zVWRZUG0xN1RCNCthS1pGV2dKZ3pNUFQyZlRISXc2?=
 =?utf-8?B?NThTc2pnVEloS1hVM0RNMG5OVHB5Ym01RVRTclgwRG9lbnA1RWd4NzlwQWlX?=
 =?utf-8?B?NUhkSldqeXJ1clBXeHAvaHpENTRXYmVQeUs1Yzl5dE9lTlJoT2p4OFJ0K2JU?=
 =?utf-8?B?SlUzSlNNWU04YTFXVkw0WHNuck9OV0NjQzhWRFU5ZmMyREZrMFhZTVRuVXo0?=
 =?utf-8?B?NGhjblpYbksyZCttbWZMc0JpZGQ0MlBoWEpSWWdPVUNnOTloRVFpK2plMDlt?=
 =?utf-8?B?RnBUZXdoaG5JSzBkOUgyM3pGRmVwNVdJdFU4ZEw4d1RZVzhCMW1odjBEUEJJ?=
 =?utf-8?B?aER5NmlDZFV4SjBIdUpZZ3BZbHNCUmVoWDFWbjEzamxDU2VCOGtRQkNBZUd6?=
 =?utf-8?B?VmZabnFhVjBNQkFGK0wwS09TcVB6d2poNFZiTElrc3F6ditpS1JocWxUMXc3?=
 =?utf-8?B?V0xaZHZRQUpyNTl0Nk1OVFdmZnhqMk43QlM1NXlNREUrOHlXdW1oSXlSUVhX?=
 =?utf-8?B?OEtKUmVJM2h1cUlpenZiN1RKSXdNQXIzR0RvYjRzQTlsdm5YTGkrYkd2b1R5?=
 =?utf-8?B?WlVkRUE1ZlgyaUVFb1YyVEFJMEJTNlpHelJNRGxrcC9tUzhBQm1CRHhNZVdL?=
 =?utf-8?B?S0JqUTFvaCs2cU5wTG5wcEtpcVczUkNJUkNmaURoOWk3aHJydVJZUGtkNm82?=
 =?utf-8?B?R3JOWkZzNlY4YU8zT0w4VEd2R0tHcHZuQmZEZklyc1djS0RRRWtYWVJ1UHdo?=
 =?utf-8?B?eTI1aTNyUlM5Z0RZczJyODNkOU1KWkQ2RERLT3RmbDFEZnFQSmdrQWJKMVpx?=
 =?utf-8?B?enRMRC9YbWw3QlNpTlNqb0JIb205TFdDdUVyTGpzK1d3c3pQaFA4YW1iM2Rk?=
 =?utf-8?B?TXBKNnd4R1lJd3FOVVRNK0xNSmJHb1ErclNqTWlkdDZEUjRsblQ3d2dweG5x?=
 =?utf-8?B?VXZudTVkZHhFZFlYUWZISTVack5sakQvNFA4L2VESXVPM1RTeUIyS2hBMkV1?=
 =?utf-8?B?TEkvNENBUnNnRzhLdzhuTVlVMTdvb0IxR2NmQ0ZmZUp5Y2doL09PcERRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmErQUl5RGVPcHdvakxuZTNQeUk5MWxJVG1PVTZlN0QzKzBaelcwUDE0Q0Q4?=
 =?utf-8?B?K0t1cnQvRHhHQWFmZHA0UGZwREo5b1VKbWRpSzZ2R1o0UnVhaFJIUjRyL2lT?=
 =?utf-8?B?L1lUdCtBSGhlWFhrT3pSOGFkZ0xrR1JWdVlaYVMzaDh3UDF1Z3dhMlpDSHBX?=
 =?utf-8?B?NVo1U3JhQ1VaR2k4Tk1IMml0OCt6OC9LZWhNamNVVllKYjlXWGJ2NHN5QkJv?=
 =?utf-8?B?U0Z4bGVYbHBiRUw5dlJzbkpNNFlhcFg0S3EzbTVnR05OYmhhdExBc3grRXNE?=
 =?utf-8?B?bEpqMHRVMklvUXh1TDQxSTQyZTBhc0g0a3pmcWNSRlJCUXVqNEpZdjFDMnc5?=
 =?utf-8?B?T1YxdWt6OEliRnpmZTRWWVRlVEpZc3NIZUJMSjdFSS9JRlpyckFOVkt5V2RX?=
 =?utf-8?B?M2hMWi9IODIzR1p6blBBckJtZmZWNENvNlBYMVZ5RENDbGZKeWRJc3kxSkxa?=
 =?utf-8?B?SUdPSVY0LzRveHJCZnZldkQvaTVtdFZVOWsxNGhaTWx4a0lCQXRaMUlXZm51?=
 =?utf-8?B?NjRyOXVhRkRwa3VvZTJHZVJjK2pjVE5pVlNPRkFIQkt2RzMwM1ZxcDA2M2hZ?=
 =?utf-8?B?UUI5Q052dGRoNnlyejl5cjNBZlFBc3l5L1AwbW9rUmw1UTh1UVErd0lRenZs?=
 =?utf-8?B?bWJ0RTBHVlNudXBUNzN6dzkzK1ZmcFp5bjVBQ3d5ZXd5bXB2MlRBajBHRkRx?=
 =?utf-8?B?aC8vazRscmhQNDBpdjNrbEpVclNaQWZqek9PVDl1cE0zZ2tMWFYwSWxNYkVs?=
 =?utf-8?B?UEE5MHVIRVNvSlRkNkJJSTJJUWw3QUNjbkVKUWNIZkdNaW85alEvQnZxZ0Rq?=
 =?utf-8?B?TjBlN29zd0l6R01XUUkzNGRuQkpUSlAyOEtjOWc3SHVYdWVJT3MxZGtsWlpy?=
 =?utf-8?B?dUo1WUN4aXZsMlZTazBxUlI1d2wrV3hCRWRoK04zdTA0RWc3eXJaZHdKT0Nz?=
 =?utf-8?B?eXh1MW8wYmNkNkhsMlg1dHYzOU5IMDBTZzM5dGQ5TkpSL1J0dmpHQ21IRndC?=
 =?utf-8?B?RE9UelpwL2ZtRWY0OFdOU003ZmtrVjhDN2F1dE56N3dkcXZlYlJOMlJHdFBJ?=
 =?utf-8?B?Mi9Kc3lhUEpHZ2w1ZWdCR2tRYWVPUVc0dE9TSTFUL3BzZVhvOVM0K2wrVUVY?=
 =?utf-8?B?dnpBNE5qMlBnREhNTndqNVkxVGVTbWlFN1ZyUDZBWGxYY044cjF2dzdIRGht?=
 =?utf-8?B?cm5COTZ1U2h4S3dwejY1Z3J4OEtmV1RNc2t3T3FmckNPbFBhOXVoL0ZlbVVK?=
 =?utf-8?B?MEw3UlpQMzFiRlcvalBnYjNDZlFrdHhzL2dmaERMSEZZNjlaZXhLZktBWGRN?=
 =?utf-8?B?SnlYczl2UkZ1N0NTZ013YmJDd2dicmFPUlhkakg0OXE3M3daWmlBdGVIalFG?=
 =?utf-8?B?QWk0c2hLOGsxU2craGZZeS9DY0R0WDBsUWJWSEZUZFR0bW5GSXk2VDNHb0c2?=
 =?utf-8?B?MnNTNm8rcnl3SkFsRDlRZW9GOU53VFpiSS9JWERmVktBK2thVjNlelZZWnE5?=
 =?utf-8?B?OG05OGZkMXN6WkVMK2NBZEEwQUtkNlJ3ck1BcWY0MjhqZkF4TEl3MEFjQVhO?=
 =?utf-8?B?WUh2aHo3R1RYSGV4OWFzZmpCWUdOZVRlRlBvV2lUU2FaZVh0STQwZnQ0Mm9E?=
 =?utf-8?B?RXlOelJIMWxiRS9MTHkwNG8vK3BmR2s4RFlLM3B0cjRXZWJteWJTRGxwdkF5?=
 =?utf-8?B?cWRnSkE1UjZGUXNuZ3hTQnlCeGlvN3JZV2cwTHpQUmI4T1h4N1ZMdjNEeHhJ?=
 =?utf-8?B?VzFZQU9MbkpwZmlEOGhvVDg1Y3pZVUdDOFN6WnBsWkt0Z2Q1TDY4N2NscmN6?=
 =?utf-8?B?anlFaUdOYmk0b0xBK1dpdHMyQUJUcHlNWFlxY1hlTllsdGxzaTljV21KRFVv?=
 =?utf-8?B?NE4zNWlkUGpHZzlmVXQ0Tko0M3R5MXhySE5FandBcHovM3lUSzZINVBCQkdV?=
 =?utf-8?B?dm9yTXF2Qjg5L3IrdnlmUElQb3JlVXI4M016UldrVEtEaWY2U2lFTHhEWEcw?=
 =?utf-8?B?b2hVN0UyM2lTQS9iYkQveFZ6czFGMkxrWWFlQ3Q5azlGSHF6bTBGNnFENTRo?=
 =?utf-8?B?S210Q0ZjS2dpR2drNDkxRUtocm9ZVkxSdkdGN1UyYXZnUkNlT3VnT2tiTEUv?=
 =?utf-8?B?N1RtcDlKRGZlTUMvUkpsek9BZ3hOa04rdzM5QkhKS1JoSElGYUczRm94NDF3?=
 =?utf-8?Q?lnxWDlMS5tiQIza7uuWxXD4=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be17d4ff-0cfc-43db-e82f-08dc87957f18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 08:32:13.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nz739HbrFtqdluTLr6gzsNqZ8vaPJ4it932n2Gsw2SpyH7FyhJICEQs6X3qs2Lt5AeyvvdJA4G3ygWXg8BpibZJrrsl+jQ10sfXxw73ygTyRG4t9BlfTFfhO8pwLUvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8330



On 08/06/2024 06:14, Guenter Roeck wrote:
> On 6/7/24 09:47, Chanh Nguyen wrote:
>>
>>
>> On 08/05/2024 23:47, Conor Dooley wrote:
>>> On Wed, May 08, 2024 at 10:44:34AM +0700, Chanh Nguyen wrote:
>>>> On 05/05/2024 22:40, Guenter Roeck wrote:
>>>>> On 5/5/24 03:08, Chanh Nguyen wrote:
>>>>>> On 25/04/2024 21:05, Guenter Roeck wrote:
>>>>>>> On 4/25/24 03:33, Chanh Nguyen wrote:
>>>>>>>
>>>>>>> pwm outputs on MAX31790 are always tied to the matching
>>>>>>> tachometer inputs
>>>>>>> (pwm1 <--> tach1 etc) and can not be reconfigured, meaning 
>>>>>>> tach-ch for
>>>>>>> channel X would always be X.
>>>>>>>
>>>>>>>> I would like to open a discussion about whether we should
>>>>>>>> use the tach-ch property on the fan-common.yaml
>>>>>>>>
>>>>>>>> I'm looking forward to hearing comments from everyone. For
>>>>>>>> me, both tach-ch and vendor property are good.
>>>>>>>>
>>>>>>>
>>>>>>> I am not even sure how to define tach-ch to mean "use the pwm 
>>>>>>> output pin
>>>>>>> associated with this tachometer input channel not as pwm output
>>>>>>> but as tachometer input". That would be a boolean, not a number.
>>>>>>>
>>>>>>
>>>>>> Thank Guenter,
>>>>>>
>>>>>> I reviewed again the "tach-ch" property, which is used in the 
>>>>>> https://elixir.bootlin.com/linux/v6.9-rc6/source/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml#L68
>>>>>> and 
>>>>>> https://elixir.bootlin.com/linux/v6.9-rc6/source/drivers/hwmon/aspeed-g6-pwm-tach.c#L434
>>>>>>
>>>>>> That is something completely different from my purpose.
>>>>>>
>>>>>
>>>>> Based on its definition, tach-ch is associated with fans, and it looks
>>>>> like the .yaml file groups multiple sets of fans into a single
>>>>> fan node.
>>>>>
>>>>> In the simple case that would be
>>>>>       tach-ch = <1>
>>>>> ...
>>>>>       tach-ch = <12>
>>>>>
>>>>> or, if all fans are controlled by a single pwm
>>>>>       tach-ch = <1 2 3 4 5 6 8 9 10 11 12>
>>>>>
>>>>> The existence of tachometer channel 7..12 implies that pwm channel
>>>>> (tachometer
>>>>> channel - 6) is used as tachometer channel. That should be 
>>>>> sufficient to
>>>>> program
>>>>> the chip for that channel. All you'd have to do is to ensure that pwm
>>>>> channel
>>>>> "X" is not listed as tachometer channel "X + 6", and program pwm 
>>>>> channel
>>>>> "X - 6"
>>>>> for tachometer channels 7..12 as tachometer channels.
>>>>>
>>>>
>>>> Hi Guenter,
>>>>
>>>> I applied the patch [2/3] in my patch series 
>>>> (https://lore.kernel.org/lkml/20240414042246.8681-3-chanh@os.amperecomputing.com/)
>>>>
>>>> My device tree is configured as below, I would like to configure 
>>>> PWMOUT pins
>>>> 5 and 6 to become the tachometer input pins.
>>>>
>>>>         fan-controller@20 {
>>>>           compatible = "maxim,max31790";
>>>>           reg = <0x20>;
>>>>           maxim,pwmout-pin-as-tach-input = /bits/ 8 <0 0 0 0 1 1>;
>>>>         };
>>>
>>> Why are you still operating off a binding that looks like this? I
>>> thought that both I and Krzysztof told you to go and take a look at how
>>> the aspeed,g6-pwm-tach.yaml binding looped and do something similar
>>> here. You'd end up with something like:
>>>
>>>          fan-controller@20 {
>>>            compatible = "maxim,max31790";
>>>            reg = <0x20>;
>>>
>>>            fan-0 {
>>>              pwms = <&pwm-provider ...>;
>>>              tach-ch = 6;
>>>          };
>>>
>>>            fan-1 {
>>>              pwms = <&pwm-provider ...>;
>>>              tach-ch = 7;
>>>          };
>>> };
>>>
>>> You can, as tach-ch or pwms do not need to be unique, set multiple
>>> channels up as using the same tachs and/or pwms.
>>> In the case of this particular fan controller, I think that the max31790
>>> is actually the pwm provider so you'd modify it something like:
>>>
>>>          pwm-provider: fan-controller@20 {
>>>            compatible = "maxim,max31790";
>>>            reg = <0x20>;
>>>       #pwm-cells = <N>;
>>>
>>>            fan-0 {
>>>              pwms = <&pwm-provider ...>;
>>>              tach-ch = <6>;
>>>          };
>>>
>>>            fan-1 {
>>>              pwms = <&pwm-provider ...>;
>>>              tach-ch = <7>;
>>>          };
>>> };
>>>
>>> I just wrote this in my mail client's editor, so it may not be not
>>> valid, but it is how the fan bindings expect you to represent this kind
>>> of scenario.
>>>
>>
>> My apologies for the late reply.
>>
>> Thank you, Conor, for your recommendation!
>>
>> I spend more time checking the aspeed,g6-pwm-tach.yaml . Finally, I'll 
>> support the child nodes by having different tach-ch values. My system 
>> is designed similar to Figure 6 (8 Tach Monitors, 4PMWs).
>>
>> I'm going to push the patch series v3 soon.
>>
>> This is a brief binding.
>> ....
>> properties:
>>    compatible:
>>      const: maxim,max31790
>>
>>    reg:
>>      maxItems: 1
>>
>>    clocks:
>>      maxItems: 1
>>
>>    resets:
>>      maxItems: 1
>>
>> patternProperties:
>>    "^fan-[0-9]+$":
>>      $ref: fan-common.yaml#
>>      unevaluatedProperties: false
>>
>> required:
>>    - compatible
>>    - reg
>>
>> additionalProperties: false
>>
>> examples:
>>    - |
>>      i2c {
>>        #address-cells = <1>;
>>        #size-cells = <0>;
>>
>>        pwm_provider: fan-controller@20 {
>>          compatible = "maxim,max31790";
>>          reg = <0x20>;
>>          clocks = <&sys_clk>;
>>          resets = <&reset 0>;
>>
>>          fan-0 {
>>            pwms = <&pwm_provider 1>;
>>            tach-ch = <1 2>;
>>          };
>>
>>          fan-1 {
>>            pwms = <&pwm_provider 2>;
>>            tach-ch = <7 8>;
>>          };
>>        };
>>      };
>>
>>
>> As your example, I saw the #pwm-cells = <N> . Please let me know, 
>> what's the purpose of this property?
>>
> 
> It is the number of fields in "pwms" after the provider reference.
> In your case it would be 1 (the index). If the pwm has additional
> configuration parameters such as the frequency or polarity there
> would be additional entries.
> 

Thank Guenter very much!

Please help review my binding. I'm looking forward to hearing any of 
your comments.

I'll update all comments on patch series v3 and push for review soon.

The patch series includes two commits:

[PATH 1/2] dt-bindings: hwmon: Add maxim max31790
[PATH 2/2] hwmon: (max31790): Support config PWM becomes TACH by tach-ch


Thanks,
Chanh Ng


> Guenter
> 

