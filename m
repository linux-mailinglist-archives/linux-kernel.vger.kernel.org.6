Return-Path: <linux-kernel+bounces-389769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4E9B70FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6054E2815AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FBA46BA;
	Thu, 31 Oct 2024 00:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LzZSPKyb"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEBA23
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730333852; cv=fail; b=KWGx2L4C2zRJGd0gla0TEdLKTP0JDFgXOnPvC9a3eob57ozscz3ClpSriaqfaUzNRcYASIFokCwsG4RGIC8+tASUaoM4CkNZpGVJ/n5I69xfDWtPqed06ATv2qzVRIyHYmPxjsitDMxKTJ5ZLjzuSVX0FU5F8JVe4bNiK6uC8VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730333852; c=relaxed/simple;
	bh=b7Z8SNeBigXAJk0uDeg3divMSk1bGskTXct86UxLQwo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n++2F618CrEJZIQ5A436VSYgfPZjHG4fDBOBO22Jc2zzAl0r3ZZqj9nTbjuCwn3PHDfxZw8CoxMxCdNupu9mGTdBGaLPp7sip383NiltZxbujEIOsv2O4DDNKbWCUJwE7CzKeuWBqlhHOA11bOoBbTVvkUhyS1VoPtjy1OBDmWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LzZSPKyb; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0GzmqL9JsmPnQnUuRRbdRzb4+Un9Q2n0g1YPT908TuwMrINLfvATvFCEx6CMzXs1xMcSsJXUOXICbaQGex68aWwFIRyJ4Daj50K9C8LT32MYFK5juTSGiKqv0yJiymllU45r59amenhv0BWe3js6kPj/zyPL40QfWOa9lllZSZibDIB5rZGzXG6M4Lpjb3pFM0vmx3I4Qr1o8iqqJyOCBMxm5nJJ41D68L+hrWK6GDd3ramHuyJsq6hDoPe+5xhbtsb259VxDEQs4Lbt8mJ+CoPLJU5/Tmg0pXahcnzCibNbAGOjNe76ZFWoCwkwffMomLdoyKrycRsr0CZUHy7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FRYhH+apTJvSKX7+5g5IQMLoJY4mdECpd7PQKBUpZo=;
 b=EHA03lMOpLu16zwSPGGNE8o82j4dZ3dC2HVWg6dJadWmVbxG31dlMETJm67ozE3Iy1CDwGrjSzzSI0pp5Jy84ueuQ5gZSa6to5d/L8CyWlLrBNKCAiVftJ8EwDKUFA1lXE2+julsG9lYf7nUJglm7OXGIzITKJePq9EaOP/xkA45W6N8JFogi4oFKZdARADh84yzhLUkDX426lHtgCmWokXfDxcsYsGcEIODcBJIIampecooSqzxU6ssGBpSnz+8jRCW0Qn9OzgnWIl0Mmh0vVKB1ibV/gmZtQqtM3iL/Yb1JSxfCcHrYD1J2wrQfz1HRk0F0iSZZxD8FPtdr15TZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FRYhH+apTJvSKX7+5g5IQMLoJY4mdECpd7PQKBUpZo=;
 b=LzZSPKybslV+ktGI46BBpM5pCV4Q3xf7+H14Zix0vUnu9p2uzu2Gst7LxVcCH1G9IXLqiVo0wPg6Q3duMe6UTNWQ6p5dUFs8VmG1toCwjgIzT6aNS4ZbozQwXGRqt5XUOgCI8hieFDnj9MKEcik222Wlr6+LyrmbA+sy4G+vNXLed7/OnVityt7hidf9oFw95diMCblSRPkvrCt+wrbB4fB4SLAEBE+s5OAc/Qgc2Xs4hMHUmM2dg6SYjZmfTkq1U+BV/UyU+XLU2xjV780J3L0YOhhoBXmhzhgKCudh1q/kfce03rmvhYfQMtm3lpQaJavygXinif/1Gct4GsPE0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 00:17:27 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 00:17:26 +0000
Message-ID: <21ee9aff-a9d5-495c-9e5e-38e9d25b11cd@nvidia.com>
Date: Wed, 30 Oct 2024 17:17:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Alistair Popple
 <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
 <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
 <cdfadcd5-d9fe-4f90-8794-a563744ce207@nvidia.com>
 <20241031000218.GA6900@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241031000218.GA6900@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: b71a8c94-738f-4e49-6b2c-08dcf941663c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzNjUmJET0RUYU84Y1oxL0pncmlha3IycjZ1S1BFSFkxZi9IT3JxMjM5MnVF?=
 =?utf-8?B?TTRveVprWkc1encrNmtwTGNsWjA3cXU2WkFJNEs1UmhLOUJEa2Y0bUxWSHBY?=
 =?utf-8?B?TmF1a3A3dnoyOHhqNVZMSERsZUtmeWkwbmRMMDRPR2hEbVhhd0lSRFk4MUJk?=
 =?utf-8?B?dFFqT0hEQnFKcTlXU3JjWTJ5Z1Fqa1B6aWpYcVVPaWFNNEtId2hxUnNRcFdq?=
 =?utf-8?B?NGE0SHlJNUVCL2MxWUdqdEZkckJWTHA3dmpoYUFsVzlBUUtQMHhLd1JmSUhn?=
 =?utf-8?B?aks5Q1g3WHVDS3IzN2V2ck5OT3Ird3FoKzhwckFGcTNOUVpoeTNQODY3bWpB?=
 =?utf-8?B?d1FvektFTWx5UmtsbStqSkV5emZDRDNqTE1BL2MwYjVjZmNHQUM5bDFidFJN?=
 =?utf-8?B?ZmVvMFBBYWNFUXZCZkx1QThDZFJESXR2RzFsMjJxMERkWForUml2YXl4V0U2?=
 =?utf-8?B?RTBONncxL3I3Ulo3NHZla0FYb1FtVVRENnVUWXU1NnRxUnBlT0ljclZ5NkNp?=
 =?utf-8?B?L0ZuT21SSFkzV1N2dHNmSDdwZHVWQ3hBSldzS2sraEZ5cklXOXh5NVhqWUlQ?=
 =?utf-8?B?NS9OajdWZE1zYkJLSmRYNUhsWEJiMGd5OTBHQzJJQUJ6bVJSTEw4RDV4azhS?=
 =?utf-8?B?RWNKVCtoWG5wQmhSenZaTFg0MlNaMjA2b3dTWlRuWHpNeGlxWWpsT2xjbFhk?=
 =?utf-8?B?UHBaVTFnYkpvSkQzSUgrYU5yZnJDUlRiRWRmcTIvUEJBY3k4Q2cwSS9kOWww?=
 =?utf-8?B?Z0NGOS9ZWVA4cFB1a3JSSHpmQTJncGpqMzhyWThRYXptTnNjYWphL3RRS1c4?=
 =?utf-8?B?Mm5SZDNsTVJVR3NoY012S25PaDZoUFdXU3ZQT1VldVNtdnhhUnVJbE0rNys4?=
 =?utf-8?B?c1ErekNhVzNoZlI1N2ZRaFk4QkR4ZVU0ejhHc2RIalJqY2krRUZnTld1cTQ0?=
 =?utf-8?B?b2hHM1lNbFUwa0hHMGt5T09vcnNxNUFJVnVhbzNPeDQyYkNoTHlVRHpLUWty?=
 =?utf-8?B?UWFQR2x4OFd1M2tTSU9WMUkrVW1DMVQ5QU5iOHZZUXo1YXlFcFNXdEVjaWl1?=
 =?utf-8?B?UWtFOFdqajFnSWVaMThrcStpalc1TSs0SU53SnlkeFpQcVJXWGZNejRVWlhv?=
 =?utf-8?B?NnhQZUJSYm9SNkY5VUp1VUZPN0d3ck5xb3hSVTVPa2ltdklrb0NyK1gxcXVH?=
 =?utf-8?B?TnRLMlh6YlRFdWJCQTMreExtWWpOZzNHK1VnYkNpaGxKcVRmRGE1VEZzSWdm?=
 =?utf-8?B?R0twYmtzT1MwcGZkcjFrNDRuWGkrK0lyT2o5UkZrckdtU2tGeVZhbHRzRTJJ?=
 =?utf-8?B?bGttMllFaFdzSmRObHY1RTlBZ1JKSE5lOXFQUDF5QXF6TzV3eTh0QkFOVjlO?=
 =?utf-8?B?T3p2d09XNy9uV1JvNzAxNUtnOUtZK0JySU9DZEczN2tyei9Ja0l6VVoyM3dZ?=
 =?utf-8?B?NlUrVW9FVm1maUdRbXJKb2Z6Y2ZsVkUrSGxnYVpBOUVGc1c5aHpEdGJZK0lB?=
 =?utf-8?B?ZnhKaVAvOXlndlpYanFTUTArREhXMlBDMVdvVFc0Qk1xd3VPZTByYTJLSHpH?=
 =?utf-8?B?VUthNFlBb1dWSlhKQ0M3K2JKbVIxNmhSYmh6QkpCR1VCdG1CZ2JiRlZEaVRN?=
 =?utf-8?B?bUhVSldjNXBrQS8rbUtsZkpPQzVJWUJqQTZ0bmkwV3BycXMyNlg0WnBaSk02?=
 =?utf-8?B?WHhLR0E5cFB5WjIvYVQ4cVdtcWswelJVV2kxd1hxT1c1bHZBcUNGYlJzeTIw?=
 =?utf-8?Q?NndKoETXiBs6KIqDqqpJshzln4rbJnWLlmCbOVM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRkMjV2bDhEelZPRkNrR3BPMXk3d01VV2xSSkxFd2czR3B4MDhncVZOSStm?=
 =?utf-8?B?c3dhZUNYMnY4ciszVVVDQnB3M3pHVFhSbWxFblcyeGVCc0l5bHpHRUxlalVL?=
 =?utf-8?B?b3ZlcHJnOEV2ZWZmMU5vc05UV05MV2xuMlVlUWtNN25QalJIeXhRTC9uWGZh?=
 =?utf-8?B?eWo0ekVPd25MVFNCdHNLU1NFZDZ6SWxEcnZYRklrM3I2akRRTXpIT0hNSUtP?=
 =?utf-8?B?RzdYNStTcjdqZ1VEMFozazJ3bFFBSmRsNGEwSWpSMTkzTjIyRzdIdE5RbUdq?=
 =?utf-8?B?OXRiUENGejdwMUxpZnZ6K2RZbDJwTVJ3L25uakRqQ3E2c2tRS0dXV254enJW?=
 =?utf-8?B?ajN4ci8wMHNONUM2TWsrOUdjQkRiMnkvTEphL1dtc3hCZHRsbEpyWG92Zmth?=
 =?utf-8?B?V1BlM3dKZUkxbDJ5NDNLT0ZHR3Y3cVdwOWo4cEI3eVJpZ2JPQ2dBOVUrYmdJ?=
 =?utf-8?B?OGJiVWVDbExCS3hHNGkzVURld1ZPeC8zU0QrTWIvN205QlNEOTZlS2xsN3lh?=
 =?utf-8?B?dkViYzNITE5MY0puODVIVmV6SWxkMWlxR05OVDVkOVVPTGhDdHIxWUhSdisr?=
 =?utf-8?B?c0J3Rm5aem9ta2EvQVpmS1ZHVHlzNVVQQ2xCQnFYcituMmxrRVd3YUhUR0tw?=
 =?utf-8?B?bkdQRjBLNkEzNlJoREhCVmh5Y1ArMTRVSFo2ZXZBTUs1SmRkTHFJd2R2OXVn?=
 =?utf-8?B?ZHZIb1JWRFBNNi9NUm82TEorUmVWMnpjZTE3dmlFTkNOV1lvOUNPM0MxT3dI?=
 =?utf-8?B?ZzA4NGgzdDlGTmhkOHZmcXhXeHk2NHRZbkdZYkhiR0JmS2UvSzZIeEU3bC9n?=
 =?utf-8?B?SGhRcEZuaDZoZEZCbW4xVktrTFZZNTdja1JoL0RCUjhuK2pGY1ZleTRXM3B5?=
 =?utf-8?B?TFFDTi9Qa2JJNlJUOWtUYm1tdEQ4ekZ4V29JendHRlZzNWFCYnk5Nm45M3VU?=
 =?utf-8?B?WFdJbmlWSThmSXBrM1p5NEllYjQwK05rT0dvMnhPSUJ5QTUyUkhvclFLbVBX?=
 =?utf-8?B?M2ZDQ0JqQXV5bkozcDZvby9oYkEvdFRCaXVUeUZYSTdUeFhwc0cvRW91Rmt2?=
 =?utf-8?B?bENtQ01CTzgwTHJydWk5OVJyR0NXTXZoakxxV3c3TE9xeTVRLzQ5eWVwd0F6?=
 =?utf-8?B?OCt1NGlTbXhBUUVNZW9pblhJV1NzcXBub2JGblc3UXBOQS80N0xpN2xNVHhV?=
 =?utf-8?B?RkhHOWo4ZVdwajlzRjlOM3FjdE1HZ2crZHRCY1FibFV0V1RpRlRuTzV2dFVn?=
 =?utf-8?B?S0JFRktTeEdLM0ZGRzBHTzNpa0s5QTN2S2xWNFVJcDJpbSsveG5rMis4VzJZ?=
 =?utf-8?B?WjhXU3dnaUwrZ1pWQ3lIaG5abmo1V3d3NzNKU1k4T0tPcElvdVVVckVHdS9L?=
 =?utf-8?B?ZFdwSnphcUxrT0NWYWR3ZXBPcUk3TUhzb0lzdDB5bHBlV3RMbUFkTUhKeElp?=
 =?utf-8?B?MmhFS05DSTZkTVhWejJHZEJqeFdNSUZYemtXTWRBVlgweVRPTVJCRmNGQzRL?=
 =?utf-8?B?WmNOc3Q2UXR0MzB1S09CU1hvaE1nck95aTFZWGJ2Q3JMbmVvb2YxT21JY1RB?=
 =?utf-8?B?V3UvNW9aU295VnR1RVk2RjVod3g3cDVYMUZEZDVzVEVwblcyNERtUWJ3b1BO?=
 =?utf-8?B?ZjNWVXM3VzQxTFFXLzFoanhIVm5uS3VvWkZzWTMyK3QrZTMwcStDcTVDcGJq?=
 =?utf-8?B?bW44dEY2c1M0bVZZL3F1a0QvT1JacmM3SE8wd2tHSHY0cjZOZnJvS0lBTklh?=
 =?utf-8?B?dSs4TmRRbFY5ZkZqbFFmaFFqTWx3RDV0NkRaWEJybExWK1hlNXpqenZvSnNr?=
 =?utf-8?B?ZUdGc3ErT2N0aDJlQk1Wdkd1cjFETWMwdkZOQ2NYVXQ2RW5INjd2RE9iYkc4?=
 =?utf-8?B?d080a3ZXazlvZ00za2dkdCt3NVVhcUs1T09UNXVHU2VxcUR3RjZ6NDZoM0Fz?=
 =?utf-8?B?dlVxSkducHM2VElNSjJubnN1QTY0T2N4K1JrNzFwMTNpT2tBa1hZemlIQllq?=
 =?utf-8?B?YjB2YnJJa0xXNmQ1S3p3djlaWTlVazhGUi95ZGxsdy9EKzFBKzlsa2FxM0hi?=
 =?utf-8?B?S3hCb0xnV2tCUXFZUy9PZnZIMmV6MHdvckd2bkIzUDVRMyszZmdtc0FYMUx6?=
 =?utf-8?B?OE5YcmN1Nk5TR3U5KzNhVXE3VStmc2tHQXJ3dUxyNHVkQnUzRGMrdDdKZVFB?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71a8c94-738f-4e49-6b2c-08dcf941663c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 00:17:26.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shsqi/seX2xa+lLs+cWCCvI8Jf8Qok8O7hjnD+3rsMP6GZY+YfSi+vWeGluqKqL71A5OT6jgBunND/lLlFOYkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On 10/30/24 5:02 PM, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2024 at 11:34:49AM -0700, John Hubbard wrote:
> 
>>  From a very high level design perspective, it's not yet clear to me
>> that there is either a "preferred" or "not recommended" aspect to
>> pinning in batches vs. all at once here, as long as one stays
>> below the type (int, long, unsigned...) limits of the API. Batching
>> seems like what you do if the internal implementation is crippled
>> and unable to meet its API requirements. So the fact that many
>> callers do batching is sort of "tail wags dog".
> 
> No.. all things need to do batching because nothing should be storing
> a linear struct page array that is so enormous. That is going to
> create vmemap pressure that is not desirable.

Are we talking about the same allocation size here? It's not 2GB. It
is enough folio pointers to cover 2GB of memory, so 4MB.

That's not really much pressure.

> 
> For instance rdma pins in batches and copies the pins into a scatter
> list and never has an allocation over PAGE_SIZE.
> 
> iommufd transfers them into a radix tree.
> 
> It is not so much that there is a limit, but that good kernel code
> just *shouldn't* be allocating gigantic contiguous memory arrays at
> all.

That high level guidance makes sense, but here we are attempting only
a 4MB physically contiguous allocation, and if larger than that, then
it goes to vmalloc() which is merely virtually contiguous.

I'm writing this because your adjectives make me suspect that you
are referring to a 2GB allocation. But this is orders of magnitude
smaller.

thanks,
-- 
John Hubbard


