Return-Path: <linux-kernel+bounces-295681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB4959FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECAAB23EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C871AF4CD;
	Wed, 21 Aug 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MY9sjYDl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAB763F8;
	Wed, 21 Aug 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250845; cv=fail; b=jYkCDRbSaYgCqNojODpFkrIx9R+64O078NuWPG1tlfnoYgMmI/E8ev+/f2dSAQSUoOPB6X2CMusIPwWfmUCEtxazoIPrU6GOo7dRsr59VXWqeIFeHx1JOczb20CDo+Cfw/T5YmahmEfe7ORiTgJW3laTBgubGg2ABumv5ueOXiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250845; c=relaxed/simple;
	bh=4bU80ChhEJX48fFT4aL9JBrCm4ClI9CK3l569s8ZmO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MvX/oC5KydM1G8Cy2UqgKukkrEYifWI+Y2X08GusyOoZO6/8YRn6fqhU0oaVAXQp7dDVRM2ii9Qh8W1lJI4b+sn3ESnacFLscGgzXMHGDXUI4GSieK8+VUrVSg2+o8zf0WkNFeJUa+x7XTjV7HNUKXUERqJyvpq+E9Pzyhv6kUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MY9sjYDl; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XomUMsvBGlkFglAyAkuXEw84XYeQvXcT3n+KT5PiAlGKDvVwKN7dUoa3jGgm1J2Y2j/zkfqoTfsy6+WEY4EttEL2mDcbuCDHZyUnpWIvlt9a2lyMlEqt96/Vh7mIAb1SgbSgJem0khTo231DpsJlWbaHQcpEsQEvt+eqnhtBS7tx4GeT/2dbrG1X+iaUMXPxxHmIATY4odsgtcU9wu4Nx8tufbe4uCT9xCIw4NpmsDi2lc2gBu5KD5TigTqk8fGBYvAhksyo89GmY7X6IVTyGf5pLsE9RZeUSpbW6VF+595SsZsYOyiFc31YV0LRlw8LXATHkmzUmV0046xzQ2auGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dozAPa2PPjD97Ah21fCho7bOf2dfA0psIG4lHNLGlA=;
 b=yzAA88z6uCDp5qwqv0ZK9pb5a+2zJqGleFt3QrJV6Yfyt0o0UtVQggjEw9TsJjMGlIfqakZu+KEk3e7C0xnLDx2Rs2vt5njUk2+8YvHxVBn9cOvyBdLCXXwsqUq6jLKHOHNuoqQoGa8ZygZBbqs7/0p+t9cst4rU5LbZDF0YRHAJdpVm6u1OEMFZ/T2gb9MiCvGCyHaEFMNR5ch7G9eDmBQuS57+4SPQr7LJXcE1AMhObX2rg6Ga0AiQhOh7BsxgBu8Sdde2dqVTOOhdIeWSxNBW+z/jkmL7TFyzYLo4ibjs9faFWjNOtbB24k+OU0DlvEGkA8iPqcK2MneMMnbjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dozAPa2PPjD97Ah21fCho7bOf2dfA0psIG4lHNLGlA=;
 b=MY9sjYDl8QxlTTi6WglBAw6i9UTqFVhxlQF6A182UHaAG/37VmFb9JqpUKKKQjZObOIGJ5fLze5VEZ+hm7l7aJ3KvWIc7vVqU9ck5uRqVhwHW0VqMYqVUgK1ld6ZBL6cp5wjiugefWCtHnjTr6v8UkYBEplcawroQr5yEKSUkc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 14:34:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Wed, 21 Aug 2024
 14:34:01 +0000
Message-ID: <cb08e5d9-17c1-457b-af9a-a172feb5e72f@amd.com>
Date: Wed, 21 Aug 2024 09:34:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (k10temp): Use cpu_feature_enabled() for detecting
 zen
To: Yazen Ghannam <yazen.ghannam@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240820053558.1052853-1-superm1@kernel.org>
 <20240821130916.GA1062@yaz-khff2.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240821130916.GA1062@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 4911214f-d6e8-434e-76f6-08dcc1ee4ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak9sanBCNXdLdThHbFRpZ0dNbzJENkxRNGVBVytacWxEUUlKVzJhWXpsa0k4?=
 =?utf-8?B?ejhwa1F5ZEdpaW9HQ1Z6NklvQVdoL09xY3Z1VUNXbkFuNEJWYjBHZU93SGRu?=
 =?utf-8?B?WHpCYzJoVFN1QnZrYUE3a0xwS0gxdEdKYk5vUXZFSlExQzlDTW1Yb2E2NW50?=
 =?utf-8?B?dWJ0eWpuUE0rV3Z3T3JYT0NMbkVkYVM1M21YdW1SQnlyVkpmdFZ4Qisrb3Na?=
 =?utf-8?B?NkhmVUdYQTdLbmVXNnJ2TFBaSFQ4L295MXAwejJ0dG1LM0R6TURwTWJMZndn?=
 =?utf-8?B?VEhucFVyallXNU9tVy9jWk5OdzB5V1o5UTBiVVNmZ1c1REkzZExCMkRmMTNR?=
 =?utf-8?B?RU9rSG5tTllMbWsvaFk3R0NYWGg3a3RYYkJxanJ0bVBJd24zdDZMdldaeWt4?=
 =?utf-8?B?OG5Wb2FudWpNUnNSNk5Jb0lHb1ZXQWltQUtiWk9NRmZQTGJIVHJkL09yRFIr?=
 =?utf-8?B?N3lqNVRTVFV3OFdCbDlWQ3Y5TlRQUmZIVEVSVmNSZ0srUDl2dDdKUnlNN1I2?=
 =?utf-8?B?QWg5blJ6aU9ua3dUK2lEUWM4aFJwZkRPWnh5Q0J3RkxJUmZsNmlGTXl5Z0N0?=
 =?utf-8?B?WTF6YWI5RDJKSk1PY3dVZjBPNGc3ZDNGbzZpdSthM0JLd1NTeTBhUGNOYkc1?=
 =?utf-8?B?eTRjWVpub0VLK0FCUCtXTnU3Mis2ZjBhV0R5bmkvM0JGSFA5enJ1WllpcUVF?=
 =?utf-8?B?WE5wbkJ2YldtRUNNWGJKdkxsSGNTcXRSV3g4VVVZekFTZisza0xXZ0hkcTZu?=
 =?utf-8?B?ak00OXpPR2NBc09lQzI0a09NUDQ0MWdxQjl2MkpEUklpNHZUZHZNQWszNzdZ?=
 =?utf-8?B?NG5WNHI0cXdqME5tQ3QrY2Y0NmpxUCt5Y3lNMncxWUtPSzBseEVLNU4vaW1M?=
 =?utf-8?B?d0tPSGxrZ0NkZ3hmbnpXL2cwN1FzNTNkZG1Za1NYUlRCOUxCbVVxeitXUnp1?=
 =?utf-8?B?K0RMZ3hhWUs5ZDV5QzVHekxOZVdnTEVLVCtxUnJ5RzQ4ajA1Vi9seWU5d3pp?=
 =?utf-8?B?Nm1aM0prVGlIcEZkck9OTnJLcTVBUEhsUFFnM1kxdEx5U0JqamZwa0QwQ0ND?=
 =?utf-8?B?OXVORlEveFdpc0twdlJNbzdKMXZGTnRyZkk3bEgrTG1UdlZzbUFUQUR0T2Rt?=
 =?utf-8?B?SW5ZdmZnOWZlTVZMdEV2YWQ3WjlETGlLUm1GUmY0M29WeXJuWlU5UVMvZmRp?=
 =?utf-8?B?anVhSTVLR2tSK0ErWEtTQUtaTWJiQVdqakxXTExCVHBmTDdHcWxNTUgxVlA5?=
 =?utf-8?B?THdSTmVGYnNRaVl6aHl2UktYc2YvSnNVazhoOFdhTGYwRllkME9NekxOSkFx?=
 =?utf-8?B?WjIrVnZpcHBxRXRQMUVDYUNBU2xqdlFraHFPQ3ByaGQvNHdjY1VsRnRyTUxX?=
 =?utf-8?B?Yk5UOS9rbDMwcUprMVR5VHpCVWVkUGRSMVNaSFZ0N3VOcXI2VkhxcDc4WTBT?=
 =?utf-8?B?ckFHdmhhM05iV0QvOWhFQTIzTitXSDlnQW01NWpQSHV5dEM4U2Z1VGkzSUo1?=
 =?utf-8?B?aGptdG9vdUQxQ2xMQ21EVXFnZ3VhTjZ5eUp6T0ZGTTlNM29MRTU4V0pFanJK?=
 =?utf-8?B?c053ZWNNeXMzUi9tcjBsZUg2eXlaNHNzdWlnUGtEb2hUM2FTZVQ1TXJBdEVF?=
 =?utf-8?B?eVBYUXJYdTJQeXQyWTdhazJEYTk1Ri9EWTZwaXgvRG00ajRCMHcrWGJRTjFM?=
 =?utf-8?B?QTZGQ0NSN3pPdmpGSGFESFM2TkpTeFF5NXM0UUMwaEk0QmFmMW9KaHM1ZHpv?=
 =?utf-8?B?aFBZaE5FdmhsbXBzNXgvakFFTTFoL2thQVFvK1h3cUhvUFBOaW0rNFlKeWFD?=
 =?utf-8?B?cUJnTDVKT1RFRUF3V05MQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXp3MTg4R2ZkVlZNc1dWSUNVdHRmZDg0ak9ROS9NamN6Ui8rM0xaMDZBTEZL?=
 =?utf-8?B?cmwvbmF0WTY3VW4xVXNCZnBLOHcwT0NrRXZBeVVBejdJS0dFWlF0WmJDdytu?=
 =?utf-8?B?V01WcnVLTXZhQWl3L0N0cE9lN0V3T3pUTjMwb0MvdWsyUDhETmNxODdIbVhY?=
 =?utf-8?B?T2JSNGVtQjYwanVvalltK3FsWU81clg5emFROXVwSW9QeHR0ZVA1SjFqc1FI?=
 =?utf-8?B?UTh4cnFSV3ZtVkE0dmg0UHp2NkdUbzU3ZFl2anlHZWxpMXhJcStINCtJenZE?=
 =?utf-8?B?RkFFeDhrR0taQmcxYlZUUm5ZWXdGdHNoZ0Fwd3NJNXJES3k1NXdVVlVjcFcx?=
 =?utf-8?B?NFMzM1ZBYWVoWDB0c2xhVXJYYzRxVGQ5M0VZblVEaktmN2dpOE9YV0J5Wmsr?=
 =?utf-8?B?N1Q3Y2xmOE8vU1g3dCtyRml5WE1TczRrR0RrVUU4WXZwRTdHVzNlOUsrMFUy?=
 =?utf-8?B?cThmV0RGSXhycHEyOWt0QXFOMEs1RUlpVmFUdlZWeG5KQkY4YlhQUWU3elli?=
 =?utf-8?B?YWxuMCtQbE5XV1N0Q25BdjlVUXpleUpGTEtmMXlxTWkxRDhvYmFSeHRNMGtX?=
 =?utf-8?B?Z0o2bVc1MFlGKzVBS3AwUTduOFU4eHkrNVpOVHpZWkVKTkIvWUFzT1ZpRHpo?=
 =?utf-8?B?YXp5NWlMa2UwU2tPQVp4VDJiSVpnVVRNWW9TVStGQ3AwbTQ0NWRPNzNPeWpk?=
 =?utf-8?B?bEJPWmV2bGZYVnlnbExUTktYY0dUNjYvYVRqOExCZGdGcHBpRE9iYVY4cmlM?=
 =?utf-8?B?aFk4c2pCNFYyWG5FanVhODVPaHpUbHpRdnBsKzhQbzVXMkpmcFlpbEVOZVJ1?=
 =?utf-8?B?bE5TOHRhY0psbDNhUTE3YmNwMFluMmpvKzRTWGw1Q1NUMW9DMWlUWlFsUnhD?=
 =?utf-8?B?WGtTblNvViszS0t4dnJqRjQyS0VZUFhDNS9CMzdkZ1NUWVBKcHBjRmZVczMv?=
 =?utf-8?B?NFJOdSt5eGE0TmMycDZCbUtqUUNyTFhkNFJidFFOTXo5ZEhDWDhCRXJtd3FZ?=
 =?utf-8?B?TFZPR3ZVSUk1My9xMXJXdzl3L0JYT3REZzJGby84T094Q3J2cmM3U25WZVR1?=
 =?utf-8?B?ZUV3Zzl3QnJNa1pEU1lxb1pVN1pGd0FQbjZ2cEMzWCt4ZzBScXRGemhOSGxU?=
 =?utf-8?B?elRlVXQ2NXhwcFVIenlVTHZnRUxtSnQ1OEI2cHI5bUZQUjIvbE00SnZvM3lz?=
 =?utf-8?B?Q2ZsQXZIS1MwV094bXdzdzZMeDJHd3Bta2xzenFBMHhWODEwTURrR2RobFdw?=
 =?utf-8?B?ZHJJWjhBTVhyQm9uQkJIWGJFQTdvZUVDQjIvUHJKYnVhWk9UV3R5MUFIaTRu?=
 =?utf-8?B?aGJCcGFMOU43TXJibkg5N2ZkZ0dBUDVwdjVHeFFuWGRqeE9vRjRZanFPN1F0?=
 =?utf-8?B?Q3BpblBHbFoveC9lMU91QTkrUHNZemtBODJ2UldtcXE3LythVXhiUUR4UVNN?=
 =?utf-8?B?T2JCMDlibHRoNGxseDNPWjlXVTRpSDVManAxZjBCaXVoQjExOXpUN1ZjeVQz?=
 =?utf-8?B?dGUrMkhzTmp0enE3VHBnbmxjWHMzektEYlhnWHRrZjFyODMwREFrS2RmZXlh?=
 =?utf-8?B?K0N5SUpPaFhmOWhRSEVzL01Ec3lXWHg5clZRSmF1S21MVU9kQy9TS3VzU3h4?=
 =?utf-8?B?YzhjdU1mbWxIaStYUENyK3VYVmhHUnJuNWFOSnBUU3pQaldsUU40MXlxUGFY?=
 =?utf-8?B?SlJtcmo3SkZuZHhqUjFXWWxDdzBacWFTSm9RWS9mcTQ0YTI5VlFmMkg0cTNG?=
 =?utf-8?B?UjYzeWtGUWZXeThwOTB5NjBVWERwemxZdlAvQjdGQTBjdTAxVHBoaUtSam52?=
 =?utf-8?B?WldReXo4Z0JiUlZseWtXMWhSSFFSQjljSmRxek9SMUhZQ3VXNHdrOHUzaUhz?=
 =?utf-8?B?SWNnWEM1SmpMOWYzK1dudmlJTWhuenkwdHpMTDNpWEZrOHlEUVVINi9FaVpO?=
 =?utf-8?B?RzM5Z2NVYkJyaW94R1JTTm9DTUU1QTd3cW5GUTRHcEpGMi9sRkhYY0ZDK2JE?=
 =?utf-8?B?QmlHenhmbHJiQ2JiYWpPUDRVdkJtYmd1S2NkcDlVOHlWNWtuRzR3dERxM2pX?=
 =?utf-8?B?dkh3aVE2UWR5Z21ZdU9QWk5reGRnZ29SYkNxWEFHaHdtMllrN2NXajVnblI5?=
 =?utf-8?Q?kSK7H0E7Lg8Gdj8b0U22PchB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4911214f-d6e8-434e-76f6-08dcc1ee4ccc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:34:01.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7mr25ZRXIGLbvcYWO6l1rlferePy2JhQaM17yw4DxM5eMiKrNfpBhUHE0hXmfAKHcT2If4cGSnF9LZYVWEbNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350

On 8/21/2024 08:09, Yazen Ghannam wrote:
> On Tue, Aug 20, 2024 at 12:35:57AM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> This removes some boilerplate from the code and will allow adding
>> future CPUs by just device IDs.
>>
> 
> I've been thinking that maybe we stop using PCI IDs entirely.
> 
> The PCIe devices that we match on are internal to the SoC. And they're
> not optional. They're basically processor components that are exposed
> through PCI config space for software convenience.
> 
> Thoughts?
> 
> Thanks,
> Yazen

Yeah I think that's a good idea.  The one thing I want to make sure 
remains though is that k10temp automatically loads from a CPU modalias.

This is "tangential" to this patch except for the commit message 
reference to the PCI IDs.


