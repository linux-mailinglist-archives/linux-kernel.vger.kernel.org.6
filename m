Return-Path: <linux-kernel+bounces-271207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09290944AFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E7FB219FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511C1A01B7;
	Thu,  1 Aug 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a8su2hTL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a8su2hTL"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF51953BD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514110; cv=fail; b=Hc1vDj7yfASnUDQNKUjPpHZB3D9zUhuh0ULdr3w+2uWMEL6ZBQhQwXH01uIzmeiBTaEhG8VEz3qRSN8QyTAUjJf3fWcI3rS6/AT1QNI0xX75oYf31Eh5OCLu0piDyM7qSTFVJS0aU8wFHBpo5EMKO5R37E2NNViHgJnXtC9tXUY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514110; c=relaxed/simple;
	bh=CMU/2hawI+yQO7ZoayxNh0MfbGaJtxw7AnTI63eFmpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N6/9n/Hiv1slMRq8iOLhVfFx8rQxbJQ6YrEU7iiR6FF4cE4SfbdSgZoOy+IMoQeIoEYYDEhtfzvwQk08yN+ck7LZgxTM6/Joewx6QWxcuRyGQet8E0rI21qVvlPsBYq/a4MSL0skbWX58POoVoLxv/xm85iuds3OoIKQqEXGrV0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a8su2hTL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a8su2hTL; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Nj6/GuwPHyXesbzlUuvmZn/YS7/IXi9/CGPqv4/7qd5/MzQs2rCDEcUbqwwo9G5c8TkmekwphF0MZAyGs6fMCNrayNORn/ID/2eMsiF9aN/XWdfVzkmhXOIaK6KE0qN86P4JUPb3lbPsC5IvgXs9/opZqLaGBvfKv6z/JRofbanNQRuNVx7DYaD5TYaXQFnRUPHxpVVdGaTQ+uEGYVLNIX+fQ0uf1/h0pqr9/kPug0hXPBx2KInntRd7NQfMZ7dwgHSluLpltF1yfbBHNnZcUjNTY0QIY7A5Xz6+Sz8TPRDnTsLiu+BiTh3aIM5uWGCeqmqy9o+2iKLPAIBIMtjuiw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH6MWPBI3CJekLv4b+6qZ/QSuxmnmMaUGI5IjjiBD+I=;
 b=N4TbtCWU4QP2RLn8pn8rHp7zIlGN6TGJ5XLZAUlRDmpF/cFOkaRdpP5rBYyNZ/udd63YJFhsvpeGVz10XWAlwSf196+BLaUt/gz6+CgwhWyUv5Yp0cwHWvcHWVW4ew6UNRVtJPBTXeP1h3/nJE2i4sCPlOzSUJwr4BxJFEvor9dyE5l6eG0CaswaGh83MXJie1SNCTRJMI+H0Sike+ZwjYSasN6nIChrN7LDUVKPN8hVJ7fzCOlhDzW/h9Sbq6k5Tk+uWMEwgtMvfIsGFhdR5smSDvd+gUIwDxVwTnkIBkd7wkA7SR4JDWl3RmvLZ21pz32gmFGQI3pIZ4tCwQStkw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH6MWPBI3CJekLv4b+6qZ/QSuxmnmMaUGI5IjjiBD+I=;
 b=a8su2hTLSvN3O7XtCXMlwwem0OTm4RQyOdjek86TzZQrJr/ciGHUTEjxvaLZu6vUuYGHxFkXhE/e21wWHdE/2yzo6ZR2gEiv1hOLMQ7wGL04OtZCql1rLIMdpOCzMm3Kr80VUYA+vXUTKSiWzsvScUEQzHvc7UQzUCbZf9L0W1Q=
Received: from AM0PR04CA0043.eurprd04.prod.outlook.com (2603:10a6:208:1::20)
 by AS1PR08MB7402.eurprd08.prod.outlook.com (2603:10a6:20b:4c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 1 Aug
 2024 12:08:21 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:208:1:cafe::bb) by AM0PR04CA0043.outlook.office365.com
 (2603:10a6:208:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 12:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7828.19
 via Frontend Transport; Thu, 1 Aug 2024 12:08:21 +0000
Received: ("Tessian outbound de9676d3a70f:v365"); Thu, 01 Aug 2024 12:08:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bdc0887d4a360f02
X-CR-MTA-TID: 64aa7808
Received: from L048fbbc8be6d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id BAF59D7F-BEF9-416E-93E9-8AEDAF02F6E2.1;
	Thu, 01 Aug 2024 12:08:14 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L048fbbc8be6d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 01 Aug 2024 12:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezr2KKMWYCRVqvAYU/bpvaEfgLzqYuPCMZfzpgxP3Nwj/nVT2eNqKRvPgxadPmvajPWUdAfxSsPlB36GA/HztLZeZ5E9u3F+McMkhwtnuGbJwkb8HxFnaxP2C2Htluzrnyk7QpdW8chcEGeNowux4ZMcGfdNPlLotlcPZUhnP5Qxo4BViQ8C5fKIKH7xcVP4FUpr6A4tHf9GpH7CEMswDh3y74zdQs/o/FuEaDCnMl5HixZNRDJ4RS9cypguGku3BxSJayn4vcQif2a/1wpKj6scTVvgv4Ee2OzIU24ujPODBKcU4EKH3jHDimBU2+X58iLfSAjMO7GHSs1VTAaUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH6MWPBI3CJekLv4b+6qZ/QSuxmnmMaUGI5IjjiBD+I=;
 b=qVi1nJ8OZiXRVPgnVCsbkaz13hASl+d5hgddDIEJc0Dxzj1RIjxkiRZivAUBJf/WkfTQEBN0aF1z2Y5RLuEKhUNfv0OAtnBi6eg8D1HWDThO1YMjY2bCbTsvwZnoMUoiosqcgVYerr50qdtbRIe01Kfwhj3PiurYi4WK4ZBBBL7aTcV/wwXyLJ+IFWRdpeN0uGc8qgWy2u2d2cnk91kfvjFo/P5Wl2nYtdVZPcmgTWmiiMQkKncqMM5qdXnlojx5Vq/cigS5/zo87Dv1yob1oC6jRQghE/VAK15qnLqH/Tbw8pbkqmBpvAKYGwF17g5IGNG5f/xz134LDqhade2vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH6MWPBI3CJekLv4b+6qZ/QSuxmnmMaUGI5IjjiBD+I=;
 b=a8su2hTLSvN3O7XtCXMlwwem0OTm4RQyOdjek86TzZQrJr/ciGHUTEjxvaLZu6vUuYGHxFkXhE/e21wWHdE/2yzo6ZR2gEiv1hOLMQ7wGL04OtZCql1rLIMdpOCzMm3Kr80VUYA+vXUTKSiWzsvScUEQzHvc7UQzUCbZf9L0W1Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DU2PR08MB7326.eurprd08.prod.outlook.com (2603:10a6:10:2e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 12:08:12 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 12:08:12 +0000
Message-ID: <d0160fee-87be-42c5-a050-e436980f0acd@arm.com>
Date: Thu, 1 Aug 2024 13:08:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] Complete EEVDF
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240727102732.960974693@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DU2PR08MB7326:EE_|AM1PEPF000252DA:EE_|AS1PR08MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 126a999e-574a-49c0-2693-08dcb222a2f8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MndLRUd5dXpMRFZEZmx4Q0hDN2R4VCtkZ0o0REVkMjg0a0NseEZxZHBJcitY?=
 =?utf-8?B?OEFncElJbE1OdzVFS3lmOHNlbVFJUVlYUEFSYi9wa0Z3WDc5c0l4NHBFZG1R?=
 =?utf-8?B?OFhNYU5NZ2w1eE9aQVdHMmFSeG4vUHRkZUZpdm83YTNBbE5zVnZxaW5VaXdi?=
 =?utf-8?B?c3ZIZStuUTQxajRadHhXQnliWkUzWkxoOHg5UmlpbldibmVhbzI4VGhTK0FL?=
 =?utf-8?B?YlFvbnJFcW4vNUsrVnVkMzAxNkRveHlSdjdoN2w1Vkdtb2FLTXhPdG5BQlYz?=
 =?utf-8?B?NXcvK2xZZnlBU1JnUysxNW1aUVh0djJYd3ZtUDg5eTFsUlR3Tm9NMVRVYmtY?=
 =?utf-8?B?cXNuQzRxamxQZGFsdkVmZjg2eGRZb3NEVDBZVi81K2d2VktOYWRjcWVGSWJl?=
 =?utf-8?B?ek5lNVUrQk42TC9ONnFvYzF6dDdzRnB0REtDU1dhMUxuMGpwOFlzWDdNM3pE?=
 =?utf-8?B?bG4yNUl4R2szWUtpN0hJMHZaMDdtNzhOMkIxZFBzNXVjNmY2S0hzZDh0YmJQ?=
 =?utf-8?B?NHZpbFo1aks5dmNvRzJXcW40ZmN4bzBuSU44QXhaR1hyTzU3RFdRcHVkOG0r?=
 =?utf-8?B?SFMwUTNrL3FpbElUbTh5WkV6K1g3aHNGVkJNZnFINjlSM09DQ2prWDFhMWtu?=
 =?utf-8?B?VFZjOE5Hck9jQk5MRHRyOUxBQUw2K0IyR1lPaktyV2FNS0RlMWdpMU8wN0NF?=
 =?utf-8?B?NjNwQjlwMC9yRkhtVHM0R25Qd1VCS3pYVDQ4d1plUW9BN2w2dUsyaU1KZGVU?=
 =?utf-8?B?QlBORFp0R1dwTWlaQWpudHpVVjF0TjlQbGs1Y085ZFJ2YzRHQzJWK1NCU010?=
 =?utf-8?B?TUJmbUw4U1FsbDZRWVBBZ3ExY1hxWnZjQlNybHBDVFBJSXlIY05XQ0JHQkFF?=
 =?utf-8?B?Y0dGNlJ3V3dnZGZLdi84MDZOd0d6bXRtcjVrRjc0QkxmNE5wRkV4UnlNdGZV?=
 =?utf-8?B?NkJrb2NUbklOMEZaTE9ZazhvRjBoMk41RzVBUjMvaGoxeGo1MThPYndhMmMw?=
 =?utf-8?B?RG1SUXN6NlYvYVg1TlJuVDUrdXJkWlJBZ0cvMGd1dDlTODNvRFl0eHhwNGds?=
 =?utf-8?B?RVVzOXp6RmpNLzMrSnFrNEdLTk1SUWJFR0RWMzRlSGMyamlzUURzdFhsUDBa?=
 =?utf-8?B?d2RZbWx2SlZvaDhGT1NBVWk5Vnp6TDBJUDJKLzNENjhxSGlYeVlTQVRQQjNV?=
 =?utf-8?B?OTJiVWRoZWpKU0drcXh0OUxHVHVZN2tGMncxT3llTTVWbjdQQkRvOEZ1Zi8r?=
 =?utf-8?B?OXJOZXNWNGNYR0tDbTAraDBNcEZZeUZKODYwOUF3TFk3ZlZ1VE83RHR2SnFn?=
 =?utf-8?B?bmFsTHNTcS9ienRFM1d1OGFEKzFhRU5NWGZpMy8vc1hhZ3ZuMnE1cWgyaWta?=
 =?utf-8?B?MkFONjk2UEp1ajJ2cTFONURVaFNSRmovTFd3NVVkTGN2QTVSNzdIVXpJbUJP?=
 =?utf-8?B?bDE4ZmNXOEZIR1lZQVlRYnQ0a1NCaGtISEtxMHNJZllDNWZ0VlBKY01EcHJa?=
 =?utf-8?B?cm9SYXhWZWgxc1JXNytXUVNFeFNRS3Q1dys1Uldnb2lvNklRSHA2OXFURk8x?=
 =?utf-8?B?ZTZyYVFJN21POURhb3I0dFB4UE9wNXJHTzd6MnFrRHB2Z3FlNk1rYnhZZFA1?=
 =?utf-8?B?VU4xbitxRnRrZ25LQ3A4NXZmQVBIU1AxM1BqbnZEVnhwKzBpYVdUZkNzUVJP?=
 =?utf-8?B?VFFmcXZpNHVuWUtzbHRvRDF5SGVHRll2T0NpRFhMZkw1S3pTKzEwUmxFK1dl?=
 =?utf-8?B?RU1hdVNkK2tqU2VEcWQ1bjdxdE9Yd2d4Y0k5UjJWYktuR2JNRER5d2tpU0ZX?=
 =?utf-8?B?NEVlWlYxWWhGdlQ1Vm9XS3JuSnEwMElOOFYwVE1BZVBYNlhOc0w2MDhBU3Nr?=
 =?utf-8?Q?Udz11WBliW1jq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7326
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3b4a6539-1dc3-4a03-6cdf-08dcb2229da4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a09GQ1VpV1F0TktoNWR6Y0N3UU9EWlhaVFk4VUJWQy9GMUIydHB0TllVM3Vo?=
 =?utf-8?B?Nm5jYnY5WTkvem05N25qVEt0RXNJVDdVNUd4aFc4SFFvMDRSajMxWGVvNGN2?=
 =?utf-8?B?ampqN3Bkbk5ZV0Ryc1ZZam9lRnFxbFNnL0pxVGIyQUFPVmJiU2pCREtpOUpr?=
 =?utf-8?B?MzFNblFBZWxCeDZrNEQyNWRibG1ZNERQOFhudm1WTzF5QmZjdDBtVW50cDRS?=
 =?utf-8?B?UENCb0Qvb2llVWJsZCtDUUUxMkV6cnFhZjVrRUZWSkxoTzhHUFM4eXB1bldG?=
 =?utf-8?B?VE0xYndETUEyMUkrN1VMWHJUL3ZaUjhwaEdpZjQxckxmOHR2Mk9KNFZEaTAv?=
 =?utf-8?B?VnNqMGdWYTB1Q24vVlFHQWZqcVVsdnlYVVprZ05HTmNUZXFKdnFjVUFtZUdP?=
 =?utf-8?B?WDdybFhhK1NyQ0wyNFkvL21pNU9BZ01EZWd3c1IzdmgrMW1yNUJMOUxCRENO?=
 =?utf-8?B?ejJIWHIxRjNmVU1DbXd1QjJSbURpd3p5WVJXK2xhSHVGaGhYejN5UG5YYmZ1?=
 =?utf-8?B?TkhCN1FHY1pWK1pCT1pkc3l2VE9jMjVONEV6N3hmbVBld0RrNDFnRFpPR0RL?=
 =?utf-8?B?bXJUZzJLZGRHUEZ0N2ZyWGlGNzhoRWJIQU0vc3BtcDNZOXh5KzdzQ3FXVUs1?=
 =?utf-8?B?OWJBL0FWRWFGZ2JKV1BuOUtaS0w0T1lXODkrNnhLblRiYmd4WlVYc3QzU2Q5?=
 =?utf-8?B?d0VoU2dHck16SDFCSFd2UkU2N0lNU3lXbndmMzZmVWthWUhSWWZKMXNsZWNw?=
 =?utf-8?B?Z29vRWpyaTRZT0Y5V3B6d2xjVVVwVEQreFR3dUJOMnh3TktXajcxaUcvOFZW?=
 =?utf-8?B?L2Evc0NLMXlnWndKL1kvalN1YS9OSFJNV3RqeW9tK29kazFCdTR6UllwaDNL?=
 =?utf-8?B?N2NnWk9pUHl5TWNNbUlnYnRZVHVkWkwraXQyaXg5QjA0OERVSzV0eHR4OWJu?=
 =?utf-8?B?ZWNsU3ZES0Y3R2dteS9DM29PYkI4R3E5cFE4c3FWWEZ3VWlLcDZ0blBaRzFk?=
 =?utf-8?B?dk5zT25XVG1lZ21icWxLV0h2aVk5ZnVHa0FVbjRLb3B0WGtvcWl6b0hWQ1BD?=
 =?utf-8?B?NjlvdkRYNkdldmxOMTNlZWxvUFpaazFudGE3M3Y4OStWSm84ZTIvWWkyQml0?=
 =?utf-8?B?ZnluSlpuYk5rc1hVUnh3K1hBd2d4Wkt1MWwwS3VDMkhJMjJEWXI2aHRNT3h5?=
 =?utf-8?B?UVYza09mMTIrZmRuajdOK083b2R6dGRJUXduK0FGSExZVWZGcU51SlJjanhY?=
 =?utf-8?B?Vm9YM21XTVRFQmswSlQwMGdSb2dwQlZEV0F4UVJOZUs0WjhobW1mVnpzSEtx?=
 =?utf-8?B?NnJuNG5Tcm1uT0tWZ2IxNjQydEVnVFIvQVJBMzEyQWdIc1N5bjZTSlR2VnNv?=
 =?utf-8?B?TjhlSVB0VWV3Y2IvbmF6SVNVQVFMRFFNYllXazFadWhiY3JWdzc0eWVnZVhC?=
 =?utf-8?B?L0pkT0JNQnpYa2o4Zmxab0FyS1RPSFp1YllxUGtNbWZPbVpoWWVJRHZiN0lS?=
 =?utf-8?B?ekIyaTdMU1IwSVBaTGVYTTBpei9uRDdRekdVN01GRW5XZzFSaHllRWs3V1Vv?=
 =?utf-8?B?QjVGT1RjNjR3THgrOXNxMjI5ejFUM1NBekQ2UUp0ZWJCL3BZTDg1RWdFdUNX?=
 =?utf-8?B?NGtuUjhCOTl5WEdqZEhSYTV1bjZOT3VkMlhMOFhBemhLQXgvZTlOeXZ1YzdW?=
 =?utf-8?B?d0hFdEdrWGppRGFCajNmUU1HbFNMaU5hdmxkcnhscWRYaGpKdVpRZkppUXdh?=
 =?utf-8?B?RXk1aUtsTk0vS3Y4SlYxVVVZVHVRa3BNaGhlNDhPTG03QldmaDExblZYVk5U?=
 =?utf-8?B?K3VqbEJ1TjZ1NS91amZvOHVSR2Z3dFgwVmVwaEVTZ0RCZVlOTmdWeGJwQkJC?=
 =?utf-8?B?RGlBS1NZcHhLdWhBWXpscnNWaEtTWVJlbjVuZjYrRU82UmJWZVl6MFdyRjhI?=
 =?utf-8?B?MlNHOU1JM2xhdTNpZllwM0J3YURrUGhyL1E0c0tZTURGQWpWUmUreFdQQVFI?=
 =?utf-8?B?bHFCM2d5K2Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 12:08:21.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126a999e-574a-49c0-2693-08dcb222a2f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7402

Hi Peter,

On 7/27/24 11:27, Peter Zijlstra wrote:
> Hi all,
> 
> So after much delay this is hopefully the final version of the EEVDF patches.
> They've been sitting in my git tree for ever it seems, and people have been
> testing it and sending fixes.
> 
> I've spend the last two days testing and fixing cfs-bandwidth, and as far
> as I know that was the very last issue holding it back.
> 
> These patches apply on top of queue.git sched/dl-server, which I plan on merging
> in tip/sched/core once -rc1 drops.
> 
> I'm hoping to then merge all this (+- the DVFS clock patch) right before -rc2.
> 
> 
> Aside from a ton of bug fixes -- thanks all! -- new in this version is:
> 
>  - split up the huge delay-dequeue patch
>  - tested/fixed cfs-bandwidth
>  - PLACE_REL_DEADLINE -- preserve the relative deadline when migrating
>  - SCHED_BATCH is equivalent to RESPECT_SLICE
>  - propagate min_slice up cgroups
>  - CLOCK_THREAD_DVFS_ID
> 
> 
> 

Thanks for the updated series.

FTR, I ran this through our Pixel 6 and did not see significant differences
between the baseline (6.8 kernel with EEVDF + fixes) and the baseline with
the updated eevdf-complete series applied on top.

The power use and frame metrics seem mostly the same between the two.

I'll run a few more tests just in case.

