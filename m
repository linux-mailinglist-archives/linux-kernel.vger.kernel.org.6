Return-Path: <linux-kernel+bounces-291728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52AB9565F6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E361F227BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E715C13D;
	Mon, 19 Aug 2024 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NT9CvfTb"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591715B546;
	Mon, 19 Aug 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057308; cv=fail; b=QnNJukeiJSxP5cZ6TMoYZ2/IhbG/OVJMdZ7+NhpoVVEuvp0Hjk5xEcsNwNtWSBPJ2eg25kgorBkKBMipq379vz/KYKBPxrIrVESoMVOxBf40aCJR/RdF/wsZFA2S46DGZ3/QDKAyM9mTQHPb37TYZFAB9nQZvAjhxF08fk61oGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057308; c=relaxed/simple;
	bh=nOtgLZC6MA090UYvzzg4Cw+MqqPF/yZhsIGU/guAbKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5qamnxhaepfzVSalPFh33Os7rWEXvk4ySLtVs9L67ez5nscGO2ZWalgs72IP6RtVOJRd9G3y3Qcg7r91s0Ne/BMWFyFITg0DNopr5IZy+kG2Lbaa4yTkjH0ZANwHi1idedibWNbQRLf9zV/9SNmGImsX77q0N69lixycRY9zMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NT9CvfTb; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk8gYYLbqmr+Wmjb7jSRExLVirtmYWd3HsKEheDEuKzkPq/dwpk6YC5E3bgpU7nwxXsAv5A2CebGKxKrgbuG4OG3jTtTgJlWpZ0mdmQvJMBa9LftxV4FFLQjoBSQ2oNKWuke6YSJhJ1FZI98rXeXwuDYfuLdnOcqskG0SEypkh45Vm2+SZVssno+kw9bQQBcpDkBpQgSJXkTj3NHNN04xw0ulvJAVz+W8rFkSHh1x7zxt+0azw3rEtO/w4PbdTtFW0Hw/4TavR53qkU8OZ64kztjz0nByMj42+0cx4MwQ1igTm3pLJ5vVlGsfq4YSoH9mpeutW0dHngZ/PuK0cl/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOtgLZC6MA090UYvzzg4Cw+MqqPF/yZhsIGU/guAbKY=;
 b=h+m/xEF4+4Lc/qavNEAnr7G75Su3uYutjSCYSAiTKT3B6xF7ldw3fM28XLXtqjo+DaThfOt1JTKaL7sthheymLzHkbaTCasmQp0NpxIIQWifj4pdTl1ChGFW12cl/cB3Dl1sdhsegkHQb53PFAHjL2fJWkH0Rv9N5jo18MaO2189ysxPvJ0zTxkzZR6RqOxaT5Hba7ISSJOZQCvsBOYpTQtgnrY09WF2LirQJt5i/b+MpFbXbOnrd8+CfjqIFaHmtVg3WKTzLXevE5NNOtl9WCmco8EqS6cZRzpldkoTKqXRDZU8vUoAA9hjAsX38Y0Isv4M45xCNDmcUtZrD5hKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOtgLZC6MA090UYvzzg4Cw+MqqPF/yZhsIGU/guAbKY=;
 b=NT9CvfTb6/e4GmxzxFnnIQmOTVTZDNkadPp0TzHT8gFFe25O+N2RY+nYAPNyx5xRF2vggBUNRCn2GAbbZyhDJO3iPjkE6DA1sNXJb6jc8SA3jgNuNykJBjdcfd7JL36Dsv3UzL4NZJvInAa4MrUWvM0cxK4p/6vY9mtK7wTvC4j0bHTqVwXJzHx3xFsyl1DkfiS1o9cXUeABcJcR/VfShcSS4V5i41s2gNxDCV/ccb085Nq2YZAAaH/sU21MaQcPag3nq0h89dtOOvokDY5TzQEWuJtgPcFgjS0n7ydAW/gPknEPv7wRbzThEoEMecXI9pUjqczvxBEI8MR2m8eSfg==
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com (2603:1096:400:358::7)
 by TYZPR06MB6565.apcprd06.prod.outlook.com (2603:1096:400:452::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 08:48:22 +0000
Received: from TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe]) by TYUPR06MB6217.apcprd06.prod.outlook.com
 ([fe80::c18d:f7c6:7590:64fe%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 08:48:22 +0000
From: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"quic_prashk@quicinc.com" <quic_prashk@quicinc.com>,
	"quic_jjohnson@quicinc.com" <quic_jjohnson@quicinc.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	opensource.kernel <opensource.kernel@vivo.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2MV0gdXNiOiBnYWRnZXQ6IHVfc2Vy?=
 =?utf-8?Q?ial:_check_Null_pointer_in_EP_callback?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjFdIHVzYjogZ2FkZ2V0OiB1X3NlcmlhbDogY2hl?=
 =?utf-8?Q?ck_Null_pointer_in_EP_callback?=
Thread-Index:
 AdrvzihtFNSOcxRwTAOIHI6tveAOMAABV00AAACqLAAAAoTOwAAAUcYAAAD4WnAAAUYXgAAAwgzwAIjopbAAAJpGAAAAFMjQ
Date: Mon, 19 Aug 2024 08:48:22 +0000
Message-ID:
 <TYUPR06MB62171FA07658FE6500DB855FD28C2@TYUPR06MB6217.apcprd06.prod.outlook.com>
References:
 <TYUPR06MB62177737F0054278B489962BD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081608-punch-coherent-d29e@gregkh>
 <CAOf5uwnsgcJjp1=RLa7qx9ScQY5rZvwX-Zu6BOqxBBhBCz+CFQ@mail.gmail.com>
 <TYUPR06MB62177BCD4AB43C19E38990D3D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwm65Cw-V+td_=6QAGUF+Uisueqcm0z=1zFaNTisAJnSFQ@mail.gmail.com>
 <TYUPR06MB6217877B31A08356241CAB38D2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024081652-unify-unlucky-28d2@gregkh>
 <TYUPR06MB6217D1798DBC41C7DB2A1DEDD2812@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <TYUPR06MB6217AEF9DD73C9424C7C1D07D28C2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <CAOf5uwmdf+Vxes6+BQyghbiKByVC_i1RhmTE81_iix99U7HMmA@mail.gmail.com>
In-Reply-To:
 <CAOf5uwmdf+Vxes6+BQyghbiKByVC_i1RhmTE81_iix99U7HMmA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB6217:EE_|TYZPR06MB6565:EE_
x-ms-office365-filtering-correlation-id: b915d03c-9206-4356-f256-08dcc02baea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXExQXdoRUplS24rOHV4OFV2RGZFc1lEZ0RuZVNHcEcyQm9QcGZZR3lsdU5L?=
 =?utf-8?B?UzhIdHVYc1lTY0d1ejE0SlNhaWhmU1RzQ1ZqUzVET1cvR1VDakZiLzdLdGN1?=
 =?utf-8?B?d1Z3R3NPcEp0WFR2WG1iOXpCdHIwbDRNdUwzQUNZVnZybjY0N1VmWVdEUUpo?=
 =?utf-8?B?c1FFdjkxbzgrVzRJQnh4d2VyZkhpSFVmQUZCb0lObGhwY3JkVFVOYnh1ek9N?=
 =?utf-8?B?aThSSEwxMm45eXUzTWphOXh6bW5iWUIxQVlnYys2QXBEUzVhUEhDRGZXMWR1?=
 =?utf-8?B?VXdjQ1hwSDAza1lGUlVyZGFxdGNJRE1nQS9NNEZMcys2SGl3WnhrbUFNejRz?=
 =?utf-8?B?RVRzZFRnTTdITldmZU9uV244TWFhYW5TU3ZJdmpqUUVIZnNuVThTSStLVjh3?=
 =?utf-8?B?NmtOdUZsNDdjaEJnMG0yNHBsTkxPVmtqbzg5U2VBdWg1NUg3S0h1azc0aGVO?=
 =?utf-8?B?SUtHRWNQclZRc3g5eUt3V2FuTWxlN3lrcER3SVg5QkI0TDRvcStPaVBPdGJH?=
 =?utf-8?B?bGRqb0lQOTM3ZFRvN1UvaUNDZ2tDZ2pHUjBMQzYzV0ZPOUQ3cTFQSmVJd1pP?=
 =?utf-8?B?YVl3UWU0alQwQ0xxQzlMdUNXcE4zVmE3RWxkR1pJRUo4cEhRbldKSVlpK2dt?=
 =?utf-8?B?WWRoTThkWkRjWXBLRnMya0ZFUXBTcktBUVNjSjE3azhCRU9kdHh3a3dFeEIx?=
 =?utf-8?B?Y24xMTZOSXFSNllBaENRSWF6VzdHSndUS3JNZW81M0ptdWlwM1hUWW1Dd21L?=
 =?utf-8?B?SDVNbURhaGlkM2F4N0t2YU15L1lUbkFyeitLdVAvcHBONmhKT0VYTkpDdTd5?=
 =?utf-8?B?c1E3R1dnL0hwRitmZE1EclUzRmxOK2ErQlFHMzJuMXpSK2JLb1Y1N1Z1cXdh?=
 =?utf-8?B?SlFRZndsSDBLWHIzK2t5aG5oYzBYd1YrRVFFR2djRTFKSDk5SHVnS0JhcDg1?=
 =?utf-8?B?b3ZHdE1LZU14SWp0TEwwTlB6YWozZVgrckZtTjUvdEJzRGxPYSs5QTFSVmhV?=
 =?utf-8?B?MHdwaWxZR2lFcTJvUkxreURvdVRmRnlkQjBwUkx5a1FFUG82Z2cyZzM2dmtI?=
 =?utf-8?B?b05sTVR5WG8vcHk5YzVVbUxRUFpZRlhSenoySDNmRWppVEM0VHVyMGlpQndW?=
 =?utf-8?B?cmZRclluTFlnaVdKMnJGNVhUN1d0L0RjRnF0aFM2cFdtUElSbkFERitnLzZJ?=
 =?utf-8?B?M051ck4ySlhiQi84b0M3dVYzTGc4VUhUNWROSEovTk50MElKMzcxK1VYWG1C?=
 =?utf-8?B?SGJKSG9VcG0wdGR4cVhHVnJlcGIxMis3MzJBam9xOFVMOW5VdXQ5a1lOVGtz?=
 =?utf-8?B?ZGJiblQxZnF5Q3Y5K2ZRalVlQjhvakJRSFQ4Q0ZTTUhGOVJqV0hwYU1XaXg3?=
 =?utf-8?B?UFF4U0tRTjRCZzVyem5pZTlLL3FRam5IdkdJWlA2OHB0SWZrM0xZZGlYT2FZ?=
 =?utf-8?B?cEd5K0JVcG0wdEZ5RmRzYXFBY1RlVk90Z3hJeU0xcEhodUJnUHRoS3lOSDc5?=
 =?utf-8?B?T2U2L1hFM00zbjBlekNBaFc4VWR4NE41M1laWnBWZDEvZmZvbHRmd2xRWE82?=
 =?utf-8?B?b3RtUHI0YWF3Q29oRlBkelBYM3N1QzFxRnl3Mnl2Kzd0TXVhUUJiNERXR3M1?=
 =?utf-8?B?REdybGp4S0doQTFoam52VWxncDI1VE9YV0lZMHMvUE9XWVJ3RWtUSGp3bUFC?=
 =?utf-8?B?VUNIMXA3eWVQK0ZBcHNTMUE0d1MxakZnMk5lVWk1eURqOUt5U1V6b1FMeXdl?=
 =?utf-8?B?ZUtqWWlQdWphQXVTeHpJVU11TngzOGNXMVRpVE4wenBHMjdwajhFQWpCNDZV?=
 =?utf-8?B?NEZPdHNCT1gra3ZNU0JWcFlmdk9YeE5ITW0zbGNXRm4vV1RabktEdVlhSFpa?=
 =?utf-8?B?UnprVitDV1NnZmRWdVQ0ZytPWXh5UE9MUEwvSi82Q2MzMnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB6217.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3dnTlEzUlRCY0NwVnZqcE1JYThWYTZIYWV5VzBFa1l5bnR6M1lWRjRQQUNN?=
 =?utf-8?B?VmxvNmExdDVoTEtxbnZ2T1F1UTV5UTNtYmp5dEw3Mk9sbHYrUitGMW5YaEtY?=
 =?utf-8?B?c1d2VGxja0VYVEU3TkpBRTUvNHpyT0NybDFlTDB1RjV0TWxDM0k1T3RBK1pM?=
 =?utf-8?B?QnNnT2VJUDZOdURQVzMxYy90RU9CUTVJa3FqUTZRV29wLzg2bFNLeXlhb3Iw?=
 =?utf-8?B?c3RCb0gzR3VYZnRFTEZzTkp1eGdNZk1FZmxoci90MXlOSnZraTdGNEUwVm5C?=
 =?utf-8?B?R1Y5cHVlM1VQTWZKSnM0dVBKM3lYc05UbFJYcmRaNnM0V3NFMTN5VStkUXFN?=
 =?utf-8?B?RWdaUzkxVkxBUXRpUCtKYXlyYUxMZkxhQlpXV0x6UExQNUVNVTl0YVpYc3hS?=
 =?utf-8?B?Y0gzd2Q4Z0FiZ0E3WDhYR2ZyR2xoeTc2dUhHMG5LSk14SnVLYVdEeGVxQ1Rh?=
 =?utf-8?B?VmJRWktGRmFjSXEyTGtIblI5WTRITWEwaGdQZGlZRGFTNHp4WW9LcWJtNmRl?=
 =?utf-8?B?YUxGTGs4cGlwQXdsTkVJN3FERlNFSXdNd2FsRDZlQi9tNGx5bFc2dmpvY1Nz?=
 =?utf-8?B?bmdVU0dBcHJhY1VCRHcxd2RQTWl1N1YrYVA4WnBVTGdma0llczVndjdXZ3ly?=
 =?utf-8?B?MFF4TE8rbHZEeCtpc0o0TTVLeHJucEpUZ2daNGd3eU5PVW9xVHNxWEVCOTJy?=
 =?utf-8?B?RHA4bU5oUjdYVC9JcCt6Zy9RbXBVNFZuenRsY3hKR3kzcDh6M3o0MWVjdG1x?=
 =?utf-8?B?L3FhS3NOOG9sMXhOMDJDYnN3TGlLZ3dXUlpzTWdzNXJCYWRIeHExdjRJNGNJ?=
 =?utf-8?B?ZmZBWE5RZkxLVUpZU25GRHhNaWRMU0VWK3IwTW9vNTFZVSs5d3hFdi82OUNU?=
 =?utf-8?B?TFl1ZjNpUDFzYUxYczF2RVg1TmVDVWNSVklEZmlJM1g1ckdrenE4ZHprbkw3?=
 =?utf-8?B?QkVLQS90NU5wc2tvRHJkdU9lNXVTN09qZWdIRWxDYWU4cGhEazVWQU9pRW45?=
 =?utf-8?B?WG5JQTBqNktYNXpwcWdaQlhpMGdybjI5YXRNRjJNbGdjMkVFYTVjMmxkRnZV?=
 =?utf-8?B?NkRHTnJzWUZVbWZLYWpEdFdkQXNrNEQ0SE1aTTlKVEhCVWV5VjJPZEV5dGRO?=
 =?utf-8?B?NTFhRWFieGdnVWYzTVZ4UkorMWFtT2RHYnZwa1lUTW45UWZaTUcxK2FQS1BU?=
 =?utf-8?B?S1hhc1lzR0VKdlZ6U3p5ditNL21QYmNXd3JyUjBOSUI4cFpkejVIUFZhbXha?=
 =?utf-8?B?d01rcEtTVjVIQkI4c1VDa0pDWGpTT2w2RlJyY29LWDlzTjFwcFhJT0s1RE5J?=
 =?utf-8?B?UUVCajlzNE1oeGIvUkZQbnc1a3FhOVl2bG9yUUFudVZiUVRjeGt3TS92NnBO?=
 =?utf-8?B?eExMUVcwVHcvRHoyU2ZsSnNRejJRYTRwUklHZkxTQ01VMk1jUm1PL3Y5TTNy?=
 =?utf-8?B?VmV1RG96OXYxUkVzVEw2LzIyUDUrSlg1NjRnNmc1TmdiUnFhMXR5MDdHNDFO?=
 =?utf-8?B?cnU4MTBQNEtYNVpWNjBhbUNseTlvVjlzd2d5VGt0REZhekYyTTJEUlpWVG9x?=
 =?utf-8?B?MlZiTHk1YVRWMklDcW1nZHhXRzRFVzE0MUJNSkFKZlNJSFRLZFlQS2VOeitl?=
 =?utf-8?B?dlNuVnd1UUMyelZEaHlsSkdibE5TVHdRSXhWNm5FaHovVGJDMWRSSEdrSjdu?=
 =?utf-8?B?STlkWUNLazlrdGkyUmI2SzNiNC9JSUlUeG80dXk0U1ZpWVFuYWhMbXR2MGxr?=
 =?utf-8?B?RE9hdENMb3lWblNZS1Z4RUVmcllucjBsd09IMldpRnBQbHhIem5RV1FZQVFU?=
 =?utf-8?B?WHJRR2VGMkt1R28zVzFCWkN2R0NNN3RIVnJQRit0cHprWFBmZE9pR0tuZnBV?=
 =?utf-8?B?NUpNUUszbG5UQWxRRk93V0l5WXBLOGJwN2s0dXF1RjBlK1RVZnJKVlcrQ1BI?=
 =?utf-8?B?R2JuR3NYYktoOG5zbURra1Rpb2lmd3pGbnBTM2p5SHdFbGI5M3B4MzVnVWQ1?=
 =?utf-8?B?SmdwY0RhNjNBUFhwbTNDdGJUVzNkandBTWgxQkNnMUw1WkFUNEZqOFlVR2xi?=
 =?utf-8?B?cmNFZWxUUmxLMjhaUTNkZjdvVEZSRklvRFM0SWpJQng5aXBaOW55bWQ1QWg1?=
 =?utf-8?Q?g4Qo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB6217.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b915d03c-9206-4356-f256-08dcc02baea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 08:48:22.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zjk9XB/QhInbrJmQ+Z7gNHbOV+G2U7r4ickO0sMGE7mondGVFkQiwi99Z7uAnUObNCYKoQ7vdu/DJ6F6Jhe7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6565

SGVsbG8gbGludXggY29tbXVuaXR5IGV4cGVydDoNCg0KPj4gPj5JIHRoaW5rIHRoaXMgaGFzIGJl
ZW4gcmVwb3J0ZWQgcHJldmlvdXNseSwgYW5kIGRpZmZlcmVudCBwYXRjaGVzIGhhdmUgYmVlbiBw
cm9wb3NlZCwgaGF2ZSB5b3Ugc2VhcmNoZWQgdGhlIGFyY2hpdmVzPw0KPj4gPiBJIGhhdmVuJ3Qg
c2VlbiB0aGUgcGF0Y2ggZ2l2ZW4gYmVsb3cgYmVmb3JlLCBJIHdpbGwgcmVhZCBpdCBjYXJlZnVs
bHkuDQo+PiA+IEkgc2VhcmNoZWQgZm9yIExpbnV4IG1haW5saW5lIGNvbW1pdHMgYmVmb3JlIHN1
Ym1pdHRpbmcsIGJ1dCBJIG9ubHkgY29tcGFyZWQgdGhlbSBhY2NvcmRpbmcgdG8gdGhlIGNyYXNo
IHN0YWNrIGluZm9ybWF0aW9uIGFuZCBkaWQgbm90IG5vdGljZSB0aGUgZm9sbG93aW5nIGNvbW1p
dC4NCj4+ICBJIGNoZWNrZWQgdGhlIHN0YWNrIHRyYWNlIGFnYWluLiBUaGUgcHJvYmxlbSB3ZSBl
bmNvdW50ZXJlZCBzZWVtcyBkaWZmZXJlbnQgZnJvbSB0aGUgcHJvYmxlbSByZXBvcnRlZCBpbiB0
aGUgbGluayBiZWxvdywgYW5kIHRoZXkgYXJlIG5vdCBjYXVzZWQgYnkgdGhlIHNhbWUgcmVhc29u
Lg0KPj4NCg0KPkRpZCB5b3UgYXBwbHkgdGhlIHBhdGNoPyBhcyBzdWdnZXN0ZWQsIGlzIHRoZSB0
ZXN0IG1vdmluZyBmcm9tIG9uZSBnYWRnZXQgdG8gdGhlIG90aGVyPw0KIFdlIGFwcGx5IHRoZSBw
YXRjaCBpbnRvIGtlcm5lbCA1LjE1IGFuZCByYW4gYSBzdHJlc3MgdGVzdCwgYW5kIHRoZSBwcm9i
bGVtIGRpZCBub3QgcmVjdXIuDQogQ29ubmVjdCB0aGUgcGhvbmUgdG8gdGhlIFBDIHZpYSBhIFVT
QiBjYWJsZSBhbmQgcnVuIHRoZSBtb25rZXkgdGVzdCAocnVuIGFuIGFwayBhbmQgY2xpY2sgb24g
aXQgYXQgd2lsbCBvbiB0aGUgcGhvbmUgaW50ZXJmYWNlKS4NCg0KVGhhbmtzDQo=

