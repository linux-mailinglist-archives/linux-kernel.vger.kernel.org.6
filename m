Return-Path: <linux-kernel+bounces-437949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8299E9ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39372165A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6C78C9C;
	Mon,  9 Dec 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Yaxhlxyi"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020141.outbound.protection.outlook.com [52.101.191.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47225777
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759322; cv=fail; b=uNtZRTqX3Q7elnxltfotji05VqfHtpWIoPtnM/3rQ29QGOSHDHaQlLPk4JzULTD7r4+A4Px3WYRObv1GyhPV5qbs+dmJx5gD8TblwagP/utA/E4zcoDt+hBI2TG0/KDPrwBUEk+qfZ9lITfoAv5JKP3IV5qPsxlfqreAlAqGE1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759322; c=relaxed/simple;
	bh=IQbXmVUCHz5xhikyS0BCWmpmzwWECs4zLg0XxaUmQkA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lfc+vrncUhg8l3aLpIJk7AbHk7VF7YWFzRsfSWk5gTTRcbT7ML+AzshynhbP5EXyaZnU0GdnUZLXVT3iH69gq7rYeyoxx7c/0XoRXP/3JyuPO0fP7ATZnGoHSYtTkUn1s9meoR/cbEq6cwpTyZwLENyVlf/oTvgQ2kTq3WNOVhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Yaxhlxyi; arc=fail smtp.client-ip=52.101.191.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8zv11qvFebW5CoIgniET6clN6X4oHlcF/iQ6K9u0mDHl4SAf44LaczShMg1lfPIxLhPfBjXIIVuqXO18wINHEr3uuJxb/AyeltkIb7UO7heeZVciQ6lDupw1ihN8qMrCegyaZErn7WFLqi4mM741DlBqo88v21KIKCSypJxs+IfltPynl55Vz/VLt2VyOSsY3gGoLaYjwzFDZFyBG4224vzjFy4vybKJ47hKDezugUWvMqJDKqk3a6jCYq/cSNrA4iouLq8j3qi8m2fR7CcowRBkUVL2GjIYiIcghrB+bEwgku6JgWRrx246p6oHih1KJBZW5YgTeuXKPq7/XopCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHMSJCYuMy8Wute/6L0QHEI/BneV90d2NtbMkH8oTVg=;
 b=OjLVDVc+KihnKimXy16cGi56IDLmOcfLlP5T+aor5c1pNlRJ1otQA/zsnXC35YTKdy+GcTpfFvFVlJAQRv9jza2r8lAt1dlQFwKGijlINnpSq3+nQRPc7dPCY3J74Pqp0cxEj0cj1xZc+PlxaUCbPPOt+X2VSf4iePcSdniUNG/IEt+wqZZE6+yVJ91oX9DuBHeqYu9me+EAcQsD7z4s2UC4RvASd2agAJyCIHfUe96TmvtO02krh954mRuHE/95Bl4HaqvmjkdOiyobD/Mm1wtNRnjPmGG5UA68YINi0jzhSkxp6o3BEKO1vYZA0pmpmsbJ/vd8AFLinPu4chSb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHMSJCYuMy8Wute/6L0QHEI/BneV90d2NtbMkH8oTVg=;
 b=YaxhlxyiMn0dK2fbtfosU5PM0MLTjSp90fbXfGe5808Nyv4exeU5KtFofsvS3BxVv+Ug7j2pAoqL/b0smdHx0CQeCHg/9hsSN8gGetpkzyXH0eaxWvcsS+XWmTVTR64Ad2IpgJISVxpm1PIbLyb7yuZKRmMweYU8iqieJqMafbDdV8DLlY6O1k2gylD0jY78eU28YRQk2cZiAObozfBOdDuPkgtnm/wZvYKTrzsh7nrQGrNoaO41Thvg7P7tlodke5yyS9tzPi0jMMbOoGLdtrJOv0Ybf5U35k3YoJ2cQ08nS9kGJjndvcf5BvEVBuAoDhD81nJ7MSUXN1s7kkURRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPFC1E5F08CC.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::28c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:48:37 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:48:37 +0000
Message-ID: <1f4a8928-8450-48e2-bf40-e75967240d79@efficios.com>
Date: Mon, 9 Dec 2024 10:48:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20241205083110.180134-2-gmonaco@redhat.com>
 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
 <481a7b7716cf4eb2d592b08558d297d343d9aa25.camel@redhat.com>
 <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
Content-Language: en-US
In-Reply-To: <cbc0a3c5-2ae5-439e-ae5d-7fb68ea49aec@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0260.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::34) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPFC1E5F08CC:EE_
X-MS-Office365-Filtering-Correlation-Id: c575de3a-1db2-453a-8422-08dd1868f1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWhRWXN1bHA3K1hpSVcxR1daRFBtc2NDS1RKQ2hhZWZkSDVwRDh1SUU4akdz?=
 =?utf-8?B?N3dzaC8wZHFabXVzNFFHNWRBaE4zbStDSlFLbkh0TERpOGVGSTBtcGpHZEZs?=
 =?utf-8?B?K0pqZ3Y1dFkyd294WEpJTGFmUXJiWTJtdk9zZE1YbjFhdnYvQ2tPV3pEdVZv?=
 =?utf-8?B?ZVJsMExNTTFwWmZnNWpvVWdBOWFyR3FxN3ZMbmxBYnh4d2NoVlF5NE9EOWEz?=
 =?utf-8?B?Z1g0MmtjUVd6MkkxZUJGb0tQZktLWmNQbmJrN2YrcGh0TGRDMkpDa2hacTJD?=
 =?utf-8?B?aUhlNTZVSUIrNVU4aFo2aVZYQVZCS0NjenI0ZExVZjQ1anE1Uy9BVGd0Qm1N?=
 =?utf-8?B?aUFWdnV5UC9Wci9qL3k1MXlmdmQ1c2pPZ0FZSURIOEdNVEQ2b3R3VXkwSk9y?=
 =?utf-8?B?djJLcElkejUySnR1MDcxWi9sZERZM3RuN1V2bGhXeDl5YnI2Snd0NkdDN1VJ?=
 =?utf-8?B?OHBlTXNXWWhJYWNHV2dmeVlvcXkwVnFBSitGSjZjdmFBNVFlOTlBL3Y5Z1Iz?=
 =?utf-8?B?WmZUdnhkU3VtWm5XR2RONDVnKzBoOXpWVGJ4S084Y291ZDI2cVJiRlpZdnJJ?=
 =?utf-8?B?QjRnZThjK2w0a1dzVGxldXNURWV6blhjYjdXWlhMcjdnNWZtWkNoVFdocmZY?=
 =?utf-8?B?cU5tZXFldmJjaUpNSFprZ3RWRWZkQ3M0T09OSnFteHpHRXIzenNSdnR5b0NS?=
 =?utf-8?B?RzAzbkJwV3JzVXlTaWNxdVJOT2ZlcENkbWkzNGxRR1lJalR6bDBUWUlaM2Nz?=
 =?utf-8?B?ejZRdDg0aGMwVlJucUdQclJaWmV4ei9vVEttQTZSUHM3ZFpPa2tINkZ1ZEVr?=
 =?utf-8?B?eVMxWXdjV01DYWZwYTNLOUd6K1R0TUVWWVBUMkVGd09IMmtuWEZyYzFqMnpR?=
 =?utf-8?B?VWROQzgzNTQ5MGxObkVKU1Zjc2xFdGJka2kzT2RsZVZLUVpMek1vS3M2Z2Zh?=
 =?utf-8?B?ZmtTNjZoOHFkWHJNNi9oamZSS2l1ejd2R0xjRDE3a0FnZE83WXRtS241VU5Y?=
 =?utf-8?B?Vm9ROWxZWW16cldESGN5dzhVTHFQYUlSNkNvT0RJNEJ2cUFwcVBBbEV3MWZ6?=
 =?utf-8?B?RVJOOHA4aDRMQ21ESHZvcEZtQnM4cW5DUGlKdTNjQVNRMHdsNjI4MDRCdU1X?=
 =?utf-8?B?dWExMlV1VzA3TWFxNXI0Q1o3U080bnlpRUsxbjNZZDJrOVhpRVZDbEs4UGEx?=
 =?utf-8?B?VzVqNnl6T2NqeElLNTYwcFdhUEdBb3FmK1VMVWVHSU1GQkpNUHY2NUZhYURT?=
 =?utf-8?B?aDRFWE1ET2l0ZlNURkVzd1QyalV0em00a3d6TU9VTDQ5QlRtMG1SQmk4RUs2?=
 =?utf-8?B?dGNPRkpyR1hWcXpqQ21QNXA0dmdjL3pJT2dqK2t6bFQzQXF6YXNlM3l3UUVY?=
 =?utf-8?B?YzRNbFhTZWY3eHZrUFZtM0NpcVFZYkFsSzVDUlNxaXU3WUJvT3NaL05EMHpQ?=
 =?utf-8?B?Vm05QjNYZ1Q1R0hudFpieEVSbm1HbEFxelRvVThPd21uWFZJemVickRFNVlW?=
 =?utf-8?B?VmFBaFVpeENaRzhrY0FIZVdkdTF0WE5NYmF4TUpuWmlzZWNJNWNFODZmM212?=
 =?utf-8?B?ditESFMrWlg1VlpWckxxUkJkY2grNjNpbXplclBXYWM2U1B3aGR4OTBPRTFQ?=
 =?utf-8?B?ZGVLTG5FN3d6eDYvbUJ0OGV5VXcyaExMcEk4Z3RLUnpHQXJUR2E0MGxGM1lp?=
 =?utf-8?B?M09NekpVOGg2VFplU2w5VkhpNXNSSEt0VHVPUldMdkRsM2J1eTVsY2FQQnV2?=
 =?utf-8?Q?Q366wkCoLEWmg8Arb8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGFTZUZ3RGFBQjJOZXpyYis2UVNveFk1Mit4bEJoWkF0cC9NOEV5Y09rb1JO?=
 =?utf-8?B?Z0pQaHFQd3dtMHlybFJLTFRFeUwyWHFmZThjSFpTbW1iUXQ2TlB0UUhkTVBN?=
 =?utf-8?B?OGZseVZMS0ZjZ2hySTVYMU1RVDhjUHVKNWtQVHJvK3UzTDBFN2Zmekg1NkFy?=
 =?utf-8?B?WHMvb3lTT2pSSk5qbU9DTXVGcEhhUHdBcEpYT3ppUzVTcnZoWXEyYm1INGJN?=
 =?utf-8?B?OVpncEovNmorTzBnRXM4UjRUMXRZNXpDU0dURHlZNW1JRXljaG0reGN1aUJt?=
 =?utf-8?B?SkpFYTZXdmZWRmQwT0VIN2IvclA5ZVRSSUxndjRFWHBiMUVGa2Z0TURTa0dT?=
 =?utf-8?B?bmlYNWNFS1UwYVdudWgvd0F3TU5ScklnTEZMRitTOW9ncG5YSVFpbUcreVd1?=
 =?utf-8?B?NU0zZDE0Z0ZWbmFhYjZTVzZ4ODdSNlJnYlRRL3ZQL2phT0ozN1M5S2gxSExN?=
 =?utf-8?B?b3BiYTc2RmlMNlJWdmRLZ0NDRUdOZFpxOFlkaFBaSm9HTnFDSExYeTNFOTFN?=
 =?utf-8?B?MmtBMkF4eitockU2bm5xY1FzaFhMNU83NVRpNGdCMDQ3Zng3ZXN2Z2F1YnhF?=
 =?utf-8?B?UjVkWXBFZlRjZ3hmcDV0anVDZlNkZTlmbVk2RzVuaWJGRTZyZ3hTVDIyWVhS?=
 =?utf-8?B?MjB0aXJtTzlSbndiRzlBZERueTloK0lsSnFBdTNZcGJkU3ZqQzk0QzIzTllK?=
 =?utf-8?B?MVV4Vm9DQmROb0ZrcU1mZTVwcE9yRDl6MHRyQlVpOVlrd0lRWlh4MzVlSHNi?=
 =?utf-8?B?a3k4SUhEL3VOKzNHTkRFb1VLTkRMaW03Q0tuTUxpMXJZU1dyK3pxczd1Qmcy?=
 =?utf-8?B?cTNMMVBZRGl3bFp1MUZLR3RSZGx6dzd1UnNBVDZuWXhBdHE2Zk5VYUoxeUhG?=
 =?utf-8?B?WVczbXdhVmY2bVJCMVkrTzVOS0hWTUFHa05pUXpJTGpyZUEzb2lhM0tKVkxq?=
 =?utf-8?B?UzJiTWJ2M3dCTk40OHRMczJVbld5ZjhJRjRvQ2Y1Ly82c3RESk9OekUxS0dC?=
 =?utf-8?B?aTM0bWlmK20zZHJKcDE2ZGtuVGM1SzQ5MWk1OTVqdUsxVkMrSlNPVXZlR0Vq?=
 =?utf-8?B?UGFnTnpFb1k0N0VibUh2b0VlMmZXQSt0eS84cWVyRVNXRjVmWDg1eitkbjA3?=
 =?utf-8?B?SnZ1M0RpanhSOHRjRzRWZGJ1eS81cnozRFFXMzdTUDZjTjRQa0w5KzA2amVB?=
 =?utf-8?B?RnZkZjVOdElRbjMvcjNBNXFsQzJpaFJ0cWwxS1p6RFRJZ3pGbWtNNEUrQ1k3?=
 =?utf-8?B?SGJ3SFJ2UyswR29FWGh3N1VhY05DU3lMVWZnYTllTDE1WXNVdktWQTlHSkxH?=
 =?utf-8?B?MGFBMWxYcEZQbDJVaHphZVJ4MkRINzBTYU8zVy9jZkptZTdwRFcwZmxIQXg4?=
 =?utf-8?B?QlBtKzJBd0lZemptVkMyN0RSR29raXVpclE5c0dySGd6SUpBcUs0L3ZvMUhZ?=
 =?utf-8?B?eVNiQ3lwRGEzV1hOZjE4aDdNZ2dQZDNtYTdXK0grSVBRZjN1V01kbnhOc3RL?=
 =?utf-8?B?WjlDOGJXRkdWTm1rMXVxWjlnbjNTaU15NDdhU01zeEx0ZC9qRW0zeG01RXc3?=
 =?utf-8?B?amhzR3JXSkU1bFhzZXQ0NTB2YVRDWFFRQ2MwbXdPMk84RE5xenR5MjZSZWtT?=
 =?utf-8?B?Z1cxN3Zqc2ZOV29qb2hyVk1MVTRGTHNZMzhJNFd1Y2JBMVpySGZ4MXhzVzQ0?=
 =?utf-8?B?UzVJdmQzYVgyUUR0SnBkMDA1MlFqV3Q4d0IzRjBLZEVTZHlhWXJ2M1dPR2Na?=
 =?utf-8?B?djFINlI5bmpaODdyK3U0NFdja3czRjRwcVJCdmlIMVc2MUhtNjRscHFwbEpj?=
 =?utf-8?B?VXdqQlAyVU9HbDVBZTBwSDlOcDN3TEVwcWR4VEt2VUw1dC9BbDcrSzhLZWVZ?=
 =?utf-8?B?SzBNTkI0SXM3RDhXY2Z2SEFyOFJVdFlnNkc2UGl0RVlVWlBJTy9rSVZXczgr?=
 =?utf-8?B?UGk5eTNBS2k3YnU1cmdHMGlzeUlSNTNjczdYdTFzdFMwN2x0cis0c3MrWW1C?=
 =?utf-8?B?aWxRT1F1QWZQMUV0NndNMm9XS1lhQ2Mzb2pTMnRSYUpzS0k0bU1YMjFlUHVT?=
 =?utf-8?B?TWd3QWptREFSamNyZlJaM1ZiZ01yM3FvWU9rcDhyMmlBTmJJQkpha0wrYmxx?=
 =?utf-8?B?VjB6WGdENXI3RU9td3ZBVVhnekhiSURUUWF3dTRZejJETlI3TEhodm1IcHRo?=
 =?utf-8?Q?HFZjjTXa39ysb+SV08Mv/ao=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c575de3a-1db2-453a-8422-08dd1868f1d2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:48:37.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrrgcRX4+AEDxBv9nxaWG/nsbKMv0+9v5bpYnyXEncJjiJzbsnDlaFUS5p+yJ6vMMSlNXQySWZe3YhAwN4A7Ch4zzf/AcYq4oPXHUErtZcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFC1E5F08CC

On 2024-12-09 10:33, Mathieu Desnoyers wrote:
> On 2024-12-09 08:45, Gabriele Monaco wrote:
>>
>>> Thinking back on this, you'll want a program that does the following
>>> on a system with N CPUs:
>>>
>>> - Phase 1: run one thread per cpu, pinned on each cpu. Print the
>>>     mm_cid from each thread with the cpu number every second or so.
>>>
>>> - Exit all threads except the main thread, join them from the main
>>>     thread,
>>>
>>> - Phase 2: the program is now single-threaded. We'd expect the
>>>     mm_cid value to converge towards 0 as the periodic task clears
>>>     unused CIDs.
>>>
>>> So I think in phase 2 we can have an actual automated test: If after
>>> an order of magnitude more time than the 100ms delay between periodic
>>> tasks we still observe mm_cid > 0 in phase 2, then something is
>>> wrong.
>>
>> Been thinking about this and came up with a simple draft, I'll probably
>> send it as a separate patch.
>>
>> Doing this can lead to false positives: the main thread may be assigned
>> the mm_cid 0 and keep it till the end, in this scenario the other
>> threads (CPUs) would get different mm_cids and exit, the main thread
>> will still have 0 and pass the test regardless.
>>
>> I have an idea to make it a bit more robust: we can run threads as you
>> described in phase 1, stop all but one (let's say the one running on
>> the last core), make sure the main thread doesn't accidentally run on
>> the same core by pinning to core 0 and wait until we see the 2
>> remaining threads holding 0 and 1, in any order.
>> Besides a special case if we have only 1 available core, this should
>> work fine, sure we could get false positives but it seems to me much
>> less likely.
>>
>> Does it make sense to you?
> 
> A small tweak on your proposed approach: in phase 1, get each thread
> to publish which mm_cid they observe, and select one thread which
> has observed mm_cid > 1 (possibly the largest mm_cid) as the thread
> that will keep running in phase 2 (in addition to the main thread).
> 
> All threads other than the main thread and that selected thread exit
> and are joined before phase 2.
> 
> So you end up in phase 2 with:
> 
> - main (observed any mm_cid)
> - selected thread (observed mm_cid > 1, possibly largest)
> 
> Then after a while, the selected thread should observe a
> mm_cid <= 1.
> 
> This test should be skipped if there are less than 3 CPUs in
> allowed cpumask (sched_getaffinity).

Even better:

For a sched_getaffinity with N cpus:

- If N == 1 -> skip (we cannot validate anything)

Phase 1: create N - 1 pthreads, each pinned to a CPU. main thread
also pinned to a cpu.

Publish the mm_cids observed by each thread, including main thread.

Select a new leader for phase 2: a thread which has observed nonzero
mm_cid. Each other thread including possibly main thread issue
pthread_exit, and the new leader does pthread join on each other.

Then check that the new leader eventually observe mm_cid == 0.

And it works with an allowed cpu mask that has only 2 cpus.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


