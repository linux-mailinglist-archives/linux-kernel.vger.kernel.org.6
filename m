Return-Path: <linux-kernel+bounces-295759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5E95A128
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712BB283817
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CF1494BA;
	Wed, 21 Aug 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAv2bgvP"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2813B5A9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253146; cv=fail; b=jV+O7Z86oMX50iUiFZfwPSkjrGeU6+gcB4J9q+wiSSyFvEHh0cD2Bm87u/Yy6sf8QGZzY6iWiMTzi6bowTlxApYM/MTmZuxHQ4LdkFH29VmwzChgHfySeCrvUPKfjzGG+Ikj9L7vgMR4pGOwlMZ+5YbIxUbsdmzUltFto32h5hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253146; c=relaxed/simple;
	bh=cVqNv6Mk22QybRZ+PxNJSzrvPYXQVAsALH4N/HoK248=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJsNnwhY8WXwTzkk+//qvA/jM7BONY3kQpCMmFHyE1bJVPdowrwKW6CLE6UMcSdI2ph0Ay//hlz9t1yELO9gvqhLLwmYbHNmjefi2hJO7DCX2CGeS9bT/ibrKhZ6kQ246A2pq3xK+ZJFYq50S06sYWdmq/kaFs3HnIqtrb6cKfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAv2bgvP; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxhpQo/UF9c7BQ+oZx8jLBRuBMxsw43y7TOn4TpL1abQZtelm1T0QUt8TqaW5LCG8rsARZ8BHE3QtOh4bq0Fk4DQBhToyXA0ZQWhOY641bQUTuCul82+aXXVQrujxFLCz7hxrCHWdOSK+qYTitFzd6c3Aj/5bQ2AM3oH7JfO9LoyOt5w/bte6rZ1uhoDXOk+VzPjX8mobkjiPgiPrhsBU8kt/dMEDoLZWVSrpg/XlmIzg1BbD9XiZclhBBIa8iVVyoKT4YnHF5LtOSq74lp8uBj2QlJOuI0ko0TMwqER3luljEC7b24V7KpjCqMEdhMBALVy2DIBlnQv41k0w4KGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=839NL4DhzFAuW+x1NPL8/ty4Wp+m3aVvJ5breijnanE=;
 b=g4zEtt/ybeHcIuSbMWO4Cpu7Oh3fF+VO4VoN5Vav1jEkJJUgOl55nYy7hp81BKm9JfNQnrKDC3R4yD3YSS4yV5jtqAlHvYao2d0zmMqP0jN0XjmjusGIX7x0/92cc8WjBT9jUDTlWaoeQXfb0gsKGeODAUC+E3I7ZFmq5Lx23p3z1knMmKFNXCS1zcYXnScdS+RX6w7eDpgfyB8E+2/JnMMmjLsyDjXaMASb+3UNH9kM3aCklbWjck/QvvKLsPOTB/22CR5k4w7S3JmFh/upeyTHatPZSMcOK4HqgFOSDqfGiXZsrC+BQwxszq9HGISz18ThFe0isEc6JOpMMTptWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=839NL4DhzFAuW+x1NPL8/ty4Wp+m3aVvJ5breijnanE=;
 b=KAv2bgvPjrmajJWR1gopdgdwUZMftNJFpQcSswrY94pKeaWrWjghdzj7Nkd7UJZR3NPDm1Jx7LUR9pyr/39Qm7DA0XODMwGORZpLNtu9msnbd6N5I7uK6nxeSSwgRLKnPRBE5ohAdJKBotiOr0/S2/CAe/79HEM3i+2RP5xJlck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 15:12:22 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:12:21 +0000
Message-ID: <236aa6d9-bb5d-4854-86e3-5473f5ea6337@amd.com>
Date: Wed, 21 Aug 2024 20:42:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C
 Support List
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
 <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
 <ZsXyHfLJ8SJOW0RF@smile.fi.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <ZsXyHfLJ8SJOW0RF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::6) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e357bd7-8266-499b-e6bd-08dcc1f3a739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZyVzFidE9GOSs1aHdiaUV3cDFwYUhhbkZBakk0anNMeXZwVXhJb3hMejB5?=
 =?utf-8?B?bmF5QkpXQ1dnRUE4b0pTZ3UrS1ZjaENCbldCSWVxVEhtN2tyZ1RTejR6S0pF?=
 =?utf-8?B?VTkxbnBLdlhOU0ZNTU1TZnJUeUhZUi8rZG42SUM3RHV2RGFaMHR0NU11aEtu?=
 =?utf-8?B?dDlTVFJJNW93R0FSLzNCTkFzbVNqUjhxUXRqWjNYOSt6Ynh5dFU1YWFwaUlt?=
 =?utf-8?B?amRHcWVyU0l2WjMwbXZwbzdUaytwRVM0TXJVRnB5QlE3YW1wR0llL3Q0Umpn?=
 =?utf-8?B?K3djd3JoU2NYUnZRVHZleWNZNVpxaW5hWkJEUGE1V2tkWEFvZTFQRCsydjYw?=
 =?utf-8?B?Mk1jZmo1NTNmMk5qaE4xSnhvcWh4azhQLzRVUDVDd3JIMFZIRFFtN2tENkVL?=
 =?utf-8?B?WXNEZnFUOHkrRGM1L08zZklnVmlXeUlpc0Zvd05aNGZzRnRkYXh1czRjMmIz?=
 =?utf-8?B?U2UvZitrdFNJRUpCakVjblQ5TFJvS3ptWXB1WmFlbUswZ212UmFncDMzYnd4?=
 =?utf-8?B?ZjlrS0RFNHcxQ1lqRE9oZ3dQTkVrRThhRllULzVuUXgraTZOTlh1V1hkd1pG?=
 =?utf-8?B?NW9TTUJnQkVsRURPL2VrMlNRMmFrQ3haak02cnlkektDb0h6YzJ4Rm9hN0x3?=
 =?utf-8?B?NGV5b25vODl4aUVPNTNPOFNuTXEvUXVLSFF5TGk4Zjl2dVl4cmxESW9RU1Mx?=
 =?utf-8?B?SXRtWWFzZ1lObWFtbm5qdTMxUW1BZnV1RDZ2REQ3Nkx5NCtkVkJGbXhUSlNr?=
 =?utf-8?B?aDVzMFU0RTJWT3RDZ0d4OVc1SXgxMUp0bzRkMmE5UmN3TjMvdVNTeGMzdTJ3?=
 =?utf-8?B?Zjlya2QxaitwRTgwZ0ttNC94bGhyeDNUVFJnek9hSWpDVnF6clpjNUVRTVc4?=
 =?utf-8?B?SVkzc0RwdGdlV2tzbFJ0R0V3cjhyQ3h5WDlkUzhJdFBoQkt4MVBGajNkc3cw?=
 =?utf-8?B?ZUtXc2FrcjdVTnY5c2Q3OGdzVEo0M0U5QzN2a3c2WExWOTU3T3F5NGRWTXR4?=
 =?utf-8?B?bFhPc1hpcUNXaWxzRFNJQWVmYVFFaS9FcHZnNGlEVEpxUFJuTU8vcVNxMVNi?=
 =?utf-8?B?djZ3ampKTzJ1Rk5RaWJKNVRIek92d0pqM3ZpMmZib3FTU2dLQ0cwVnlreEhW?=
 =?utf-8?B?YzJPREE3WERLK2pSTEhodlM4YXJkc01RbDhGQS8yZHBiRCtGQXh2QTNUazZt?=
 =?utf-8?B?ekR1Uzdjb0xyZ2ZUeXg3WkRJY2MwQ0hkeTZIOUtZUnhkWFAwUlRlQVBTNXg0?=
 =?utf-8?B?MjB3MUxRdDNqTXlIUGgrMlRiVDNVQkJrVDhmVzNIaFhZcmJHREZHY1krWFN5?=
 =?utf-8?B?bG5paVovUDErZVVrNVc3YklnV1dzYjZ3SEN1SXcyY0M1L0Y5Q2R0STdzMnFy?=
 =?utf-8?B?SUJpTE02UmhGWjluejhrVERIQ0hUbjhMTURjeWkrS2hXRWRLVkJmdThScXZX?=
 =?utf-8?B?THF2UzVFc0VKb0hVejlmc2dpa0NOVlhkU2tNQlJpY1dvZytQL3IwRlBITjlC?=
 =?utf-8?B?ZzFaY0pnSHMwKzRKcVlwUkxtK3lGcVhrbEdxdFZRbjQ0dS8zRDNEckRCS2ZD?=
 =?utf-8?B?bEZ0YWpLVkE3Sm9GYnhxT245TlpTR0hZVGwvSGlJaU9pcjFGVHYyd1NaZ01X?=
 =?utf-8?B?RGNqNlJoMUZLTHQ5VFRyTmo2ODhsWEdjZ0h6L25JVG54SERmNVM1YXhNQU5r?=
 =?utf-8?B?WUk2eFp2SS8xaGttUlZzVjFFNVZxTzJ6NGp0YUI4a3FnWHBldkRlOUNnWXdh?=
 =?utf-8?B?dDZDN2lwVGxJWXRnQ1MvaFBVRjhaYlVzN2M3eUxuanp5WEN6M3U5MG9VUU9V?=
 =?utf-8?B?OWVmcGJUOGZmcDhDUzFDdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djBDKzVlZXAwelJQNURyWUwvSm9PRW42V3dweTlYM1dxR1BOMWxWVmdPenpB?=
 =?utf-8?B?d2toVHpKL1haT29WNFZ2Q2ZhaUd4czBGclB0VGdwNkcydEduNVFHOXkxcnJu?=
 =?utf-8?B?V3d6ZFVjM1BYcHozaGRidVQ0TW5EcHZqZW1WMUxuRGk3RUxPSm16OVNhVVkz?=
 =?utf-8?B?S2YxVFpDMmJIUFV5TzJlVFJlSzhvc003Y3dXdDhmRHpWUWVXSVBSVXNhRTg1?=
 =?utf-8?B?NmpOWHo5OFBOb0VBNGhud3VRcTZ4azhQZE5zRGVHY1pidEdoVVVTME1DMjJr?=
 =?utf-8?B?Sm13cy9tZ1huTm5jdCtHVDh0WTBtbU5QMkdxNThHTVJQZCtOZGlFVHYrSFFG?=
 =?utf-8?B?bDJjWkVCNXo1a2ZwZlhRM0hhaVlJT29VcjVyV0dLRmpCQkJsbGxkbHo3UnhJ?=
 =?utf-8?B?NzBZZmJtNm8rL3dNVHVORjdycS8yRHZpQlJ5UEpPblhjSVk2N2lMdFpqdFMv?=
 =?utf-8?B?STk4S1lwNWRZeFBGaG9SRDVibVRybDB6ampoSGhrYUJYUlVWYVZzUXpyelAz?=
 =?utf-8?B?bUtxbU4wWnpyWms3QlZqSjNiVjVObDVUZDcvUGt1T0NFUEFCS2VHY2doSU0y?=
 =?utf-8?B?ZFo2eUpMKzU0WDRzaTRtUGlVRnF3YWVlR3YrYkxaQWVDdHI0b3hrMkJEdC9Y?=
 =?utf-8?B?RG53NlBCbVp3aC9JMTUyQ2R6UnpVMEo0eTFoYko2aHo0SjJoaGNFYWgwdjlZ?=
 =?utf-8?B?N3lIS0pzcFdaK2g1bC9HdUNCOXh0WnlCbS9MTzdLNGZyVmFwUkxlYlJobkNk?=
 =?utf-8?B?MWxNYXJXMm5EM0UyaExmUWVXSWVVZFZ5cXBlRVo1UjFqQkpNM1lXanVweTY3?=
 =?utf-8?B?YlJGUEpVN1lsVHZ3a0hKcG5kRmFkclU3Ny8rRHhEdFR0dm40U0l2V05JWTFw?=
 =?utf-8?B?NFFVZDdMMU01Nkk3SE9nbGZTV0I2VzE5VkMxZTJPK0hrMEJsVnlyVVV2OFFT?=
 =?utf-8?B?VTFTcUE5a3FVWGVqeGRraHRPS0ZuQ0RDNkVTYjU1dzhFMUZEcU9ROGtPSVRZ?=
 =?utf-8?B?VWJmbXE2TVpaRnZLSFQzRDNWZDl2bnlwMnJ1RFVMVHVJdGRRNzRoTnpyTG9T?=
 =?utf-8?B?cXNGODJYWXhJOUN4eHJhbkh2UTNualdGZm1QTktrYVRTTkF3emVoVzNWbFJx?=
 =?utf-8?B?bzdRMEF1S3VEOTFFcDlGV0RqeFpsT0o1eXl1L3VIdnR5SVdHaHBnWUJ5VWNx?=
 =?utf-8?B?MStBOUxtUXRZOFF2SksxVTFFajdVU1RSdXZ1alBORXRxa3RUTHkyNm04a0Rp?=
 =?utf-8?B?bm9RR1Brb0EyeitoTmdXRmI1bU53V0kwOTVJSm15bEZMY3A3SlRxVE1NYVBS?=
 =?utf-8?B?Wm9jTkdLTFpndkRyd0hIMTVRdGpnajdBd3dHTUhYdFFxUHRmQWI0YUw5OHdv?=
 =?utf-8?B?VnV6Z0x3Uy92N1lNb0l2VFNyYkRQZ3hKL3FrSE5yN09tVlJORUFYSFBjZnhQ?=
 =?utf-8?B?OXVMbzFja3c2Y3dxUVFXbzVqU0dwaWtIODF2TWp3MlluSURJWGlJNG1pRG92?=
 =?utf-8?B?TGlVdVRrUHNYMzJIa0UyZGNtek1OV1p0U0RheXBPcTg4ZVBmcnZSWVBuUXd6?=
 =?utf-8?B?TWoxS2dWYUJ1NGFJblpuTm1BaUlQSFdxSndEVWRpTGExVis3bHAraWFYL2tQ?=
 =?utf-8?B?dmI4eXBDN1hpcE93RjMyMXFEZzQwM25hUlpjak9wdngwNEtUdXFlT2s4djhJ?=
 =?utf-8?B?MHAvZmdhV1g2Zkw1bDFJZmE0UkkzMVRvdHYvdmMva3FEanNza0Rvd3UrS2pT?=
 =?utf-8?B?ak94RkJNV1ltWmdvYmhnRkpXRWFzQURBUUY2MEJVV2FVOTZnQzRYWlNpWDds?=
 =?utf-8?B?TFc1RkZpQWhkK3o2aHorS2NGNnNGc3kxdW9VNDZER0R2MzQ4RWdrdzJFTnkz?=
 =?utf-8?B?d2pTdXk4aGcwM0FkK3REOHNRdDJ0RG5QdkM3MVJwZXA5MXVKZDRrSlZGdnlZ?=
 =?utf-8?B?OURiZlFTZGdRWmt3YmJwb21pQm1KVTFEYjliYkZFWVBBUXR3dE81ajJHdmxX?=
 =?utf-8?B?R1Nyc1NqVnh0amZnWFh6RlFrdnkxdm02QSs4U2NZTzhlOEN5a29FckdqMmFr?=
 =?utf-8?B?Z3hzaWp6TS9vRGFTWnNPRkFqSW1LUWV3K05JQ3pCcDhUSUdkcWVuWjNMejJG?=
 =?utf-8?Q?6SPT1limI3fi1lJyqceL83jb8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e357bd7-8266-499b-e6bd-08dcc1f3a739
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:12:21.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCWEDXrOqojydBtfHSNraGbMCg7gPZo3x0It2P7mvPOip/i3R0aEvHptizva7ObbA04ONz8P6XJLwLwXKnKaHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856



On 8/21/2024 19:26, Andy Shevchenko wrote:
> On Wed, Aug 21, 2024 at 07:07:45PM +0530, Shyam Sundar S K wrote:
>> + Andy
> 
> Thank you!
> 
>> On 8/21/2024 19:05, Shyam Sundar S K wrote:
>>> The current driver code lacks the necessary plumbing for ACPI IDs,
>>> preventing the mipi-i3c-hci driver from being loaded on x86
>>> platforms that advertise I3C ACPI support.
>>>
>>> This update adds the AMDI5017 ACPI ID to the list of supported IDs.
> 
> Please, provide a DSDT excerpt to show how it will look like in the ACPI
> tables.


    Scope (_SB)
    {
	...

        Name (HCID, "AMDI5017")
        Device (I3CA)
        {
            Method (_HID, 0, Serialized)  // _HID: Hardware ID
            {
                If ((I30M == Zero))
                {
                    If (CondRefOf (HCIB))
                    {
                        Return (HCID) /* \_SB_.HCID */
                    }
                    Else
                    {
                        Return (I3ID) /* \_SB_.I3ID */
                    }
                }
                Else
                {
                    Return (I2ID) /* \_SB_.I2ID */
                }
            }
	
	...
    }

> 
> ...
> 
>>> +static const struct acpi_device_id i3c_hci_acpi_match[] = {
>>> +	{"AMDI5017"},
> 
> Spaces are missing
> 
> 	{ "AMDI5017" },

OK. Will change it.

> 
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);
> 
> ...
> 
> Otherwise LGTM, thanks!
> 

Thanks,
Shyam

