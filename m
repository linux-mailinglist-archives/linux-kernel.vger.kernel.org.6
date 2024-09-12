Return-Path: <linux-kernel+bounces-326548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1A09769D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051141F23055
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B931A724B;
	Thu, 12 Sep 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S+P11eiW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S+P11eiW"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9171A4E85
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145950; cv=fail; b=G2xcnQcJLGH59k63zoZ9kyhg2fp8ZFPREgl6kg16ezncdsMO2sKjPtNAN/+s5goCQXPgpkOtGXcSRyMxuIJOIWesIJzadvyOVCZHM7ZPs2u4gi3bk8tvOoTspp6FS4af2DuqucvQyX3vq0EUxwSbqHqRESvAloQ2Y2T/MkbQeaA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145950; c=relaxed/simple;
	bh=p4wFQEKg25K6kKJxRbX71nuG/VSaMSEF9JCRG2/VS2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WC6HTCHX00Y7e+XNsI+WvAzJxGuYZbmakjxpt8pKXmZtogn2qyMAV9O9bOCLvXejHppRylZzRjazqVnIfWVTr5kNZsnEhENrCvO0dA0zNoZtFe6ZDyDtyuUJeRprwT/4hnFXtQ9XTN3UE5+Cpz4F308zwHL942nn06BbFCOq4MA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S+P11eiW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S+P11eiW; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hqHVtguvNHG6PdbIWGQDjx+s3CwJcQmPFkD+R19lqYnpLoZoSnE6FZxpcLnOLyhaCc4EqaYdbdZjmEPK/JZhb6XUzoNQfa8XMoBagdMWatugJpixV1Vk55A/7Ii9/TalLlFhpMFoCUjQzkqIAOvxTNNLsugPUsHLsiPFkIqUEVL1669kI8fYIwF2hCVlIQoYlv6ZKlXaRKqdiMcvfSs1BYRuAeX+H5M/UpZ8dq3VHdxN3EkSLLopVAkx4n5NLh0eqDB5oBB0Oq9W0XuXMwRyxP5tGbPyi9l6m0hSs6BobaVxtfJkDTz4v/PLU81WhVNreoKn98ePjTMxSvp6gW4aUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnN4cDwWUBKRmCb6Tv19jyJKjk+p+B3uJRaze47vGR4=;
 b=hJLdHm/QhRXuHWkT9qQbtNNAZ/GmjVIIJwje0ryYaY9rQZHR0LykCvs3HUakol+WrsHa4dkRtoTgQ5uPDUhqKyhqgGPcdO3Y2PkcekpID9byrr9cKvz4ow8vtAHfe0cwxL27Lp0zavEd9LweyoouIa3zKftivy4S7piBGNFplefyMY3IpFVFEdiALHgQR8mb5U5oaLjsyR3EMFTMHAv9Z4sD6D4bX+0wvFhB8ICFKFITQPLaoxB4Xu8JzG2mab63T/Zf3grHtSKQ9JmBp3wuf9c3qFOMJXw0FR6yRTdDRRxQqwQnsROkaRW5A0se6CVDcZmrsUsmFQQnkA2ht62ZvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnN4cDwWUBKRmCb6Tv19jyJKjk+p+B3uJRaze47vGR4=;
 b=S+P11eiWVo8f0OEhsikJ6aDTG3c+jt5MqTo4A9a7NrogMJDRDDiq2UYlhysBTW9xPYEu+v9lPRMT4hhaoVaeEV40W9h9CjiibmkH50g8sD5/uMHighwO1Rf4EzEXjkl3x1iCzAxql8wGO51i2yWpgEGsSox0BiIFfKASOLBbyoY=
Received: from AM0PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:208:ac::16)
 by PAXPR08MB6606.eurprd08.prod.outlook.com (2603:10a6:102:157::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 12:59:01 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:208:ac:cafe::c9) by AM0PR07CA0003.outlook.office365.com
 (2603:10a6:208:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18 via Frontend
 Transport; Thu, 12 Sep 2024 12:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Thu, 12 Sep 2024 12:59:01 +0000
Received: ("Tessian outbound ee7a81b3b7b9:v441"); Thu, 12 Sep 2024 12:59:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bc401fab738535a2
X-CR-MTA-TID: 64aa7808
Received: from L63b69ff08533.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 01E83A6C-3339-4152-A2C3-7D2AF17857BE.1;
	Thu, 12 Sep 2024 12:58:49 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L63b69ff08533.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 12 Sep 2024 12:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqH79uxLvVK8HK22Z3HOc5kKCl3f5pgkCjY6+YTLL0Rjsth8Xcy1//Fcy7MdQyBI3mWGR/okbI4F2PuYYFDOUi1mMPuvHAi37oENs7UPMkXnK0Hayvh1CmFi4O0/jCNYkTrB0T0v3osaEvD2uxhPMWy1uVwcQwWETR96xI8cB9SX39lXZewDWNfBrhPKJlbiALbEnNTedPqp1VAaCZqYcVMWGLYnkGj9kH+aUrMiteOQ74VorWV7OyXAglx9dCsjoo/tzyiHYzMWEBhW6aj+BGGXhtVxViCaS9dZDz+PtYb1GB7Xx7C/Tc0aSq39wxNWl+pUMzXyLZ0EqjiaIzxJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnN4cDwWUBKRmCb6Tv19jyJKjk+p+B3uJRaze47vGR4=;
 b=MeYhv5N60FVpkOyW2olF4Gm4QyGNQ8MbPquuaOzefhBJZYAwbRNIxBPAiNyZlBSoRaNE/2mrAcQkJ1xZ/mLPBXYPSQEdLKsVJDYNPQpuXFIKK4eTrFdER7rL68eVLmpg+8D0AuK8phkgT3QwCLva75/y5F4AH3yUERWduVRZb95mM2h83WEbHFeLl9Tyn2bdOJP3vAlmLfK3rBQBsPQiDG7gNN+OU/BZikbZeL8Wcei2MKOD8fR1FQZhgijK/j2lHhF8eXTR9TZ8tttaH1jbIHOMOqp0UMAiEpaUhcQ99F5OggvaKzrPTriYj9Uc0xbNa6/6ut1F1T0rAACnlFXN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnN4cDwWUBKRmCb6Tv19jyJKjk+p+B3uJRaze47vGR4=;
 b=S+P11eiWVo8f0OEhsikJ6aDTG3c+jt5MqTo4A9a7NrogMJDRDDiq2UYlhysBTW9xPYEu+v9lPRMT4hhaoVaeEV40W9h9CjiibmkH50g8sD5/uMHighwO1Rf4EzEXjkl3x1iCzAxql8wGO51i2yWpgEGsSox0BiIFfKASOLBbyoY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by GV1PR08MB7314.eurprd08.prod.outlook.com (2603:10a6:150:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 12:58:45 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Thu, 12 Sep 2024
 12:58:45 +0000
Message-ID: <6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com>
Date: Thu, 12 Sep 2024 13:58:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de
References: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0509.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::16) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|GV1PR08MB7314:EE_|AMS0EPF0000019F:EE_|PAXPR08MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 4232213c-82dd-441a-03ee-08dcd32aac6e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bDhvNks3R3FYeDJ4S1RWeW9uTjlzeDRIeFR4UmZWa2VscG1hVUZkWFQwSGs2?=
 =?utf-8?B?VXZoWlN4ZnN3dy9SK1hmYlJFclB5SGxjRi9aRE1VbUg5akJBS3hJTy9RM2J2?=
 =?utf-8?B?aEFJMlZDd1AzR1pBc0x5U0k4bFcwMUs0RE8ydEVVU1hjSVpIcEtzcGdhaHVr?=
 =?utf-8?B?OUpFaDBlUTVZVmJ5SVZRUXltK1JkeFdHcmJlem5NZ1cwWkZlY05VZFgzZmlT?=
 =?utf-8?B?cVA0eVl1ekFxSjlFODMwWWRuS2x1aG5pNUxIT21MY3pUQU1xOERBNmNUVTdj?=
 =?utf-8?B?TU9LRno0dnZidElIaDlmS0tuNFR0QmRHNjVMRUhyTWU1c0RRTDVhOEJmMHNn?=
 =?utf-8?B?NTJ2S0hCUXNWUVpOdDFNdERGSWo5R2hlblU5L2NYbGR6QzAzZGVzNDFldWJB?=
 =?utf-8?B?dUUrZUl6SWw0WTR6aTE3RUtMdDArZ0h6SVpOWFVzeXhDZFNUVWNCb3BJV2g2?=
 =?utf-8?B?dC80dFJ1dHo5ZkJiZXhra3FQMVVJSkhvSWlXdGYwYUpvZDAvSWVPMEV6NTR6?=
 =?utf-8?B?MnlpMy9vQytuWDFSRm9odk81SFNITTVqRzNnL3V2T1p4L3pXTlhYaVlMU2Zq?=
 =?utf-8?B?VkNORllQbHByUExENGlSbktMdHlzUjRJcTB2K0UxczBFVHdVU3h5cHpjc1hq?=
 =?utf-8?B?MjBISlRaRTRRQmlkUkxpbjZHMklCMW91bElBZzdKejI2RXB2OHpONlJtdGR5?=
 =?utf-8?B?enh6czlGVjFTUDFrUUFXUnRIbmFaakVTMmltT3NkdG5YVjU2YUh6MWNxU0lJ?=
 =?utf-8?B?Z1l4V3J6em02RGFYNkxKN3lFL1JnR2wxQTA5ZUZnV2tEdXBXQ3VQSUpqM1kw?=
 =?utf-8?B?YW8rNnJkSG1EOVdaZ3BzKzZsK252YXEvOGlrOEpucUprMmwxdVNSallnTmpF?=
 =?utf-8?B?azVXT1UraXh3TEh6YkZMeE9mRDJSNXdBK1J6K1QvTE1TU1JrV2g4TU1IaC9a?=
 =?utf-8?B?SFk1OGdrUU5IcmJsT0dpRTZ3MHN6T0pYVW9vVSt0VFhTd1VvWmNmam5NeGln?=
 =?utf-8?B?SWFrei9zSmx3ZFJrdlR6UGFXUllISHltODJRa1o0Ym9Ld1U0OGZYaFMrNm8w?=
 =?utf-8?B?aHdGMjZONkhDMWhUSENZZzBqdjVMcjZUZDhwK2U2VW9hYUlhYUd3dE5SbC91?=
 =?utf-8?B?cHJ4ZzFla3poRGZ1L3FLN0pmRkYvNTliWFRBcEcvMTJSN2ZvVU9ZN2VjbUJx?=
 =?utf-8?B?NTNHVU8vMWR2RTBzSmtnSnN0UTU2KzdDVSszZFZqWTlFOHNpK2dNRmRLVFhs?=
 =?utf-8?B?TFZyZ1cwMEF4S2NSM2VLRGh2WFplZ0VXR3lacDJFN0VKTVZGdU5TbW1xQTdI?=
 =?utf-8?B?OXdWQlFhWUcrWERGQ0FrNnJYaExpQncvdzhnRHNvbGsvdGthcHJYdnZ4WHBS?=
 =?utf-8?B?UDQ4Ykh4L2luK0hoZ0ZGdDY2eDVjVFdST0wvWXZBMHI3WmQyWGJ3Y1ZqcWxk?=
 =?utf-8?B?WWRDaGhlcVNqMGU5Vm1RRGdsekRJZDVTV3FncGU4OUROOC9oaC9jdGNFZW5j?=
 =?utf-8?B?RkZDekJJTW9BSkxDbm5ya1BDUC9hK2s2b0N4elNmbmpVU2dvY2gva0h1UkFH?=
 =?utf-8?B?cjBTWG9lRitBZEdFSFR5Zllld1JpNExjWDdhN096TW9kcHMrTTN0TVI0clJM?=
 =?utf-8?B?N2ZGSmk3eG9IOGM5ZFJ0RmkwVU5EbU5tNG80aS9tUkFEazJYZnh2emxMZUVm?=
 =?utf-8?B?SXJlRlBELzJtMU12akExdS9QekJvWkxnQzFzL3R3dVVoQXRRcGJVQWZsWWVy?=
 =?utf-8?B?elR5b3pybC9ldFFqUWhYTkxid29pU21lR08zU2VVQWhkWUNoaXNmSm9oYVNj?=
 =?utf-8?B?bmVVbnovSWs3Q25MV0tuUT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7314
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e40a99d7-8f5f-436f-89f7-08dcd32aa2e3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWgvczJDYlZnNDJYcWNzTExvUGFQWk5JaWVuTGRTbUZvWW5uaHdyYWFuMWdu?=
 =?utf-8?B?WVk0WGNZUk51SnZnQ01JVkpFNXhXMTB4ZWVMYUs4ZkhXcU41T1BUQktneUR0?=
 =?utf-8?B?MG9LS0N6YmM3RVU5TndUMUlnOUVQYjhSc0gvcURRTGtvT0xwKzFIaTNMcEhx?=
 =?utf-8?B?MUVuc3RiYUpTS05LbFVqRXBXd1ZkbmIxZy93dnQwU1h3cXVxaTY0aFFCZ1pU?=
 =?utf-8?B?T2ZBdjluZGFQTk5yRnJZQm5yWmZib3pYbEZJVTNKYVpHSldDTVlaRTU2SllP?=
 =?utf-8?B?dlp4akU1MVROTTl0bmlkMmV1TjZxcUZNanBvcDJBcXNCK3B1OHpHaTZ0enk3?=
 =?utf-8?B?aUgwcXFNbnFQVzduRS9QNVVoZzBseGpFdWxZSXZTRG5aNlFxeEIvd25DQmdn?=
 =?utf-8?B?d2xVdEEvYjUxYnNsWlYwY3FNSkNIVEhsQW5nK0VRYisyQzBtWm95aS95b2hU?=
 =?utf-8?B?emFjS2hiaUJ0N09IYW12NEtqbHJPdk4wQzhKemNsTlRiZVlqV1pyT2tlWlh4?=
 =?utf-8?B?c2FsSmEyTkI4Sm95SVlXZDFtNTd6Zk1DK0VaVHF1aDNkRE81ZkI5ZVdJZHhz?=
 =?utf-8?B?Y3B1dGpCT1NaNGliR0pIN3B4V255UjFoMFBuNG4yaW5BY0gwYzRBYUtMRlJa?=
 =?utf-8?B?d2pVWk92MXlHNFVYWDJqc1VtMTVCVi9HOTlldk5lK1V1K1ZIbEpWVFQ0dHpZ?=
 =?utf-8?B?UVdLMGVMdG9TY2RyRlpKUUVESzV6UEZWVVlaYXZuaStmWEIwL3M3SklVNVFF?=
 =?utf-8?B?SkMzYmFtNit3aGVyVnpidCtObHdZN0dtVmFLdDJ4NldIRkplWFYyRWoyaHVJ?=
 =?utf-8?B?ZHlNUzBnVmplVFd2dWZzbnpPdzkzYjJTdGpjbEgxZUlsUXNhZ3MyVGJUeHFv?=
 =?utf-8?B?Tnl3YTdoMG5zbmo4WWd4VjZIY3djOUZGMysxLzFNcEczcjNUZnJyZzlMcWdr?=
 =?utf-8?B?bFVCb20zMEFhQnJyRnA0YXk4UlZxUE9zU252M3JrcHUzSW9rbUEwUVFKaHcr?=
 =?utf-8?B?RDhLakdIMUZSWlEzbzgwekxPVnY4VG91RTI5YWtTbURRbWRoZ3FSamRmRStq?=
 =?utf-8?B?VHhJMlNyMVhTd1RxZTFqN0FZeGtLLzhUS1RNZCtsNURqRXpnbDlxTXFoZHQw?=
 =?utf-8?B?NmwvQmtjZjR3VWVzZkhrSVU2WjFpc3NHTHdkQ1Nob2Q0eHg3WG5YMWRoZEI4?=
 =?utf-8?B?cTE3YjBHRktucDM5eS94Z0tQMTZ2MHluNGNLRFN4L3doQVFMaEdRWlUwM2ZT?=
 =?utf-8?B?eEdFRTF5dmhzMGtuVkJtbHYzNm9rTG5lM3lqSzBwK05oYXBvQklYM1hJTWJ1?=
 =?utf-8?B?elY2R1UwUFByYlMwbTVzdVk1QlZ3cTNEN2NDV2ZYYVlPQXdQQVdxUUVIM0hs?=
 =?utf-8?B?cmU4UFFlTlhybm9BTlA5cGNuQXdyQnN2am9aY2V0NjFFa3Q1SUtmbkw2dGtS?=
 =?utf-8?B?UGhqQ0U3ZUFtcHBpbmFrR0o2d1Vob1dFSzY1eWYyV2xna1Nhd2dOalZTS0th?=
 =?utf-8?B?Z3hDVkJyNkF1M3dPRmF4aUdGWlk3dDJTOWNmR3NLeFFPajV5bGVPL2o5elZG?=
 =?utf-8?B?ajlRdVYvelRwTkl6YUd1dktjQlRvQW1Od3hyQ1ZxMGt4NGcwelVZTWJqTkha?=
 =?utf-8?B?MmtKZGlJMGtRNDhVci9YS1lGOHRGNnFNbFc2aUpFTEFLT2F1R2g0cmZ5Zk50?=
 =?utf-8?B?UE1NNG50MGxRdkNObWVRaVdMVmRjc2NsOSs0dE5EYmUwcy9NRERHdnZxL3Qr?=
 =?utf-8?B?c3pvSEU4bHVBYzM1RVY2b040WWxnSWM4aEZ2Q2I1Uk9BUmNSVjdsbGxaZmhF?=
 =?utf-8?B?bWNBT0VFVUxCc1g3WjMxcXBqeG9RcTJWcjZQS1liUTB0ZTNiaUF3aEtVRDRs?=
 =?utf-8?B?ODZ5SXF6UXZvalp1cU5ONTdaQUlKR28zdDQ2Z0xNRStBM1pzZU1BYzdZanBu?=
 =?utf-8?Q?YWbdv03kc481/5LaTLMBE4NuyWqXUFNq?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:59:01.3964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4232213c-82dd-441a-03ee-08dcd32aac6e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6606

On 9/11/24 10:10, Mike Galbraith wrote:
> On Wed, 2024-09-11 at 10:45 +0200, Peter Zijlstra wrote:
>> On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:
>>>>
>>>> I'm assuming that removing the usage sites restores function?
>>>
>>> It does restore function if we remove the usage.
>>>
>>> From an initial look:
>>>
>>> cat /sys/kernel/debug/sched/debug | grep -i delay                                                                                                                                                                                                                             
>>>   .h_nr_delayed                  : -4
>>>   .h_nr_delayed                  : -6
>>>   .h_nr_delayed                  : -1
>>>   .h_nr_delayed                  : -6
>>>   .h_nr_delayed                  : -1
>>>   .h_nr_delayed                  : -1
>>>   .h_nr_delayed                  : -5
>>>   .h_nr_delayed                  : -6
>>>
>>> So probably an unexpected decrement or lack of an increment somewhere.
>>
>> Yeah, that's buggered. Ok, I'll go rebase sched/core and take this patch
>> out. I'll see if I can reproduce that.
> 
> Hm, would be interesting to know how the heck he's triggering that.
> 
> My x86_64 box refuses to produce any such artifacts with anything I've
> tossed at it, including full LTP with enterprise RT and !RT configs,
> both in master and my local SLE15-SP7 branch.  Hohum.
> 
> 	-Mike

Ok, I seem to have narrowed this down to scheduler class switching. In particular
switched_from_fair.

Valentin's patch (75b6499024a6c1a4ef0288f280534a5c54269076
sched/fair: Properly deactivate sched_delayed task upon class change) introduced
finish_delayed_dequeue_entity, which takes care of cleaning up the state of delayed-dequeue
tasks during class change. Things work fine (minus delayed task accounting) up to this point.

When Peter introduced his patch to do h_nr_delayed accounting, we modified
finish_delayed_dequeue_entity to also call clear_delayed, instead of simply
zeroing se->sched_delayed.

The call to clear_delayed decrements the rq's h_nr_delayed, and it gets used elsewhere
to cleanup the state of delayed-dequeue tasks, in order to share some common code.

With that said, my testing on Android shows that when we hit switched_from_fair during
switching sched classes (due to some RT task), we're in a state where...

1 - We already called into dequeue_entities for this delayed task.
2 - We tested true for the !task_sleep && !task_delayed condition.
3 - se->sched_delayed is true, so h_nr_delayed == 1.
4 - We carry on executing the rest of dequeue_entities and decrement the rq's h_nr_running by 1.

In switched_from_fair, after the above events, we call into finish_delayed_dequeue_entity -> clear_delayed
and do yet another decrement to the rq's h_nr_delayed, now potentially making it negative. As
a consequence, we probably misuse the negative value and adjust the frequencies incorrectly. I
think this is the issue I'm seeing.

It is worth pointing out that even with the Android setup, things only go bad when there is enough
competition and switching of classes (lots of screen events etc).

My suggestion of a fix (below), still under testing, is to inline the delayed-dequeue and the lag zeroing
cleanup within switched_from_fair instead of calling finish_delayed_dequeue_entity. Or maybe
drop finish_delayed_dequeue_entity and inline its contents into its callers.

The rest of Peter's patch introducing h_nr_delayed seems OK as far as I could test.


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f993ac282a83..f8df2f8d2e11 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13168,7 +13168,9 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
                 * related to sched_delayed being true and that wasn't done
                 * due to the generic dequeue not using DEQUEUE_DELAYED.
                 */
-               finish_delayed_dequeue_entity(&p->se);
+               p->se.sched_delayed = 0;
+               if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
+                       p->se.vlag = 0;
                p->se.rel_deadline = 0;
                __block_task(rq, p);
        }

