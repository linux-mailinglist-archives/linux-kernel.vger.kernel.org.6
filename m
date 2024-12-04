Return-Path: <linux-kernel+bounces-432041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F400E9E442F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C073316891C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1071C3BF0;
	Wed,  4 Dec 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QhCsyEHt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QhCsyEHt"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067E1A8F6E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733339424; cv=fail; b=Fbc2Cic74C2iGK0sKfILcpTTzAyyHHBdACzR/djQBYAQwcH5foxhHxMazb9HbLXhc+8qXKzMaJIFuFVqw3HVMRo6WpkDDDWYexBe1wjN+AR1jw0wq0p+1YU3KjsmLH8EcYMqXHsv9HXJZMd3uMZB203kM20pv6TOs7NFlLsswdc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733339424; c=relaxed/simple;
	bh=GsQDFEj7HbkImKmOYC1ZX+3QK4+ZZrfhOtiQCYq4wb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gA9Xn6JHPPcgrjt4zE3oq53OIagXFrUawGoqlvTn6jq5o1R6pwWQJMonCmxIjvIkb8ljyMIrrq53+Jl9NAXPKpfRlyglePbE6Hlfe2PUIhzKzgRU8OXRctmYc6TDGKNCMBeNe405KcaOFzh/5skde9zx7KaKMtfc773g7XRXvvg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QhCsyEHt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QhCsyEHt; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uAcS1TqPSZeH3uHHRRqg60aOOVB/L1kFnbiox/u06YOeUC3tPZ7n4cRzieeHf1ZtKASRWeZ+xyWNG/24Rruhi3nqCoW4vcD87E336Vd50N5vofm2Ctv0weC3Rv9jFEviWlPQJ2Xh16MNSmYQkGRWNQryw/NFL+mSUKkVdNltfNDq/gHAUY5oJpTocJYwrtpHUyHUwwaj46vHioADiyRmF3j3enqVNtFfSvuYGmZHaxufjeQ9tQ2BuOuhg3EcC8/OZkr91nGe8ntmJ46EkD3K34U/rbErFMMVjzDe6E+C7kJiwnYi0+9kg+u9ZRC5gusMRbC1opTmJYHV3yu7+sr7Ww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HgruuG1BEyaMAtVoaGRWJ0O5D0WhZdoyOqZedrvo+4=;
 b=H81MJkkARRfwoFcnmdIyzWQqit2cQfNTOmeAOXvBFfFdnnhAUd0GsFlYf9bVqKvsML9iYTvYoDF/eqdBjcqKMZCgIme7Co+fwTo10+g6GjxZUd3ABiheXVzpARL7mhorVdo7LWo4gHWP7oXawERgvPPOlXqHirzzjcaywfLAZRVP13i0VczUbqrePwmddpJM6PaHEu4ms+gBEzex0Wd8zQNwnXxPtVMZBg/z/hZTjnkY2Dmm+BI9tafH6ObGngQ5R+ro9tJBhIvDPFYrhno+MUnXqXi8/2wv8XWV31Y15kHn43PlTmkXw0S+8bYiTC/DsTvwGW/1cYMCmB5d0XylBQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HgruuG1BEyaMAtVoaGRWJ0O5D0WhZdoyOqZedrvo+4=;
 b=QhCsyEHtBZNcmwhqcqWYzgv1MYjGxUTpOFPkIgpsWC5/4O7jdOMijz1BorkVzoUrSoY5mTiPkV+pyz1Kl3sVxl9zfp0zws3F7oLGXFhlABWIDKt6eUEHJLDsHylnaZBQzbMMmsN/YT4W2z0bhNfkw7vRPFVHmM0NN1fFslbviRk=
Received: from AS9PR06CA0581.eurprd06.prod.outlook.com (2603:10a6:20b:486::21)
 by DB8PR08MB5321.eurprd08.prod.outlook.com (2603:10a6:10:11c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 19:10:14 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:486:cafe::dd) by AS9PR06CA0581.outlook.office365.com
 (2603:10a6:20b:486::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Wed,
 4 Dec 2024 19:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 19:10:13 +0000
Received: ("Tessian outbound e5f180d9e249:v522"); Wed, 04 Dec 2024 19:10:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 310afc08fdf52d9b
X-TessianGatewayMetadata: wXyuRCZjf/9eUhEJm6eCTQAec08bVJFdvAAG6HjL2moBT/ni0lD1TNCgveuZZ8Jgf1N2CA3zSVAYS2cX4wbELiPI/QRU2xkorfS4ROE22/bBxNlvwL4TeWVZUPkVAjXk5FBtoAV1J/xSvbrhJIq8ij4Kzwe2Gn+hcTtkOOUz78E=
X-CR-MTA-TID: 64aa7808
Received: from L56cadaac3350.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 21E7A8DE-35E7-4CCE-9C89-0454710A081E.1;
	Wed, 04 Dec 2024 19:10:07 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L56cadaac3350.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 04 Dec 2024 19:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJLkY0XFdoxSUCXQ818a7zgdlN+raJiLQaZqpOxW2a1XTMz+UUXCIpzfUwlwc3u/y4IgbxJwFxzndUZ7guo16jT3kEIcLzEBGzrRoF6L6FqKq8+txbem6k7o3aEoCb8hGpjY0a1C1ejhRsClzQJhucq1fsBX7BFNU4Ox/2WF895UlDGXAxO+z/3ULbKRtNnQjtIqPCxvW3F7qZ7TysQjlrR+uLPGn6eRbY4YxknrXmhet9PRWmqRDbF2lTbPt40xFUchkvytHQLj1peLUl/GODyI+4fppIqMO8GYXQRsz9/ZH5/7BT80BfHro/ANzxfLThiTiduUDE8NQQxoLr4Nqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HgruuG1BEyaMAtVoaGRWJ0O5D0WhZdoyOqZedrvo+4=;
 b=lS/1sC7b94BA6oK9vPo0TcawsfRZ9tfN1+S/owcsowMnsU37oFTG8/zfqQQVRCptdPvCJfN/6AQXeWGuY/4YeKgiFcTmGfcimOT1kvut6GGHvsv2965ZodXTYVMOpPeCdVCyJiUITcGVFzK9jAPXlk6E17+hers3RIn1jQ2oBwT8YkxBWApimKvMFIfWv7zjVT6EbZWrCnC+/hWKHBzDXkiV9yoKgur9VC46UhLU5g3j0jAur60+APY0WCR8Je75hY/KBCo0dAaLnjP/hbGfNYMSy8vrPkyMr1uR5x54py1CqQMmaf/xq+lOO+CTh/jWYhhYMrCwO0VKuT6uBseR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HgruuG1BEyaMAtVoaGRWJ0O5D0WhZdoyOqZedrvo+4=;
 b=QhCsyEHtBZNcmwhqcqWYzgv1MYjGxUTpOFPkIgpsWC5/4O7jdOMijz1BorkVzoUrSoY5mTiPkV+pyz1Kl3sVxl9zfp0zws3F7oLGXFhlABWIDKt6eUEHJLDsHylnaZBQzbMMmsN/YT4W2z0bhNfkw7vRPFVHmM0NN1fFslbviRk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DB9PR08MB8580.eurprd08.prod.outlook.com (2603:10a6:10:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 19:10:04 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 19:10:04 +0000
Message-ID: <d36ed494-0143-4afa-8c14-cac7b5d20245@arm.com>
Date: Wed, 4 Dec 2024 19:10:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/11 v3] sched/fair: Fix statistics with delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de, tj@kernel.org,
 void@manifault.com
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0332.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::13) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DB9PR08MB8580:EE_|AMS1EPF00000044:EE_|DB8PR08MB5321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8efb7e-a116-4cd7-ffd0-08dd1497482f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dDgvdlZWZFh3a28zeDFyYWw5S2Nmd1NYOUIrOVVyZm5MUlJ2SHl5SVdPcSt5?=
 =?utf-8?B?NkExeFJDR1BtUGp0R1l3djhtTkRhbFZDY09LL1hyYW9GWmJtZ2VtUEVyMTQ2?=
 =?utf-8?B?bWxVUFVBcHJvVjlES0hSWUp5Wi9OdkJWVnppOHArYW9neDMraTN6ak5VYlBV?=
 =?utf-8?B?RlFMVFA3RnpVYXVTaFFlQmJFZ1VYc1V0NTFCS3lxS1l3YTl5K01wajYxMFJk?=
 =?utf-8?B?Qlc0VFptY25sK0YwdzdGeHNvUm1VQ2xFYzd4SGxsUVhhaVdMcjFEYWhtVTll?=
 =?utf-8?B?Y1BMMm1ZWTczaUgxQ1NTdE5NaGtwbDlyQ2twSlN4R1VXRkhTdzU5OVZQMlVa?=
 =?utf-8?B?RHRnV2hieFZtcXA2OGU5U2ZsQ0h6TmtrbUNyYkpHNFpCRDFxMWRzV2xKTUNJ?=
 =?utf-8?B?ZUhsWExhRDluaWljUGNTSXVjUlBlbE5ISTU2b250azV5eER2cEJWQ0FtTVRt?=
 =?utf-8?B?YXpQZDN5Q1A5eS96TlViZEpjSTdHMHBUaFRjVzBNR2FVQS80Ly9wRVpMMVR3?=
 =?utf-8?B?OXhnWmZlbnpBcTlPWkRCMVFQRW5IZTIvZzUxNk9GaG1rRmxDeWlONjZJVlk0?=
 =?utf-8?B?L014c3RzTjU2TVdVVnNyZVFoTlgxVjJPTXVGTFNnRlRJRGRjOGdkMnRLdXdr?=
 =?utf-8?B?VU5uSVBHNjFUa3N0cTEyQ0d2d1pKbnhKRGVqQTlNS3hMTHJwWDE2U1BFeEdZ?=
 =?utf-8?B?elcyV0tEalJISFg2YktyeUNQOHg3UjdwS1czdmt0NENUdVkvemFKakRTRlNw?=
 =?utf-8?B?dTYwZVZwc0xtRTFZc3g4aExDSjJYSzFMZzNPbElnOERtM1l5M0UzcmNnZm02?=
 =?utf-8?B?a3dOYm5hellYLzBWSDVsUUQvczRUTUlDQ3Z4K2VSRWoreHJiRldmYkM2eDdN?=
 =?utf-8?B?Z24vRm1YcXRJaUJQdERzVFFwazRZQkEvajgxdTRwa0pGYkg3dEhCZnRkWldz?=
 =?utf-8?B?ajE0YkpKbDd0ejFwR1dTcUs0RTdrMlBXa0FaWGJuUTJka0lxaVN4YXY1bmtq?=
 =?utf-8?B?Vi9URFdDL1NmNFF3RFJjNlEwUlBFaEZmSk1EV0hjT1hwd2g1YzE3eUM3MGdE?=
 =?utf-8?B?L2o5eEtQWGdRTDFRRnV2RTJWUk9hWk9BQkpVMU91em16M3UycmtwVnp6cDBV?=
 =?utf-8?B?UExQTkk3YUw1OTVGZlQvNG9UMjJiQW1wOTIrRUJma2dWajRacno1WXV1b29i?=
 =?utf-8?B?WFArQjNTNkhkQWZ3OFlBVFRzbER2RmZvRjFWMDkvSUtwdUtJTUY3N25CaFJs?=
 =?utf-8?B?MGFSZHJOQ2pTUVJPN3pOWStvODZWSEM5YlVVMEd2S01GV0ZERjlVRFpEVjJ6?=
 =?utf-8?B?OWhLWVg4dzdTQjVubk1rZEhkdkFkZzZJeGNyaGpkSkZqMEZzQ0RjYzFjNGg3?=
 =?utf-8?B?bktKSEQxYnlNei8wZXBWNk5JS1ZDeTNubDZxZnlLL2s0M1BNclA3c1V0V1dJ?=
 =?utf-8?B?ajNaUGh2MEY0SGwwSmhtMVdMQkgzTXB2TDhhc1NqWU1ROUtKN21yRnh6b3U3?=
 =?utf-8?B?b2VrSTBsYm4vcUFRMzRLcTgzelg2emVyNW1VS2poRWxnZW5wVTJnS3hpM2hE?=
 =?utf-8?B?MlVDSFFNd0Y1T1lneUdiS3VTbkFhVkJlQjhxYkNSSjNxR2lNNE85VTFYdS8y?=
 =?utf-8?B?cHNlYTV3MGR3c1AwTVY1Skh1Ykx2VUxiT0xkVThhWDhGMUpzdHdBenVHTjB6?=
 =?utf-8?B?SjV3R3RCOFFyTGxGVzNWaStVcTRRNnhOeWVaMDBwcy9WUXpNZWVzRHFtSFZT?=
 =?utf-8?B?QXFFWmZLSGhBNjZHU05KQk83bm1hL004aHB6c044UzZrMjNycVFqVnV1aVJW?=
 =?utf-8?B?STFtZmVZMFN5bnRYclVNREhMa3JhQnh3bmI0MkJvdlpXNWdIY3IrOFJMY1d1?=
 =?utf-8?Q?RBN40X9y/EJgW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8580
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c7e48145-6165-46d3-2f50-08dd1497426f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|14060799003|376014|82310400026|35042699022|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmRoQU4rd0srU3V3YUh2SVJUL1dDc1JMZmxITW0yMVY5V3V5NE9jdEdwaHlv?=
 =?utf-8?B?K0o4dHQ0OGNjODVVbkNaaUZNbkhKRGRSVEhFVkdYT1lCSHY0VGZ2ZkgyQkE2?=
 =?utf-8?B?aHpBbXpoUmpxNi9Rbm9vcEs2cWVXTDZpeDFsMjl2OURPUHpPeXJJNklaaFlF?=
 =?utf-8?B?VlNDK0xQMVg2WEltZEpmQitkZEltL3lvRVo5TkJBLy9MWkFHNWg1dHUvZGcx?=
 =?utf-8?B?MGc0dFN0WXVsYi9GNXViVnNIbUlhaWhuYzVZN1ZvZ0xVSytQTWNuMjFJVVU4?=
 =?utf-8?B?QmhwS2ZYQnlHOFVncW9hWU1IL0hITEgrY05VOGU1S1JlR25sRDJoTWU3WVRh?=
 =?utf-8?B?dmJXSmIwdldNZENHcWszQStxYUV3UXZqbUZFWjBlTGhTN1RpYVpUTFpRSFNv?=
 =?utf-8?B?UklOVTRyS2N2WWY2ZmZrNWVjZ083VnZCL1RrRmdYenhrTGZDcEpJdnFNNUJO?=
 =?utf-8?B?YU5YODkzdjdqWHFwYyt0aDBvZFkzOGRwRjRYazFFZ2l5VHc4Ti9nZ1FJRUVV?=
 =?utf-8?B?N0dDQ0ozWXZEeXZpMmZrdHpUTUNxZVRLazF5dDdwT2tsNU1BNXVQbXlkZ3RJ?=
 =?utf-8?B?VlJ2TkhpMVlsSmM4NnhTSFpqbjYxeEJJMGFYOFJrK004b01nVUpVWVI0eHZt?=
 =?utf-8?B?ekNtUFk2NFh3M1h1L3pJc1FjczBpUHJQVFo2ODhJY1dMcjMyNjkwRnloS05l?=
 =?utf-8?B?TEVaSGdxeDRUZFNEVk5NWEFBeDdFQWJ6ZCsxeUdNNUl5MzVwZ25LdEhaeE1w?=
 =?utf-8?B?Ny9ta3lzdmVFK1hLTEdOOUhwMzQ2YTd5S2Vqck1YSlA4NlFwYlhwOU1sR25y?=
 =?utf-8?B?TjVwNlhKUll5QW83aWZLcWlDTkNkTS80UXRHNkJoVEM4MFV4ZG1XZ3d0YUR4?=
 =?utf-8?B?ZjFnQmlKdjl0ZHcvNSszbHJsbUJDVTRZWnBkZ3ZzL3dPSllGT1pkb3FrR3RK?=
 =?utf-8?B?b2xwdENQNThpVEM3T3NuM0NhQ2hETG9QeDd6S1FnUGY1dHQrVERKTWYyTVBX?=
 =?utf-8?B?a0t0ZWtyNjFqQk1iYTByNGd2aXhWTEVMTXFJZ3lmTm1hdjduK0RwdmdHT3l1?=
 =?utf-8?B?YS9ReXc2N25CUi9xSmVsQjV6U0RlUnBXNGhaQTFJQ0w2SVN6ZzZVbjBWam13?=
 =?utf-8?B?T21zRjl6b0hlVTc1RVpHeG1pbDFVaWNUMXRoZFFPM28reXQvc2NUVDc3OUQ5?=
 =?utf-8?B?bXRsN1R3ZDZpbGRqT0pwSytTeXc0ZUU4NXZBQWlJVUxCR0dEaWVJN2xvblJv?=
 =?utf-8?B?cUtaejE5L0xqT3RQUC9qTDF6QkxOM3o3ZENGb3BvTGR2Z3JUTHBadStPZzRn?=
 =?utf-8?B?S0puWXR4anhCSWhpRVNYMHZNVGYvNENsU1lYUTRrVnhHZ2xFb3A2UUFvNWR1?=
 =?utf-8?B?ZHVHcUpWZ3NCZWdtajJ5MG02ZkFydzlrV09KZmtZMGszazBiZ2dENTY1a1Na?=
 =?utf-8?B?VUVPcjRnTWk0RUlremZ0T0UvS1dnWWwvWnZTNUdQK2xobi92ZVVZV0RCQnFm?=
 =?utf-8?B?RUNLeWVySjU1Vy9wVm42Y3UxSnhFdllXc2w5L0VWaDc0K1BJUXZrYUZib0Z5?=
 =?utf-8?B?aEhCL0c5YWcwd0dVaHJnRXoyVkM1NzhBb3l1c3EvN0ZZNHdCR3haNGwyK1Ra?=
 =?utf-8?B?SzlpRkt5YmprbVJucG5YbFdkZHd4ZEV6dk1pRzVHV0xNSUpjSUVxQ2QwbEM3?=
 =?utf-8?B?emJKalBDZjJmSENhWjM1N1JCQVVKSGhBbnlOcGtlU3NldFA2WDk2NEFaRVFO?=
 =?utf-8?B?SnhwVlUwR0JnV0NWOGozVUp2bmkvSHk3dGpUSFdpMWFKRmNyOEhKemF4OU1s?=
 =?utf-8?B?VUI1UXZUQlNUQlhhSDVZWHA0K2Ztd1NLbUZPa0lRNFpBS1puWjdEMk9mSCt5?=
 =?utf-8?B?eUVkVDJORmc4Q2NtZWVhWHo5SUFGTEZqMWlaZU9vUjlZdlhmcmlBN1B3MFUy?=
 =?utf-8?B?eEJZMGM2UEI1V1JhMUc2K28xRGw0UmNqTFpselltaGJRQ3VSZHNXQUN6bFNq?=
 =?utf-8?B?Y3dERDU1cmJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(14060799003)(376014)(82310400026)(35042699022)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 19:10:13.9419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8efb7e-a116-4cd7-ffd0-08dd1497482f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5321

On 12/2/24 17:45, Vincent Guittot wrote:
> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
> lag has elapsed. As a result, it stays also visible in the statistics that
> are used to balance the system and in particular the field h_nr_running.
> 
> This serie fixes those metrics by creating a new h_nr_runnable that tracks
> only tasks that want to run. It renames h_nr_running into h_nr_runnable.
> 
> h_nr_runnable is used in several places to make decision on load balance:
>   - PELT runnable_avg
>   - deciding if a group is overloaded or has spare capacity
>   - numa stats
>   - reduced capacity management
>   - load balance between groups
> 
> While fixing h_nr_running, some fields have been renamed to follow the
> same pattern. We now have:
>   - cfs.h_nr_runnable : running tasks in the hierarchy
>   - cfs.h_nr_queued : enqueued tasks in the hierarchy either running or
>       delayed dequeue
>   - cfs.h_nr_idle : enqueued sched idle tasks in the hierarchy
> 
> cfs.nr_running has been rename cfs.nr_queued because it includes the
> delayed dequeued entities
> 
> The unused cfs.idle_nr_running has been removed
> 
> Load balance compares the number of running tasks when selecting the
> busiest group or runqueue and tries to migrate a runnable task and not a
> sleeping delayed dequeue one. delayed dequeue tasks are considered only
> when migrating load as they continue to impact it.
> 
> It should be noticed that this serie doesn't fix the problem of delayed
> dequeued tasks that can't migrate at wakeup.
> 
> Some additional cleanups have been added:
>   - move variable declaration at the beginning of pick_next_entity()
>     and dequeue_entity() 
>   - sched_can_stop_tick() should use cfs.h_nr_queued instead of
>     cfs.nr_queued (previously cfs.nr_running) to know how many tasks
>     are running in the whole hierarchy instead of how many entities at
>     root level
> 
> Changes since v2:
> - Fix h_nr_runnable after removing h_nr_delayed (reported by Mike and Prateek)
> - Move "sched/fair: Fix sched_can_stop_tick() for fair tasks" at the
>   beginning of the series so it can be easily backported (asked by Prateek)
> - Split "sched/fair: Add new cfs_rq.h_nr_runnable" in 2 patches. One
>   for the creation of h_nr_runnable and one for its use (asked by Peter)
> - Fix more variable declarations (reported Prateek)
> 
> 
> Changes since v1:
> - reorder the patches
> - rename fields into:
>   - h_nr_queued for all tasks queued both runnable and delayed dequeue
>   - h_nr_runnable for all runnable tasks
>   - h_nr_idle for all tasks with sched_idle policy
> - Cleanup how h_nr_runnable is updated in enqueue_task_fair() and
>   dequeue_entities
> 
> Peter Zijlstra (1):
>   sched/eevdf: More PELT vs DELAYED_DEQUEUE
> 
> Vincent Guittot (10):
>   sched/fair: Fix sched_can_stop_tick() for fair tasks
>   sched/fair: Rename h_nr_running into h_nr_queued
>   sched/fair: Add new cfs_rq.h_nr_runnable
>   sched/fair: Use the new cfs_rq.h_nr_runnable
>   sched/fair: Removed unsued cfs_rq.h_nr_delayed
>   sched/fair: Rename cfs_rq.idle_h_nr_running into h_nr_idle
>   sched/fair: Remove unused cfs_rq.idle_nr_running
>   sched/fair: Rename cfs_rq.nr_running into nr_queued
>   sched/fair: Do not try to migrate delayed dequeue task
>   sched/fair: Fix variable declaration position
> 
>  kernel/sched/core.c  |   4 +-
>  kernel/sched/debug.c |  14 ++-
>  kernel/sched/fair.c  | 240 ++++++++++++++++++++++++-------------------
>  kernel/sched/pelt.c  |   4 +-
>  kernel/sched/sched.h |  12 +--
>  5 files changed, 153 insertions(+), 121 deletions(-)
> 

Sorry, it took me a bit to work the backports for 6.8/Android. I gave this series a try
on the Pixel 6 with a couple workloads (Speedometer and a UI-based one) and I didn't
spot any significant performance/frame metric differences or power metric differences compared
to a 6.8 kernel with this series applied.

Also, checking the statistics for the cores didn't show any numbers that are obviously wrong.

Though the kernel version is a bit behind mainline, I hope that's useful.

Tested-By: Luis Machado <luis.machado@arm.com>

