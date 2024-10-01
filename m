Return-Path: <linux-kernel+bounces-346698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12298C7A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C19286343
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66C1CCEF2;
	Tue,  1 Oct 2024 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tKm7SOMN"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021127.outbound.protection.outlook.com [52.101.62.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95119DF62
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818380; cv=fail; b=q9MIMFtzuXgQjeWcDos63lY1lT7lLqX3jO/lqHLgk2xPy7MfGD3+clcs6ZoHvwW+WG5S92CXqJEbSCr33MzjRmaOB+fK9HjW/vHJVCq5S98eR0lk3YKWlxuVwMhic21FqDe/cRfFJtvb2l/XUtmloNgnWA7RkLSi8WKvtfHygMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818380; c=relaxed/simple;
	bh=EMgnomfyGF41tpdpdry9OPt5rK+yvou/hRKJGoDRvls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mc1bXn7JPVpF9wNGr4qkRCLENd0pEa83FMCICtG79NXkfxKjLQGAzRD5LrSiibaSM8FCMUA5zv23o8bt95WrU29dbPaxOhmQsHBCrtY6CuWVrxdvepsOC5ilZ8YiCgk145/AgTkQvLE9SlefLwXkJfK2dH+vIGKH290SgKBuLgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tKm7SOMN; arc=fail smtp.client-ip=52.101.62.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXepsAXlme8l3eTH1pVs+DhzLKajQe6zN/xuxuUCktpRiAMExptjehHgTIzmSXaRDHUVBiWcZJQpEM16jvHnJ5fR64c9a55wCq2L2NMKgSkfquxDNpX6vCAEMXhFizr+AsKfsMgg/Vzx3VFRbRrmHZLDaQLNHgbkXN+i9MAkBZOtzHA3ynimbAjXMoi5EMlDPGzTRl5nocNOTIP4pE1JCzNTK/Vn6bdYRIUa2mfr/X0vVyp75wUCFmdXKXemAABuUYqaO3W0fsEgOJ9SvJindQdYTSBtDKf1SX+GHYTkIUlxiEdn9ypB3KFT/ngRSFw+hlQme19pZ2vQDcJBjO9Lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCuC9H6ex+2oM9V9wzIuaDsfhYePzLDOpueRD81kHZw=;
 b=QBJXnjv51ffbXlBgSR5+M/8fpSqyDDQjKLw1FmLOJHStlrF8gkHM7+PYQo29iuHlVukHXGTA+W8+G0QQa1gxG6htY1Yc5q9fYs6SG8RFpeTqGqzItgRBKrxGqQM8ME59D+l3jjOVv5q56oCyNJIJ7g5Ly5kTAa7KxvKZxvF2cHrPaAfzD28Zy5QfqBtlnwKxjvkwh3U0N4VSIBB9D7YG7ZIcgGImOKO/lyxFalJBJJPyTRiW3nVfunmId8zPdcprGah2PSn8L8kJZqTp0GtcYir1eaTBGOfBBitznIPfwJkvAJJdt+UrktqOrfeeHsAHSZJVqsIIslcIh7CHkQf2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCuC9H6ex+2oM9V9wzIuaDsfhYePzLDOpueRD81kHZw=;
 b=tKm7SOMN4+YqxmwIkdaKJyCodJWPZCchdcbA51f06MlnOuIYRM4H7c8oi8nudfunm2K31kAXdEbrobMm8r4KdnUvJGJ1S7ApZ8wdIrWFdiaN+l3Pnb0Yo4PF3+uGtmvCAWOuPR7oy2eSy1XzkhMm0cFG/2yIYaPeYBtvOIjTgVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB6637.prod.exchangelabs.com (2603:10b6:806:188::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Tue, 1 Oct 2024 21:32:55 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 21:32:55 +0000
Message-ID: <fb8461b5-4471-4927-a585-b62d05819f79@os.amperecomputing.com>
Date: Tue, 1 Oct 2024 14:32:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
 <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
 <20241001194620.GB1369530@ziepe.ca>
 <e374e8ec-29db-48a2-95d7-6fc9ac6317d9@os.amperecomputing.com>
 <20241001210200.GC1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241001210200.GC1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b31bc95-1cc8-4d1a-aa69-08dce2609cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGhqMlBPMGRIK2I5WlpidGtHR2Zvd3ozMmxwNlNCTGhjRVM2T0F4NWNIenQw?=
 =?utf-8?B?OWJ4OHlrTnM4K1dic2FYeXpaU3lUbVEycWkvV0ZhdHlqNGNyU1JoZDJ2YXlN?=
 =?utf-8?B?UjdHZlVjZ0Z1cHl2MW53ZkhoOGI4VkFCUEJXKzZrUUJJWGp4aWNKR1hwN2s0?=
 =?utf-8?B?c0VodXNFSWo3VnJRUFZQZ3hoSTlET0piZ2hYcUxSV3pZWE9FTmFQaXJ5NUVt?=
 =?utf-8?B?MlFsbys3Nm5sRytiakJ4blppUEMwNStsdG9WUHJ0bG11STR1VjM5dG5qU3lq?=
 =?utf-8?B?NS82b2ViUm13OFdjanBWUDRKUzI5V0c1RnJuMXRVYmhZZWovYlVSRUE3MTkw?=
 =?utf-8?B?UTZiMmNIT3JXZk1JMFBoUjB4eEJvREtlWmpZNWNVODNEY0pGaFlBTTZlV3I3?=
 =?utf-8?B?UGhMK2VMeDUrbWx1REZBZlBxSzJxN1QrWmtWbm5xODFPTW9DVTRnSmZvdjVu?=
 =?utf-8?B?YndkWllUVVpmQkQ4Z3N2NDBRaGl4aGVtc2pxeDA0R09rckI2Q01wUlhaWVpV?=
 =?utf-8?B?Q01zWDA5TkprTTJlWnBRelhRV2M1QTR1MFBJNVhQVDFqZXN3ZlFPMXVGY1M0?=
 =?utf-8?B?b28wZXR3V1dyeHNGaDd0czdDdlVnOWZuLzJicVFBZncvdlFKMVd5cCtnVHE0?=
 =?utf-8?B?SndwMjBRVHZ5TlJ5N1hkMmN4LzZMUUdzcG5QTzlkc1Z1US9QM29QWnFTVXQ2?=
 =?utf-8?B?YTB2VVl0SVNzalNabVNjelFqbHZpbGdtWWZPZ0xJblQrYmp0UG5WVG01Z3g0?=
 =?utf-8?B?Zkdoek5UUGxHY0ZGY3ZnMERPMGJPS3d2NWFYaUN5L2JsK0VobnNaUDE4ejFx?=
 =?utf-8?B?VkNUOVY0WlkrYk9vSFJRemNtS3RuRHJNdE1tb3loV0ZmMm1YNU1vdHpQRVox?=
 =?utf-8?B?TCtySXFLa1RuRTdHdnE3QUNxcm1UcXNpbkFjNXloSjdxaGVqN1lkQVN2NkVD?=
 =?utf-8?B?eHNHMlJwNXQ1TDhPZmd4TjdCekxKMWxleFdSOTA4V1Y3NVdycVlSemtpN0cr?=
 =?utf-8?B?UmlyRzRYUTRpUWdROXREVlVpZVduczFDbGJWUVZwczliM2NzWTlyU1pPODJ4?=
 =?utf-8?B?dWRaUUlrc0VJTTIwWmhVNGZNN1ZLWUdTUFJmZUdRcDJUWUNucDEyLzlHdWhu?=
 =?utf-8?B?eWxpZ3BqUEJLYk5OSlRLdGptRHg5NlZCbWxZcGVaSHJkQlBvd3dKVG45YzFK?=
 =?utf-8?B?VldJUmVHS3ROcnVUc2VGNnE4ekhnUnBsRmFKRzg3OFRlK1p3djdnUGV2MUNF?=
 =?utf-8?B?R0JWb1J0N05XWFJPNlNlMTJqU2RPV1lrcGRJUi9sZDFxek1FUkZjRlF1c3lU?=
 =?utf-8?B?czZXMENaTW83bVUxbmhCTWtaektiNFlLZjRzeGVHSWh5QjJlek5vQS9TQ2N1?=
 =?utf-8?B?cFRqQS9ONUxGbHpwZ2E2NktUVU5Nb3ZSOUpiMmpxQTNxa3hPZEJ0ak1iTlIv?=
 =?utf-8?B?elc3dGV6Qmc4YUxrSENCN3hFek4yaGIwNDlUdk5SUTV4N2o4bjhqU0k2emxY?=
 =?utf-8?B?eUdyYVVEVkVyenVpUzZEMUpxS05aSExrTE9peVZKL2VicUdJbS9lTU8xdHBI?=
 =?utf-8?B?c2NHaUpkdHhBU1FWU1hBVWM3d3FMcWhOV1BYVm9EeEhBaEJiOXlxM3l1a2p3?=
 =?utf-8?B?OE5BVTJwU285L3hwZ2l3LzRJUUZRN0VITHdreTJpeThNa3I5TkgyUUlaL2RS?=
 =?utf-8?B?SGUvYlZkbGN4ZnBrMzVVMU84V25CNDdmcXFZU1c4aDc2YzIxY2JPcUdCTmJZ?=
 =?utf-8?B?SWZYL09LMEtCRHI3M29Td0x0SFB1SEc5VnlSVDk2VnFCTHMzS2lqaStmYy9y?=
 =?utf-8?B?Y2xMWXVHNWo4OVRVUXZSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGFKbmdGZElIUkFxYllRUkNGbUYwdkVGMnNlYU80SVVJbm9zdzhvaElzRWx0?=
 =?utf-8?B?YS8xL2NEVk1zeWhZRlJSUzFlRTJ5bGpZa0dabUlyWmo0SXpvN0RVUnc0c1Nw?=
 =?utf-8?B?YjZBN1IzYmJEMCtNK2liclhYVjJVSGpQMHNGYy9EK05YK05QUmdKUmVyM3NJ?=
 =?utf-8?B?UldSV0NKTllhSU5HTStSZlppaHBSSlp0Z25BR0tkRFIzbGRhV0s0ZHk2U0Nu?=
 =?utf-8?B?SzA5Y0NzNk5IRFBIaTl4UG1xZlpTdXhWRjZaQlVBV0FnQ3BMb1lRLzNra2I2?=
 =?utf-8?B?S3lOMDZZUmFvVnZhNWxsMlFBNzZYWWF5eEdnT2ZYeTl5S1RkeUxUNE1nakxh?=
 =?utf-8?B?MmV2RzNPeDRGandnRlJ2cGdYeklYOTNhMUxjWHRoZFFkaDFGR0E3bjhoY0tp?=
 =?utf-8?B?eTNyWXFKaTFucnpMcm9NSDRuNVY3cGVqdUx2WDBlNDlsTzBjNUU3KzJTdmFF?=
 =?utf-8?B?RlJFcm10cUxWMzBCcU0vTFdzeWtJcWREVnFWdzJEY2pNQ0YyYm9zZzNwVEFU?=
 =?utf-8?B?OExUMDZsK2wzV0YyWDQwVk1DOTc1NzBlMHE0Z0FjenJSNUpDNnE3WVZNSEdS?=
 =?utf-8?B?OTVpTis3TWhJRUI5Uk5qeWVkYnZqd3pUOE4za05FMkYxOWFOZTBwaTNmUkZL?=
 =?utf-8?B?ZFhINmVEb1F6OUJrcko4QmdrNWY2ejhhcWpBd3oralhtTjFhb0pObVltQUhj?=
 =?utf-8?B?b01nUFhMNWhIWVJWOWkxRVcxbXhaVGs5Y2VxYXpDdExPQ25na0grdTRnaUp5?=
 =?utf-8?B?alVXeDZ2YUtpT3h5cHdTZmVyWDNXays3cFQzMi9hOTRpeVNWRzVNODRRRWE0?=
 =?utf-8?B?UWVpRlpIeUEweHRQMXpoOE5pZTA2dXZWMm9SamFJNldkTFluY3FZeXVOcXBk?=
 =?utf-8?B?em1IRlJUNFFMZVNCT3Z3TXkwdXRjbXMyL05VY29RRDdHMG80RFh4STVTUFMz?=
 =?utf-8?B?SDVCdE40a2hEelV4RVZ3eDJ3NTJkbXdMdDB5TWhaRk4rVWp1alZuVHU3RW0z?=
 =?utf-8?B?cllhNC9XOG5DMklGTVFSSjRCVnRPODEzV2tneFFTa2g0WjBuaUdSZDZQWGhz?=
 =?utf-8?B?M3ZnU00yVHdTNTRIOVNTb3FIZzc0aVlEZy9BMWFIYmlDZ3RwaEp5cHhlVFFN?=
 =?utf-8?B?bC96aWNFREovZlF4LzVJUHkwVW1wUFNHRmNxNFBTSUQ2cElPWjdReVpZTmhw?=
 =?utf-8?B?QWtjMy9ON3FYZGZYZkd4UEpkUG1HVDRhdE52WEdHYmRxcFh4QW5YcXVvbEx5?=
 =?utf-8?B?VTlUWlFhZVd4YUJaSUt1UFg1SVM0Y3lJY0VBS2trLzV0M284M2V4Y1F2Z1JI?=
 =?utf-8?B?QW1lVnRJdFFKSFEwRXhuR1dESnNITWNISWkrbHlPMWd5RHVNS1lSR0dNMzBx?=
 =?utf-8?B?dmxVaXJnanFkOFRMdTNreE9iaE9RQTFDMWlGY3IyckJFYmJ5Q3FJbXE5NzRw?=
 =?utf-8?B?Yk9WRzhvcGhRSlZma3hXN1lIQnI4cVp6NDZDcFF0WG9PTmwrRmNxcmIyeTJs?=
 =?utf-8?B?SkpTZjNFNTJRRy9naUNiNzc4Q3FIRzIwTmhGbUtudjlyRUZKWWMrWUZUUnVD?=
 =?utf-8?B?VUJ4YTd2WDFLZU5Xc0IwN3ZEOHZneE93OThHekpHUmN1VG1HbzYxUXFyU0k2?=
 =?utf-8?B?RmdCMGkyWWQzVFdpVHVmeUNFTFlvbWFlVlNiMVdwVUwzY1JaVHROdUZjc1VM?=
 =?utf-8?B?QlJDbHo3YUJRaU51eUZsWW1wTEgydVM1WjhNK0VPTHNnN1RWSmNCY09PbjI2?=
 =?utf-8?B?aWw0S1QwNnZBbE01dmJCVkNRRFJWUXdWVkljaXM0Z1VyU1RoeGhFakVWWEF6?=
 =?utf-8?B?elNMS2xRUGxXWDZwdVB2K2grMmE0VUFtYUJ1cWV1YVU5TWExQkpkMHdpb0FT?=
 =?utf-8?B?T1VvRU1sY0RSQU1LNlhsRHp1eEE0aHUzeWVHMkdyUlVsVTBONXhjYURFS05B?=
 =?utf-8?B?alZ4eDArVFUvc2Mrc3FEa1RTQ0g3N3JmTld5QUtrSHU0YkVUdkdsbHhrSSta?=
 =?utf-8?B?RzJ4MmV4K0I0MFRhMXZjNE9tRFhEODJsR01idDBoUHFJOWoxVWxzbjUvUmNl?=
 =?utf-8?B?NGVXYXhBSkk3RlVGMEJUTjkrN1NNOC9KWkV3WUdzaDUycnJCSFI2bmF2SUtQ?=
 =?utf-8?B?bzFGamNXZE5KbGxZM3VqR3ora2xSYVYzTmkwK2E5cnluSXgwRHpBT3VrQ25Q?=
 =?utf-8?Q?7AWRczPkI9fLQKhKRbNKQUc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b31bc95-1cc8-4d1a-aa69-08dce2609cb6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 21:32:55.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZe3g17kqFgDyrDUZt0+hzllyWBZHG63C36ok+qlWROPV92DS+Q2hqH54hGOu3R4KTaYWhD9TejTVz6gFkz434Psk8anZW4qnt8E4/cJuaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6637



On 10/1/24 2:02 PM, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2024 at 01:47:24PM -0700, Yang Shi wrote:
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index 1e9952ca989f..de9f14293485 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -235,6 +235,11 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
>>          return sid % STRTAB_NUM_L2_STES;
>>   }
>>
>> +static inline unsigned int arm_smmu_strtab_max_sid(unsigned int sid_bits)
>> +{
> Can we take the smmu struct here instead of the int?

No problem.

>
> But yes, this looks OK

Thank you.

>
> Jason


