Return-Path: <linux-kernel+bounces-340397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C59872C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75244B256E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFF118C931;
	Thu, 26 Sep 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="XmxDQ/OO"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85E18C022
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349856; cv=fail; b=rvb7vQGlZJLtpUTIGksFNUFw2Yx04I4NbLeFCZNmuETL4PV853lsgimp92A08eCISy43VecfcDJuJUadMU5/DW2C35AK/AYVqObxZdg5OQ1Mxc/CNxYxOEGSQ9ilDSE3hbI5oQw/99LJbyNCnsW+Ni5tOxTvd1+17FcKWDlPCPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349856; c=relaxed/simple;
	bh=a2h85yc0zPpK+yWkCoAKVXqn/MpzXnNBlIBqizgGmJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hiW9uemHzxPxbeh/oY9MfmB1cF8EKQBq/HLOmY/+dJIXmd0Vq1qjBIOXt8AJDrbLh8MZBq5OXickZG8E3tLE87En1TnAiufvHQ6/q/YeOtNf5Dbdyypbdcn7DcsiM/kDZBVeaaoB7U3kfJP9gdq+/PrfUTBc1WtwQGVf6T5V4aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=XmxDQ/OO; arc=fail smtp.client-ip=40.107.247.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGPko6ycbH10H40RB1xh99SufWmaOGNHFkN6/OkBG0Qfo4PY9bAA/4642EJ+KlINV9kIuZuEMvQA1rZi1rR2/3XRhEhr5btvNdBbwR347QaKkaIeSADzO9ZppbaQEl/htC/VCqvGB2NQK4JojxiFodZ1I8s4McRE1rwS6DlKsfsV8aTK/xz0/TZa3td+n+24DQ8Lx+yOhYjOv7s697thlLYnHUhQHNPlb/x8i2mynAUYxazCwzb3Az7+9R/xSJGpjTGRCHXf1j5U/9c0W6jdNtbKU5AhP0KVbUzKWTIqUc4Dx82KSISxB+JRu5tsCQyPsRCO/dRRy9QQpYk9O05m0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgcwMcJAgBew8lbvNwAUBazjrJJukD4LVaTSYXiBIdk=;
 b=U9xAWMjMEoDY1gnAYghJ0xosSq1JSIbbbggF+t7ay395HtEaaJchVu7mmDc5Xv7Zo5vgzIanu3uz1a1LWZ9VYvU7prdRF7nS17QESgXxBtTSTuodG1t35PoDTROINi+Kl2/24FXdGjXAKsMPUwkvKXqkZI15yq3SUkg0IYCDJ4EBP85ELglENXNEZCPizyMHxPNdxYuNN7tDQM1Njw/gcBgwDAZOGhyJczexzLikJLien4PNjgFAwym+7/Za4TIp8k1aRmjZmovjA9p8Jhk8kIzZmuDMbC6qbWth4q2IbQ1ACF6ZHC6tRlOblx1qWfu2E4beG6daIsC9qQei076E3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgcwMcJAgBew8lbvNwAUBazjrJJukD4LVaTSYXiBIdk=;
 b=XmxDQ/OOvRb2TmAfBUUROrk1VbTuJNK70QsFOXrTZTsQRVwLDKgv1bAQaKgZ6mbySGAyNaUpe4G+b8qALmQfIIYwG4jIceGQ8MgnWU/mmUbxFkNZHQWb2tmlJjl5XlkBTL046WghYmu+dLJcT46Qc7F5yYHppazcTAoImEIx6tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 11:24:03 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Thu, 26 Sep 2024
 11:24:03 +0000
Message-ID: <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de>
Date: Thu, 26 Sep 2024 13:24:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
 jakob.unterwurzacher@theobroma-systems.com, linux-kernel@vger.kernel.org
References: <20240201124427.279986-1-jakob.unterwurzacher@theobroma-systems.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240201124427.279986-1-jakob.unterwurzacher@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::21) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7b02f7-e5f8-483e-2470-08dcde1db9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG4zK0EzbnEraktrL2xNMVhhLzRUWmlvazR6ZEpsbERCd2ltbGNKSjJ4K2pY?=
 =?utf-8?B?ZXBCQkZxWCtYbkNNN0RxWFFsVithZmxPWnFPNVVXUlpPT0RuTU5lZ2xPR28r?=
 =?utf-8?B?aWFGb2RBTHI5dFcvZHJaRjV2K2tGUGFVeWFBbGg0K2ZqdllkQ3YzRmxVUDVW?=
 =?utf-8?B?SXRXVzViLzdaWXVnSUxXRlorcnZCdnE2OENuY0pTanJRRWZWMHhyOWZMS1FT?=
 =?utf-8?B?YndrN1VnNzBja3hFYUdtSzBNSHdTZmNpMjRFODNuQWNCVmVPZE5HNHBGeGtR?=
 =?utf-8?B?SVJ4S2JUWlpDRWp1Y1hianV4RE53SDdmWVBWYWJIQXU0WEF3elM0MEpKWlZG?=
 =?utf-8?B?Y2ExZ3BGdHZCeWczMldMUzBubkpWRC9hMDBmQUh2dDd3ZHlTMjM2RlFlbjF2?=
 =?utf-8?B?MG1OSVZjcjBnYWgwNGtOUWFXM0tVRW41UDA2ZFVpZVJiY09aSkI2bm1ROHBB?=
 =?utf-8?B?eWhQMk9KYUxDUHFCbjc0RjRpdHlramlHU1Z6enMrK1pWb2I3OWVvblVRUFh2?=
 =?utf-8?B?aTdDallDMk5rK2IwTVE0bFlhVmpQUjU0bUkvdTU0dmZKU2Y2NkhNQTdwYkhs?=
 =?utf-8?B?dzlHOHJraTlLeWJxSW9XaFIwY21KSHAyeU5JM3RlK2l5d2FGeFJNZmhZeEl1?=
 =?utf-8?B?cVFqd1c3ai9iQnFXTU1idTNjSTZ2UkxYaHpBN29QcGJ0MXR6VFVJTWpjTDdj?=
 =?utf-8?B?aUlOK2pwUmpXVVhwbkZMaHBCdzhqZ0ZtNldEdXJmeXBpWWNCT3FjMTl1Ylhq?=
 =?utf-8?B?NS9LS3VOcVVWSGxncE9lVDBjODN5cFlBM2tuUmZjekpWelZIT2EyWVN4alZn?=
 =?utf-8?B?UGpqaktmcDJMeCtFRkROY0pkaVBHZXo0L0hvdVlwS2VVYjZyamhGdHNESkd6?=
 =?utf-8?B?TWVPejRWa08rdGVkblRzTG5RNlpsd28rOGc2dmJmRXp3MXpZU0hvVGZVR2tp?=
 =?utf-8?B?Qlk4bU5EaTNnVkZja1lMMVAzcFg0V2FWZGNqVmUxdlBidUVnTlN6ejBhbWRO?=
 =?utf-8?B?eXJwQ0MvTGRyMWR5dHBMUGlESGYrakpRU2tJTFZiYUJ1RWttbk1WdjE3R2Ew?=
 =?utf-8?B?ZndEd09TOGFUN05NTTZZVlVNak54NEFHWE54RlVaeThoWGhUazJEVmZLb1Vz?=
 =?utf-8?B?Q3ROUjBHZ3REcUcvb01jUnZFc0ZqY1JFci9BbU5EcWhEUkIxeTdqVXpEK1pH?=
 =?utf-8?B?cXRadUlLSHBpelVueWtMNGZXdFlieFBqTlpmdUN2b1ZrNDFKZ1FsYTRheEtK?=
 =?utf-8?B?ZWhJMEE0RktNK2trMWVhTjB1Y2VPVk5Zek9rZW5ieHNwekJ2YVNoZ1pUSnpr?=
 =?utf-8?B?QldwbnF1a0l6RmtnQ0F1ZEJiTkFtVmp0VGYwRzZqTE5tQ0J4TGZrMENSNFV1?=
 =?utf-8?B?L3ZqazY5T2FWRlZsbitSQW54c2liWE5PQllLcmtzMVN4ZWdsZzVXTUU2TGFS?=
 =?utf-8?B?Wk1CZ3dKenJub3k3WW1ZL1Z1NXl1LzE4WXU3ZTR5QW8yeEh5YXlFVzhXM0Uw?=
 =?utf-8?B?NUYvYk1EdkY2Q2k1MmNYWXNRYnlIdGF2REhrV25jdktJakk3ODNoODVuQTB1?=
 =?utf-8?B?UjZRUnhTb0E3TmhmWGgvb0Vvc2lVczFtV0tuR1RuOHhkR0tsYzJFYkVmR3Zh?=
 =?utf-8?B?SXBlaytYQlJaTFYxZ3d4NTNyOHhMWHNPd2RIZGs5RFFyT1RIM0ovTWI2OGJX?=
 =?utf-8?B?UVFnY0ROZ1k1ZW1IS0s3b2Y0RnI2YXRDbjRaUFJmdFdpVUJyZXlVV1dnaVJM?=
 =?utf-8?B?b1RoVzBjdjFjR1JHM0cxUEEwdzZrSGxPSFFTOFdMdVVyZkJ5a0dNY2FucUtD?=
 =?utf-8?B?Sk1uM0VtSEJzMGR3ejVzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEVUUWNEa1V2RHZXcGs3TG1yOFNVbFZkaitBVWRsaTEra3lXUzN5S2NiK1k1?=
 =?utf-8?B?aXBwUXFKS2ZCRmN2T2pVWE9WV2JOZlhhUlB0OXkrUXNBV01IS2s1Tk9tbDNR?=
 =?utf-8?B?cGh6OC9VS0xObFkrU3BIcm1LRTBveDN6YStlZ2s3TlZPdXdyam5aRzFkWktk?=
 =?utf-8?B?Yy9oR085aEtCSUMrRUloR1pLZ01HZ0o0ckZ1T3FBd2lkV3QveThoNFJMTEVL?=
 =?utf-8?B?a3VhRVo4Q3NENHkvczZzUERkcXdTbzhxaFVJaUtVcUdNSjdqZStzKy9DTWRz?=
 =?utf-8?B?SzZxUWpkd1ZBMjYwYjd5bTdENGxSNHVOQTJ1ZSs0dmlWVG82Smg3dEROdUls?=
 =?utf-8?B?SlQrdDJWcFpBUmx4T0x0dWo0dUE5bmlkMkcvbWh4eXA0Syt4dzZid01JdWtO?=
 =?utf-8?B?NkNBdnZ2U2MrMU0xTnk4Y3hZa0NtOTJZM0NQR3BWQ2N0cENKejc4TDJ1QStJ?=
 =?utf-8?B?Q242d0FZdW5CV0x4cUFRZWk0aVBack9uZi9PRVRyZSs0b2xGNytZSDRSSlds?=
 =?utf-8?B?a1V0MW81S0RLSjI3Ukc5WVZmODMrZEtlZGNJKytZTFlaTWlkZnlXYWd0QTdy?=
 =?utf-8?B?ekg2amdLemhkQ0EraWI2bkZmWGNYRTF5di9rVGpTV1FoSHFiTVpnUm4zWFF1?=
 =?utf-8?B?SEVJd2RaYkc3amJFY2ttMXRIK1AzMFA3UlF5WW4wdktud0ZqeGFoRWV0NXJw?=
 =?utf-8?B?SmJ6b1NvQ0hCM0ZPMlBRS0tkV2JmSVF0bldrVzNGZDRSblNhUzhZb1F3MDFF?=
 =?utf-8?B?aXFGZzNBdWhNelFHOVNHdit6SVlnNWVsdXRmeFhRVWYzZ0F2ZFdQTEZ6eGRH?=
 =?utf-8?B?dnZZYXl3SlpXTTJncnRLUXVwR1lWVUdZbDJiT2R1OXMxOG1WdXY3a3BTUC9Z?=
 =?utf-8?B?NFBtRlJmSE1wc0ZKWjJlOGhoUGpWODVUTFlISFNYVmxuS050UWFWQ1FnY2R2?=
 =?utf-8?B?bEl5dVdURWNVdHJGbWtEU2E2eU1WcnI4TWpCQStiUFJtWHUzWXJKL1d0d2Ja?=
 =?utf-8?B?K0pRR0x5VW5PNGw3VVFvMTBxY1dzYWtmamRmdkY1aHl0Z3F4ci9zUDVIaWVo?=
 =?utf-8?B?eHN5V0VhVlc1cks4SzEwaUlUUCtleGRwNDhpamwxTmFYT2JiaGU2K2xkUC9n?=
 =?utf-8?B?eDRjcG9rdkc2NlFWM0ZHNDZBQ1VHT0g2bkJ4TkpRYjZub2lNaFVFbU9QMUJ6?=
 =?utf-8?B?dnZGSVhrQWpaSGtJWlFQQkd6a2M5QTV0TGdWMmh0V1N0cUppbE1pUkJxeER6?=
 =?utf-8?B?NC9XUlF2d1VGSDRURGhwRnI5dDltWVF4U3JzYzF4dGR1bGR6b2FRUjlDVzRC?=
 =?utf-8?B?VFVLcG9FeWtCK2R2L0lHamhJMDYwYjBSMS8weHA1RDB2elVjODNEdVMyZ0F0?=
 =?utf-8?B?MXYzRW4yZnVZbXB2czlQOFlrSFE2WUtSRDB4b3lCazFyazhHazZZbFRQMXpE?=
 =?utf-8?B?WlNLcWUzVU1ndjBodG56QU11M0dXeGNEOERwZHpQaWV3dzJFMHF1d3dQNHAr?=
 =?utf-8?B?WjJVbXV1ZWc4SzJ2RzJMU2pNcGdxMHlaZEIzMzRVVTl1bHJ5TGo2My9nWVBw?=
 =?utf-8?B?OWVxM0RqUnpUS3hmOGdyRmNBdXFZVVg2ZVhtNFU2YWZibVhodFZvNXBZSVZN?=
 =?utf-8?B?R3d1TFQ4NTI5Q2Fiak9zNFRmbGJ0VGNGNnYwQnRIVUFRSC9UeDFqejQ3RGhY?=
 =?utf-8?B?UWtGeS8rUTJPQ08wN1FZUksyVmtsK29SWktCZXdtWlhFT0d3WjhSUDNhNmZo?=
 =?utf-8?B?Y3dFNmV4dVZLRGJtZEovM0lmS2FyQzdta1I3UUNYUk9jTTJCeC9TYTR4MnBw?=
 =?utf-8?B?ZC9NR1loMk03bTcvUHRUYkZNQWcvL0NocnhEMTBWU1gzWFpaR29KRWFwTEZk?=
 =?utf-8?B?ZUtoRFlkMEU3eGhkamlBUjdXeldUK0IvdWE2Y0pYVnArMFBmSC9uQjF2UGtT?=
 =?utf-8?B?anVwcFdFMllybjRiWGFLaUlIcmZvb0xHaHEva29TQ2QzK2JsSUpTRm03NE1V?=
 =?utf-8?B?cS9vVjczMTFjWVFyMEFvZzMrNzhJa1gyeEJuZmNvWmRsaW1zWjlpU2g2NkVL?=
 =?utf-8?B?Ryt3cENXSFgxL0ZQQWZjQndscWNadE1UNHRWWndKWnl6VVhnbmZiUndueU9k?=
 =?utf-8?B?aUZ6L2hLbDNYb2RjZDZhOTltb08xKzZ4eUVDcUxpbEYxWmYvckFoQkNjelI5?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7b02f7-e5f8-483e-2470-08dcde1db9d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 11:24:03.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5X9aW+jCXLTsMhvKg+87Z3JcHDlKyGrdmucMAACbg83bqhHuaRjYcgWA+H1QOm4deB5eKo2JoOg3zwABzb0O8VzQfUDrj0ln5HI3wDz3X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085

Hi Jakob,

On 2/1/24 1:44 PM, Jakob Unterwurzacher wrote:
> Ringneck v1.4 can contain (placement option) an on-board ATtiny
> microcontroller instead of an STM32. In normal operation, this
> is transparent to the software, as both microcontrollers emulate
> the same ICs (amc6821 and isl1208).
> 
> For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
> used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
> we are running on an older Ringneck revision, SWITCH_REG1 is not connected
> and has no effect.
> 
> Add attiny-updi-gate-regulator so userspace can control it via sysfs:
> 
>    echo enabled > /sys/devices/platform/attiny-updi-gate-regulator/state
> 

CONFIG_REGULATOR_USERSPACE_CONSUMER needs to be enabled for this to 
work. Just putting this here as I had forgotten and was wondering why 
this sysfs file wasn't available to me :)

> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>

I finally have access to some HW to test this, and therefore can give my:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

> ---
>   arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> index dec29a75d361..1f7f4b2ea66a 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
> @@ -15,6 +15,12 @@ aliases {
>   		rtc1 = &rk809;
>   	};
>   
> +	/* allows userspace to control the gate of the ATtiny UPDI pass FET via sysfs */
> +	attiny-updi-gate-regulator {
> +		compatible = "regulator-output";
> +		vout-supply = <&vg_attiny_updi>;
> +	};
> +
>   	emmc_pwrseq: emmc-pwrseq {
>   		compatible = "mmc-pwrseq-emmc";
>   		pinctrl-0 = <&emmc_reset>;
> @@ -146,6 +152,7 @@ rk809: pmic@20 {
>   		vcc5-supply = <&vcc_3v3>;
>   		vcc6-supply = <&vcc_3v3>;
>   		vcc7-supply = <&vcc_3v3>;
> +		vcc8-supply = <&vcc5v0_sys>;

According to the schematics, vcc8 is routed to SWITCH_REG2 and not 
SWITCH_REG1, which is fed vcc9. Even more so, vcc8 on the PMIC isn't 
actually routed.

I therefore think we can simply remove this line here.

@Jakob, do you agree? Can you send a v2 if so?

Cheers,
Quentin

