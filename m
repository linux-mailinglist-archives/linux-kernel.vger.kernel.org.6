Return-Path: <linux-kernel+bounces-220718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133AB90E631
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E901C217C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40357C6C1;
	Wed, 19 Jun 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MJ/jrFa5"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC21745E7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786658; cv=fail; b=G89KiJAKY/OPLnsXHny49b0wWe0q7cTfIPUlnnOuANYwBiKvAiE0cvo0N00xaN0HNCL/FmesqJU2LpxQYAWC9kMpchQ1kZxsAVxTfA+HWvDi+A2sqnQvczM35lAhfVpNf0daFjAoNSUHNyWs9VvM/TpI/l3NlU0xPUi8scIaczY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786658; c=relaxed/simple;
	bh=QRXD6MR0E+REcbXxPhHfTHCiN+/e+Iwx6quk+HYRkjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DKuIX43OLuRGqYtfbpBUhFKHDF6+odbNVS9BpLYmrymi0IhloOvSbufg0P7cESWyNtvJoZlwujNMoaMg8ornT/1tiuAqGXXZW61JoD/PgGbvklNn+vjwTNvRIqf/9G2IkwJyw8rYRV7cAzRC8w61nELRyv09m4xwmH+X1HoVRGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MJ/jrFa5; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3d1hp+Jvcsqyq37b/q1FmjBj4Ej4CK7kwXosPp2copDBS5BX1y8Q3bqVVw63+N0Uy7qQMaxfbUvPrcmX+07e+2whO++aHVmnZc4fgbpSTSHgAXCi200cK380q9WM9czHBNPUXZnvxlIga+i0hVy+Ld5k1oW7vUbLdKEOkJKU3v9Tspl1TzSieGtxrMJ3cENqEZ+jQFVVUz6uTFizsrpTa/nwoGB6MOsVLrltuY3JA+3Ueh0PCblWvaKKbWWZairPMvq/1lWT+EXSVDFam1l8qs3pwOKqdE3UinbuqRlb7uoBIK38dmCxVVBesxogfJdn1xVWZINtYFd0kkGBRlOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMq06O426W2S6mVRiIpBm5MuKT41fDL6NlC1SWaUUSk=;
 b=n80KQVLpIcTlDy12EL1rfa8J+F1hs1CZPL9Hk52OwPiWYr/xzzDYwgbUoUGqthNpENqtv1pH/meDwi6NKOV9vn1WvKlGBT2eOC+D5c+kLjaOAw0Dwg0zwY1ETg3qdLlZJ8Ukr0Xm3V8GhVRBDEDiXx99j2vtbmRBaz1ja8kk2T6p1EvZ+M6aC8Iv/1BtN9QT9kpoOPNxwmafHVhConya14edQAHi1tlGl78F1WRhoBuzvXnrwCvNscZg3qTj4bbVjStfVTiq2GUwfCQFqYnCt0brYnRLUF8to0TbK7xjKzqN1mICPp9X1xfmx7sWGcYoeKyLOwjtv8LCANeAT+RvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMq06O426W2S6mVRiIpBm5MuKT41fDL6NlC1SWaUUSk=;
 b=MJ/jrFa5cXOOOUoc2+MquBWQVwA2n67Y1kAB3N0fDb0ABD3PlcWUVmHz9SPaN/0xcnDEVfO83DrddeZr59nbBNjUw5tMWmHtle1cVFaMqjv1VJm/o6JRVAmr+f+i4xjR8k5i1A2LKLtTKXKl8keMtAca5TTA/pJxeQ4Vt+cJp0YpjAg8IXlLd8Zwd9p6e4+4CZK1uHepqPWMRalGhhKJkrTWwDkeLxjUm8XHo/MfNXup98+lz3KFZKKySm7tEJOzhblt0e4vU72LNUaunhLia/Lw+OkB2SwSTqDdGcJZoIZlx9NDvqC1cpvh0BFvfhpM7HJygO9v2PzidzkNyFYhEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 08:44:12 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:44:11 +0000
Message-ID: <239d2936-8fae-4538-8621-b07c09918df9@vivo.com>
Date: Wed, 19 Jun 2024 16:44:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com> <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
 <ZnCDvpFveS6X0a1g@google.com> <32e0c2ea-6035-4ec9-b99c-e6b686f04cf3@vivo.com>
 <ZnEO8X-7pjeTFTur@google.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <ZnEO8X-7pjeTFTur@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: cd182366-f998-43eb-11fc-08dc903bfde1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXVLOWxydkhYdDNwc2pKUnhOWW1vYXVrMlR3dDhDUENlT2EvY21ka0Jjelkr?=
 =?utf-8?B?V3ZtYkpLSXVyUFF0c1IrZWlzaUlDQ2NqZ0JJaUFMRW5KcndVU0h3bC9LLzdY?=
 =?utf-8?B?TnVOMDBqUXJsRzZEb2k5eERvUlVaczhwSFEwbUROdU1QUmVNc2lEM1A4TnQr?=
 =?utf-8?B?UHlidCtjTmRWREVwRUtrL0Y2ZHc5ZzE3NFZMVmRzZVlDT0RhUnBaK3lKWW1n?=
 =?utf-8?B?NW8xSDR6K3o4T0N1OWpicE5XT3hvMVlDemxwbU5GTlNBMlE0Rk42bWJxMzVX?=
 =?utf-8?B?SGlmSEFtMXJzYnZpdjliQ1hXWXlEcDBPb3g1bGtzbUJKZUlJTFpqUm5IaHRT?=
 =?utf-8?B?UEZoRTFGQVdWMWRWanJKcWtwaHM3N1o2MnkzYjhtVXBBU0tYQ01rczlmWDU5?=
 =?utf-8?B?ZmFGTE9XeU9WQTdJNEZ1Z2hHMWpvZDM4bVhZYzFkWlNlakMzYTRoRDNjQmhk?=
 =?utf-8?B?dFBlOGdQSGVzQVZIK0p5b2M1ZVA3R2Vqelhham5oaWRjMU9tNFFNQmZJOXlt?=
 =?utf-8?B?aHNmRHlEeFA0L0EvdlZKcUxJcDhlK3B3QUpYZWUzVGlaNFFtdFA5cytCdmUz?=
 =?utf-8?B?YTFxdGg2WUZkSlFZVnRpUzVCSUpMSThTalFlczhWenBlNVZkYUg2Qm50VmNn?=
 =?utf-8?B?OW1uc3NTekNLOU1mK1VLdTRhUGp0Q2hyRmRoYW9wRTd0Vm03Y3Rwa3NUaGdN?=
 =?utf-8?B?QnZKWjEvejhnQkVxOUFsR0NIbGFFM2tCcG1vV1pjbVZ2OXFIc3ZjNjRTL0ls?=
 =?utf-8?B?OVVVVmhnUm03ZHJMWk1wZVBqUkduZHJlUlIzVHBqWGEvL1VsSXUxakhUbncz?=
 =?utf-8?B?L3FmNEUzYUVERlV5U01NS05ZQ2JEbmZiQnJHVE5BMy9WdzV3QlJZZ09Ma1Uz?=
 =?utf-8?B?V2lVNjZwQ3ZZbEFDZHlWdE1Ed2NxRlIwZnRwemt2RVR6cGhoc3hIbUNta2Zo?=
 =?utf-8?B?ejFhMmhaYkdId00xcjJBN3hNc1BKajVqN09oMC9RTEl3Vy9WN1NIbXlnU0Vu?=
 =?utf-8?B?Z21iblRBRmhVamd1UWtUYlpibFZIZ2Iwa0hLcGhqQXFKN3VXa29VTWRTOUEx?=
 =?utf-8?B?UVFrc0l5cXAyZDJPWWlUeEhyL0grc2Vzb0pSRWptQ0J1YWEwZUYrTFhuVlFl?=
 =?utf-8?B?d3ZYeG84MXN1TXF0VCtUbDFvaEc4dDVRMGc2NllLZllzODFrL0hBdnhSZi91?=
 =?utf-8?B?M2NKeXdra1hYZEI0WEl2cnJMOGpRdmh5Uk1PKzZpRnZjOC8zM1RDUkF0YjhK?=
 =?utf-8?B?bUxjbFFqc3J5ZW9lUjNoUktiRUJOdkM2d0ErQnNiOFJ1Y2FnZ0U2T0FjbVBa?=
 =?utf-8?B?L0VWNGdYNzZ0SjNibC9HL2hGbnRrVVk1N1JFUGdDd012RFpEdzZRTEYxczRT?=
 =?utf-8?B?UmRMaWowMmpnSHBzR2NDV1daRlZiTzFienJDMlN4aVZQKzBlWDRkckhxZkxI?=
 =?utf-8?B?bExPTUd4U3g0ZVVJT0tsUUNCVEVJWC9IQkFRQ1N2bFV6U0djanAvSUdZVG9W?=
 =?utf-8?B?R3hLLzQvYlZRM0p6cVM1TE9pM1BMcUlPcXFjcWlBbUl5dVRvS3Z3VStkS0g0?=
 =?utf-8?B?Z3F5VmtZaTlDMnNvOTJ5bTMwWjhiZEF2VVBDOXo1aGp5b1B2c0VjVnpDMWsx?=
 =?utf-8?B?dkxDZmpYT1hMN0xQTHd5K0RNSHNYVWpQbEhpMmgzVm13anY3cFBzTThPa0Vr?=
 =?utf-8?B?c0VSU05CQXduU1R3bEM4MTYzbUNOZFlIdWFnQ1lERmlFT2l2Q3Z5T21GZDF6?=
 =?utf-8?B?Y3F4bEVDN09adzlTYzF2UzRVV3JITTJkL05Kb05CeitvTjV1eWZ4VXV5VlMx?=
 =?utf-8?Q?KEGRFm6bkZxI72Yy1JZXiCoxT9stuYHcvGcgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRLb210aktoRmljK2VWNk80ZHhXaDVpVzRzakRrNXBMWHF3VW1obE1SYVF2?=
 =?utf-8?B?TEozZkFiejZDWW1GWWhhZ2pRd21GMDdKU2c5NHJCWmZxT1RlRjlCNytNa0ly?=
 =?utf-8?B?anJyOWdxeEtWQ1cwVEU4NEQxMmdJbXFkbFRPTE1penBJSitONmpVajZpU3BZ?=
 =?utf-8?B?QTJwNXZtSWFmampRc2MzTXJCQWVKWndiT3JoNFEySTNyTE54eE5lMlhnd1lY?=
 =?utf-8?B?T3FKS1k4TStWdHo4VGdmMTVmQmlJcExnd1FqMlphTUhIUnhYUFgxTjcvVzY5?=
 =?utf-8?B?VEp0U2o0NFhJS0R5YkFVZ0E3QnpjYk5obW5PdDBOc09zRzhyWTM3Y0RGR3Iy?=
 =?utf-8?B?QzRnNUVQejdUK2dVS0RoUlBOY1FlR0FNNWNkQU92SUtRTFQvbmJxZnJEL2pY?=
 =?utf-8?B?cG4yUEdTL3hqdUZxZXZWb01UTkF4ZlNYd3B6Y3M0SkxHdjYvZ1FKc1ZPdWk2?=
 =?utf-8?B?eEZraHFmSktOZUIxRkZHbms3S3BIUXJUQzlqOXhrMzhRTUE1NXkvWG1za1p4?=
 =?utf-8?B?cTBUbzljcFVWaWZPR29zZVlZVDZQSVlEV2VDT2Z2dGVyekpIMmRlR2IyWlp6?=
 =?utf-8?B?dDVoT3VEdEZlbU9tWmQ3TmJYTm81VE1OcGtLQUdoYWZlOWFtckdVMlQ1ZGFO?=
 =?utf-8?B?L2pPS3dDMk1IakVWQUJKaU52N0V5OFU3aTZBUTMvUTl5QVpmTkgvKzZYWVF4?=
 =?utf-8?B?UEN0ZzVjM2ZKR0ZFU0FmYXluUDlMNG1PVHhHZldCclBtWU9rWG14WG9BVXE3?=
 =?utf-8?B?MVdLeUk2U1R4ckVVdWtKem1jdjBjeDlGVG1QbXlKcDkwYjN4TTRCeFNhamsy?=
 =?utf-8?B?bDY4WGxpdUdHQXY1L0hxS21LVU1RbVJLQTBjeFdNdVBhU281SGcyblI4Rmh4?=
 =?utf-8?B?T3ZGcUkwdVltZ0ZDYUNaZTNmR3Urc3EwZDN2a1ZvK3hLUjdFRFhnRUtKenk1?=
 =?utf-8?B?SjRFbG5VSSs4L1J6akNzVUNaQVM4UVRjbWI1TGtBUkQ3QmNBZkcyRElrVXlh?=
 =?utf-8?B?dCtTTVQ2cEtlYnZQbDBKRUVKSkJ6Y2N2Und3R1c5TmNPMUU1ODdKaGVPZk1s?=
 =?utf-8?B?bU5LRjd1bm5ZdmVjd3N1RXJwK2tQNGZja3J6cjgwTUJ2aGIvSGZWUmZEd0FV?=
 =?utf-8?B?c1l4SzRPMm1XMTZVVHphMXhFUm54ZXdSQklLbVRIZ01RSnJJcVdGOXNoVktJ?=
 =?utf-8?B?U1RhN1Jyc21Tam9FRzhqUFVWcmE3UzNVU0RtaWpOT0hMZTJDNTJ4bnBNRkU4?=
 =?utf-8?B?NTRyaUlkRzd5Zzk3M3h5bHYrS3pNQUlpamtVeUpUM1lob0I2Z3EvZWU4b3RH?=
 =?utf-8?B?WnQrM05sR2ZIM2pQeTVmSG92Ny8reThsRGhrL3l3RW4rNXFDN0FRWG1YT0ov?=
 =?utf-8?B?RndZOFJuOUVadHNSY205ZHhoTnFhZmxTdEIwOEdEZUNjOXdkbEdtSzBVNzdt?=
 =?utf-8?B?cy8wQ2FreElGbzlkVHphZHRKZVhwQURwYXk5TFUydm03cW4rRThXeTdNUTE0?=
 =?utf-8?B?N3N6L0hZWWpHRjFSd2k1UG9vRW5OQ2lTWTRKc2EvejRwY2NCSS9LZTExVStt?=
 =?utf-8?B?RTlzT2FYNUM3eGFBdDB1QzdKVERIdDZjYWNJRU9RQ1YraHJ6dk82SVhMa1Zl?=
 =?utf-8?B?M0J0WEpnYWpwamtzbVh2aEh6Ykw3V1VRVlUvMXhRZE9xNE9KY0RKZnhTby9U?=
 =?utf-8?B?OENoZ3VCcW85SEo3Y0p2N3NUQXBZNmlQV0c2T2doTUhLbkhaTVVhUCtRbjRr?=
 =?utf-8?B?a1RoQXJyK1ExLzVjaUE0Y0xPaVpnaEVJTmZuVHFoMnpvRHhYWkFqSllnV3dN?=
 =?utf-8?B?YkptSExGQmpiOHZJU1c5R01wSGUyLzl4VnRQa1J1c29zWEtPYU41YmthUU5r?=
 =?utf-8?B?dnFrU09JQXFwTzhrWW1QQWpyMytCaUpwNzVibXRNWmhxWXBCR2JUS2U1ckpK?=
 =?utf-8?B?NGZHOUlkeG05d2Z4U2lab3JKVEMzbXhJMHN1OXdWbFJOZzN5NlhQYmFZOTRx?=
 =?utf-8?B?SVMxejB5RFYwNFZmM29SQ3JpTlhOODlnODVXa0NQUEtyNTNaSU9SdHhMU3dk?=
 =?utf-8?B?N0lZVlY5cUxnM05Kb0Z4QllGSzFCNmdIU2Rxb215bkx4ei94MllaRmZGb3Yz?=
 =?utf-8?Q?3pLcxbsNUPFzLFT98HOFyMHmT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd182366-f998-43eb-11fc-08dc903bfde1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:44:11.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJTmRwxR//bb0ClLU+do7u+yhEXxuSYZ8gen2lbHQAYbHBRsT9LQYZTlhHxS+7/57rIt8OTpzJ7jen5i+R5JKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673


On 2024/6/18 12:37, Carlos Llamas wrote:
> On Tue, Jun 18, 2024 at 10:50:17AM +0800, Lei Liu wrote:
>> On 2024/6/18 2:43, Carlos Llamas wrote:
>>> On Mon, Jun 17, 2024 at 12:01:26PM +0800, Lei Liu wrote:
>>>> On 6/15/2024 at 2:38, Carlos Llamas wrote:
>>> Yes, all this makes sense. What I don't understand is how "performance
>>> of kvcalloc is better". This is not supposed to be.
>> Based on my current understanding:
>> 1.kvmalloc may allocate memory faster than kmalloc in cases of memory
>> fragmentation, which could potentially improve the performance of binder.
> I think there is a misunderstanding of the allocations performed in this
> benchmark test. Yes, in general when there is heavy memory pressure it
> can be faster to use kvmalloc() and not try too hard to reclaim
> contiguous memory.
>
> In the case of binder though, this is the mmap() allocation. This call
> is part of the "initial setup". In the test, there should only be two
> calls to kvmalloc(), since the benchmark is done across two processes.
> That's it.
>
> So the time it takes to allocate this memory is irrelevant to the
> performance results. Does this make sense?
>
>> 2.Memory allocated by kvmalloc may not be contiguous, which could
>> potentially degrade the data read and write speed of binder.
> This _is_ what is being considered in the benchmark test instead. There
> are repeated accesses to alloc->pages[n]. Your point is then the reason
> why I was expecting "same performance at best".
>
>> Hmm, this is really good news. From the current test results, it seems that
>> kvmalloc does not degrade performance for binder.
> Yeah, not in the "happy" case anyways. I'm not sure what the numbers
> look like under some memory pressure.
>
>> I will retest the data on our phone to see if we reach the same conclusion.
>> If kvmalloc still proves to be better, we will provide you with the
>> reproduction method.
>>
> Ok, thanks. I would suggest you do an "adb shell stop" before running
> these test. This might help with the noise.
>
> Thanks,
> Carlos Llamas

We used the "adb shell stop" command to retest the data.

Now, the test data for kmalloc and vmalloc are basically consistent.

There are a few instances where vmalloc may be slightly inferior, but 
the difference is not significant, within 3%.

adb shell stop/ kmalloc /8+256G
----------------------------------------------------------------------
Benchmark                Time     CPU   Iterations  OUTPUT OUTPUTCPU
----------------------------------------------------------------------
BM_sendVec_binder4      39126    18550    38894    3.976282 8.38684
BM_sendVec_binder8      38924    18542    37786    7.766108 16.3028
BM_sendVec_binder16     38328    18228    36700    15.32039 32.2141
BM_sendVec_binder32     38154    18215    38240    32.07213 67.1798
BM_sendVec_binder64     39093    18809    36142    59.16885 122.977
BM_sendVec_binder128    40169    19188    36461    116.1843 243.2253
BM_sendVec_binder256    40695    19559    35951    226.1569 470.5484
BM_sendVec_binder512    41446    20211    34259    423.2159 867.8743
BM_sendVec_binder1024   44040    22939    28904    672.0639 1290.278
BM_sendVec_binder2048   47817    25821    26595    1139.063 2109.393
BM_sendVec_binder4096   54749    30905    22742    1701.423 3014.115
BM_sendVec_binder8192   68316    42017    16684    2000.634 3252.858
BM_sendVec_binder16384  95435    64081    10961    1881.752 2802.469
BM_sendVec_binder32768  148232  107504     6510    1439.093 1984.295
BM_sendVec_binder65536  326499  229874     3178    637.8991 906.0329
NORAML TEST                                 SUM    10355.79 17188.15
stressapptest eat 2G                        SUM    10088.39 16625.97

adb shell stop/ kvmalloc /8+256G
-----------------------------------------------------------------------
Benchmark                Time     CPU   Iterations   OUTPUT OUTPUTCPU
-----------------------------------------------------------------------
BM_sendVec_binder4       39673    18832    36598    3.689965 7.773577
BM_sendVec_binder8       39869    18969    37188    7.462038 15.68369
BM_sendVec_binder16      39774    18896    36627    14.73405 31.01355
BM_sendVec_binder32      40225    19125    36995    29.43045 61.90013
BM_sendVec_binder64      40549    19529    35148    55.47544 115.1862
BM_sendVec_binder128     41580    19892    35384    108.9262 227.6871
BM_sendVec_binder256     41584    20059    34060    209.6806 434.6857
BM_sendVec_binder512     42829    20899    32493    388.4381 796.0389
BM_sendVec_binder1024    45037    23360    29251    665.0759 1282.236
BM_sendVec_binder2048    47853    25761    27091    1159.433 2153.735
BM_sendVec_binder4096    55574    31745    22405    1651.328 2890.877
BM_sendVec_binder8192    70706    43693    16400    1900.105 3074.836
BM_sendVec_binder16384   96161    64362    10793    1838.921 2747.468
BM_sendVec_binder32768  147875   107292     6296    1395.147 1922.858
BM_sendVec_binder65536  330324   232296     3053    605.7126 861.3209
NORAML TEST                                 SUM     10033.56 16623.35
stressapptest eat 2G                        SUM      9958.43 16497.55


Can I prepare the V4 version of the patch now? Do I need to modify 
anything else in the V4 version, in addition to addressing the following 
two points?

1.Shorten the "backtrace" in the commit message.

2.Modify the code indentation to comply with the community's code style 
requirements.

thanks

Lei liu

