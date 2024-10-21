Return-Path: <linux-kernel+bounces-373707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D619A5A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6610B1F21785
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F251CF2B3;
	Mon, 21 Oct 2024 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPzHIXy+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495A194C6C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492734; cv=fail; b=geYtAdzv6iEyDoyMaxCrPiabGANzBmyLSNbXwSwhzgwIiYujZCqR7wAeHCwMrQ/a6s/VksjiyOoHvEe4ZRbpiRV/roX80i5iyOXLjF8BZwNKuTgciEs5TgujK44f5jw+2sjV3eqnM0HZPYqiweXmDTfphoBrehUXUyXc5BbvDxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492734; c=relaxed/simple;
	bh=dB/fwnsLOkgrGaQvvW3974Hwq9EJFbmPKHgBBG1/O+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h7lGVVx/BeDxkXQtjjtT0zr1xw/jsWXew0Zvp52P+Dl7uixG5lo34ZW/0BU6rMnsNGK7ih8ZmhRMm/GPcJo2+DCxw4ATj0bkcPJjiGj0lkYjdEi8kNN83hOYxEZN0S6/aTOjGzDpdsKTV0CLhljw7oITfPaHEfkeSuGPGVzTRa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OPzHIXy+; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMEQi9M59c6AxhmYbm3dnW/UUHXKqRCsK6PLn4+vGXx9qFSuUBBg8caZtyRzBlxmBLtgevwgawv9W7dVNE51spXiy6T1eUAppZ3PV1oGfKX6wuBc4RIUh2cpDS8wCcnnAMQ2/GEHKXSQ0k+GuzDv5B+1OAHGoJXp4ZahV+yYPB6LXgDI0HUvOtoP2w/sfv+kS7EwVfkCY2cEFHMTo4pV1Bls8OfW78E2Aiccxkqsw+kNng40VuI37Cqq9AJSzmULMzstwBY+97M3+BzPxBzkivW1gow7L0z36x+p0558Apr3cMrAmnMzVbtC8pKWSQrMjaGu1j8WX2MoBRgni85XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4UxLUXITKs0amY6LqOzntXZ2H7+ajZJFQo10auQEyg=;
 b=UYP701Sw5xKBrBQ1yeCZx+Nrf77VH8ZdeyaWBtnhj2zwFUXDl6NEVEJucBJ2tZ9qzEyGJsYUtBzAgjPRDrwWbCONtszub4JJY4eoPzlcdXe8rmzprvovTMCihM9/VvQliG3rLNRD2nma3W87oLGwycwHrptLUKKLPXGkTFsjEY4y8KR8p12vd3e1F/dEwCGk2pGJvaxGoY/AsRcoQ62bUahjXbtxPNcE3hGC6WU4LLw1rySis3XXBgCE1NHqTnCKoRK9Q36VXSwCAVO3XG9UN+l5FTvOahy9iTziuw49Bf4Q1ZSSeMxt8XjUIrmCDS/hHbE653ZIjtPNb/Z/0PL9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4UxLUXITKs0amY6LqOzntXZ2H7+ajZJFQo10auQEyg=;
 b=OPzHIXy+ZVi91JmMz6OPM1cCfi+nYaUZow49bOB8pu/HxZgkwMKSZQACVcqPvpEPCt9B0D/uiiHwnkyCf/ee5SXWSbzh3VUucz4N/0q0uQaa9wB1RU6kkW19oYBdosUzEp6uMzlfNaPOneF6wilKMoxDs6kZHxgMFmAelfhUj6mT23ZjNg61NmsOsGLfvNTiG/DRq3QMUMPGYg+PBdgv273EqalWpJPzWxZBY99IPl0O3xeddpJ3rV0aG8Z527jgwm1YqeviTBzjcL42jxScw76lbgWk9/2b53b/cBPegyv5/+OhaWWPX7pQ06tJRPgw68nF8VgDdZJEo6mLUQu3PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 06:38:49 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 06:38:48 +0000
Message-ID: <f5a0afe9-cca4-4ed2-bdf1-0cd82f6e92b4@nvidia.com>
Date: Sun, 20 Oct 2024 23:38:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Alistair Popple <apopple@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241018223411.310331-1-jhubbard@nvidia.com>
 <87y12ibbew.fsf@nvdebian.thelocal>
 <142152a5-d265-4aa5-b103-dede882f9715@nvidia.com>
 <87ttd6atxi.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87ttd6atxi.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::45) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: ef88dde7-ee55-4698-9072-08dcf19b04eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVdub0dVbERtREh3WFhiR2I0WWdjcTl1S2NpcEdnTmcxalhnNXpaTXBUV0J4?=
 =?utf-8?B?cjdhVUI3R25iR3lKOGN4bWhUb3JUVjdyNjMySWNmQ2dFSjVGVEhoM1lpcXhC?=
 =?utf-8?B?R0dNaUo1WWRoQ3hjQzVhMjJOK0dtN2MwWVc3c2ZwZktCZDJ2c1k3TVk2S0Nh?=
 =?utf-8?B?TW41YXBmNUx5UHlHL0VLNERSV0hjeU4vRW1MUkorZi9nZENqZzNxYkhoN2ts?=
 =?utf-8?B?WFBWbVlNT2RFNC96VHVNVE9FdXFUQ2J1SmRLRlZxaFVJK051Yno4ZjhITW9q?=
 =?utf-8?B?aFVrbzNxWDhCSHhwc3A4TzhXMENZN1hwTHg0ckhBK21Qcy90U0c1NkhSZDNX?=
 =?utf-8?B?K01yMVVwWmxmbXloQnZtMFR6VUQvZjFBcXpjV1d0a2Z6anNuWWw3aXZBZ2tw?=
 =?utf-8?B?eHR5UVRIUzFqV3Vzc1hTalVxKys1RUpVTGFkNFZGdVBVajFib2grbk01TXhk?=
 =?utf-8?B?TFpvckwvSlpOZFhXbUZmZTFDNGNQcDB4T0FOTTJ3MWFjQVUrYlpNTmRGU3lN?=
 =?utf-8?B?ZkdzbG1KUlVWcjJ0MDVWc01RZ0c2TEVuWmdVY3R1bVFTQ0V2OWNZeFY4cnBx?=
 =?utf-8?B?N09ZdU5mWkk2aEZmSzNZbG5POEl5UEhHZ09meSs4UUhTalgxNUEyaVp3Znpa?=
 =?utf-8?B?RExqMml0L3JSSjJ6OCtKZFJVazlZUWtzbXQzNmo0b1BZcldqK3FNTWNCcS9N?=
 =?utf-8?B?dXpZWlFtckVkR3Z4d0JnRDRPdGJIbzhMV0xoNWVZSnZhcG9Ddm1QUE5lSGsr?=
 =?utf-8?B?ZE9aUml3QXJaWTJiR0NUeDQ4VnlkcjdLNkFmOURuSGdRR1BBQSt2eFFlMWph?=
 =?utf-8?B?VDUwUm1idEJsVGx5TTdzN1FGQjBOSkpVdWhDMFpOdmZNODlMTU9KTytBODQ3?=
 =?utf-8?B?MjVsVTF5ZmxVdTRDbUk1RHkwUzZBYTlXa1hsdms3aXdkK05NRnoxb2ZBUkRo?=
 =?utf-8?B?OGRtbVJvTkVkN1dVM2JVTW5NK3g5Q2dSSUxDWU1WVmp6clQ0alFLd3VMcVhL?=
 =?utf-8?B?NUtmOHJCT0lGaHdsMjRReG9IcTJIcTU5TnhWcnREZG14dlZUYVFxUlFKcEVY?=
 =?utf-8?B?ZFVqWnMwZiticXBOc1NWVDJ5eXh4ZnY2S0xRNDhPbGhMQUU2dDZrTGtNRUZn?=
 =?utf-8?B?ck5GZUJJMm1TSjlRcnVpR21WWjlhSitwVmJOaFdGQnF2VnpkSEF5MFFtcEpV?=
 =?utf-8?B?R2VXRWF3cGlPVmVJOUZvQ3Q3Z0JLNU13UnoyNWVzYW1hS1BKa01FQlZIR082?=
 =?utf-8?B?dTFLVE8rWk91dVRFYXdqZXVoaVpwa1V3L24rOXBqbi9lSEVXUXBYZVNOem5q?=
 =?utf-8?B?Y2U1c2p4UmJNQ3loZURzc25rU0IxVUd3d0trQk5ldm1heXB1eE11L1BHNFRT?=
 =?utf-8?B?L0l4ZUpoRjVOeXRiNzVicDBmdUNOWkg1cVFPSzRsdXYzYjZKdFlYR0JBa3lE?=
 =?utf-8?B?aE8yeHdLaXNHNmxMSmFCa1ZsNGdIbUF0MXJpdVErcEN4aE5MTFRPREE0NE9V?=
 =?utf-8?B?dHNpNjJDdG9jWFdqY2licTF4VWRqUFJLNXIxdkpjNDYvVC9oMnlRQm9FV2ow?=
 =?utf-8?B?YWs2TDZhRnJpUXdEdUhYMklFOFZ0akg0Z0N4RmpWUlhNcnlaL3VnQ0p1ZWt4?=
 =?utf-8?B?a0lITkdxMUl4Q1VlYWZxdnZoL0R1c0RKNjFqMVdOcE1lRUdJQ3J3anREeTZZ?=
 =?utf-8?B?TkpVVVUrMkZBSUtvS0NPQnhxelhSRWNablFTcXdIYjFnbzQrcGM1YlZKeExK?=
 =?utf-8?Q?N2agNfEIiP44xYEuoXcOGYZOkl2UiacYZOhXAak?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJmNHJKK3gvNER2YVhLb0gyMlBRNldKQk5GcHUxVXdtODFyUm1EM3lrdHNS?=
 =?utf-8?B?OFRuell2U3BzM0wzZExFeWRWelU4VDZvZWN5S1lIOG9LUkEzS1NwVXhKS3Rx?=
 =?utf-8?B?UENacUhXNlozSzUrQ2l1cUVDc0xCYUVReldTSEprZmxpSzd5UU5ZVXhNZCtP?=
 =?utf-8?B?NkZ5VEdHdUc1YkRtSUcrOWFLN1lFWVlWZ0RyZWlaVU9SSzlReG5GcTlWQXpq?=
 =?utf-8?B?bi95NkRJa2dRa3pzVGpsUVpBc0xZWjV2NnRJeFpXVkovSTVYR3VCbDRQbDVR?=
 =?utf-8?B?Q0VhVnNGSEptTWVOb1pnNk13QW52REhmWUxsa2hKNFdpVlRZeDBoREUxMzZX?=
 =?utf-8?B?QlJjZlEzb3g4amNyVWEzOTBEM3haamNRcEkrUTJIT0JweEw4RSsxeERDaXJu?=
 =?utf-8?B?THdKYTNRSUZldHdTMjMzTG9Da3hVV2xUNEpsVkRleW5STjdkUjg5S3ZRUmNa?=
 =?utf-8?B?cmpDN245KzVPQ0tjV0hyb3ZGTnhuOFNVcytYeGNVcmtFNUhOK3ZtUi92NE5Z?=
 =?utf-8?B?TVFpNzZIZFZPd0R0TEh1ZXlXT3d6ejZHcUkzc0I4MmM4ZVJCNkZzTUVzdnlO?=
 =?utf-8?B?WW95S1kvOGFob1UyTjM4WnkwVThkWERVcjJnM1lHeW9JUUFtKzNjMjRWYmhP?=
 =?utf-8?B?TVZ6cXArTUZoS3dWdm5sN3lBbC9oSEp4OHhxMWNYa0g3ejB3Vm9zZ1RlQThX?=
 =?utf-8?B?TkFzME9YTXV5RjgrSGNJOWgvcTN1VW9JZmxVZ0prMDBEZXVHNlNUQ1kvNjI4?=
 =?utf-8?B?UFlFYVJQMnVtengzbDkvWVZnWlI5V0lTVHV6NEhZWWF1NWw2N2thUDlCTmZo?=
 =?utf-8?B?R25BTmpzTlZCMk45K3Y1b3Q5L0E2Wk9xL1A0STNwa3hjd0RDNVpNbFJ6Umc1?=
 =?utf-8?B?WWV6WEZMeUxPU1FwMHJUN0JyL2FIZkViVEFjTzJVTlFYM1F0VHdnK2JoUWRy?=
 =?utf-8?B?bzhuWWh4TUZvZFJUNkMwQ0dhdnR1RlprQ09Mb1FMdzFwN2YvT1FTUlNYWXNT?=
 =?utf-8?B?R1gyc1dIeG9hSURMak1taHdMNTIrTmszaUQ2bFRoekFKTm9tTHd0Z25RZ1NX?=
 =?utf-8?B?Zm5kQjRkTHh4UVZTSSs2ek54RngvTHArZ0E0RjJwSmhqMVRQK3U2S3V2S0Qx?=
 =?utf-8?B?YnY5Si8vZ3gvemtrRDJzUVRnYmJDQlZOeFk3ZDJVWWVYdGRoekoxNEZ6RWg1?=
 =?utf-8?B?azlIR1pjckNPSTZEUjl0cnVVbnJkUGRjWGJ6dmRRSnFqMXhvb2ErZThFMGpB?=
 =?utf-8?B?djhuNFVkalFiQVVZaHdXYUt4M1BrbnQ4QVdETWNMcEVoUS9BUG00RUI1bkkw?=
 =?utf-8?B?aSsvOWk0aVVSRWhTT2pEZWVyUlA2UmlHMnNqbTFhNkF5OFFDcWp3WVAvVStu?=
 =?utf-8?B?SE95eWVEZ0hLYVJoc1U0V2tRdUk4MzBFNjhyUUpEbzhlUmFJMjliSHRxdkM3?=
 =?utf-8?B?Q3o3dlY0WmxRODVxcUNsN3IrSXhIUVF4QnBZaWNnSklLelBNN2xVSHpQdk5z?=
 =?utf-8?B?NGthNUlGZ2c4NkZESzFDelh5SkRQU2lRbzBiMGVzOElFV05lK1RuMkFvdkhD?=
 =?utf-8?B?bzBhek5JOVlXTHFQeXF4VTgzbVlCdGxNSk12N2NHQWNzNUVJaXhoRGhoSlZl?=
 =?utf-8?B?L1ZvUGNpMDV5TjROOUFnVnZtR3FQd2k1UElzSHFVUEVSbUxYSnpZL1lnNG1t?=
 =?utf-8?B?MmM1bitNUWpQVlVoNGVPdEZ2OSs3eHlEMytKbldCTXdZRTBkUEN1bEdYR3hY?=
 =?utf-8?B?WmRzdmVwNjh3cnF0bXlWZnZTYTRJUkE1bkprazFWVlhaWURlcE9nVEJRMHpE?=
 =?utf-8?B?RFRKS2xZYnJaZlU4aEpQS1EyOS9qQkhsVWVCQm5meml5YjJKcFZNSWY5amJW?=
 =?utf-8?B?WjA1N0x1b1pwK0tFNDVvSzlWazlkTEtkTStSKy9SWGk5QStqZmZ1VmQ4QTBD?=
 =?utf-8?B?NEh3ZTBnT21UWnJUV3FyZUF0Q1N5alltUEZwTkZWZzlFYjIvUVdtdWhKdXlq?=
 =?utf-8?B?aldEclNsNWNMeWxnQ05OSTI1TG4rcmJXN0pGaFpBbHE5bjQ3VGtocWNXMHB5?=
 =?utf-8?B?K1lEZWp1VmdXR1BFeDBtZEkzbllQbDNYbFhUNUpOdWtJMU0xZHFWYlBaSkxl?=
 =?utf-8?B?clMvdVpTTjhUQnhxTjIybXJyVmRpQTVqQTJqcGtmNjNiTVpncURjYUx4SlJj?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef88dde7-ee55-4698-9072-08dcf19b04eb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:38:48.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mYmau8/pgmhShb4qQvb1Zcd06UmEhmeDcwqy73+Ei+utGvx7I/x1arxp8Y4LU90rvQhMJq16saPNgoFI/6Y/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

On 10/20/24 10:39 PM, Alistair Popple wrote:
> 
> John Hubbard <jhubbard@nvidia.com> writes:
> 
>> On 10/20/24 4:26 PM, Alistair Popple wrote:
>>> John Hubbard <jhubbard@nvidia.com> writes:
>>> [...]
>>>> @@ -2437,8 +2440,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>>>    	long i, ret;
>>>>      	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
>>>> -	if (!folios)
>>>> +	if (!folios) {
>>>> +		unpin_user_pages(pages, nr_pages);
>>> ie. Doesn't this unpinning need to happen in
>>> check_and_migrate_movable_folios()?
>>
>> It already does.
>>
>> check_and_migrate_movable_folios() calls
>> migrate_longterm_unpinnable_folios(), which unpins if errors occur.
> 
> Right you are.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks for the review!

> 
> As an aside for future clean-ups we could probably get something nicer
> if we reversed the process of pin/migrate to migrate/pin. In other words
> if FOLL_LONGERM try and migrate the entire range first out of
> ZONE_MOVABLE first. Migration invovles walking page tables and getting a
> reference on the pages anyway, so if it turns out there is nothing to
> migrate you haven't lost anything performance wise.
> 

Yes. In fact, I see our emails crossed, and I just suggested the same thing
in reply to your other comment (in the v2 review thread) about short vs.
long term pinning. Great! :)


thanks,
-- 
John Hubbard


