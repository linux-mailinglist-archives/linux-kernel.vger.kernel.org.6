Return-Path: <linux-kernel+bounces-237617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6D923B93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C01F23D59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B47158D98;
	Tue,  2 Jul 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="ZYC7WsQ8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2119.outbound.protection.outlook.com [40.107.20.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9B158A3A;
	Tue,  2 Jul 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916583; cv=fail; b=jVUNVNzG2F6johDgGT82woR9da4WQG00Tglys7RZbq7l76WD5Cc0rVA/mMOldv3HA1O9wTg6xvwprkNVjnoixqSAmoikto6B0suUvreVOw9E4RaKwws5o6ZryF9Cq9Vntf7JLeJaB7Hcnk+Kzq7CQAXnyLC1c0T5jE9IA8ccON0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916583; c=relaxed/simple;
	bh=KniW1/UqN2mS3ByvUiqyYsLNvCZS1uCqGpjwBysv39Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkPaJqfvj9C1Yk+cpevvEgT0Ps0KGR7MwosIFb2UVs6kiAV6RLTaaYTz1At0zOSM2NBbASD2OAKBtD8TcMmxqiA83Rsqodul+PWjTeviGsx2sv3CUALLndKqrDn/B5I0Zhe/s6VBfFLVNVTvKS3zFWAnmEm3AIqQolXLJMdEVck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=ZYC7WsQ8; arc=fail smtp.client-ip=40.107.20.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY4c/Cnhj2gfmGHQ06672YF0YTQSymXs5fiORdWG2hx/JyOXJ6mH5PCj87kzL2dI8TCUl0Ou6NLkbQliieLeBYRZTunYScPGlEum5HYvdichod2e6Fq53dcp59D+Vh/tWTtqS/tFbAtnd1tPoCuAxZNuHKD+iYAvFfZSMzMpAQGy/rnrL6x4VqZ+Ae42gCcUOhbng+W+TSsTUixklFD4GEch5+iA8Cf261//qwOMFXAO3PgUpg04xMIOG4JE4P51seealSk8gkdHuRScY+u7YHXKsXu1o5vAOp35OsAZJqgxgLSG67RQLNQ4TcXq9jll5R5D5hg2JpyER2rApBVyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x99Rv/LHOaaDqmgpgaAhCoNLlqoNRjfq/v0la2sEd2k=;
 b=QqlsMDRZRURsvtiVNZ9kTxm9r/6R1PeFRirGP79HMgyFP/N3M1yovzGj2zhzd99NR8IAYwbxSfbWVtdb6Yb2TWZJCxHQcQDDj9B74CtAssGISrZbC2Kj1D6KUmIQ7pJHnvMs687hOPvJtExtRvsiTWUP0p/gUSZndSx01K7wcAnRAS/TZEf6hefIrh5MTukZbA1bLQv/GjIHgW+khwbqeSfitNzz7I+UbJBnE/P+KASqXT7U/50Qk07EHtcp+jXNyPhykYO6IeD6oRljLbKbCDKkz6UAl1prc1Gw1LJtOUUUGnWI+Na2eIgM3CVokCD8tFZJYCAUWDX7xHO0NTNFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x99Rv/LHOaaDqmgpgaAhCoNLlqoNRjfq/v0la2sEd2k=;
 b=ZYC7WsQ89pztUCDtK1Pnd62dmPhp7AYtZl4ln1kOvdA2rQNrSjD6EQ5uHzEpYzHOBuHTpyjn2bcAsTyEo+HVb9/yAfudLxccyM6oCVNS/TskQHQqCMjldCM52usbCkKN2rTIKfyXFJv7F7ETS3QsBPO096U/TK0gylkCWJ0tjz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:443::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 2 Jul
 2024 10:36:17 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%5]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 10:36:17 +0000
Message-ID: <0f5d659b-7f2a-4b33-8e4a-168640604e88@kontron.de>
Date: Tue, 2 Jul 2024 12:36:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: Add support for Kontron i.MX93 OSM-S SoM
 and BL carrier board
To: Frieder Schrempf <frieder@fris.de>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20240702103155.321855-1-frieder@fris.de>
 <20240702103155.321855-8-frieder@fris.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240702103155.321855-8-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::23) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0ffa9a-2a67-4c0f-aedc-08dc9a82ce04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vit1Q0tOMGhzTmcrV0FaZ25RZ0hlVy9EaUlaZG5zY2lNbUFRU0thM0k3clJk?=
 =?utf-8?B?QXQwYW1ScXZEZDZoOEtQMi9LeFdvSTgxQzJGWDlOdlpjdnBzcjRiZlBqdWov?=
 =?utf-8?B?Um4xYk1oSzN4ZVNkdkNIRG0rSDU0dlB5Vkd4ZWJsbHpLNEhhRk4yOXBiZWlw?=
 =?utf-8?B?MHB1b3dlNVRCUDBUTXBwMWRib2NWQnZReStzcm9Wbzk5d1ljZG5HcElmU1Nv?=
 =?utf-8?B?S3pTTDNBSXRCYzEvWnR3bEVGNzdKd2s1ckk4aTlTL1lIQ0lZVVczeWZIZzFB?=
 =?utf-8?B?amxsVGhNSjNmY2s3UXZaU0M2NGVTZE9iaHB5eVpzcHFJWnZpTWliZFRXMHEz?=
 =?utf-8?B?cE8zQWhSRGZqdERQVVRkTWVpWjYzS0VLV2NBbTgzQkhWV3ZwUFFKVGxrQ0or?=
 =?utf-8?B?WFFsckNxS3NncEduU3RmN2VrdFZUZndFTlEyeFcwNTJ5MTRhMXVNQ2ppL1ZY?=
 =?utf-8?B?bk1JU3BOL0FJTUl6d0M4U3hZNnlDYW45SFhTejFxOUpxZkorMm5KM29EYU1D?=
 =?utf-8?B?MVMwMDVFWWplZ1NJSVBlVVArUkJPM3d0U0ZZaWw5MGJBWlpGdjl3YUJjbFN1?=
 =?utf-8?B?b2VVRzRJRWdYRE5TSzVaSlVpZkxseksxY3NwdVJNRXE5VVNmWXk5OS9Iall1?=
 =?utf-8?B?YllvM3c5YkZUS1FneHJ2czdtbnRXbC9CalJ5RTBManhXVkJBWmxoTUxmdDZw?=
 =?utf-8?B?Y2g5blJTU012bEd3U3NNZkhDL3dlOTRIMS9MNEZRWjFHNGZKVDNDKzdZREJj?=
 =?utf-8?B?b0xSdUd1OWJoMHNLRC9HMFpVZnNJTGFBZmJDQW5Hem1lV2VSaUxPaWR1cmJx?=
 =?utf-8?B?ejNhR25YR3pxNmxZSXBUc3lKMVY4SXNITGFmM1Vldmp6ZmRCSmtpUFRoQTcw?=
 =?utf-8?B?SERtZUR1TWtad01jM1lEZGNEck1yTE1XZnZJS2lKOGMxNlVVYUkrNEo0bnJt?=
 =?utf-8?B?UjN6RFlqQ3FwektOazRidjZSVHZMclhWRW12SFJYTGFqSTJTRFZKZUtjd3Vm?=
 =?utf-8?B?RzdqTjFUMDFpVEFsL3kzd2ZpeTZjSDZDQnpQWi90TDdXaEdxeEpVb3Rkalhz?=
 =?utf-8?B?ZFRuS1RMVVJSOWV4VnZTZkFHZjNDRmxYNU9weDhCZm1DYVFIc0orZlVmWTJm?=
 =?utf-8?B?cSt6MUFnQXlXMVBqQm91emRJNjBzL2pmQy9JajhSblZWQS84b2VYNlZ3Zm82?=
 =?utf-8?B?dmFsMStVZkhWSG1udGE3dnpvUnQ3Y0FrNmV1T2diTGs2OG00SnV4WWlHN3Vl?=
 =?utf-8?B?SEVUM0NwbmoxVGVXTXhRa3lRaVpHSGhvbDJuQlBpbklQRWE5MG1YQ2xhczAz?=
 =?utf-8?B?Wm1qakxCSDFHS3lGeDhseHU1blhKTldvOGNDcG1SZDBVbHFaSWFiVWZ4VGsw?=
 =?utf-8?B?T3doQmNjc0xDeHpCaWJWVTNjaDVCV0FuZkpGcEVYWHpDV0RxKzFDQ3U0czZL?=
 =?utf-8?B?dDdDU202OHI1TG1nVkRRcjYvWU9sZHRPQS84YUxwUWRBdWE3TmlneHQ0aENq?=
 =?utf-8?B?U0hjRTI5d29CWUZ0a2hTMGUzcHBmcWErZFVlcU1FcHR2RkVwVkt1QUlGRThW?=
 =?utf-8?B?ZW1UM3pqTk9ZeFRCS2FSVW1iRDNITUdEVTdJZGVRQ2duR2ZtYzBDYnlZVkV3?=
 =?utf-8?B?SFAxTmdtSnZtNmpidDEydjhYMlhGbU5MRDhOaW5KVzdnMTVheE1rWG1iLzE1?=
 =?utf-8?B?eHB0Y0xEcUIwZGNxS0s3M0c4SEx3SUtTQWRYdWlhaGF0bDNEa0FwdUNuMm1i?=
 =?utf-8?B?NnV4THNGMWJxdHVabGtDM0FGcWVGSnFPSlJZNXI5blgzZTc4YnN0b2h6VUxM?=
 =?utf-8?B?WU90cHUvMVp4MVQxeE8wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTYrNVo1enVRTUNBdzE4QVVjVGY2dHhqMldzTm0vRVM4bUlDL2FPVWM2V1Ri?=
 =?utf-8?B?cHNVdVYwZVN2TnZ1N1E4MVN4dFB2dlJMSzU0VTZTalprczhLWmVKRURWU3NI?=
 =?utf-8?B?Qmw1aTk2dDVjRitOcmpKYlFNa3hPYmgrMnBXWGxCOFd5UlNkeWN5SXRpVFZh?=
 =?utf-8?B?eDRkR2JPYUtyc2xWSDBNQzRuUFgxSkpmYUlPWmdJTG9Ud3ZtR2hUaU5QSXZN?=
 =?utf-8?B?d2FGWUpRWHRjazlmcE1URXdNVjJuS3p5SWszQVhtNHNzWXJOc3lmK01KTTdo?=
 =?utf-8?B?M05NeXd5MUtiYnVlVkdVUXcyUVZIV1FLbmhHK0grWlIzWGJMWU9VeUJZa055?=
 =?utf-8?B?RHRkMmQ5WkV4bURmbDlaSWtickw0WVRIenJmbFBKMytLRWlPcndyMkhsK1lY?=
 =?utf-8?B?cnR1RWVJRXcrNm93eUwrbCtHS3VQZkNEVDRVcCtFaDFwclltbFhWbGQvOW1p?=
 =?utf-8?B?ZmMwUkZ2djZKOUFiM3htNndNZlFiMlBoWWtTWmFxa0RudkpVK3lTSllOMHR0?=
 =?utf-8?B?NUNEVWZSVmxIU01NMmQ0cDhwS2J5TEdiejArQnNIRkVrWWVlZWNOcFIyQjla?=
 =?utf-8?B?THBYd2k1UTl6RWpNTzUzRG83d1NsTllDRU1La3dJUmY3UktMRW1NbW53emds?=
 =?utf-8?B?UThBNHpTVTVhME9mb216OWs4Y1hCOFV0OW5wK2ovS0JTVlJ5UkV5aVJRcytJ?=
 =?utf-8?B?VEU0c1JwdEN2S29keWFUY3hoQlBTSlcrQzFJUUFBSG5saVV6SHJiR2RmU1Bv?=
 =?utf-8?B?ejk3YWpUM0l3M08xZW5CSFJMOStBU0N3WlhQeG4yN08yRS83NEduUVg2SDQ1?=
 =?utf-8?B?RTNXNmQ5ZFl1TVlMdy9VZ1N5VUpwNjRuMFVnckplWXR0QWFRUk4yWVg0ZnZ1?=
 =?utf-8?B?ejBKeTJuL21Oc2gvUG52TG1meGxuTHphUHBnWUhKb1hFU2VwWkRXMk0yV2Fs?=
 =?utf-8?B?K1k4d2ZDcjlSZkRLZHQyNTM0ZDRGZ1NhWGdiaGFCRXJtUFoxalI5RHIzT0dC?=
 =?utf-8?B?eWpiVmpFZ1dNQ2xhZWZLSnlNTmFjcTh5dlNOUFlkeGw3VUFYNGk4LzZFOHJ6?=
 =?utf-8?B?R3A4R3JHVjkyTitmUjRyV0RMYVVnRmM0OFZHSUZOOUV2dElmTmJKY09VZmpQ?=
 =?utf-8?B?N0llVnFkUnBiZC90RGk3bGhDc0VydWpwM2ZiRlhYWkRsODRTNk5lbW52OVBG?=
 =?utf-8?B?cGhCc2RIMkZBUmpCOGQyVUdDU0FWSGpLL2Rtd21zcEIxT1JuR2d3a202dDl2?=
 =?utf-8?B?NUxhWWt2cWs1T2tuRStCbUdJVnJIaUZXNTZ5Z0c2ZTczUmptYTJGSDBxWHN0?=
 =?utf-8?B?eHNNbDV5R2xveFRTb2crcmlEZVdRUS9yN1BDWXh5ZmYwOGZqU2ptWm9RWE5P?=
 =?utf-8?B?cUdmd1Q2Uloxck9oRy9nQjMxNDVzeWg1bUtWZVlqMnAzZDJ6YXFWUXdLelFj?=
 =?utf-8?B?a1BjM0pybmJzQUdGNW82SEhMdTRzNHRyU2NQQ2xNYnFEcGJPMndURzQ4L0RW?=
 =?utf-8?B?d05XREc4ZUF1RVU4K0hOQXpyR21lU2IxN0RKZDM3KzdZR2c2WEVwYmdDTCs3?=
 =?utf-8?B?MHhPZWI0aG5ESGFuN1JmUGxnSkMyOFhVOHBJVERYQmVFS0dSOGM1Ly9id3lF?=
 =?utf-8?B?T0ZzRElrRFFJMUMxWmUwVis4eUZnU1E4L3JpUWxRNHo5MTVCT1liSlFFTlpZ?=
 =?utf-8?B?Y29FTktRYlF6V3lmTlEvZU5pWWFQOXRDV2FiSUNlbHUycXZyQXVYaGFNTzh0?=
 =?utf-8?B?YzJTcm5aaWNoMytzc3FyU2dNQ2FpWDlyRnJMMlBRRFU2d2trcDRrUEgzbzcz?=
 =?utf-8?B?WFFVYklEdnZmdmJpc0IyaTdKd0M3a2xFTFdwcFN4czRYdzB6MzdBWXE0UG1n?=
 =?utf-8?B?ei96eUZMSDNlUnczUFluTE8xWjF2OFZZeW8yOXVocWtVZVJiaFl5UWVzTlk3?=
 =?utf-8?B?QWpKQS83Z2xUeUpQTEhnc1dzUHVDa1lKYTF5d0tJaHhqZTdUcFo2bkptWHQ1?=
 =?utf-8?B?QnNqaWV5Yy9qQWc3VFRoSmthRWlTemJYbExhTXl2KzlGd1VCUkw0SWdXUXRu?=
 =?utf-8?B?KzlxNDlUMjVoNk40Tmt4bXk3OVk0aHd4ZlpuREJ5Nkxvc1g1eVhnUzdkWldj?=
 =?utf-8?B?bVl0RkxLRytRL1Q0bXZPa2JaVlNFYWpueVl3MnB2OVV2cC82cUFVNEJMTVVO?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0ffa9a-2a67-4c0f-aedc-08dc9a82ce04
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:36:17.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQOftNbcR7By6GufqUpuCnoYkDjyxQuLWrqepIg7cpUbSru8QOVFHfMOwcUtA1mWHPAB7mEZvZK1vnXNFQCKsBkoXIyCUEHASF9fCXaG1JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8811

On 02.07.24 12:31 PM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This adds support for the Kontron Electronics OSM-S i.MX93 SoM
> and the matching baseboard BL i.MX93.
> 
> The SoM hardware complies to the Open Standard Module (OSM) 1.1
> specification, size S (https://sget.org/standards/osm).
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

This is missing the Makefile changes to actually build the DTs. I will
add them in v2.

