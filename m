Return-Path: <linux-kernel+bounces-337303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A4984867
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA02281785
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D91CFB6;
	Tue, 24 Sep 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B3F9KjCe";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B3F9KjCe"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE217C77
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191015; cv=fail; b=ExJeDKMxtK5vwgiWLkl2H4TY+GglYIbDGPUyS2JSdXQHN8TFxTzmSmm99BM4Bjkmdaj9NVinUyKUrYDeRS758ZVtdqg7q4dnkZHdwG75p78ZVc0tVZurwuiTLaJOg0Z+zPTaZupevphwG2tFzI7zfRbwa+bIm9eyMOGtbTjxADk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191015; c=relaxed/simple;
	bh=S0SuDoDCABR1n9Jv60F/d6xLDS5daE4/FXHS99xTvp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLaQgT5ge4ysN8kD2coDpiZzjMfE+YWThA2yIOvHdcMx+V/PcGsAomKt8h7PTb+kvKz0J2TF/glULHzAob1GO3A/K3HfE012AHcBVNca1kZ2r3bzMx8m3O3XckS6oAtvugnXZLnR1fnCDM4snNGmkB2d7qD41g0fqF55oWrb/b0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B3F9KjCe; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B3F9KjCe; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MXA/hP2l5OYwVcadR4W47fELAGZPQGQxjyPy792dfpSNpC7v8uksbbKk0Qi9Wj9GpXybPUVKocM3VeL/C0dpTa6HYbIJC1N2tKUOaFJ3lE+2SQudkOZyzSWaLlXKPhK09rS4BbcqXzVsT56lCpgs9d7jvzVENx3/CApTGVvb+PpuAfBurecQ33U4EU3Kyl6K9srpbhyoStsx+8otHB6JPbtAQ/MlVQQVtjm6sR/CEYS0nMn7p46/oExRfRaXExMUq5A2FJRll2WPtOvlZOJ7KxLmW/1v3nJtcnIbB6IMxdxEFz863LrXdr+rsnAIgEhUnn1Jtn+/Inatk5YmGhcFsw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DdRfL1mmnNFAst08mKjx7tzWgRiLPqe0ro5MLmu408=;
 b=aFYmlckTHdP4j7S/m5y9Uw8rHqks2DIjXz2XguzpD4Wzrann6xUHHKgZYQqzA37f/GoPAdgFFYExJIbln2VG2wHNeJeDsvwPXXGdUxeX4WCb46EjOnkwOa64ZZOYv5d8S3H8nztEbqa/qWGbtH0HvqtbJF6IgE3CsLilooNIcbC/lOzN3yWTva8Y3lfC5qRFlDcDDZGp4jgyerRjXvYHA+6wyhA8fvlgcbWJJSeIpkntcn1oUsDNwpdvvvCVD3ZP2JBTpSXkPvh9+Ss5Mpff/2NQxikuqnBI7/ld7ZY34eIe/gtFW4uvZ6mCf6VhnnUdrFjuyeiHej3JrTZ3luK2qA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DdRfL1mmnNFAst08mKjx7tzWgRiLPqe0ro5MLmu408=;
 b=B3F9KjCeVs4MIdG1Loy7Kom7b2XIMh4Q7KCIFPmvtIeG29slOz7HwEFf9w+yuWDixFzm3DGftKYpEvQ//fZZeZEVtO4S9K3ksCcCPSIWmwqQJNRGO2n/XuL/6m9nG7SVCU8JWMnfC+mMGcigWxF2EcxcTs46we/bI//Cc1uciFc=
Received: from DB8PR03CA0031.eurprd03.prod.outlook.com (2603:10a6:10:be::44)
 by DBBPR08MB6316.eurprd08.prod.outlook.com (2603:10a6:10:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.11; Tue, 24 Sep
 2024 15:16:44 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::82) by DB8PR03CA0031.outlook.office365.com
 (2603:10a6:10:be::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Tue, 24 Sep 2024 15:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8005.15
 via Frontend Transport; Tue, 24 Sep 2024 15:16:42 +0000
Received: ("Tessian outbound 245dacdadcd4:v465"); Tue, 24 Sep 2024 15:16:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fbcdc1ae8bf05f24
X-TessianGatewayMetadata: w86v7X2+neVBH/1F8vzTGNQW7sdQenT7kgTe0Nf4nxleGLYr3z+RJgGvx9NNDtFE16/lyNyB0I7ddyZL95cq4cPMElwXotU78nIlkfPu5Rb9uA5sT7AUI/JLupmwTYU26AHjS8hK0aBvhlKNTlETet8p9e6bmj+3uQOOeHpg5qQ=
X-CR-MTA-TID: 64aa7808
Received: from Lfdc299072922.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 591901FB-BF4F-4AA9-A799-C615B23A6E69.1;
	Tue, 24 Sep 2024 15:16:39 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lfdc299072922.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2024 15:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsZ+j7CT0bbKJ7vN5etJYe6zuUi27rcZm6LhvS4l3y2L8EbKwNj+mzsD7XVSUAnJgika1Y/0omSvfE3zo7bFAspVA0SF1QmNkuLAqp0SfwHjhKd3bY0dxyujm3+Q/GTLDWbIgglz8Ldkms2amEJki3ZpaBhm6HmxlHZN1vhoGsSXyAaV7tRUgCUOgV2AWoQ7djNZOgqmIOQFhP7A+0dLDH+nPTLT5EQKhpItmujHm5KuOKXsAROFQ7v9OZ+EGB3sc2BAx/63JBOdcZuYVb6i3nrYChYwBp5ATBLio+uRBhGE0k6d7JMki5x5CNsmJjSNipgRQAtu06rtF/rBni3ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DdRfL1mmnNFAst08mKjx7tzWgRiLPqe0ro5MLmu408=;
 b=mCLR0DcbFqp0KNTfSWcMAuq+ZUns4TD8AHXPdwGiq/QZCwHkeu5hCkv0rb7jFDwr7UgvRfXO3nI1gKWAg3kl5vhxeT3Nh/7drOZUpDM4pETqfg1VsvuvuZ8YlsOMvdu9IURcD8Fn8Cl2uHJdN8hSvZVdXs5R8JEtobSzEDkw8EM7QF+tnc9e0haHos4e+apo4NGj9lRyXkHVcugO2qsR+BQnFx38mGfbt30kFDz8aYirKqyuFcUK63NcQgbi9wEw9ynFx4DvXCIB4KBNa8pddpfETYuH210YbWCm91ViOryMTyhCyHXR/1+TEK1fLLJ8NcPPwBHa7nWkkgHEegg0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DdRfL1mmnNFAst08mKjx7tzWgRiLPqe0ro5MLmu408=;
 b=B3F9KjCeVs4MIdG1Loy7Kom7b2XIMh4Q7KCIFPmvtIeG29slOz7HwEFf9w+yuWDixFzm3DGftKYpEvQ//fZZeZEVtO4S9K3ksCcCPSIWmwqQJNRGO2n/XuL/6m9nG7SVCU8JWMnfC+mMGcigWxF2EcxcTs46we/bI//Cc1uciFc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DB8PR08MB5353.eurprd08.prod.outlook.com (2603:10a6:10:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Tue, 24 Sep
 2024 15:16:30 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Tue, 24 Sep 2024
 15:16:30 +0000
Message-ID: <c001e3ec-bbc7-4de3-a9bc-cc324d366fbe@arm.com>
Date: Tue, 24 Sep 2024 16:16:28 +0100
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
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
 <20240911091328.GM4723@noisy.programming.kicks-ass.net>
 <2030b198180259eede6384cc6a6bc9bc9f64f874.camel@gmx.de>
 <a96858374fb06ba38dd5eea5561cc7542220416e.camel@gmx.de>
 <627e37090198cee91bf79c41b1cd8c20c2e2d71f.camel@gmx.de>
 <1e89e5bcbd43934c65f8da23e7fbd59da950a0a3.camel@gmx.de>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <1e89e5bcbd43934c65f8da23e7fbd59da950a0a3.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DB8PR08MB5353:EE_|DB1PEPF00039233:EE_|DBBPR08MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e61a3b6-66b0-4a72-782c-08dcdcabe583
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZVNQLzNHaU5Ca0UwSGxRUXprOXQ1Ly9KdSsvUVhpZ0E2SmdSamJJZEU5djMz?=
 =?utf-8?B?dnV6RWZab04zSncxbWNSVWdZenhhUmZKYUZZU0FvckVCQlBnWUl3ZXdta1g2?=
 =?utf-8?B?ZTRmZyttSEtqWmdhcm14aXp0ZlRPUjdia1BnZFI1c213RmhabDVLSWp4Y0Q2?=
 =?utf-8?B?aURWeTZrVUt4OEFaU1RQS2ExaVFhSXBsenBGS2oxbW41MUVYWERERERlanQ5?=
 =?utf-8?B?RjQwRVYrRVNPQm1qRkQ1RzRTSmswWjlNd3BNUlkwSkNxaDhjTEZxYmQ4T0E4?=
 =?utf-8?B?bEtKeVJydUtwZGswUi84MVFLYzE2Sk5oK3owTTl1UlhaUXlJZFAvcWRvNVZi?=
 =?utf-8?B?amk5MEtLU2UydkJDYjRybHFOYy94TXRXU0tkSmlEaTQrdGhPb2FUUzE4WGow?=
 =?utf-8?B?TlFlaVRVRnVEaGVXSkM1TExLSnQ4QUMvZmVPUk4ydVdPejdnQzY3QWVVZ3E4?=
 =?utf-8?B?YnpMM1hlWkVEaUo0TkJJekNGY2t6blZuRXQ1RFFtNVpDQi9TNEloSnpFZWlQ?=
 =?utf-8?B?YWpmYjhvcS90dytYcVdxTithTWNGcVhGMEZZeFY4T1dxNStXdE44M0VzOEdy?=
 =?utf-8?B?ZkRVNGtSbkhNUXlxKzBFQ3Z5ZVZCaiswSVRQVERuODRVeHNOYXJJQUZXdXZo?=
 =?utf-8?B?WHNaM1V6bDRHZTZLTEdNYVM4Y2N3ME9ySVMvZFJFWGJ6RVNJVitpOHBaR09C?=
 =?utf-8?B?VmQ5eVEzL3dQUjRwd2l3RWRVYm5ZeHlVY2gvcnVBWEpxa0daMzN1ZHpsWUlP?=
 =?utf-8?B?eC9jYzdkRmgrYjRqWmI4clZSeG5McEVIMGVkQnkxMlBTRkp3Y1l2aEpkVm5N?=
 =?utf-8?B?aWlWc21rMWZla0JxK3ZnR3ZPTXFCV1pIdHo1UUxYZ0RiZnREQm9zZ0FxWDFJ?=
 =?utf-8?B?c2djeDFNVlVmc1VudnVJMFd6dEFjRXF0R1k2cExRTnhlcktIRjlzdy9oS2FL?=
 =?utf-8?B?TFhrdDZzZGZDZGE4S09VbmVXcWRaNGFFeDlIc2lpdjVWWjhOb3lhdFdwK21z?=
 =?utf-8?B?SEY3RUErYjhTWmJReTVnQS9rZ0NnYWpoK3I4NXVEdmdrQm1XRXk4WCszSk5F?=
 =?utf-8?B?TllITlQ3d2FXMy9xdGh1ZDVhdG45Ry85M3RuVlk3ZzZpYmFreHhYMjI5ci93?=
 =?utf-8?B?QUhyRDFaVDRYVHNvZGVWMENZUnFXR0JzUlhVMmZUejF4M0N5RUFzQWtzZkRh?=
 =?utf-8?B?RlR5QVJGZ2x0TUtlTjR6K2N0YkcvNENneDlBYUpzNXAvTGRoVjV2TmYwWTVW?=
 =?utf-8?B?T0F1NEtvUmxkb3BxdVo0aC8rV2RWLzF4TXV4cXFYWTJCZGdWaWxFVHEwdU1I?=
 =?utf-8?B?Wko4RUpIeC9XbHFjbkcweS9PdjNaZ1FQbnppUXF6cEszOWNWOEFMSVJiVmVZ?=
 =?utf-8?B?bWNtVkdUeHlycGRDQ2VHbG1sbzZWVHRBRUREM3JNZ1J3WFl5bUNldkQ0ekJn?=
 =?utf-8?B?eWRBdFNMK1RqY08zK2p3b3dnbjlRMjcxMEdNQnAvZk9Hd3EwWm1pOFUyRGda?=
 =?utf-8?B?c3RiSWlOV3FZYkRqS3JHNkZjYlpNTDFXWEI2N1NHd1pPcnpGT2s3U1BvT3Jw?=
 =?utf-8?B?eE82aE1kdFUyNC93MTNiaHdGYks5VnZTWWFZYUVKZ3hPdVd5alZScnhaZ0V6?=
 =?utf-8?B?OFRLNDdXcG1JUUhJRVhFS3k5OUl1dnlnNFN4NjY2UnpYUjd2c1FlaUJ5Mm8z?=
 =?utf-8?B?NjVueUtDZCtZUklBWnNuYVNWV1pzb0dJSmd2MzdrUHVwTGJFRjU1VENnPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5353
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	96365e5b-6784-4c3c-de7d-08dcdcabddc0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlRoRVRmKzg2TVAzZzFZL2o3QWhwVW1hZkkwQ3B4d1VacGpNckpCdzNNTVl1?=
 =?utf-8?B?aG14YjNJd1VweTJ2NW1QR2x4a3VOejI1WDlhOWExeHFEWmxRUUppWHhRTEEv?=
 =?utf-8?B?RHdvS2RzM3dYOU5nWEZBTXUxZzBFWGN2TTlXSnluNlBXVDVWZHdnemhEZVQv?=
 =?utf-8?B?b0IwWlNaTkZDK3B2bTBtUXd2K3pxeVE3NmRiN3d1YmNQb3dHTDJaUGcrSVhY?=
 =?utf-8?B?WmhZaVBFWGprQzRVZk92ak9CT0NST04zTkR6NDlhOVRBU2VHWWZzc2gvNi9z?=
 =?utf-8?B?TmhxaXNrZnNUcGVsc0ZXSitvVHIxaGxiNXQyWmNUaGhWMTY4UGhLdXBwNUlZ?=
 =?utf-8?B?a2lJUTR4bW8ybFhPQ1J2QlpPZ1VmajU1SnVET0NnYmd2RytmU3hKSGFUV25p?=
 =?utf-8?B?WVFtbEVsYUE2NEIrK2lFQ0ZPc24ycEZvQVlQdjZqSFlyV1JkQzk3WHpUYlhj?=
 =?utf-8?B?V2Q2VnNlNlI3OEtIYmNwUmc0VUpZeXpXNWJUZ3NmUktjQklqNXJNdE05Zm1X?=
 =?utf-8?B?QWxzUk5jb0k1d05BSThNcEFHUHVGKzZYai83bDdaWkZjYjlZR3R6ZUx2Z0g2?=
 =?utf-8?B?WkhGd2RzVGY0OUhFTEVPNVhEdHdQRDBicW1LNnY4VlFqQU9KYlFvdUdWOEVM?=
 =?utf-8?B?RjRJY0tnYkdWM0hOK2NaU2dBWTZVR3pqZWxhbVg5QVdJT0ZwNis5eXRNQVB2?=
 =?utf-8?B?bC9OcGxYSWtTY0NzMXlMR0hMVWd1Yk01amNmU0I3UDBtc0wxMCttM0tHRlNQ?=
 =?utf-8?B?WmRzdlVQQXFpTHhZUGRnOTVhbHhLZ0YxblZkb05WT3dEOEJZakd1NmVJcXM0?=
 =?utf-8?B?TEkxZDNIT1Y2ekFzYUlYRVVNbms0VW9xcVorZit2Sk1QZzJVRHcvdDlNMmQ2?=
 =?utf-8?B?aXdBZ29qdVYwQkFnSThkV0x3MHNxcUNoeXA3dUVBbFltVDByNk5vVHF0d1B4?=
 =?utf-8?B?T0ttWm1MQlNXWkVNSWpSVmlKTmxOT3F5ajFKUnAyUXZaRmxBc1IyZ3ZUQm45?=
 =?utf-8?B?TGFURjhPRVdIdHd0QUl3blBUbUIxeTBRYWpBN3Y5a0VMUCtraDljVDVwS3R1?=
 =?utf-8?B?Z04rSE1hYTlBMXhHeXVFTEdlM3N3Y3dWVGpUelVQejY1N1lPUmt0OEpXcXZ4?=
 =?utf-8?B?UmM2SURybUpCaDdtQjhVSE1kc3Bqc1I4TmJYZjJQNmRlYUxqdkVURDZRRXRU?=
 =?utf-8?B?UlowdzhKeWV1UWFZRU5mdkx1Q1JEd1hJUUJxSnFKUUhFM3lHMEE2dlhaNUxT?=
 =?utf-8?B?RzhZbUFWN2l3aHJmQ2ErbUJHbWNFTC9rSmVwSU9sNXgxUElMOWhSMHRYaWZD?=
 =?utf-8?B?TDRaUWJOeEVWNXZTNlFYZGxDSyt1QVA5Z21JZ2VaQVo5UWd5Rmw0YWFXODM4?=
 =?utf-8?B?Qk82TEZyR0lUMFNVWVNKYWZsMDhhNVlMYW40WEUyWWc1bEVTbmd1dmJsenh0?=
 =?utf-8?B?bXZKRmpkUDI3RDB3eTd6TEdZVnVuQVVzRDJIZkYxWVMvVjlPbThoM1lHSUJV?=
 =?utf-8?B?ZEpBR3Y4SmsrZ1JxRytkRUlwWUczVnpIYjJVNVY3RDloSzk1UkZGZW9icXl6?=
 =?utf-8?B?cjNpTHBEWlBObnNQN1hiTCtMSk1MVjcwbEdpNUpVdU1HZ0Vyc2Y5Mm90YWdz?=
 =?utf-8?B?TEpvQVgrbFVKajRJdk1mdWJZay85SFYxS2dQQjUreGpKaEs4N2F4bzlDYWFG?=
 =?utf-8?B?dkxQNEdvdTl2TVpaUk9iU2Y3K3pjRHJ5ejY3T3FnVW1xZndBaStQdEN5akJ4?=
 =?utf-8?B?ZkxOZGVRMVc1aDBSanN2SUxMalgyTFd1RGFmRDlRVWVyaG9XUllmejZ3WWJO?=
 =?utf-8?B?R29DalNPTGZiMDlEV2JBRXNVUkdKdHZxUlpQYkZqeGx5c0xHeXUvWmphM09L?=
 =?utf-8?B?bys0dG9QMlVXRjBBbWN4eHl4NzVNTW44dUVLUlZKQ0o1RXphUTBzblM2akQ4?=
 =?utf-8?Q?rMWzUajJfbSv48TL4n+/4uSOA157Xs2e?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(35042699022)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:16:42.3665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e61a3b6-66b0-4a72-782c-08dcdcabe583
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6316

On 9/14/24 04:40, Mike Galbraith wrote:
> On Fri, 2024-09-13 at 18:39 +0200, Mike Galbraith wrote:
>> tip 4c293d0fa315 (sans sched/eevdf: More PELT vs DELAYED_DEQUEUE) seems
>> to be stable.
> 
> Belay that, it went boom immediately this morning while trying to
> trigger a warning I met elsewhere.
> 
> 	-Mike

Are you still hitting this one?

I was trying to reproduce this one on the Pixel 6 (manifests as
a boot crash) but couldn't so far. Something might've changed a bit.

