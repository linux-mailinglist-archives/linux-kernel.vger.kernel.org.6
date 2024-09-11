Return-Path: <linux-kernel+bounces-324615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2B974ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B601C22183
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C1183CA9;
	Wed, 11 Sep 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hLXEVVDL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hLXEVVDL"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F2B17B51B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047546; cv=fail; b=C0/jiPqsKPX1PM31QBw2drEpgnRVMlzF+im9PYJx6ZHMtI4PmO7WbGUqEsaUYu3a017DgTJEIsxcTn00xlGoOvjG+Kj4+S8TNqvoYpW6DyIyL/DoQEjdHzlh/AFosN2Q1KdwxR+qNEux41EiyGDG4FJjR22WCQxCc4SRtgjfNYo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047546; c=relaxed/simple;
	bh=AWP2xkajzfkaJ/aMdlj5SqThI4OgPMCVFQPY3SUZXQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pNWRg5AWqT3ArsSDoKrBwqBYyRWJUv3r2qa62Rys2uOVH5I+xioKjkVEFPN6DTN2vn7VTvVw2ugX5nrWOzK7AMJyfm+UT3EKheOhkH+XeGaX9RGWvZ+8Eu6dYe1VhhBPNExdDCDMZDsTXax8BOeiWW/U9M/bVZTr+4PnP3ZhWe0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hLXEVVDL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hLXEVVDL; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EqWeUokzDqnINBbAY0ty6IsHo+Arn/oRVSPGuNzk5Lp/rWrl3vEhN05eOX9OIzizPg0NaWXr14W9tSO0pjTRzA9bqGeU8RNaPHvTfLEMsgHz5XRs1ZDa5WUtdMlvbQZrPouu/krRpUudsN3XP8UDPqQfQ3HOu47D/0xlJvXz5C3e/WN0nZj/P3cSJW3AmFlfwyPrSh1uHV2OpLMkkupktF3eN4qtH0DfTS3g6MP++Vst9zMWGsjcXPV1jq+z9qQypyuyNdJgi3X46DZ14i0T2k+NCd56f5A7j12vlPxTi4hrOQyhoNja5sNKIob/Nwgb5f6w0ate/8aKAbCn7uoTMQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZYx6wAJHgTrdBojfjwupIGKKjQ/0iMXWb0bsiosN4o=;
 b=RCj+S4kdpq4jj9QdoLjOGoWxdeHKGgvLKHdccocV0Cxwkc1mFUfALOnK5UwieoA79tevgDD1D3UNa7Ln8u0NtHi56mDGTpBcGnChmyfI9ofzoa/MHfKxy4REUWf7feeL29eJEaspWJ/Tv4UcYI29+5dKiDzWENSLIs/2X7bCk/e9wy3iQ3UecqcoQhW1aT+fPwvea9A/fUxxgwpeciwkjwLBG0f3O86aULpjrLOPnQ3/TlQQiHUTXURs8sGT/tAo46psRxmLlJpVXEepc5IwEflsCO9vJTZWD+ovkN8NqkRo9b6dgxxVJuoYWSBrcoYoTFODCTD+gYZOzcSF9RFRQQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZYx6wAJHgTrdBojfjwupIGKKjQ/0iMXWb0bsiosN4o=;
 b=hLXEVVDL9wvm6v69Dxfht32DXvA9HzDEwBDVnylA5BpZe/kL1QYUjgglhpy1ZELPfh+9gJd5vM3aw/ik3LgGSyc4ygVdLzfo3kgQRqwbYGCGr8WNRcdHX2j0wN5OJiWCVxME6k+o1e7u8hRQylbnIdvyrYMAHzAnqd9gmMnZFwU=
Received: from AM0PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:208:d2::30)
 by AS8PR08MB10170.eurprd08.prod.outlook.com (2603:10a6:20b:63f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 09:38:56 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:208:d2:cafe::93) by AM0PR08CA0017.outlook.office365.com
 (2603:10a6:208:d2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 11 Sep 2024 09:38:55 +0000
Received: ("Tessian outbound b109797c3965:v441"); Wed, 11 Sep 2024 09:38:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c68aa92eb957324e
X-CR-MTA-TID: 64aa7808
Received: from Le2efd0e7e248.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 911CD9CB-E19A-447F-8320-EB9C8BFE9765.1;
	Wed, 11 Sep 2024 09:38:47 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le2efd0e7e248.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 11 Sep 2024 09:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsQ0no0j8x0OPwY6iGXTFvyqKzRQ7c+iXeYFbukmsmYttVOsM8gSBmAuaM7gZZypmU5mbz2vC8iam6r0ehAX93s2va4B9gUOa4Uhh9xPl0yBPhPw0QQabI0n+aLKLnj9IhBKfN1uQIudTTww1osW7epY4T91LHizz5WcSUn2DAV1j/IYm4pQaA/N7i+hOMJIl8RBEDfvI1TkG1a4ek6lVE00zqF/V5UllFxXA+CapL7UoyrKeMsItWqxwUC5jzoJ+rvN6lzeEpDWpqDno3mt//umEodnIEzdZMoTDTGaGXrcKM9J9NKC+C+kNmJisFozh1DLhw7Nu9a4ffJ/UXSRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZYx6wAJHgTrdBojfjwupIGKKjQ/0iMXWb0bsiosN4o=;
 b=lzXK1YYlxNuP/L0QjmbxJqv0/BHxpeSRv+YyDw1IFL0f+FR2ZG8P5YAYYpSwUS3jPb6bLlFGKleAoJBkyd80YalSkXu/JvWXP2lR0fblFPhzsao5UUcON+ZRCGgTK7c5DV18kXjLu7+iG+YG8S7SaiWeH3IA5omJoQ8bTpyV5aKn2dSfbf/XR+8AsEDKOwDPu5hSs+7GCF7oH3pzXcab1ELpZ5BsxuFzOgcXDfWtF4aBlGcmTnUprnr48zf8jQIPzE5YtXzVynwRgfLBK+znnxvZD97WNzJX6zQFdVG7zDCSy1INR7wfbK/ffou9VJtM8QzONOE5S1uvLDoENEj2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZYx6wAJHgTrdBojfjwupIGKKjQ/0iMXWb0bsiosN4o=;
 b=hLXEVVDL9wvm6v69Dxfht32DXvA9HzDEwBDVnylA5BpZe/kL1QYUjgglhpy1ZELPfh+9gJd5vM3aw/ik3LgGSyc4ygVdLzfo3kgQRqwbYGCGr8WNRcdHX2j0wN5OJiWCVxME6k+o1e7u8hRQylbnIdvyrYMAHzAnqd9gmMnZFwU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DU0PR08MB7881.eurprd08.prod.outlook.com (2603:10a6:10:3b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 09:38:45 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Wed, 11 Sep 2024
 09:38:45 +0000
Message-ID: <156cfeac-bc29-47ef-a296-b523a619234e@arm.com>
Date: Wed, 11 Sep 2024 10:38:42 +0100
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
X-ClientProxiedBy: LO4P123CA0620.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::16) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DU0PR08MB7881:EE_|AM4PEPF00027A5D:EE_|AS8PR08MB10170:EE_
X-MS-Office365-Filtering-Correlation-Id: c75ecbf2-a957-47fd-eb92-08dcd2458db0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?eWpsNzJXL3BrbUdQMldNTUJNNGJzczM0S2REYUFudncvRzlmK2NVaXZpa3VR?=
 =?utf-8?B?c1d1bllhR09rT0JEZmZaMHJkbm9sc1F1ZnM0aG9jTVhUQ0hBVnBqWTEyUkNn?=
 =?utf-8?B?QVpOYjhSTmJQa0tobUZnOVQ3VVd6ODlWRzlMa09CYWtNM0JPSkRERVFXa1Q1?=
 =?utf-8?B?MU5JN0x1Y0tWbkR5aFI3UWx2bjNPcncxNGZxTStKMTdBQzZiYTNsSzJ4RHN5?=
 =?utf-8?B?dytrclFtTEFCT2x5Z00rSUZuS1BweS9JNGxxU2QzVFplNFNRMnRQUmc3WEdt?=
 =?utf-8?B?aktmUktLSjFOK2ZrdnI0Q2JURlZodlpNbjR6aGYvT1Btcm9haHZZSy9wcnly?=
 =?utf-8?B?WFltU3ozRlRhN0Nlb09GaE5DbEQ3aklVQlhoR25Yc1NKZTcva2lJemZUTHho?=
 =?utf-8?B?UUQzOEZvblJmS0QxTjNBaFI0V043UmhTSG9IM0FqQnBEUS9xM21XWG8reFht?=
 =?utf-8?B?bmhrVytpRExpSzJlSjFWQTUwNlZKUlBWSTlhQTJLbHVmYnVldFZCeEo0dzBi?=
 =?utf-8?B?UWdrZTRrZkZ4R3d3Z2gxVHd5RHNUNVZhZnBqSmx5bFdZOW1rd2N6aEF1VTdU?=
 =?utf-8?B?NFZlWGtGWEJEN29jalh5QnZBNTN0ZkFPczgzWU5wN1RmbFFqaHY5RXI5QnRB?=
 =?utf-8?B?b3VMbmJTbldmZDlKV1dOSWxNeVNJOTVjTVEvNVNZQ2t5SWFCeit2KzIza3pK?=
 =?utf-8?B?bU12UmI4aGNZV2JnRmg3N3l2aFNJcnZ6eHoxQWtHeEFKMEt6azFheHBwNTl4?=
 =?utf-8?B?RlBKbWxTQlVhVXlNYlhvMjZhQ09xN0FRMTFlZjFlZ3BjVnRFUS83MG03WWFy?=
 =?utf-8?B?K3oyUmdtMmtFeTh6NHJPMStOTUx1cW15ZHF2UWJDS2RxTnhiY282cWNXK1hu?=
 =?utf-8?B?NEIyS20vVFZpTVZKSVRicXhpU1FMc2gyQUgzWldKRVZPQzJZVVNTYzR2N1lm?=
 =?utf-8?B?TkZDQjlzZWJPdDltRU1HdFJmdU5HTzU5QWR2clAvZjEza0l3cnNCcFFYNmIr?=
 =?utf-8?B?K29sVjNOa1VrT1NiMjc5NWJpdjR3MVBvRE9xcFlIN0lNaURCcndHTnFGanRx?=
 =?utf-8?B?WW8zWDI0M0VJd1gzK3gzU2lSSTk5bG96V0o4OFkxdnNQSVorNDIwUEJjMDQz?=
 =?utf-8?B?MlFHc3lkUXFML01wbEt5dWRMeEQvam5zbXhJRWpscHV6NUdta2FRSm4wTWdn?=
 =?utf-8?B?YTVLTE5oNU1HanJJTjBIK3NJcTVrZm9MM3ZUYXdFdnZ4ZmpUOXkzMjgrdjRt?=
 =?utf-8?B?MXdpU2tDWTVSNHQ0OEI5YXQ2ZnlrWG1JTkhKTE1CQ01BYlllc2JuQzlCQXcy?=
 =?utf-8?B?ZWxvSFltVEQ4OUpwdUtucXZqVDVLVHRrTDJHc2g1Y1F5RTlNVW5TejRqd3F4?=
 =?utf-8?B?QW11VUJPMDJ2RzBlemRDRnlGYWdsaFlQOVNUaC9YRU50RmQ1Sisva1NCaEhM?=
 =?utf-8?B?WEhWdWZ6Tnptam1IZk1PUkpNK2lmZjZaQm5TR0h5RzBtUk5oREZmOG5tZ01a?=
 =?utf-8?B?cUR3VkFnaVZScHozdFo2RFdpaVJOSGphU3ptc0d1RE81bnZoWlFxK05raUpk?=
 =?utf-8?B?UzlSY25iVG5ZVkkxclFtQThsWGZOVFFsSnhBbjgxM0plY3RNdW5xZU9NZDlh?=
 =?utf-8?B?VkNOY3FNeDlENkx6U1I0UmZCL0VXa3BhNzhoTUkxOUllcEFCbC9CZWRHTEln?=
 =?utf-8?B?RUIvdWJHaUgvL2xIZEJnT1ZHM2dUaThleDU2ZzQ3cXZHdVRMWXFzdEpheDFZ?=
 =?utf-8?B?bEUvSEUxWXlQRlg1NWlzWFZsdFhPZUR0dGI3dnRyZ3NwclF1UHVXWDU1WHRR?=
 =?utf-8?B?YVFUS1g1M3NpMmpOazlDZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7881
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2cfc39a6-4fdb-4645-ac35-08dcd24587a5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pyOFptSFlRQU5rZjRzem1vUkRXbHpwMXZUTW9aYVNMeTMxTWQ2Yy9yYWNr?=
 =?utf-8?B?czl6dFFqckJjSE5JdWN6cGVXWnEwaUtpUU9wVmE5ZW5rNVdvRENxOXN0UzNs?=
 =?utf-8?B?Z1VtVFU3dHVuYndzUnU2REVQWEFVQmJ1a0tHTnJ0NWhuaHUzemNiTWdjY1RR?=
 =?utf-8?B?dEsrWUFHYVNEVGN3R0JUZHVVNVRhajJ0SXByT0JkaVhJSU40a3dtV040aTM3?=
 =?utf-8?B?M2NWMEJtQWtFRmltT2FUbHYyMVNIdkc2bFpPKys2V25FK0dUSkhQU3drSTRv?=
 =?utf-8?B?a0REY2lJL0JadHo2TVFiaXE1NmxlS1J2djl3bFlGaGJGS091NEs0SHVZeVBZ?=
 =?utf-8?B?VzUrVFpRSjFDckFDU2dMMnozMFRNRVRoVnJEL3FxNWF0OEhrZU80Z2ZkbnNl?=
 =?utf-8?B?SGFGT1psV2FSS2dTVWNVcjFNY0lTYThmRzVMci92ZTZOZ2ZTNDVpdnB3ZWdL?=
 =?utf-8?B?bDlmSExhcGFDNjJBd2R0VVh3Y2h2UFk3dUxIM3ZEajlDQTdlcUJ0bHhrS2Z3?=
 =?utf-8?B?c3Y4bCtZTzg4VDhKYmJrYXNoSkR3RkpOV3pDY25RdXJMdEE2NjYyZnByNSs2?=
 =?utf-8?B?M2xueGRwVHZDR092ZzNCTjgwaGVBWDUycTVUcGhHU1pORm52RnI3b0hrL3JO?=
 =?utf-8?B?OENBS3pHVGVLQ1Zld0x3Y0FuYS9JR0FPR0UwNTVSRW5YWk8xSXk5c005WUJK?=
 =?utf-8?B?eVRvRDc1Wldqc2xUQmJCaE1OUG92MGZNNWhjektjcEc4QWExUjllTmRvaDJ5?=
 =?utf-8?B?TVlDSVZLb3NTa1J0Mlp2SWJCTmQrNVozZW9wdDdPeisxdWplRE9YWWt3bXRH?=
 =?utf-8?B?WmJqTks5ZnRiRzhoL1F6b1lOd3JYRU1uYm40NzdjMXF4ZG5IZ21UWkJvUUhY?=
 =?utf-8?B?ZTA1bDczOENBak5xSStCSFk5dHBnRUFSdUExd00wNEdYL2ZBamdSbEIxMERV?=
 =?utf-8?B?cThZSE9GM2FMdEtEUjdKaElvNEV2V0ZmRnRERCt4T2IyQzQ1eXJJclhjQ1lJ?=
 =?utf-8?B?MEVqcXNnV0E0Q0diNFVuVE5Eby96VkVMUnlXTndlczlqNFZ4d2RnTmhSb0ND?=
 =?utf-8?B?VlNmK2xkeHpoSkpYTkJEdVFlL1lnSjJ0N0srVXM2RHpYbkdOdWx1Mkh5MzlT?=
 =?utf-8?B?VVBEZHkwNVppRW5mQnBkSGtGdlpKTXMyampoQ0dIc0ZCeUFOS2NRL29FeTlu?=
 =?utf-8?B?SHI0bWltNG1MdCtRSTNzaXpqTnZqeXNoakU5VGhxa1YwcEdrTURnMThQV3k1?=
 =?utf-8?B?WGMybVJUYmd0V2FNY0p2Z2VmZzFGdjlMS29LMmlkbU1uTjJ2SmVKUnFvWWcx?=
 =?utf-8?B?MGk0M0xiKzVzRHg4UVpVa3VKOWhIejJpaUk3aFZnTktzOXFTbzFRcTViU1dI?=
 =?utf-8?B?ck04bDNhNmxtb3M3Zk0zUWZnYkUvWnhXeTdOYmpBOEhlaFlSemNOMmRORGsr?=
 =?utf-8?B?ZUM4NmU1LzVSVWVQNkhLb2xUOG95UlRaeFpCSTduM3o3YWx2US9Uak1GdHdO?=
 =?utf-8?B?YWF5QXk0WXRWY1pjWk5QKzUvSkNSbzJKVXhsWlpoU21MMHhzNXVEZHZYMEgr?=
 =?utf-8?B?YlZsSFY0emJraU1aUDhIckx5VDBqSjd2bkpwb2p4NHp0dHNML2hEREVpOHBz?=
 =?utf-8?B?dUdSdUZ4bWJGSTBxblBqd0RmNmo0ZUJnS2dvT05Ed0tiUmNNd1EycDdaUVVE?=
 =?utf-8?B?azFNVnpmQW9JcmdHODZoK2pxU29KZUljY1VKTGFHMmJpdnJ1eGpEZjlDcnlu?=
 =?utf-8?B?djNjZEdIMjJiZmZaM3JaVjRpbDFXQ2lwNlVmcVdYUU9kQmtMaFNCSXBZSm1x?=
 =?utf-8?B?Q2JxQTA5REEzMkxyNmwxUHpObkZqQVk4MTFwTzFPd21yeEJmZHBBTnNGUThI?=
 =?utf-8?B?L0ZHcWNOVW9Uc2hHN0FzYTZnVjM0RlRXWGVqbEFnbW55YUY0bkFRajBFS3lT?=
 =?utf-8?Q?pTl61c2y0XnXU64gClolYSzjnDrPDmXq?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:55.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75ecbf2-a957-47fd-eb92-08dcd2458db0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10170

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

From what I can tell, the decrement that makes h_nr_delayed go negative is in
the dequeue_entities path.

First:

                if (!task_sleep && !task_delayed)
                        h_nr_delayed = !!se->sched_delayed;

h_nr_delayed is 1 here.

Then we decrement cfs_rq->h_nr_delayed below:

                cfs_rq->h_nr_running -= h_nr_running;
                cfs_rq->idle_h_nr_running -= idle_h_nr_running;
                cfs_rq->h_nr_delayed -= h_nr_delayed;


