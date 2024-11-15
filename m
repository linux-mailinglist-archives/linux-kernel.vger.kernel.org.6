Return-Path: <linux-kernel+bounces-410276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810889CD74E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A58B247EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B9188A08;
	Fri, 15 Nov 2024 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="lAIakeUv"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45443BBEB;
	Fri, 15 Nov 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652811; cv=fail; b=fZhZXcRjKb2VNN6l7r3XxgrtggTLFv8mKJmwFoWGvDBJUSDD7nwG/Vg6hlhrQ2pd9AFxRAbfcCUazGBky2VueUbR1BEiHyfWxQJ0jSiZWkPz++kc3QXLjwOdfdFUwcE371fgLSDgm8/eUvshcBSgSUYXh5zBV7HBm13BqQtgAZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652811; c=relaxed/simple;
	bh=sAnzgxY1QbANmHLsBmV1WWfK1I/WbJogV8y41qHH3hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jmq7UqpXQdZJBVJK6Qvj2bXWG5WN+nzideFEsJJ20SXNJExeKESlQLcX9I9Juf1NFRvNr5FdEwWSWmn/JowMuYZxaUiaEaqCPLTrjAZthRho0qLEwOStRj3xPPp5QHoheiKLiWk8S9k6sMiJ/eRYg3oFuEE+9mpNJzD1LOtQhaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=lAIakeUv; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdYyzCPgRJFZcygTsaDwXBD/ri7GwXKsht2IBNNzAflu481brAytlF7tceLBIhlouNZKCTPbf9ts1Fn4rhKkyvfmWXOUD5b8BDcT4qDJsO9ocXUdwb4ObjZg7uYFL9LQCz/fOHnepzO1Go4eQOiLR++4hgaCn6Gc+r8Jr4PNvsm6tN9MPjG/kp3wpsrwUCQxGFi6j3xk7mAxv9CNSO/fPba0aUGoWGbHFNt1q3Qz3DfCeZNz+ZtotcW0sqdHMb2Jfk/C9V4W5iRfV0jQ7S1Quq4hLJ3aX4pE4ctXzA2OEj9dHRTtGC0vYzKmj/7LX3E/skJCcvJg38Tka9sOo0xejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oCbPMkfsjZj6A6ARqdwXeRZiaVSKiy28DAYrDgdpeI=;
 b=CRUdSnWaQL+JiL3Po0pdf347CpfMZNxkfU0INqsHMHA1Kf8lUtHdL+pw+OAhp5PtTeMKFt5lLpQrzegDfYe0Lvtwpm30lFFUbLqU+oyolF4JgJFtILZS0KAMCJ2Ri0bwPtq+MxOu2/LXE5HuYZrGXOWzl9m7hfEZqN/IY+jGRv4KmLKTANo2sg2TswpuDju8K2vLF4AGrSMeIhOijCVzsYtM170UUzXKTAHJUuDpTevintuD9/oXoaMiCg2+rjgF4D5LgfDOe58QnMK6xcmiMEfs0Z7WO72HmiHo+7H90CRpIsM10JfNQe+Zcboac5qlkBkCA6QudtSlQFDqvcIygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oCbPMkfsjZj6A6ARqdwXeRZiaVSKiy28DAYrDgdpeI=;
 b=lAIakeUvd/oNgmw8khRnioagNmle9WSGqFkla1wA0xpDfXhM/DZmA9eii/uKfYt8KSPsWKstOgXGoE28Y/OcDimZj0ZNhAnVrMppQO4epIBAKHKPRwCLID1cUqoT5cFNeuqfJKpiHi+UKFKVuVVWOTLwRT0sy1fqePoQj3xRAN3QEG3CUe7KuGC0WGwLyO/FTQ9buQFB9e0kGOtzFsiGrg/Nuu4usxr6V++VriCLq1VySW/mW298NRNRImZRr7ripayuUxxQIDQFsKgTWeh72o7/x/mJIFY+mhEerw8QKklc+aL6JA9+r27y1rb8Vhj02MelOOdGMPxStZBbAr5ubA==
Received: from DU7P195CA0025.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::30)
 by PAWPR10MB7675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 06:40:03 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::13) by DU7P195CA0025.outlook.office365.com
 (2603:10a6:10:54d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:40:03 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Fri, 15 Nov
 2024 07:40:03 +0100
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.43; Fri, 15 Nov
 2024 07:40:02 +0100
Message-ID: <217eee6f-2085-4b6e-b363-96c8d6962060@de.bosch.com>
Date: Fri, 15 Nov 2024 07:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@gmail.com>
CC: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>, Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
 <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
 <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
 <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
 <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
 <CAH5fLggCDiKUu_dvJZeJr8UD5RvUpqRJbdYKf1F3_MvCdOVK6g@mail.gmail.com>
 <CAL_JsqL+b-f5K24qTxyA09c_QPeb07s4Hb=s1VqrdksBB4BQ=Q@mail.gmail.com>
 <79c47555-c9e9-4ff6-8c43-c7c26a91afd4@gmail.com>
 <CAL_JsqJkkUk6AoAdgfVHROk=wpRo0En=gi7zwXe6S7LUEsdocQ@mail.gmail.com>
Content-Language: de-DE
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <CAL_JsqJkkUk6AoAdgfVHROk=wpRo0En=gi7zwXe6S7LUEsdocQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PAWPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 682f261d-93df-4110-c8bb-08dd05405617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rmx2VTRpL05GaXk4K1A2dWpmN0U3UTlCeGtnVDY0YWRBdC9ldTRvMFpkTWxp?=
 =?utf-8?B?UGRaNW5PTEsxYWVYN1VPWXlla1RlenJUdzRMTkZFV05GMk1XdWF0bGVLZDAy?=
 =?utf-8?B?ZEFOYlFRLzNzUzhHNHpCd3pnY3hnUzQwaFdOZFRxUjRwZ1pyb0tMTUV1WnlN?=
 =?utf-8?B?ZCsweUhiSUh4ZUNQRmlTVEduSU96UkxmQjlhQ3gxU1QzS3VXYTJWR0ZhbjVv?=
 =?utf-8?B?SGwvdzZHR1VaVEk2cDlkYlo5a0VrUkdUbWJzT2NOcS90S2tqa0ljRW9yNlRM?=
 =?utf-8?B?R1NtNXY5RkdGTktFOVJ3TXg1S09CUEtXaW1XY0IvY2VlazRCMmM3SFBnLzFy?=
 =?utf-8?B?V3IzcDE5Sk5UOWxvODFSNThDQnJPcnFzblA2Nyt2dEhadXNNYS8wankyaGRV?=
 =?utf-8?B?ODROTVR1My9mcUVQQzBiR0ppQkxWVUIwZG5WVlBHUUswOUZMWVAvcGw0VWh3?=
 =?utf-8?B?YnA2dWZQak51cDd3ZjdIcjhTNlJxelB3T3V4dUU2dUxITmRNWVpLZDVaOHh5?=
 =?utf-8?B?V3psakNoT0dzbjNvdzFBNkMzODYzSFpENktXdjBjWUlZQkxSK2k2UG9UVU9T?=
 =?utf-8?B?M0dvUkdsNTNGOUZralhpMzFYMFIxS280SVVzUGZHUDU0dEdia2FERTVFeVcw?=
 =?utf-8?B?NjVOTHUxOUNldlIyaEIzRTUxSkttR01hTHpaejZNNjFVK1VHcTZmelZuNTFp?=
 =?utf-8?B?VStXbmpBbXJiaUR5ZTBnNkgxeXp3b1ZDajAwcUhRRFlwbTA3VVVUdVhMS1Ux?=
 =?utf-8?B?L1dlZ2JGMVRGbjh5dmhnT3V5Vk1ONENUZHQrb3FBa1VkNy93cnhHZHJRcnRO?=
 =?utf-8?B?TDBlMzRLQS9HalQrUy9WMlVxeWNCQW14c2IzTEJuRkVHZU9WSFNyTEw4WC9i?=
 =?utf-8?B?MW9sbzdQK1V4OVJMUXJrZkZrQnpFc2hGOFQxTTdkQTBJb2hWSXVIY1lEbjRu?=
 =?utf-8?B?N2Y0K2FDU2phb09TZ294dldsckp4S3hxOVFTK3FDSFJkaEw3cnV0M0RnQm1o?=
 =?utf-8?B?NTBXaWVNcnB5SHFpSEI1bUVrNzBWSDgxOStYK0xKWW9pSkJyU3dNUFV0Nnhx?=
 =?utf-8?B?MW5TYy8rV0FpNHRNOFJDWU5mU09tUWNuakxGbFR0ZGY2VnN1Tlk1UWtBZ2VJ?=
 =?utf-8?B?VW5lOUo5U2owQW4yT01FYkI5bGsyY1lYd3FCa1lBL1ZvdnlDQ0wrL1VxZFc2?=
 =?utf-8?B?RkxCbEdra09rRGpJeUtiN0wwdk93UlZIRG81UEw3aEV0am9TcnFDUW5mNHBJ?=
 =?utf-8?B?OUFsS0ZMRnJBYlJEdjhrTUN6NGtwK05kNjdyak5KeDZjckpDOGNHRlNaYXc2?=
 =?utf-8?B?dDNuSTRSczVVUk5mWmZFSzB4NXluc3JoUmtna3o3d3FVN1pDSXR5dzJaaCsy?=
 =?utf-8?B?RUxWdlRFTndYN2ExWldCRURsSUxncm1SRXpaQjZndzdlT2JEaTMvaWsxYm9S?=
 =?utf-8?B?MWVJdkU0ZWd0ZTNYYmxwaVBOdHJCMzFIekNqeWlqNzdzSEpSdTExWk80Q2xP?=
 =?utf-8?B?N2xrQjJuSmEyKzU4ZXdqYTRxdU1ueEVEcytGRWlGL0lPSzVmSVJ6UWs1NHox?=
 =?utf-8?B?SWxTWnRGemdSS0F2NGFVVFNDVGpOMHB5a0RPZHAxNmtCUi8zd0hEcTRNWW1W?=
 =?utf-8?B?ZjJXTDZvOUZrK1FoLzlBSkV6M3NwN2YwallLRCtZZ21Dc3BuL1VhbW1QeDRi?=
 =?utf-8?B?MjRGbHpzd2paWUQvWEJzYzhkZHZjanpUbGpJSDFMTFoxRDBCU3RpZTFqQ1hR?=
 =?utf-8?B?aEZTNkxBQ0JvVXFMaXM0TTAzenhlUC9zbVFjcEVEZFRicS9MR1NOWUROQjlw?=
 =?utf-8?Q?R2KRnxch1ofoR2qpGDt71ZbJHLsOTZhdLhQbc=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:40:03.5986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682f261d-93df-4110-c8bb-08dd05405617
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7675

Hi Rob,

On 30/10/2024 17:47, Rob Herring wrote:
> On Wed, Oct 30, 2024 at 11:03 AM Dirk Behme <dirk.behme@gmail.com> wrote:
>>
>> On 30.10.24 15:05, Rob Herring wrote:
>>> On Wed, Oct 30, 2024 at 3:15 AM Alice Ryhl <aliceryhl@google.com> wrote:
>>>>
>>>> On Tue, Oct 29, 2024 at 8:35 PM Rob Herring <robh@kernel.org> wrote:
>>>>>
>>>>> On Tue, Oct 29, 2024 at 1:57 PM Miguel Ojeda
>>>>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Oct 29, 2024 at 7:48 PM Alice Ryhl <aliceryhl@google.com> wrote:
>>>>>>>
>>>>>>> One option is to define a trait for integers:
>>>>>
>>>>> Yeah, but that doesn't feel like something I should do here. I imagine
>>>>> other things might need the same thing. Perhaps the bindings for
>>>>> readb/readw/readl for example. And essentially the crate:num already
>>>>> has the trait I need. Shouldn't the kernel mirror that? I recall
>>>>> seeing some topic of including crates in the kernel?
>>>>
>>>> You can design the trait to look similar to traits in external crates.
>>>> We did that for FromBytes/AsBytes.
>>>>
>>>> I assume you're referring to the PrimInt trait [1]? That trait doesn't
>>>> really let you get rid of the catch-all case, and it's not even
>>>> unreachable due to the u128 type.
>>>
>>> It was num::Integer which seems to be similar.
>>>
>>>>
>>>> [1]: https://docs.rs/num-traits/0.2.19/num_traits/int/trait.PrimInt.html
>>>>
>>>>>> +1, one more thing to consider is whether it makes sense to define a
>>>>>> DT-only trait that holds all the types that can be a device property
>>>>>> (like `bool` too, not just the `Integer`s).
>>>>>>
>>>>>> Then we can avoid e.g. `property_read_bool` and simply do it in `property_read`.
>>>>>
>>>>> Is there no way to say must have traitA or traitB?
>>>>
>>>> No. What should it do if you pass it something that implements both traits?
>>>>
>>>> If you want a single function name, you'll need one trait.
>>>
>>> I'm not sure I want that actually.
>>>
>>> DT boolean is a bit special. A property not present is false.
>>> Everything else is true. For example, 'prop = <0>' or 'prop =
>>> "string"' are both true. I'm moving things in the kernel to be
>>> stricter so that those cases are errors. I recently introduced
>>> (of|device)_property_present() for that reason. There's no type
>>> information stored in DT.  At the DT level, it's all just byte arrays.
>>> However, we now have all the type information for properties within
>>> the schema. So eventually, I want to use that to warn on accessing
>>> properties with the wrong type.
>>>
>>> For example, I think I don't want this to work:
>>>
>>> if dev.property_read(c_str!("test,i16-array"))? {
>>>      // do something
>>> }
>>>
>>> But instead have:
>>>
>>> if dev.property_present(c_str!("test,i16-array")) {
>>>      // do something
>>> }
>>
>> I think we have "optional" properties which can be there (== true) or
>> not (== false). Let's assume for this example "test,i16-array" is such
>> kind of "optional" property. With what you gave above we need two
>> device tree accesses, then? One to check if it is there and one to
>> read the data:
> 
> Yes, lots of properties are optional especially since any new property
> added has to be because the DT is an ABI.
> 
>> let mut array = <empty_marker>;
>> if dev.property_present(c_str!("test,i16-array")) {
>>      array = dev.property_read(c_str!("test,i16-array"))?;
>> }
>>
>> ?
>>
>> Instead of these two accesses, I was thinking to use the error
>> property_read() will return if the optional property is not there to
>> just do one access:
>>
>> let mut array = <empty_marker>;
>> if let Ok(val) = dev.property_read(c_str!("test,i16-array")) {
>>         array = val;
>> }
>>
>> (and ignore the error case as its irrelvant in the optional case)
>>
>> Have I missed anything?
> 
> If you grep "_property_present", most if not all calls never need the
> data. When you need the data, you read it and test for EINVAL if you
> want to handle "not present". The overhead of parsing the data is not
> nothing, so I think it is better to provide both.
> 
> The typical pattern in the C code is:
> 
> u32 val = DEFAULT_VALUE;
> of_property_read_u32(node, "a-property", &val);
> 
> // val is now either the read property or the default. If the property
> is required, then the error code needs to be checked.
> 
> Maybe we should have:
> 
> let val: u32 = dev.property_read_optional(c_str!("test,i16-array"),
> DEFAULT_VALUE);
> 
> Or looks like Option<> could be used here?:
> 
> let val: u32 = dev.property_read(c_str!("test,i16-array"),
> Option<DEFAULT_VALUE>);
> 
> One thing I'd like to improve is having fewer driver error messages
> and a printk for a missing required property is a common one. We have
> APIs like clk_get and clk_get_optional (which parse firmware
> properties). The difference is the former prints an error message on
> error case and the latter is silent.
Maybe something like [1]?

It uses 'None' for mandatory properties and 'Some(<default>)' for 
optional properties. And gives an error only in case of a missing 
manadatory property.

Best regards

Dirk

[1]

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 4161e7534018a..d97ec2d13a0ba 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -214,12 +214,26 @@ pub fn property_match_string(&self, name: &CStr, 
match_str: &CStr) -> Result<usi

      /// Returns firmware property `name` scalar value
      ///
+    /// Option is None: The property is assumed to be mandatory and an 
error
+    /// is returned if it is not found.
+    /// Option is Some(default): The property is optional and the 
passed default
+    /// value is returned if it is not found.
+    ///
      /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
-    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
+    pub fn property_read<T: Copy>(&self, name: &CStr, default: 
Option<T>) -> Result<T> {
          let mut val: [T; 1] = unsafe { core::mem::zeroed() };

-        Self::_property_read_array(&self, name, &mut val)?;
-        Ok(val[0])
+        match Self::_property_read_array(&self, name, &mut val) {
+            Ok(()) => return Ok(val[0]),
+            Err(e) => match default {
+                Some(default) => return Ok(default),
+                None => {
+                    dev_err!(self, "Failed to read mandatory property 
'{}' with error {}\n",
+                             name, e.to_errno());
+                    Err(e)
+                }
+            },
+        }
      }

      /// Returns firmware property `name` array values
diff --git a/samples/rust/rust_driver_platform.rs 
b/samples/rust/rust_driver_platform.rs
index 95c2908068623..f8fe0f554183d 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -50,10 +50,21 @@ fn probe(pdev: &mut platform::Device, info: 
Option<&Self::IdInfo>) -> Result<Pin
          let prop = dev.property_read_bool(c_str!("test,bool-prop"));
          dev_info!(dev, "bool prop is {}\n", prop);

-        let _prop = dev.property_read::<u32>(c_str!("test,u32-prop"))?;
-        let prop: u32 = dev.property_read(c_str!("test,u32-prop"))?;
+        let _prop = dev.property_read::<u32>(c_str!("test,u32-prop"), 
None)?;
+        let prop: u32 = dev.property_read(c_str!("test,u32-prop"), None)?;
          dev_info!(dev, "'test,u32-prop' is {:#x}\n", prop);

+        // Assume 'test,u32-optional' is an optional property which 
does not exist.
+        let prop: u32 = dev.property_read(c_str!("test,u32-optional"), 
Some(0xdb))?;
+        // Should print the default 0xdb and give no error.
+        dev_info!(dev, "'test,u32-optional' default is {:#x}\n", prop);
+
+        // Assume 'test,u32-mandatory' is a mandatory property which 
does not exist.
+        // Should print an error (but ignore it in this example).
+        match dev.property_read::<u32>(c_str!("test,u32-mandatory"), 
None) {
+            _ => (),
+        }
+
          let prop: [i16; 4] = 
dev.property_read_array(c_str!("test,i16-array"))?;
          dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
          dev_info!(




