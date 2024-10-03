Return-Path: <linux-kernel+bounces-348603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218098E994
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57C31F24FAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F65914C;
	Thu,  3 Oct 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BY98tCMc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4287B67A;
	Thu,  3 Oct 2024 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935082; cv=fail; b=lhy5OFdO1FAK7al8hMgTQHxwJxB5PwkAxmFFSrMS60vlyHJXiCi0mnFzmnHgH3pntO91QHZ9kuRbadLjB4F7lnHdeCafV6X75j1dodNeGD+r2q+ElwikuQr0yuwzzdY5FzuOdh258ixSRiomqFvgpgICryjXROQS648lR1SUVF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935082; c=relaxed/simple;
	bh=VJbyl2r/GIZHiALhgCirBRizKX8UXTPkaxAWW2zLTNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bplA8VXk4ZMY/egAHSp/sHgzA+zlvc+WtCM+ALayLYivd3HK+EYdEB9earrwf55b8Z2Ml+YVzIkqDR69SmhZLV5m/7wOoTUtxfXef9dd4jW0lIKaY0Fmtnrb70WbwodNYDszwqRMxEMIbUHGiJTKDc9Ij2LSZqhDwWQ1VAV+XDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BY98tCMc; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDW8dv4dCRIqBYkUxSf4IUj6515Z10sDDk+Z6qyuI2FxLwgoEh1y9W2RgRApHgGEstVORORTjIut02i/KFc3nyo36z2uZXSqOORbcjcHWqsD/C1Csta3B2S6DaTiZBpyfV13cwlXY/U1C4DW9nEOHxdq6Ku7rReufTHJPqUVa0+IYHXm1vNrMg+iL0u4TwrVTfFIcfpqgl1FYB9+MPYACeXXn56EZVI/uhEpTlqdIGjkobD05fiPRhSlxyVn0WHW+fQgLhOka3Xyw7RDcqgJMdWHhokznFAfb16reEaYkIGiS8sM5KNE+F47vt65npityooA6rR1Xs34ldmdEI35UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfPi1MR+9hZ0PeBacvwUVg9cOj65Tq+n7AFjYJVrT18=;
 b=TzvySQveoFWS6zEwQ8m5RKZ61U7M2AKIT706ReraRPfragWc4rFt0R+ZGqE5gqbyACT74aIUsEXBQuhZm7PJu+nG9veAreDjxj9k/OHFTeHEzYHYs834yOhTYEIaej8jeScbzzhMokDi5e1t/ZUzeejqbNZ4yUCZLdbGFxSRmzn5cmUjvJ7JHtldlR2ac9CZgl2+kp5Ep0sCf7C+D6qnCdxdy7jr+CKRz7TUaWTe7dFU3m5Oa29XciavVXtLkzOaD+io7E/PcYvJDUlRGGADem2nSCzbMMXbO3slvcDn3bO66Ct61LUEgGautWuFPWr1TdjiWI/9Lw++ErDDMrqVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfPi1MR+9hZ0PeBacvwUVg9cOj65Tq+n7AFjYJVrT18=;
 b=BY98tCMcc22UU+3eFTHY7v+W7bQj+KuVyrnPjXiWalUB842mM9D/kNIvdOzrMe+DwWL/YiUVzBqax1DTl3eTvDV6AIWOaBRu5LWuQooliTPsjbKeyROkN8l9J7IZbZ20BvrCJzMImAW4SOkWGoAA0Y97msaGRB+sWtevLdQR/HE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 05:57:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 05:57:57 +0000
Message-ID: <f85ff93a-20be-41de-92a5-55f43a580684@amd.com>
Date: Thu, 3 Oct 2024 07:57:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: si5351: Make compatible string
 required property
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <b4b626c85ef3f75a0de936c818b2fff389e92c6d.1727855465.git.michal.simek@amd.com>
 <fa249ec7-409f-4dee-b853-736c5de464be@kernel.org>
 <74e07428-2ed4-47e2-a8ef-360df0252e17@amd.com>
 <7695cae2-33a3-4879-b8e5-d296d81ffece@amd.com>
 <938253b4-91d3-4217-a2c5-d8bd707f0e47@kernel.org>
 <20241002214129.GA1347474-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241002214129.GA1347474-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a3d8a1-643c-4a7f-f295-08dce3705445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2NYek00aEZLelRGZFBvK3ZHb1FZUEMyemg3b0hKZFIwVTU2WVpGM1hzekpG?=
 =?utf-8?B?cnhQZ1M5ZElSc3N1blQrQlpYWE5mci9hVmZ2QjI1cks5ck9jVmJhWlBmVmdI?=
 =?utf-8?B?bHlWVzhwcGh5UFo4aEJ6UUFkbSsxY0pVNFZ6N2VFcXN6LzJ5b0lwZXpIWWJl?=
 =?utf-8?B?b3FUZjNJT3RsNkEzQW9rZEt5YjRJREVLWEd1VjRGKzNPQjNUekFRUlRrNzR5?=
 =?utf-8?B?N0xlazVFZjM0QThQWjJ3ckhKNlliN0J2OVdGWXFLbkM4d2ZIRkNLRVJxZGdz?=
 =?utf-8?B?UTdoV3MrY3RSNDJLSkhYTjl0b3NRS2lFaG5Jaloycmw3K2NvaTJiSzQyL0kr?=
 =?utf-8?B?TVZNRGwvL3gybi9SeC9zbUVnVEZoZTF3TXkxcDdab2xXaHBsai9lTm04cnJi?=
 =?utf-8?B?MzhNaUxUcVMwblBhclI3RE1aRXRVMTUrTmZ1MC9YQVo5WUZONEFORVRhUmRZ?=
 =?utf-8?B?LzNzK3QxNjh0RlI5bjVtU09jVmJ3ck1qOC9jODRrWkpqdDUxQ2FORjRuNEhH?=
 =?utf-8?B?aGxMNDFva0UwcUY5ZWdUdUtLS1VsbDNkWm4vSThsVkpwanZFeStXcDVhdDJz?=
 =?utf-8?B?VWdJemN2WlVpL1orSWZBNWNKRllBNldxeUZjaDUxV0l4bzZaTWp5OEV4UXdL?=
 =?utf-8?B?NEhpT0hlZjBsUmZrQjdVVXVkOE1wQURzZEJXZnVxSTJrSW9tUGpRdlIyN2Ja?=
 =?utf-8?B?cWZCM0ZDRW1mWSt5bDlNV1ZLMUZVWkxXNmhKNUZNazJYTENlU0I3TDZFcXN2?=
 =?utf-8?B?QW5HdEp1YzFiYkVQSVpSeXNqV1B3MEd5STd5S3JLNGFvSlpLbk15VFlVNkts?=
 =?utf-8?B?b2ZpUVBnTlFJLzRCdDJhcnNLZThSM09mbzhpeHluMi9DRkJkaWQvZVhORXVN?=
 =?utf-8?B?bXB1YlJQbmgxaGhUSEtLeHBNTFBUY25NR3lWVU5GSzN4dGJrWjJoUEJSTmhw?=
 =?utf-8?B?SlpBWTNZQkx5cGFINkI0TVY2RHNZZ3l2NFFORytXM3k1MUx0VGFpZmx3YmFX?=
 =?utf-8?B?TEVYdkpRSFhhSG5pMmNEb3BMTXBBMjI0d0k2OGkzTzNWYjJwQ2kvcWlXNGtt?=
 =?utf-8?B?M1pJTmd2WEhCT2x6TUxxQ3pjUkQ1YWtBUUpRNTRqdkc1eG9aMjdPbndEb3Qr?=
 =?utf-8?B?U3ViYzRVRUlGejVrVi94NExMTiswS0VzVDVXNStLM0VYSW8zQkYzQ0hXaS9y?=
 =?utf-8?B?MEhXR2FGaG41dWd6WWp2ZkRUMmd1bXQ3WlVDZWhEbThkdjQxM3U5bnJMTzJP?=
 =?utf-8?B?MXI0b1ZNQUkvOGNxOXVxUWRsWE5UdXlwZTlYdnZrQU5CTmZCcE9XSklxSFQ4?=
 =?utf-8?B?Y2NBUTU5SUliV1hwRzRzYTBjQ3E2RDlJSWZJMks2QVlKZk0wcDJydnQvRHpJ?=
 =?utf-8?B?akxBQWJUL1BsenJ6bnNjaWhYR1dQWElUZnVRM3Y3bDV2dUdyd2IyNlpnMkE1?=
 =?utf-8?B?ejgzclh3Nyt4bldFK0xqS2xQOTdPYUJWRHVadDdlZUdhcEVncFpUSXlBOUpK?=
 =?utf-8?B?MWMzRUY5cUlGTmlKTnc4UmxWUlNaQjN0SVdUTHNqK1RzcjJCM3huWU9INDlu?=
 =?utf-8?B?QWlZV2xvaEFGVjhEK24wTXBlTHhMMWxuK3hFTFY4OTllU1ZhZjdZNzNSZVlJ?=
 =?utf-8?B?Rkk2czhwOWZ6cVVmOHNtcTBYc3ovZWpsRGdWMm1uSFl3UHVTSU9reTZJWW94?=
 =?utf-8?B?QVcxOU15Z2NWSzZQejJGRkwrMEpVMnhIajFYeUFjQlNZSjdYSERaZG53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFrS0JSM0szZ3lPUzZpUzNKTW9kN1VKWFFBelRreUVtYXVMOC91dGUvVW5C?=
 =?utf-8?B?RmdSZzAzMkxqcGlQRCtqSVBpQWE0eUVnendJMU5XSHFDdUhYMlB5RHJjVjNv?=
 =?utf-8?B?c2hyMzNpZkVCd3RNa0tIcVpJbGtwaHNPakJvSHVzTmErSHhjUVk0Y0M3SGdr?=
 =?utf-8?B?UFZwNmpZdGFhaVh4VnpMZTVHd1ZqMVhrQjNTSFlnMW1VQ2pIQ0g0eTc2ZVhD?=
 =?utf-8?B?Zk95L0M5ODBZbUsrb0xsRkNVSTJYOEM0Rk42OE9FUDVacE0rT241d09XYVd0?=
 =?utf-8?B?bVVHV3BRdzJDekd1QzJ1Vmk3RnNNbjFIa1JmeTE0MUFwMUkwMElsVmJ6Nmx0?=
 =?utf-8?B?dmVrRDZlRHJ4N3Z2OHA5a3ZHeXgxV3p0eDlJSWtBNitEOFNRMTZ2d21pVGdv?=
 =?utf-8?B?YzNGb3hzTnhWNjU2SnhGTVFUU2ZjS3lQbFpER0xUU1hIWjRBdzd5aFhPTHRO?=
 =?utf-8?B?SmRsNHAyUG4raXEvdDM0MzVvRmJLWnlyLzZreEFNM0llM3lKOVUxdTMrNVZM?=
 =?utf-8?B?VjdmVWFSRmQxd2krUXBMa1pYQnBhN2EwUEdFaktTOTU1Y3owZklqTkR5RGpC?=
 =?utf-8?B?Tm5lcDlZcEs1aFg1emZ2TlNaUHIzamUzTitud05GWmRidXBzSjg2OVFnTitK?=
 =?utf-8?B?TURZQitySm5jUTBZQVRVbTBiSFFlT0d4RVMrSW1KdHdOUGtNTFZsMHR2Sm5W?=
 =?utf-8?B?UGFlaUV6b042eHlqOFJBcGdHVmN0d0dJbUwwaXpLaFhDTjVOejRlbFh6U3Rr?=
 =?utf-8?B?MU5oV3lJT0hXd001SlZ0M2k0ZHBlcEM4R2FFUlQrRTF5OXJFbUN6cXpocHR5?=
 =?utf-8?B?VjArV3pnMEdTOEwvYTZaUk5UeHcvbzI4RDBySFdoTGZWWTVsSFQyQ21rVGJz?=
 =?utf-8?B?VXgxeXViNittY2M1all2M0w5Y2Q5RmhoWWxxcXl5dDRpMlp0OVgvUmdHZllx?=
 =?utf-8?B?SUxJSFJUczFxS2J0dURiT1F3dG54WVY1RW5wMW1IbWkvSjRlK0RwcTlaZUd0?=
 =?utf-8?B?cC8wSS94SEtDa1c3UjAwS05tNTJraFVQdGRTck5aWHBNa0VFVTVZY2NSMGkw?=
 =?utf-8?B?SHpjV0FYcndTNTZDckdkOU9OcW5QcUJSeERURUdTRStRRG5sQmJmZG9PaFNY?=
 =?utf-8?B?RU80RklDSExuYUtyV20wRzV6Y2FOTEVVZXI1NVdYNitIcFQ1THhxNFpwcGxJ?=
 =?utf-8?B?NmUycWE3UGlMN2tZNHh0V3d0R21VUTVqUk1BcmthQzR0Rnl5ZnVnVHZkUC80?=
 =?utf-8?B?UXhCU1drODlVMWtFNGFtZGdOeExqRFFiZHVNWmVwNlY2V3NCYi91T2U3Vmor?=
 =?utf-8?B?Q1ZuVzcxUVZYQmtuc3NqY3p3Ky9Hd1RSb1QvbmNoUUhnMTVoUXhUZkpwdi9j?=
 =?utf-8?B?dk9XdzhaZjMzZVRDQ0ViYVhqUVlJMjNDOFlFOGEvUnVtZFB6N0QzaG90enl6?=
 =?utf-8?B?dXAwdUFuTldka0lGU1NOdW9WVm11Y2dMekhacldvU1haeXlua2tlTWR1N2Zh?=
 =?utf-8?B?WUNxM0cxMW9pRU8xNi9FL0xCcW5tMkRnbVhMTHYvbVdQS1A5Y0I0UFNjQURI?=
 =?utf-8?B?a0xjS3hwSzc2UDF4UFhPbXlsdEIzOFRhdU5CZGtvUjd4N1NEeWlEMjZUNW0z?=
 =?utf-8?B?a1dMS3h2ZnB5OWlqVzdhRUdnUmo0ZHJ4K1prZG9DNWZOSDBYanV3bzF0MUtZ?=
 =?utf-8?B?K00vV0VIbDl1UFRuN2t2VE1Gblc1aG1XZS9HMXVkTzVHOS9laTJjajBqL0lL?=
 =?utf-8?B?UkdUS3krZkRXRlRpbzYranA4UHVyZHgyTUx0ZUp5MG1nWVBOSTRlN09BVWs1?=
 =?utf-8?B?WGJ2N29vYjRwaTg2cEdzbjA3WW1UdFlGeWlEV0JsdHpyQWt3Sm9oWS9tSXlF?=
 =?utf-8?B?bngwRmRldkpnWld6RmE1eGR1dGc5WjZVRjFhNGM4RHYrVGxsRnFmRnZhWmVs?=
 =?utf-8?B?NUZrWWdva2NaRHpXNkJqalNvVFdLelpHSUFSVjRVaFI4eTY4RVYwdUxBeFBx?=
 =?utf-8?B?V00wM2RSaEwzVmN0MkhhSHJxS2ZoSnJFR2ZXYzYrWVlueGlrTm1WVElTYk5P?=
 =?utf-8?B?U0pIeDJTeldEYWxWeG1WbnFPSWh4bkFGa1hFdVpqdDE1UWNpN0FaUnFKM2Y3?=
 =?utf-8?Q?S9U7RCBdZ4x9+L1F0bYb/SrQZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a3d8a1-643c-4a7f-f295-08dce3705445
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 05:57:57.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Wea0vcgwcvzRjOFZPZKlKg9CaafrqklknGHM+HaFR/h8rbU6AOk9ClLbKAzC3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368



On 10/2/24 23:41, Rob Herring wrote:
> On Wed, Oct 02, 2024 at 02:17:22PM +0200, Krzysztof Kozlowski wrote:
>> On 02/10/2024 12:31, Michal Simek wrote:
>>>
>>>
>>> On 10/2/24 10:24, Michal Simek wrote:
>>>>
>>>>
>>>> On 10/2/24 10:19, Krzysztof Kozlowski wrote:
>>>>> On 02/10/2024 09:51, Michal Simek wrote:
>>>>>> Compatible property is likely also required property.
>>>>>>
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> ---
>>>>>
>>>>> That's a convention but not necessary, a no-op.
>>>>
>>>> But how do you identify device then?
>>>> Or are you saying that device description is valid even if there is no
>>>> compatible string?
>>>
>>> One more thing
>>> commit 524dfbc4e9fc ("dt-bindings: clock: si5351: convert to yaml") is showing
>>> that compatible property was required in txt file.
>>>
>>> -Required properties:
>>> -- compatible: shall be one of the following:
>>> -       "silabs,si5351a" - Si5351a, QFN20 package
>>> -       "silabs,si5351a-msop" - Si5351a, MSOP10 package
>>>
>>> I can update commit message to describe it too.
>>
>> Devices do not work without compatible, so this is obvious... and like
>> said - it is already required, so the change is redundant. Does not
>> harm, though.
> 
> To put it another way, by the time the schema is applied, we already
> know that compatible is present because that is *how* the schema gets
> applied in the first place.

I get that argument but then based on this we should remove all records about 
compatible string as required property.

Thanks,
Michal

