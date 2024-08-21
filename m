Return-Path: <linux-kernel+bounces-295965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A827195A3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9D91C22BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA1716C685;
	Wed, 21 Aug 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cdCiMX6V"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76713635E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260717; cv=fail; b=pLx0FssSyT0lS2Qh5kxGXv1drRfOp9lG4e3L7/nBDP8LKTDAUSBETB3mxwLdjz/xIdlzPqZLvj1aLqRcAU/4ECtAGYebQhae9VakKhSOsSTgpV/NTlQyJM7gMU2y9SchupQ0L6MtOnnkqbz7USgSQSAtT4z3D63hlm3cpFhZFZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260717; c=relaxed/simple;
	bh=Dq3QaKKcYcghvZm8SmrNuDfb2jkKsk5YEiTnIrqk8f4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bPL9LYTgmAD7p5JyJ4vaRzW90Do+f+oi53c2ITxuTF3FUVc2tMa76hFIx1W3WGxlBhw4z5KHY7gIh8DNOvfW2Xg7dGztTAvP8j67gnO5UpAXuFFFRzzEc1e44WP/vWcNJ90hf4jl35jAakXlv8AAu1tcsEh3DP/iwiLDWCLcbLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cdCiMX6V; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbX67YWp1BUScYpk1UyZKJA/zUv+9lSbxC2aH4ljduxgP4Zn52gHPFQWC1EYg1MoFBoRgTBreeDTOcdqjZsgurZsfZBrs/RnX0Z2u4Po9K9iNVHsGa5Mn8gbDZiWBAEAg8xq3xpHxFR5CbAaA+RNLcbcKnqA8xNEdUXHJ/bxBHjUlm3isN/77sbayHUVOejRkBQa3smWyBlDPzotIfso9pbySCJBNthWnElBU7/tTDeMJ5+V+sv2l5HI1sPd5pNXdd0cTxomyRidSDC/Xi7ssnZ6+Ed6R7OVqD43GuDto+uFHbGqmzZXpA+kv3ibWgFuzy7FhA/WK51vpB8VSkew2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESWT4NrjVW646BbXUydhwAm8ThfNO24yMZ/b11lcG8Q=;
 b=iZonM3hNYw8ajdanBWtRPSeTN4F1rwl7KwtP0z311WYSvGz+ZGIjwbPmUAHcCwG9d3OHE92U7jd6gwXnjcZokwL2umG3czBSXW0Vxsn6R4EBV4BEqUjGWxsU8KDeOo3e8CB1f0Wy0VIGeQ40ftU1JCW495ssPBwEzhG9opP0ZwQXzxMqUSmE9o2L+P08BeRHB0hbiR8B8AeVktCtTb83L2kdf0bB1ZhFYHsOq5bM+wB0OqEf8jXSa9+kIavP6zPfOxDrV2kQZGSAPQBvIVLljK8Un+b+11W08Kdx2bndaZwMXdUCkB8rhE5F0LtCRnBxuWFkpF//lPD1G5t3cZa0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESWT4NrjVW646BbXUydhwAm8ThfNO24yMZ/b11lcG8Q=;
 b=cdCiMX6V3Acw6RDlgkqNQlZWICnHJyK84uKNX/0Ywy6ByOXTgRlw8PLQZWuHWRVX35HRlW5tNOJpWBDTvodOdecMTe85Ifb6C+YX6Gq4vE6RrJH1z70bYuiBWR9iXW7qkyoM3y4/tMJIkae+e+DwjV4C0YhL9gWp6wbH3QLKZJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 17:18:29 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:18:28 +0000
Message-ID: <b9f1fd8c-1498-437c-b787-59640c6d19d0@amd.com>
Date: Wed, 21 Aug 2024 22:48:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the I3C
 Support List
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
 <236aa6d9-bb5d-4854-86e3-5473f5ea6337@amd.com>
 <ZsYKGOLN3_2VU6Ld@smile.fi.intel.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <ZsYKGOLN3_2VU6Ld@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::20) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: cfaf1de7-bd89-4a0b-115a-08dcc20545d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEVCTTBHSmZaOVl5clI4ODlGeVV5YzUrTFVpcmlWMVNRMFJZWVllL2xkT1h2?=
 =?utf-8?B?a28xZ1RocG5RSGJTZVZPV2R3Mmh0VHE0RWZxdnBDWW9jeTk4Y3dJelBHUGJX?=
 =?utf-8?B?YTlxQjI2emNEUUlvdlhid3ZGR0tscUFrbWRGbVRUZ1pJU0ZZcU5xSHBqUmtS?=
 =?utf-8?B?UUdpOEZYWHZ5S2JQVVJ2MjRnY2RIMUJrZndSc1BQb3RtbW5oRGUyYmU0WUZm?=
 =?utf-8?B?TW9JNUFoMUNGNTlJT2hkM2JWSWhDM0ZrSUo3YlI4RjZPRWZGc2pUM0U0b3hE?=
 =?utf-8?B?N3I1UytOekRrWTZIbHA1M2drbmRFNmwwaXVDYWhkeW9MTXVYc042UkNrQ2hU?=
 =?utf-8?B?cy9ZdUtvYWw5cmJnWmpTM0p2dkg5dGhVVUd0LzBtTmRTbkhzTElwclpsQlIx?=
 =?utf-8?B?VWdOYjNxa2k4RG5aWHBtMmk1eDZPQU5xTkxsMEtkNG1rcVI2b2FDVnI0ZDVJ?=
 =?utf-8?B?STk2NVVJVncxSzhLbWFRS0tNV0hsSHY3Z0RRVDZzL2pkYXh2Z3VJcUliMlJh?=
 =?utf-8?B?OUlHclVqcXdlVWlDaUo3Q0RneW1tSzlVOTJuRlZ3Z25RUURLb25DbVJ5V2tD?=
 =?utf-8?B?elFraFhvK1JDdVgvdnJXdHBFOHcySks1SmpDeW1yeHBlQ0c1akdXV0FRVUZQ?=
 =?utf-8?B?dEYwRDNISk1IeGxuT2MyRVRFNjErSXRwblZGQzU1QTF0L0JPVHVEQjFoVW9q?=
 =?utf-8?B?cnNIME9rNXdWRHRoWW5sRFF1NWNXbHZRRzFpZHBuRDdhTjNEczBtaEppVzBy?=
 =?utf-8?B?em9iUjZPNVM5NnB6SUw3MmhKeGV1eG0yL3MvdFVWeXFaT25Xb2VsekFNMHVK?=
 =?utf-8?B?cnBaNjZ6NUYwRlJmNGpJSTRyc0tZdWZzM2xBTmdrQWtTWmhYeXo3OEZvZmJV?=
 =?utf-8?B?NkljdzJiYlk3US9jRitrbXhlZDJ1VFFNdUovOURBSWMzQlA4QStwVHRKdk8y?=
 =?utf-8?B?b21EZHNVYyszRnAvUWhNTWJFbktGb3Z5clQrMmhwZWZDcEJkZ2FOR2owckk1?=
 =?utf-8?B?OTFxZWgyZy9vQkZXZ1FGSEhhaC9qallRQXhmZHZmaHliVlZjYWV5ZmJDMkZr?=
 =?utf-8?B?Q0ZYMEY1WTZzejRRUnNtbFhjVGZxZWJRR3dGNEJJWWJzOU56eXlyUkNSWHpo?=
 =?utf-8?B?N2ZnRkRjRWFkcGNPQm1BekdsajFOMDlQWElkL2xveE10aSs1YU1MNXNNcVNB?=
 =?utf-8?B?QUFZWWVpMEtUeEhZTnBrY1RpRWlHVVY1b1l5Z2J4NjRmem4zUmZmbUZrbkEw?=
 =?utf-8?B?OXZva3Q5K3NTSSthQkFLM21mNDAxMjFPZHdXMGw0YU9iVXpCckF6d3J3V3J0?=
 =?utf-8?B?MTdEYVdCaTh5dXd0dHJyaExSL29kUW9EWklQRGppai9uZThIS0MwYkF0c3la?=
 =?utf-8?B?MkVMWU5ueUQyQ1VWa3ZLaXNNNEJDYnlyeGtybDQwVnd1bXA0WW5mL3lGUXdI?=
 =?utf-8?B?YTkvYmZDU1VyeDhTblpweUtFRzVST0xXZHhtRDkxcmUvTTk4QlhSc2M1THJQ?=
 =?utf-8?B?RjFWdXN0R0ppRzhlZmJ5aWJLdTVrYnF3SlFhRkprSGZWUXJUdTBkcHNmQVdl?=
 =?utf-8?B?cEVyZkFQcVFQTkg2UGhaNlRZRXVDTEFoWHNUaUNYcktDNVNxZWV1dytpSWNy?=
 =?utf-8?B?Y0R0VHF0b2l3T3ptR0U2Tk1rNFVEZTlVZ2hBMUNtS1BWUmNsOGdqWHRVd00x?=
 =?utf-8?B?bnZIZkxTcWR1QmtXRjdDMkJYQjh3QlhIbWhYaEhnamFuWnVTemlaZHVOMk9K?=
 =?utf-8?B?bHkyQzVKclBjNVhtNThJUU80OTR5c3Z5MXJMV1gxZWRSYzdEL1JHa3hiQitn?=
 =?utf-8?B?OVVIcHpTbUFBaWFpMkdsQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2ZNNnUyRld2eTBxTTYvVElyZTVXYnV5OXU3RlI1L2QzQ2FzOUpQVlNnaXhu?=
 =?utf-8?B?Ym1iempFZTV3dml2ODJFRnZEa0haaXp0RjJVZmFldW4ySDd1dE5zOXo4Nzh1?=
 =?utf-8?B?NUtPVFo2Z1l1cWtsU1JiTmVRd2RhdXo2V09XVWpVS1YzcXNha2ZQUEV3RHFh?=
 =?utf-8?B?QXlqSFBralAxWGcrSU9DYng2UEErazRCYjJPVUZucks1Z3AvSlg0ZGRnRUxs?=
 =?utf-8?B?a292UnNsNmNCblJQeGlENHNkVk00U0YvZnVaNFNYZlRCSVM3aW5HZUNIaTR6?=
 =?utf-8?B?VkdGc0JuWm14VnVMZ09rU0E4UExWMFNneWpMOGRIeFMxSkplVHVyd3pwOFhT?=
 =?utf-8?B?SHNmYTZkMGQyOFNOMHA3TmIwY1RLdDZrcVVTelRRdVJOaEgrZlZQVHV6Q2N5?=
 =?utf-8?B?eGhiYmp5Vk83N3hEVGdnM2pMekNJdGRKVllFdkh3ZVhxb01GZzVSWUwvV1lN?=
 =?utf-8?B?ZVlNdVJ3YnppNmduOHZnOHVSR042UXVmY0VHNnNZdTJ0NWtCcFh4YXlzNnQ0?=
 =?utf-8?B?MnI3UEZwK3lQSVZwbU15MWwySUdSWjRSSzJNK1BWZnkrc25RU1lSVUhPTStB?=
 =?utf-8?B?L0NTcnlmVjZhZ0tnVWV1dHNxcVMyZ1JCSnZURHJjdjJNc0oyUDQwcWpnc0JN?=
 =?utf-8?B?UC84YWU4bENnNTdYUVZWVGRWd0twcjBnRFRSOFlHTVNDODdEeFRNRDcweEty?=
 =?utf-8?B?S0pwRTFrWmF5cnZrbldFcHE0WXpHTHRWNlM5amE2alFtdHhCSCtUV3h1UnU4?=
 =?utf-8?B?S1NGZklsUDRwUWZwZXBQTXpDTEt4L2tjaWpTOVFiSFpTYzNlaWZaNHJiSWtm?=
 =?utf-8?B?SUhieDVya1F0OC8yMmZMSXB6d0ZHbTJQbUxWZlh6Zkg3UVlHRVpCVXZ4UWVp?=
 =?utf-8?B?TWdubUF3cFFnS1REVVpFL0dQVGMzakxBWUZBMWkzMnVwTUd6cVJZOFk1YlJk?=
 =?utf-8?B?RFpCYWtMNWdweGZCQnpLOEt5eTB1MTNheEcwd3A1WE5mVnp3ZVU1SEpLcTl3?=
 =?utf-8?B?bjdsNlVEa3g5Tm16c3lJOHVtakpEREc3ZWh0SUlTN3hLZjVPbHRoT0ZHYjIv?=
 =?utf-8?B?eGY0T1JXK2VVVkFMdkZmWlVZMHZDN01HOEc2ak5rR3lhUGlFSFh2QXFLUktk?=
 =?utf-8?B?MHZYWmIrT25zNjBna25hV3pnQlR1VEg2aFBBVUh6K1A3NzcxQ1lvR3prUTlK?=
 =?utf-8?B?SnVGckIxY3ZPa3NIbHFZTWEzSExDR3NzQ0FRNDlVZG9WeDhzeVRZZjBPN0tQ?=
 =?utf-8?B?SzVSOXJWNVdWUlBNZkVCUHVBd1FkUCtSTUlUQkpoaXYwdGRjanN1L0ZwRU5k?=
 =?utf-8?B?OEtUUXd3Y1dUZVNGSzZFMURWY2ZxTmxYazBxaUJNMDd0SGRCMW5YWXpIcDJC?=
 =?utf-8?B?VUVCWXdRbHRyaUJpSEw4WnNiVGgzWDc1N0tvNklqMHJYK0NPNGkrQ2ZyOVll?=
 =?utf-8?B?WTk1Q3BqUzhKQmwvQzRNeXVXeGthNHdnUHB1bjZxL01Yc1hockxmUERENTdB?=
 =?utf-8?B?TTRYRURzK0ZSdGhmYW0xNUF1MnlVYXJZODU0VWxSK1hlMHlOL2VkbGRENWlV?=
 =?utf-8?B?RlpicnpSbzJaaHZkZ0c1U2x5Tm1oaXI3UEJscW93WUo2cElYNGZMR0FrUHhN?=
 =?utf-8?B?d1lTaURrdFZHTXptc0lKVEU3bVovR3h4TTZyaVB1SllXRmQxRnpSMkVZT2dC?=
 =?utf-8?B?aHhLTjRHVk9xeUoyalVtSVRTOHNnTVJJTjZoN01pUzM5NDBxVk1YUTJVZzdr?=
 =?utf-8?B?Qm1sR2hjRzlMM3ZKMVpya1JzOE5vZkFNVllKangyRmZnSzNJUGoyaGN4WS9I?=
 =?utf-8?B?OEQrSnVHTmRTL1lhZzh6NDVCNUFDQndmaEw0SDlrSlgxSFVnQ3N3WVFMdmx0?=
 =?utf-8?B?bFlTNlRMMkRabWtyZnowRE5RU1BuNEpKYll4VXpDRjFpd2pnZDlxKzIyTVRh?=
 =?utf-8?B?QStwYnVWdDNsM2RySXVETEcwdmNSQTFDUnVDVkZ5RElSSEZKSERYYWJDcklx?=
 =?utf-8?B?d21HYWtreXNwUmkyeWxPcDBmU3ZNbUU0NUZYdW93Tk5jeVR1MnJxSDdMaUNv?=
 =?utf-8?B?Tm9vellvbEJHR0RrUUlRRnY5UHRPQ3Byd0t3dGVjaHJ1R2dMaUtvK2lrdFlw?=
 =?utf-8?Q?5YpOG62XUEwyJlHOyIsbz4ndS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfaf1de7-bd89-4a0b-115a-08dcc20545d7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:18:28.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otdWd5q1VLCYiX0txmNar1MiLHLXigMRjc2SXwMMcl6sa3M+6UkgQaBPBkirAxvRk33uIQsJ0Umnqj7PyiqJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642



On 8/21/2024 21:09, Andy Shevchenko wrote:
> On Wed, Aug 21, 2024 at 08:42:12PM +0530, Shyam Sundar S K wrote:
>> On 8/21/2024 19:26, Andy Shevchenko wrote:
>>> On Wed, Aug 21, 2024 at 07:07:45PM +0530, Shyam Sundar S K wrote:
>>>> On 8/21/2024 19:05, Shyam Sundar S K wrote:
> 
> ...
> 
>>>>> This update adds the AMDI5017 ACPI ID to the list of supported IDs.
> 
> s/This update adds/Add/
> 
>>> Please, provide a DSDT excerpt to show how it will look like in the ACPI
>>> tables.
>>
>>     Scope (_SB)
>>     {
>> 	...
>>
>>         Name (HCID, "AMDI5017")
>>         Device (I3CA)
>>         {
>>             Method (_HID, 0, Serialized)  // _HID: Hardware ID
>>             {
>>                 If ((I30M == Zero))
>>                 {
>>                     If (CondRefOf (HCIB))
>>                     {
>>                         Return (HCID) /* \_SB_.HCID */
>>                     }
>>                     Else
>>                     {
>>                         Return (I3ID) /* \_SB_.I3ID */
> 
> Do I understand correctly that I3ID is the old one (as per another path I have
> seen last week or so), i.o.w. *not* a MIPI allocated one?

Yes. That's right.

> 
> If it's the case, feel free to add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> from ACPI ID perspective.
> 
>>                     }
>>                 }
>>                 Else
>>                 {
>>                     Return (I2ID) /* \_SB_.I2ID */
>>                 }
>>             }
>> 	
>> 	...
>>     }
> 

