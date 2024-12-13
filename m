Return-Path: <linux-kernel+bounces-444955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1569F0F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB142818A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1301E0E01;
	Fri, 13 Dec 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NVwSY/dK"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDC1E04B6;
	Fri, 13 Dec 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099787; cv=fail; b=RBugYNDgwIrNBj9CoYRQjX4b/KB1cmhr1pJhcr4rtBhvK3o/sSbQjxp7ZwZeRFFnAflPZ64fIBpZcm80wEZClGBx4jNuRYmYsmCWVxML5cO1mcv6fqJnpeeAI3MHorLImqgvo2yUdAWZChDCJwnAvraot/s4InscmV7+36CJYLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099787; c=relaxed/simple;
	bh=c7wxY2hIh7/YDTfdVs6lsWkUfYXQIHANJgLs+9vxGck=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VnwyqenHongDOSUTjwjFKw1K2za+NwlpfFhTHVOevMsSv/8nqafsQp3oGbRpjIWjKTgW8W8fI/GsKZBR//wuFW1Ew4Ff3IDWmI3gUd+uSKrecZ39mgbluPdKexMl0ZbSEo4EKatod0tGC2RNfDzXqf+6xIUGfJPPKrlj6E1xC/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NVwSY/dK; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veXNEt9C4UNgHhQJac1ekhwRpJXfamw7i4doxUn8D1NUZFm1pprnhk1jkGdBxekGW6ycbUQvKrDUyyO5wfo0uM3QNfVWwutljzhxoiCzISZkrohEgA5NVFr6gQ4LSs6MSgfRoRqKyaKu+xdqpQS9/zZsDEp9bP6A5mVFMjgM9cGsCz48EfM9AsMs4+ygBJG+E0n4hJJgDMD2sefSJfaM2bR2Nh/utcEr5VTaS6qlmqPAViPNWB703xQiQ22sowLx1WqaK9a+Wf7h4wgjwU3aUolQj4tFw15L+pgN06/XCHpT1c+H00oxSdG/m1PcIbSbIAFTw03oOI0hjCdRFaDoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=222dzC2vXjpjjGgcZahcdE9bxHdHlBOazA7qMVDBJrU=;
 b=vWPR19KmzEEggDMDuKZxH0M5s9O/85YklfhVa3hmblQ/F4ZL9IIcOS5MXFWDBhNgcJuhPzI7PK33xmclvPioZ+PGpEuHLgoL3TK6/Ey550rV+CN+p1ipPo55GR2F6IO3MWWbBJymtg+vT7LOmLs3AQ1vZxpkuizBZGY0wzntAtLw28i83+XrITlSFFCL4e6YblFnI7L+UGIhYLWlOx1uLAtK/fkZ3UQaPZ+QivBOvhj9GHXsmEsVz5g1RtMgBmC3JTKQl7XkHCZxizhYixqsyae2Q8omdPPGv1BELOCbAvNl5+hsHCojudGgZrfg8mkyFCtDeZIWlExYmr/JMKNZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=222dzC2vXjpjjGgcZahcdE9bxHdHlBOazA7qMVDBJrU=;
 b=NVwSY/dKC4/DCO9oDJeXKhV02hdgfIdNOpTDNpR9oJ5L/Z75iq/RnQZZMAfcIOJV5v8VVEhn71vkNiYF3sD8ogGIch1DVjB3P7kJymoR97ufQNtdLfWTOfI1DH0KBd06qK13ezZEoXuGB/5Kta1V1nsSOT8j1zfALPQtxU0wPIm7REAjl6HN+ks1h2/PnTs5QRgnHe2YrYjTyFXmIWcfIKy+x7FyPYLd5ulfFwGBMSbzH9Dv9ulm2vFU3+OhW9KDjcMsZzAywdRqeAVv1s1/I07iIVwbJcyiVc019mnEBKiEsTk1mRCwHvrophFs3xkxSRxMhF9Xd4P3pol9aOXAhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8037.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 14:23:01 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%2]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 14:23:01 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2] arm64: dts: s32g: add I2C support
Date: Fri, 13 Dec 2024 16:22:50 +0200
Message-ID: <20241213142250.2532559-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0016.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::21) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4592bea3-53c1-496d-cb38-08dd1b81a677
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjB6Q3hvWWZWbGxlK09VUmN4eWtvUnAvMkpqZFlaYjRnWFpsTFpxeGFER2NN?=
 =?utf-8?B?YUpFNzMreHVrQzcvYVNHeVhVZkJuUUJPeUxOVHFoREdML0xaNS94REUvUjBk?=
 =?utf-8?B?ZTloNUNTT1dDVlEySDZtK1lwNU1Bc2tDZFQzR2FvZEFwZDl6YU80QlFJZmt2?=
 =?utf-8?B?UzBiekRKaHExcThrY3VRRFFpS2ZnYU0xSGhUbzloNExhc3pRMjdHbnpiUk1K?=
 =?utf-8?B?UnE5TytvU3JIN29DOXFQeEhSa04wb2JLZmxGVGl4bFY1b3FuVVlSWVFPdVlB?=
 =?utf-8?B?RUJCalpyN2t5eHN5S2NobU1ONllrOFRMSytVaGIzZnJZMlRDVEpXS3JFaENx?=
 =?utf-8?B?bGFrblFHc1FKQnE5SzdiMGFrR1plcXBhS1gzaVhnb3RET1RWTS9JVitNTkF2?=
 =?utf-8?B?RWtpczE4c3N2L2N1TkpGS29wMjVXLzdHOENGQkRZSzJDRnVJaEZUbHZLUGVy?=
 =?utf-8?B?OWUvemxBa1d4cGVnQVNhcXJtMU8vOGxUMG5DdHFVWTY2ZldxeFpIQzJmNjZK?=
 =?utf-8?B?Z2NWZU42OHpuaElnNk9nVTVTcVlsS24vMlVtZUFyaHZ4SlpRd1dMeGcxbmpM?=
 =?utf-8?B?enhyZU5WWmwvVTNlMXQ2QWtUMEgzemtmZnhOOVZCaWgwOUVkWVJhTnprTHJ3?=
 =?utf-8?B?VEIxSU1uczEyNXNTS0RCS0NxZmRTLzR6b3R2elI0eDlhYkt6SmVZLytObmpV?=
 =?utf-8?B?QjZFKzJ4amZhbDVBcFBHRnB3Rm9KWjFlMnJtL2ZBM3JOU0JsS29NdEliejRn?=
 =?utf-8?B?SlVzVm9kRVZCYVhVTUdKT0U0c2s0UVdPWVVEcXFrblg5N0pDTjhwdnQ0TFZ1?=
 =?utf-8?B?c1VTOG1LWGFlRTRaUFhjWVdQamFhVHY4WENGSTVIa0xSa0svRDlzVTZZL1E4?=
 =?utf-8?B?WW83bmFWY1JFaDdNZi9wWEhaL2JxZ1YzWnp2UzRGbXBUc01ldzdxek16ZWNv?=
 =?utf-8?B?TE9CZVBRR0NRZ1hsdTRoYnhhNUFPQyswWGQ4dll6dVZSL2p1V1dZZHlUZ3Bp?=
 =?utf-8?B?TEpSN3pNVHJoN3VOZWRUZmVTZGpRc0NaVElZM291Y25aMXdSVDVlZ3FXbzQ1?=
 =?utf-8?B?dTJEUDQ1YThUckhvMEVTT0N2eHBING1RNGM2SVd0QXI1dG1YNjJFSnR3Zk5y?=
 =?utf-8?B?WFRYNmZGMzlvSk8zVW8wMDZDa1lHTi8wTUsvVllQR0dqL2dNOXIyMlpWSFpO?=
 =?utf-8?B?U1pMcFA0NVhlWjkxT3hnNlk4cjNRd0VkdGh4NmVXSitDdnJVR21oWG5CMlhL?=
 =?utf-8?B?Yi9uQzdOS3BKUVpHcHdkRkhxYVVya0laOS9NdU9veTI1dFhiTE1JbGp1ckVr?=
 =?utf-8?B?a3huVDlHNXMxMTZwYTFCTE9wVk8veTNDUU1NU2JmSnBHTkcyUk1wRGM2SEVN?=
 =?utf-8?B?M2NUK3Jzd1BpZ09VcWFqeXA0UHd6YmtnYUdIYktPQU1GaE96TldhOHh6azZX?=
 =?utf-8?B?SEtvVTNoVGZPTGtZUXMxMlFDV05TdUtlZTJvLzlFZWhacEczazZwcm5mRzZR?=
 =?utf-8?B?czloeVprUTFSTXZyL1hESDlSU3Fxc1M3ZzM3TXplWi9sK25Eb0h5cDQvbzhk?=
 =?utf-8?B?ekRUcDRBZDV1K1Q1czBUWk9YN3hMZ3dJTUpLQXMvYmswdlk2MEMzYW50eTQ3?=
 =?utf-8?B?V0lhUWY3ek9BTmZaaDZiQzJ6OVBDa00xWTd3dDd2NGdGN2FKOVpCbFZlTWlR?=
 =?utf-8?B?RXNkWmJGb0lkclFHbFVla3JQWlNEN2VSWHJIQndzQkxDUEhRNEw5a21ibXo1?=
 =?utf-8?B?MlBPTHpGVUJBRHdkeHJZemNzdHY5ZWZUckdmcGl4Zmp3Q2UxcXFLa0VEMU9n?=
 =?utf-8?B?OUx0UjhiY2NiT2RRY2F0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVBFTjdaR3pXU1BkWVc3T2VwbUN5U0JWRC9RMGFSc2lYeitxYVNHNnZDRmYv?=
 =?utf-8?B?SE4xQmxJRDg0bEZibzgzWlBpcjhXa0h1dXVHSDBqbjZleHZtTnFMaTR3bDRB?=
 =?utf-8?B?Mm04eWFqbGRkdEJwd0FxUzJsaW16Y3VTWDgyTlF0SUlXNEU0TkFJWk0zcitB?=
 =?utf-8?B?MlBhdTJjQzhyY3dsV0EraXE5VHBhR0FUWGU5dnJGOTJFL0IvZlpsSWVVT1ov?=
 =?utf-8?B?ZWVaQW1iSlR4SllCVzFoZ2hlTnhIMG42UHR1dUNtM1pLODRuNytUTEx2dW5n?=
 =?utf-8?B?bnJ4WHAvVzNoUElYQUs3dGM0aGVCZ01Od2lBUEgvSGhvSFNoU1k5Qnc5cUo0?=
 =?utf-8?B?TEtxSnF2Vk9sZUoySWRKUk1wblZkWW5KV0xUNTQzRVN2SzNHcWJ3VDd4TWJa?=
 =?utf-8?B?TDhsN3BJZVFsd1VqMDR5L3pCTnpGd1J6R0ZJZVp0a2hRbitkSmc1Zng4RkU3?=
 =?utf-8?B?VGFUMlRhNzM4b0drbUNPZXFWcUdrSVFqMlpRMjRJeklBa1N1UnV2SGZhNTlB?=
 =?utf-8?B?QlZFZnFBRkJlRG5YNkordmpMVmNvOVpFUlhLT3pvanRRM0p0ZWxrWGNJaUlL?=
 =?utf-8?B?TUM3Zi8vTmFlYmIrRjE0OVdlQVJidjFVdFNjUTA5d1BDa25hTDF0K09MUXhk?=
 =?utf-8?B?WHcrYVZieUZLUDZvWVBQSjVCNHIrdk1HUjhyVHQ2UmZWcTFUVjdDS1BNaFVh?=
 =?utf-8?B?NzRibnZoVmxkUDMxK0Q3eURlM2N0VnZzWngvMFF2MDB6QTR1ZEJ4YUtvNXN4?=
 =?utf-8?B?bHFqdkRiYjd1aGtrZHg5UngrYmt5RkxBaVhkTzRiYnRtdCtrVFBRYVVhSEpj?=
 =?utf-8?B?aFAyMDM2SThIQkl1STFSeVdndW04dHEvSXRHdTllMjdCS2pxUVNzblltZXdX?=
 =?utf-8?B?NjhQb2paZno2TDJBUkozZjdsY1NHZCs1bmZhcEl1bHZ5RFBTZVFuSlBkQTdQ?=
 =?utf-8?B?Q2FZNlZUbnYzdWlndmNUbWpDRFUyWDgvOEk1TFZzKzZRYWJ5WUZsRHVncnlM?=
 =?utf-8?B?YUJUVForZDhXc09EQU5QNXJJdlpUbzJnL3JUNHVnUllTSFcyd1FzUUEzUlhJ?=
 =?utf-8?B?ZzN1QllqUWlDNG5mUXUvRGplTE5WbE0wMStqU24yRkhOMytSME15MjVCZC84?=
 =?utf-8?B?cDcrdk4wTmlvY01PS1hoWHBnRkRGS3I3YkFNRjNibnBpUlNhNHV5WTVxRnVu?=
 =?utf-8?B?N1FoSEc5ZWxlQjlUWHQ5UDlZay8rVHFJTHRQclV3alV4TTJQMDNZTHVnaUNn?=
 =?utf-8?B?L0JuRFc2T25xYnpRMG5KTmFJM1BPWWpSN1dPQ1FaMU40WnpHMDJ0OFV5a1R6?=
 =?utf-8?B?c2sybFJsUGYzd2xFNVZQdGNBQWdFbDdsODNVVlA1UW02dzlyUExlS200ckp6?=
 =?utf-8?B?emZlQmRLbjdXQzk4cnpMQjF5QlQwZEE4dnpJMFkrNnVJbVRDZXQxRWV5OWlZ?=
 =?utf-8?B?bVBKS1o4U3kwTFc4WXlaWGgwdnZiYUpEaG9LRjFHZ1c3bGJVeWIxWjc0dXNl?=
 =?utf-8?B?VGtmQjcvMEZLV0lYM29WNzJiMHJ6NnZqSjkwbTRtVUF2NVppQnhXVnhlTXVj?=
 =?utf-8?B?MW9qMVhVNlRqdlpua0hZU3FKOGxabm94eTE4WkZRTVNSNGxUeTdHNkNEZkwv?=
 =?utf-8?B?QlRxWmw3enFicmFoY1dOTFh3Mm9rOHRrWDdmQTg3SGNtMXRVQWFEb2dsdHBQ?=
 =?utf-8?B?VVUrMnM5NVdsSlppMTM1MWFGelJnelo5Rk1QSjR6OXQrZmpKSVc4WExHcjhG?=
 =?utf-8?B?enZBZ0NuaTd4MWQ5RTlWSHVoeUV1VjFqSEtwem01SHkxWEhzUEs5d3kyQ1BZ?=
 =?utf-8?B?em0zRXFaQkxxTXIvT1dpWVByd2N2NGZaTVJ5RmMxZVcyWG95SERja1FrRWJB?=
 =?utf-8?B?YjhNTkNaaGs1aGM4YlkvNDB5S28vV3VhdGovT1IzenUwUWt6L1U1K1dZbjFG?=
 =?utf-8?B?YjRadTBnZERudU9JZUVBL0ovUmZFNC9HS1B1S1BCQW9jMEovUGMrRDJjUVo4?=
 =?utf-8?B?UUw4MExRT3VIM0ZjbW1HbER5eXlKSHhuU3puOUxrMGg5RnlSZG90SkdKV0Vx?=
 =?utf-8?B?OE85enkvajhGNk14YllvaWxlOW42dlN4anN4UUt1aXA1cWtSOTZoOHcxbGtV?=
 =?utf-8?B?b252eDVqUkQ4SDY2YnhvQ3MxZm1OQnFDRXMxajlINDQ1cDdlLzU0bGx2TmlP?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4592bea3-53c1-496d-cb38-08dd1b81a677
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:23:01.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q83cU0Kdm8y04G83byD4N+roU35m/JH0ZVvqY0uDkBDwswF5JfxE584USMlh6e2U5uu6HulguriXN4jB6F5qK0dPPby7RsgAg2vsD9J4miU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8037

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add the I2C Devicetree nodes and pinmux for S32G2 and S32G3 SoCs.

With respect to S32G2/S32G3 SoC based boards, there are multiple RDB
(rdb2 vs rdb3) and EVB (for G2 vs for G3) board revisions. These versions
are quite similar. The common part for the EVB revisions will be
centralized in 's32gxxa-evb.dtsi' file, while the RDB commonalities will
be placed in 's32gxxa-rdb.dtsi' file.

This refactor will also serve for other modules in the future, such as
FlexCAN, DSPI.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  45 ++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |   1 +
 .../boot/dts/freescale/s32g274a-rdb2.dts      |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      |  50 ++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |   9 ++
 .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 150 ++++++++++++++++++
 .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 126 +++++++++++++++
 7 files changed, 382 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 7be430b78c83..0e6c847ab0c3 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -333,6 +333,33 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@401e4000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x401e4000 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c1: i2c@401e8000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x401e8000 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c2: i2c@401ec000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x401ec000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		uart2: serial@402bc000 {
 			compatible = "nxp,s32g2-linflexuart",
 				     "fsl,s32v234-linflexuart";
@@ -341,6 +368,24 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		i2c3: i2c@402d8000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x402d8000 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c4: i2c@402dc000 {
+			compatible = "nxp,s32g2-i2c";
+			reg = <0x402dc000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		usdhc0: mmc@402f0000 {
 			compatible = "nxp,s32g2-usdhc";
 			reg = <0x402f0000 0x1000>;
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
index b9a119eea2b7..c4a195dd67bf 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s32g2.dtsi"
+#include "s32gxxxa-evb.dtsi"
 
 / {
 	model = "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
index aaa61a8ad0da..b5ba51696f43 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "s32g2.dtsi"
+#include "s32gxxxa-rdb.dtsi"
 
 / {
 	model = "NXP S32G2 Reference Design Board 2 (S32G-VNP-RDB2)";
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 6c572ffe37ca..666e4029e588 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -390,6 +390,36 @@ uart1: serial@401cc000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@401e4000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x401e4000 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c1: i2c@401e8000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x401e8000 0x1000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c2: i2c@401ec000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x401ec000 0x1000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		uart2: serial@402bc000 {
 			compatible = "nxp,s32g3-linflexuart",
 				     "fsl,s32v234-linflexuart";
@@ -398,6 +428,26 @@ uart2: serial@402bc000 {
 			status = "disabled";
 		};
 
+		i2c3: i2c@402d8000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x402d8000 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		i2c4: i2c@402dc000 {
+			compatible = "nxp,s32g3-i2c",
+				     "nxp,s32g2-i2c";
+			reg = <0x402dc000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 40>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		usdhc0: mmc@402f0000 {
 			compatible = "nxp,s32g3-usdhc",
 				     "nxp,s32g2-usdhc";
diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
index 828e353455b5..5f8739c068c6 100644
--- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
+++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "s32g3.dtsi"
+#include "s32gxxxa-rdb.dtsi"
 
 / {
 	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
@@ -39,6 +40,14 @@ &uart1 {
 	status = "okay";
 };
 
+&i2c4 {
+	ina231@40 {
+		compatible = "ti,ina231";
+		reg = <0x40>;
+		shunt-resistor = <1000>;
+	};
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc0>;
diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
new file mode 100644
index 000000000000..a44eff28073a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2024 NXP
+ *
+ * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
+ *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+ *          Larisa Grigore <larisa.grigore@nxp.com>
+ */
+
+&pinctrl {
+	i2c0_pins: i2c0-pins {
+		i2c0-grp0 {
+			pinmux = <0x101>, <0x111>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-grp1 {
+			pinmux = <0x2352>, <0x2362>;
+		};
+	};
+
+	i2c0_gpio_pins: i2c0-gpio-pins {
+		i2c0-gpio-grp0 {
+			pinmux = <0x100>, <0x110>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-gpio-grp1 {
+			pinmux = <0x2350>, <0x2360>;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		i2c1-grp0 {
+			pinmux = <0x131>, <0x141>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c1-grp1 {
+			pinmux = <0x2cd2>, <0x2ce2>;
+		};
+	};
+
+	i2c1_gpio_pins: i2c1-gpio-pins {
+		i2c1-gpio-grp0 {
+			pinmux = <0x130>, <0x140>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c1-gpio-grp1 {
+			pinmux = <0x2cd0>, <0x2ce0>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		i2c2-grp0 {
+			pinmux = <0x151>, <0x161>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c2-grp1 {
+			pinmux = <0x2cf2>, <0x2d02>;
+		};
+	};
+
+	i2c2_gpio_pins: i2c2-gpio-pins {
+		i2c2-gpio-grp0 {
+			pinmux = <0x150>, <0x160>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c2-gpio-grp1 {
+			pinmux = <0x2cf0>, <0x2d00>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		i2c4-grp0 {
+			pinmux = <0x211>, <0x222>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-grp1 {
+			pinmux = <0x2d43>, <0x2d33>;
+		};
+	};
+
+	i2c4_gpio_pins: i2c4-gpio-pins {
+		i2c4-gpio-grp0 {
+			pinmux = <0x210>, <0x220>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-gpio-grp1 {
+			pinmux = <0x2d40>, <0x2d30>;
+		};
+	};
+};
+
+&i2c0 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-1 = <&i2c0_gpio_pins>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-1 = <&i2c1_gpio_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	status = "okay";
+};
+
+&i2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&i2c4_gpio_pins>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
new file mode 100644
index 000000000000..50fe6aaa1605
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2024 NXP
+ *
+ * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
+ *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+ *          Larisa Grigore <larisa.grigore@nxp.com>
+ */
+
+&pinctrl {
+	i2c0_pins: i2c0-pins {
+		i2c0-grp0 {
+			pinmux = <0x1f2>, <0x201>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-grp1 {
+			pinmux = <0x2353>, <0x2363>;
+		};
+	};
+
+	i2c0_gpio_pins: i2c0-gpio-pins {
+		i2c0-gpio-grp0 {
+			pinmux = <0x1f0>, <0x200>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c0-gpio-grp1 {
+			pinmux = <0x2350>, <0x2360>;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		i2c2-grp0 {
+			pinmux = <0x151>, <0x161>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c2-grp1 {
+			pinmux = <0x2cf2>, <0x2d02>;
+		};
+	};
+
+	i2c2_gpio_pins: i2c2-gpio-pins {
+		i2c2-gpio-grp0 {
+			pinmux = <0x2cf0>, <0x2d00>;
+		};
+
+		i2c2-gpio-grp1 {
+			pinmux = <0x150>, <0x160>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		i2c4-grp0 {
+			pinmux = <0x211>, <0x222>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-grp1 {
+			pinmux = <0x2d43>, <0x2d33>;
+		};
+	};
+
+	i2c4_gpio_pins: i2c4-gpio-pins {
+		i2c4-gpio-grp0 {
+			pinmux = <0x210>, <0x220>;
+			drive-open-drain;
+			output-enable;
+			input-enable;
+			slew-rate = <133>;
+		};
+
+		i2c4-gpio-grp1 {
+			pinmux = <0x2d40>, <0x2d30>;
+		};
+	};
+};
+
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-1 = <&i2c0_gpio_pins>;
+	status = "okay";
+
+	pcal6524: gpio-expander@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	status = "okay";
+};
+
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&i2c4_gpio_pins>;
+	status = "okay";
+};
-- 
2.45.2


