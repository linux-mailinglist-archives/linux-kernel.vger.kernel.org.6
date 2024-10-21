Return-Path: <linux-kernel+bounces-374617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE79A6D80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77378B23EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF37FBC2;
	Mon, 21 Oct 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Fq8x3YLT"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82212E7E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522923; cv=fail; b=gUXxLOqbIIl5c4hXkfnrGXb7kziDIn8kQWQqC50XCeYQSfSR92D55rYIkF+vCbrKv5impylQLvNbqis4LacbRP1HRquqfZ/IC9SiULoQyOYoF79Pv4il3yOXXtgfcPGjt6L3rNXOAJS6B3QmgR1CHbiJ93bLfrIc5/KAWKCvsMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522923; c=relaxed/simple;
	bh=KtI5jGWTK4eeD/V/B/y93WQDHFjXWfkOkyxwDreah/k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QuKTVRmpKSB0PV/wDpqPqJXkXDpHG9fi6qBm4FrcyiZj51Y81c90ras9/gZK87YDpsLdJDrmW+j0Gz38qycSK/EgRbBE6kNCU6NS19aIg/oEZVadgHk6KWF6OSjtqpNXtEwHKrvYZzxzd0++fM2YciV4GveBFtfQcg5FDCWCANw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Fq8x3YLT; arc=fail smtp.client-ip=40.107.117.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0ViSyl2VYZ9bAxuzD669k3gDkkAzt6xmAbSdBKlw1Cjl2S8KBzdWGTzYX1vSkGlAw0atHyE6Fi1Z1uwJgx07LRklcdPs9XVRw7Cj9CAJj8Q210hZp6kDmVOS/pSJR2M/Nop94N5ENJkM9WEa1HCdgDQ5FfeV4FWsfmT5ekBP67qq81gkPxN6WnPvjRB16QMujf5KhU7LBuuusWstmzRAvLfiWxj4Rwcs0xnGmZn/uDpMEO7S8RF09qA8ZnmxM78/ZO02gQLkffGotwpHvPmc17E318shqmBsDRCYZnfo8mjp31R7Xh2cbyesuVG7BuKY+VkgWeRbCBAxksx3wHRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yZph8s2DqgdvTLVf9gGZMCCb11Ka1XpO7BN5hcucco=;
 b=RkYBhlTPOArmz62RzGwQgCfS/+OhQFFLct4vEJ0FVyE79UAplTfwAaCdR+CKiEev2QN3yh8ZK0WoXOHhk9LdHUf2DKYOOxrysor/jNlJDyUqrOoQlpehuD4weJQf3u17Nsb5cnhES2Y8hWVvPlgZJqfUMXHydUUy0iSer4CxcM69RakjCSh2I8IHKRSH9u0kGRrMYz5qvKQxh3+9WMMuFn0qnloZFtteJQgBxJvSKvzhw94HT0+IjhuGoYQFrQhFwHMazNGqnN8pbF2FzIraxWbQ07bSB3OYYk8ju6y5Fyjf2TLHIJceA/aQI8MjIT4UAjsP0RYg7SMqKIrfsk4B1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yZph8s2DqgdvTLVf9gGZMCCb11Ka1XpO7BN5hcucco=;
 b=Fq8x3YLTBhXLj/lXUpwPg73j04fTIcPB7+LCpUn3guh0vBwLfwfESdhox2aLw5hqiruUnQme23K47+Bu1JIDOOxB7XCl5f+6+Cdkd23xuGOZdUKtygHfUtJ+bLAYYeICoZrB+jE8w4njHqKS1aB6oZRN4sknlsGgRjvIOAH5acFCjcBX5UhEqLOd3lSu6cBeG/aPz790lMXjKnTy6RQ7T8jwpjpCuXrTo2up3euwhwbAEVvUU/yQHSaO9coX43fEShIba+O9QAJO8LyCbz9vdbwNv06P68XdmI96/qeACaYJMuoLkD+NT99IoPJPKrqMiVpuQiTSdsC5ZHkQTUyPSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SI2PR06MB5161.apcprd06.prod.outlook.com
 (2603:1096:4:1ac::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8; Mon, 21 Oct
 2024 15:01:50 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%6]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 15:01:50 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	angus.chen@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH] tools: arm64: add registers read/write tool for arm64
Date: Mon, 21 Oct 2024 23:01:12 +0800
Message-Id: <20241021150112.1194-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|SI2PR06MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 69090dc7-19cc-404d-4f85-08dcf1e14a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1k2U3c5elB6VU1jMzJ0NTkvb3cxNEZpK0o0Qjl4eTRPQVl0cEtmZ094RUlW?=
 =?utf-8?B?RXltUTRpMjREZlQ2M1RQK2RadzlSbW9OL2d5U3JLcGNzUnRRTjAxMGdVbDF3?=
 =?utf-8?B?M1YrdXZIc3Z1SStSL1hZK1dDcjc1S1dHTkFmYXpDb3R4NSswTDl1S2pHczJq?=
 =?utf-8?B?eVlDTGJpRFBVcXdjN1pVQ2lZQzNLaHJEdTRUUGhNMTVuSmFxVDBsQ1BlT1VK?=
 =?utf-8?B?VFV3UU12YmErYTBpdDBZcldPUHFnUXlheHpScHZPaXAxUDR6ZTZyNUFFenNi?=
 =?utf-8?B?aUt6RUtLNUZMYm9kbXNRNjlvTURtcDRlKy9EK1EwNHIwS0ZwZ0xnQ0ZCQll0?=
 =?utf-8?B?OWZuMUgrS1JxOGFTRTFFUTBMWGdBd2pYcXRIV1hqR3JuK3l3YUNNL0RzYjhY?=
 =?utf-8?B?WmRobi8xbGFNeGY1SzcrTDR3a1pXdUdRejVpb3dNL3ppMXo0TUR1TmtGcm9F?=
 =?utf-8?B?KzE0ZEFvMG9ETXZzMUN4YXRIbm1YQXBWalR0c3NKMXBCSWJhYjdtb2pEMHhq?=
 =?utf-8?B?ZFdSVE1Rc25yYzhUK0NRY0xRRTV0M1EvVEdIVDA4S2JKQ1hFM3liRFlBb2tQ?=
 =?utf-8?B?K0ZUQ3c5T3lMb1VOa09yMjN2eWhjOFNBVWJ3ZlNxaDJNQ0psR3h1eC9JUnBx?=
 =?utf-8?B?QU5lOE1rYTFIaERTRWlPWWM5aWQ1dmRpM25OUEw1VlVPcGR2NGc1U3FNUEdK?=
 =?utf-8?B?WlFpeTdFZlA2eGRuSjA5eDV0V3RabkxaQ3lsczNITFFLQVlJYy9NK3Znc25E?=
 =?utf-8?B?dDBHQXBubGpQenJSTXFEdUM5L2I4R2VKRXlLSEtZUlJHZFlzM2JyZUFwTlFO?=
 =?utf-8?B?ZFJHd0xwWTdGekFQQWV4S01xWEJ0WSt3VG1wVWhCbTcrVDZRVFhHTzNFd1lI?=
 =?utf-8?B?bFQ3NWNLeUNtUmNjRjZtZEs1eUR1eWRtUHE2UHBVcldNclN3MTR4ejFHQ3hS?=
 =?utf-8?B?STgwMkxDNUpyQ2VPbk8vcllObjdsL0FPa0VYSm00MEpWRmhLMXpuTDhTb1JP?=
 =?utf-8?B?MXNkeWtxUEdjVUdFMzBrSyt3dTl4RkRhYUlIT0g5SUMwODdxQWlwOFlPLzlQ?=
 =?utf-8?B?Q0VpRmlsNjFJS3NuOWxJWDlSQ2c3bDh6aXhqdEhFbEw4S2RkUGx5UDFjYjNQ?=
 =?utf-8?B?c0pKTWRZVWlvWWZ3cHdUeGR0NGtkN2I2VFpLNjdURkVIUFdyaXZWaHhxOUVN?=
 =?utf-8?B?S2FLUU9IbVplMG43QWt0Qld1MzhmWHEyTVg1Q3VaT1BySnJuRzM0OEJISUhw?=
 =?utf-8?B?SE5KbE5jS3JGTGtLdVZ4NWlmdWdGZEpsTThRTHh5c3RxTE9kcG1PUk94aHlV?=
 =?utf-8?B?YlNVSGExOURlcHJ4bTAvSndjVzZwWFJGemdDcDV3M014VGtiVEIrTHFzNGZZ?=
 =?utf-8?B?OWpTSGVNRDNRZ0dacWVTZWMzNHdZRVhWMWNkUk42NThlK0pWczhTR2xnMisw?=
 =?utf-8?B?ZXRUT3FVY0wyTWNBL2xkdlEvOVhBemtYTlE1RW9USWhvb0tKdkI3cWhyZ3Fp?=
 =?utf-8?B?MHg0VEYxdzR5enlkT05DWWgrVWthd0I5eTl0OEVlUk1TZ0V5OG1hajFrbDEz?=
 =?utf-8?B?L3h6UDRiR3MxVkxZSzFpbDJqNHJhcEFJelc1Y2VaWFBMRjhnRGxPZFl0WGVr?=
 =?utf-8?B?ZFF6Um1TN2dWVHN0d3RMRVpCaWdicDZvZGo0Q0dyMi80d0I0U1RpaGZGSVk4?=
 =?utf-8?B?aTNUZGdUZ3FSbVRRd1h1TW1vVVVLZ2xJTHhHcWtKSFhDY0hZMGlQN3paMEdj?=
 =?utf-8?B?T0ordWV4RUpMOG9TaXYzZExNTVhoeHE1aExIOG5PalIxbUZoZkQ3YnRUcGox?=
 =?utf-8?Q?ShfshZ8jlFRo8asSeCK+SBoUxJDgxxRAVPPRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWduaGoyZlhyZE1YVDh6Y25zUmxXcmNVWk1ZR1orTVNjblBzS1JldnlSWG9r?=
 =?utf-8?B?TnFBMGFBVDhUMjd2dTVpWURQaCtrdkREWldpUlljNWZObDJaNUd2aHNYQXdn?=
 =?utf-8?B?K09IY0hESEJnR1QrRzBOWFNwOCtSSHFCQXVKRkg4dS9KVnUxNVNaNk1LL1RX?=
 =?utf-8?B?RTVhNklMZVY5YkVTc2xhWW1zUnNkTWdNbjhaaks3RlFwU2lUaW5BZ2lZNDZK?=
 =?utf-8?B?QnMvRzczWjZFNnIxc2dScDFTeFUra1dtcWZ6ckNOMUh3cW9WN216WENaM1V6?=
 =?utf-8?B?bzhhTTdXeFZ4VFJleGtLV1d2bFdROGE2aXNTcnNtR0EwcU0rN1VyaTBianRK?=
 =?utf-8?B?eEcyWFJuK0ZBY0VTS0FCcG5QUFhsMnVGeWU2TUphN1BVKy9YUll6Vi9EZlpU?=
 =?utf-8?B?MXNFbmFZRmg4cytXdU5kRmxHb3I3d3NWdDhxRllMV3pyVGtiVjczZFRuZjdU?=
 =?utf-8?B?VTllb0c0VkY0TzdndjZLRHBPemZ6ZklRakNIaWtVbFRpL0lJWVYvdHQxWDc4?=
 =?utf-8?B?YWhIS3FDTnBnSFpJWnZCQXRkVmo1YkcrazRNelMza3BBWm42eWhSc1hXNTdG?=
 =?utf-8?B?cUN1Vm1NZENLNkRPdEkzM1RlRTdLZDdTbGVibUhHYnZtYms2S1RHajYxYmhT?=
 =?utf-8?B?TGk2MXRabUtSU1hHdHh5Q1h0T3hsTklsQ2trSmltSW95M29PK0xjdW9WY29R?=
 =?utf-8?B?cHhMWmFDV290YmxXWS91S0U4RzVmZS9OMGJoZW41Q0JDL2ZwR0ZXWXB5VXIz?=
 =?utf-8?B?bmdFd1NvVDVFbnkrZEh0T0tRWTF5YXdkZmlxYU9qSHpQRThwcXFNNHJHMFQ5?=
 =?utf-8?B?UTB1OVA0WElhdWFJcUY3d0JCYWJSZ1ZGUGdYTFZxQTRtVmdvU3gva2VvSWZG?=
 =?utf-8?B?QmJEQ3JsVXgwL1hONDNPU0dLNU4zK0hQTkltempLYU1hMldRM1FNQ0szdkJo?=
 =?utf-8?B?WmtNQVhoV0UwQTd6RUkyQVZhaHdjdDRoc1dXNm10NEcxTVoxbk1mcGV4Sjhx?=
 =?utf-8?B?bk1sbzY0UTRnMm13SGE0V1FRTkw4RjRPbHdNdkRnMWlEVDJBeDhsTzRLZXVz?=
 =?utf-8?B?NG5oTlJTMVBaSHBwbGxVaHIxTkFhdFdKbzg4eHRJTXd1NGh5WUxnaW9ValF2?=
 =?utf-8?B?aUpIVS9NSHpPS0RQMXdVK01ZV1RkVmQvV2RkVDZ0Mkl4SlE4ZDZzSG9DSTFx?=
 =?utf-8?B?c25rUHZyYktxL1hvZ2VxOW56LzFqd2NZVlIyWG90bFVzaDM1Yy9VYlFFVzBS?=
 =?utf-8?B?RWJrNTc3UVJXMDIwQXN4ZHF3cVkvRHVUYlhSSm1adElycm5hUnNGMnplUCsx?=
 =?utf-8?B?WUwweVd2ZzlvRkIxNnBUT3pZR2oyd3lLV0xqanBVakxEb0k3UVlSQWM4RGNC?=
 =?utf-8?B?dlc1NkY3cWo2bDEwTmxSMVFhalpueFk3a3dyeHI2UU40TVhJTlMwZEpUSk5G?=
 =?utf-8?B?TzRMS1pJNTlnL2drTFFJNFo3T2Y4ajRTWDFabWtmWGUySm5JUitEb3YzNW1L?=
 =?utf-8?B?YUhSV285c2Zmc2FWT0ZGcmdzcHpUOHRQOTY2SHpOUVdZbWYxZ2ZYRXhWa0Nw?=
 =?utf-8?B?OXh5SHNWbVQyUnZseUVtTUJtRzFndmt0ZDVIUFhuZWoyOVhDeVlMVkx0TUF1?=
 =?utf-8?B?c0JJSG0zTElNZFp3V3kyYVF6R0xpRFBYd1lxdWpxUXRoMkNnb0RFRUpRMVgx?=
 =?utf-8?B?eTJzOW9mcVpoRitWbGtHWjZCTnFKSGEzNFVtQlBvNUsxUnhaY3Uxc0VwT1Jr?=
 =?utf-8?B?Z3Zub1pKc0xXamgyQVRoR1RSWVlQQnQ1MjkxWGtDMllnaVVoV2ZQbFU5YS9D?=
 =?utf-8?B?aEhqeFVOSm50WlZsdlNyNEE0THVwVDhyOCtaVkhMMUZGcG81eVg4TS84Zm9C?=
 =?utf-8?B?eE1RT1lGQXJlb2RTYzY4amdSUkpIMHhJNC8rSXZWWE94WklSQ2tGa0c1Um40?=
 =?utf-8?B?cTJwRzJZZGhtUVJHM29zZW9maDI0MWxzVEppdTE0YWlod3g1S2taVllsU2Z5?=
 =?utf-8?B?NUZMTzlyR1p3Z3l2WEZUWjVKQVBLN1FOWTRHTnZSSXhNVUlJWHdYTFhnRWhE?=
 =?utf-8?B?MVBoelJsalN2MktaOEEyOHRIaDB4NitBbmp2VWxmc2NBaStaQzFwekpSWktX?=
 =?utf-8?B?cjkvaUpkdXJCUHZrUm1mZll0VEh0RjUrazBSMWN3azROamNVN2p6bTk0NGtJ?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69090dc7-19cc-404d-4f85-08dcf1e14a75
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:01:50.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkgSA1hHLRqYVlPVpoeiel4M6nC1XLdh5JrkfwgSbmjMHv6ZYY1RzHZxS4T2LzmkpckQmyvSmNVk8KulJeAK1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5161

The reg_ctrl kernel module can read/write most aarch64 system registers,
including EL0/1/2/3, which is very useful when hardware debuger (such
as ArmDS5/trace32) is unusable.

The primary implementation of the reg_ctrl module is as follows:
1. when the core can directly access the target register, it uses
   the MRS/MSR instructions to read/write register.
2. Otherwise, it performs an SMC call to switch to EL3, where the
   register read/write is completed and then return to kernel mode.
   I implement an OEM Service in ATF to access register at EL3,
   using one SMC function ID for reading and another for writing registers.

test steps on my platform with 16x Arm Neoverse N2:
1. insmod reg_ctrl.ko
2. cd /sys/kernel/reg_ctrl/system/
3. view the directory tree on DUT.
[root@localhost system]# tree
.
├── control
│   └── VNCR_EL2
├── id
│   ├── CCSIDR_EL1
│   ├── CLIDR_EL1
│   ├── CSSELR_EL1
│   ├── CTR_EL0
│   ├── DCZID_EL0
│   ├── ID_AA64AFR0_EL1
│   ├── ID_AA64AFR1_EL1
│   ├── ID_AA64DFR0_EL1
│   ├── ID_AA64DFR1_EL1
│   ├── ID_AA64ISAR0_EL1
│   ├── ID_AA64ISAR1_EL1
│   ├── ID_AA64MMFR0_EL1
│   ├── ID_AA64MMFR1_EL1
│   ├── ID_AA64PFR0_EL1
│   └── ID_AA64PFR1_EL1
├── implementation_defined
│   ├── IMP_CPUACTLR_EL3
│   ├── IMP_CPUECTLR_EL1
│   ├── IMP_CPUPPMCR2_EL3
│   ├── IMP_CPUPPMCR4_EL3
│   ├── IMP_CPUPPMCR5_EL3
│   ├── IMP_CPUPPMCR6_EL3
│   └── IMP_CPUPPMCR_EL3
└── reset
    └── RMR_EL3

4. read EL1 register on core 0:
[root@localhost system]# taskset -c 0 cat id/ID_AA64PFR0_EL1
0x1201111123111112

5. read EL3 register on core 1:
[root@localhost system]# taskset -c 1 cat implementation_defined/IMP_CPUPPMCR4_EL3
0x2000315a10000045

6. set bit 1 of IMP_CPUPPMCR4_EL3 regiter on core 1:
[root@localhost system]# taskset -c 1 echo 0x2000315a10000047 > implementation_defined/IMP_CPUPPMCR4_EL3

7. check if bit 1 is set:
[root@localhost system]# taskset -c 1 cat implementation_defined/IMP_CPUPPMCR4_EL3
0x2000315a10000047

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 tools/arch/arm64/tools/reg_ctrl/Makefile      |   8 +
 tools/arch/arm64/tools/reg_ctrl/reg_ctrl.c    | 247 ++++++++++++++++++
 tools/arch/arm64/tools/reg_ctrl/reg_ctrl.h    |  98 +++++++
 tools/arch/arm64/tools/reg_ctrl/sysreg.h      |  20 ++
 tools/arch/arm64/tools/reg_ctrl/testme.sh     |  17 ++
 .../arm64/tools/reg_ctrl/testme_all_cpu.sh    |  15 ++
 6 files changed, 405 insertions(+)
 create mode 100644 tools/arch/arm64/tools/reg_ctrl/Makefile
 create mode 100644 tools/arch/arm64/tools/reg_ctrl/reg_ctrl.c
 create mode 100644 tools/arch/arm64/tools/reg_ctrl/reg_ctrl.h
 create mode 100644 tools/arch/arm64/tools/reg_ctrl/sysreg.h
 create mode 100644 tools/arch/arm64/tools/reg_ctrl/testme.sh
 create mode 100644 tools/arch/arm64/tools/reg_ctrl/testme_all_cpu.sh

diff --git a/tools/arch/arm64/tools/reg_ctrl/Makefile b/tools/arch/arm64/tools/reg_ctrl/Makefile
new file mode 100644
index 000000000000..a7ac0e6a013c
--- /dev/null
+++ b/tools/arch/arm64/tools/reg_ctrl/Makefile
@@ -0,0 +1,8 @@
+obj-m += reg_ctrl.o
+
+all:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
+
+clean:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
+
diff --git a/tools/arch/arm64/tools/reg_ctrl/reg_ctrl.c b/tools/arch/arm64/tools/reg_ctrl/reg_ctrl.c
new file mode 100644
index 000000000000..70984800ef08
--- /dev/null
+++ b/tools/arch/arm64/tools/reg_ctrl/reg_ctrl.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <asm/sysreg.h>
+#include <linux/string.h>
+
+#include "reg_ctrl.h"
+#include "sysreg.h"
+
+#define SMCCC_OEM_REG_CTRL_READ_REG 0xC3000002
+#define SMCCC_OEM_REG_CTRL_WRITE_REG 0xC3000003
+
+static struct kobject *reg_kobj;
+static struct kobject *system_kobj;
+
+static ssize_t reg_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf);
+
+static ssize_t reg_store(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count);
+
+FUNC_SYSREG_S_RW(VNCR_EL2, SYS_VNCR_EL2);
+
+FUNC_SYSREG_S_RO(CCSIDR_EL1, SYS_CCSIDR_EL1);
+FUNC_SYSREG_S_RO(CLIDR_EL1, SYS_CLIDR_EL1);
+FUNC_SYSREG_S_RO(CSSELR_EL1, SYS_CSSELR_EL1);
+FUNC_SYSREG_S_RO(CTR_EL0, SYS_CTR_EL0);
+FUNC_SYSREG_S_RO(DCZID_EL0, SYS_DCZID_EL0);
+FUNC_SYSREG_S_RO(ID_AA64AFR0_EL1, SYS_ID_AA64AFR0_EL1);
+FUNC_SYSREG_S_RO(ID_AA64AFR1_EL1, SYS_ID_AA64AFR1_EL1);
+FUNC_SYSREG_S_RO(ID_AA64DFR0_EL1, SYS_ID_AA64DFR0_EL1);
+FUNC_SYSREG_S_RO(ID_AA64DFR1_EL1, SYS_ID_AA64DFR1_EL1);
+FUNC_SYSREG_S_RO(ID_AA64ISAR0_EL1, SYS_ID_AA64ISAR0_EL1);
+FUNC_SYSREG_S_RO(ID_AA64ISAR1_EL1, SYS_ID_AA64ISAR1_EL1);
+FUNC_SYSREG_S_RO(ID_AA64MMFR0_EL1, SYS_ID_AA64MMFR0_EL1);
+FUNC_SYSREG_S_RO(ID_AA64MMFR1_EL1, SYS_ID_AA64MMFR1_EL1);
+FUNC_SYSREG_S_RO(ID_AA64PFR0_EL1, SYS_ID_AA64PFR0_EL1);
+FUNC_SYSREG_S_RO(ID_AA64PFR1_EL1, SYS_ID_AA64PFR1_EL1);
+
+FUNC_SYSREG_SMC_RW(RMR_EL3, SYS_RMR_EL3);
+
+FUNC_SYSREG_S_RW(IMP_CPUECTLR_EL1, SYS_IMP_CPUECTLR_EL1);
+FUNC_SYSREG_SMC_RW(IMP_CPUACTLR_EL3, SYS_IMP_CPUACTLR_EL3);
+FUNC_SYSREG_SMC_RW(IMP_CPUPPMCR_EL3, SYS_IMP_CPUPPMCR_EL3);
+FUNC_SYSREG_SMC_RW(IMP_CPUPPMCR2_EL3, SYS_IMP_CPUPPMCR2_EL3);
+FUNC_SYSREG_SMC_RW(IMP_CPUPPMCR4_EL3, SYS_IMP_CPUPPMCR4_EL3);
+FUNC_SYSREG_SMC_RW(IMP_CPUPPMCR5_EL3, SYS_IMP_CPUPPMCR5_EL3);
+FUNC_SYSREG_SMC_RW(IMP_CPUPPMCR6_EL3, SYS_IMP_CPUPPMCR6_EL3);
+
+// System registers
+static struct reg_desc system_regs[] = {
+	/* CONTROL */
+	REG_DESC_SYSREG_S_RW(VNCR_EL2),
+
+	/* ID */
+	REG_DESC_SYSREG_S_RO(CCSIDR_EL1),
+	REG_DESC_SYSREG_S_RO(CLIDR_EL1),
+	REG_DESC_SYSREG_S_RO(CSSELR_EL1),
+	REG_DESC_SYSREG_S_RO(CTR_EL0),
+	REG_DESC_SYSREG_S_RO(DCZID_EL0),
+	REG_DESC_SYSREG_S_RO(ID_AA64AFR0_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64AFR1_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64DFR0_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64DFR1_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64ISAR0_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64ISAR1_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64MMFR0_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64MMFR1_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64PFR0_EL1),
+	REG_DESC_SYSREG_S_RO(ID_AA64PFR1_EL1),
+
+	/* reset */
+	REG_DESC_SYSREG_SMC_RW(RMR_EL3),
+
+	/* implementation defined */
+	REG_DESC_SYSREG_S_RW(IMP_CPUECTLR_EL1),
+	REG_DESC_SYSREG_SMC_RW(IMP_CPUACTLR_EL3),
+	REG_DESC_SYSREG_SMC_RW(IMP_CPUPPMCR_EL3),
+	REG_DESC_SYSREG_SMC_RW(IMP_CPUPPMCR2_EL3),
+	REG_DESC_SYSREG_SMC_RW(IMP_CPUPPMCR4_EL3),
+	REG_DESC_SYSREG_SMC_RW(IMP_CPUPPMCR5_EL3),
+	REG_DESC_SYSREG_SMC_RW(IMP_CPUPPMCR6_EL3),
+};
+
+static struct attribute *id_attrs[] = {
+	REG_CTRL_ATTR_RO(CCSIDR_EL1, reg_show),
+	REG_CTRL_ATTR_RO(CLIDR_EL1, reg_show),
+	REG_CTRL_ATTR_RO(CSSELR_EL1, reg_show),
+	REG_CTRL_ATTR_RO(CTR_EL0, reg_show),
+	REG_CTRL_ATTR_RO(DCZID_EL0, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64AFR0_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64AFR1_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64DFR0_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64DFR1_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64ISAR0_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64ISAR1_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64MMFR0_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64MMFR1_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64PFR0_EL1, reg_show),
+	REG_CTRL_ATTR_RO(ID_AA64PFR1_EL1, reg_show),
+	NULL,
+};
+
+static struct attribute_group id_attr_group = {
+	.attrs = id_attrs,
+	.name = "id"
+};
+
+static struct attribute *control_attrs[] = {
+	REG_CTRL_ATTR_RW(VNCR_EL2, reg_show, reg_store),
+	NULL,
+};
+
+static struct attribute_group control_attr_group = {
+	.attrs = control_attrs,
+	.name = "control"
+};
+
+static struct attribute *reset_attrs[] = {
+	REG_CTRL_ATTR_RW(RMR_EL3, reg_show, reg_store),
+	NULL,
+};
+
+static struct attribute_group reset_attr_group = {
+	.attrs = reset_attrs,
+	.name = "reset"
+};
+
+static struct attribute *implementation_defined_attrs[] = {
+	REG_CTRL_ATTR_RW(IMP_CPUECTLR_EL1, reg_show, reg_store),
+	REG_CTRL_ATTR_RW(IMP_CPUACTLR_EL3, reg_show, reg_store),
+	REG_CTRL_ATTR_RW(IMP_CPUPPMCR_EL3, reg_show, reg_store),
+	REG_CTRL_ATTR_RW(IMP_CPUPPMCR2_EL3, reg_show, reg_store),
+	REG_CTRL_ATTR_RW(IMP_CPUPPMCR4_EL3, reg_show, reg_store),
+	REG_CTRL_ATTR_RW(IMP_CPUPPMCR5_EL3, reg_show, reg_store),
+	REG_CTRL_ATTR_RW(IMP_CPUPPMCR6_EL3, reg_show, reg_store),
+	NULL,
+};
+
+static struct attribute_group implementation_defined_attr_group = {
+	.attrs = implementation_defined_attrs,
+	.name = "implementation_defined"
+};
+
+static const struct attribute_group *system_attr_groups[] = {
+	&id_attr_group,
+	&control_attr_group,
+	&reset_attr_group,
+	&implementation_defined_attr_group,
+	NULL,
+};
+
+static struct reg_desc *get_reg_desc(const char *group, const char *name)
+{
+	struct reg_desc *regs = NULL;
+	int size = 0, i;
+
+	if (strcmp(group, "system") == 0) {
+		regs = system_regs;
+		size = ARRAY_SIZE(system_regs);
+	}
+
+	if (regs) {
+		for (i = 0; i < size; i++) {
+			if (strcmp(name, regs[i].name) == 0)
+				return &regs[i];
+		}
+	}
+
+	return NULL;
+}
+
+static ssize_t reg_show(struct kobject *kobj, struct kobj_attribute *attr,
+	char *buf)
+{
+	struct reg_desc *reg = NULL;
+
+	reg = get_reg_desc(kobject_name(kobj), attr->attr.name);
+
+	if (reg && reg->read != NULL)
+		return sprintf(buf, "0x%llx\n", reg->read());
+
+	return -EINVAL;
+}
+
+static ssize_t reg_store(struct kobject *kobj, struct kobj_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct reg_desc *reg = NULL;
+	u64 val;
+
+	reg = get_reg_desc(kobject_name(kobj), attr->attr.name);
+
+	if (reg && reg->write != NULL && !kstrtoull(buf, 0, &val)) {
+		reg->write(val);
+		return count;
+	}
+	return -EINVAL;
+}
+
+static int __init reg_init(void)
+{
+	int retval = -1;
+
+	reg_kobj = kobject_create_and_add("reg_ctrl", kernel_kobj);
+	if (!reg_kobj)
+		return -ENOMEM;
+
+	system_kobj = kobject_create_and_add("system", reg_kobj);
+	if (!system_kobj)
+		goto fail_system;
+
+	retval = sysfs_create_groups(system_kobj, system_attr_groups);
+	if (retval)
+		goto fail_system_attr_groups;
+
+	return 0;
+
+fail_system_attr_groups:
+	if (system_kobj)
+		kobject_put(system_kobj);
+fail_system:
+	if (reg_kobj)
+		kobject_put(reg_kobj);
+	return retval;
+}
+
+static void __exit reg_exit(void)
+{
+	if (system_kobj) {
+		sysfs_remove_groups(system_kobj, system_attr_groups);
+		kobject_put(system_kobj);
+	}
+
+	if (reg_kobj)
+		kobject_put(reg_kobj);
+}
+
+module_init(reg_init);
+module_exit(reg_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("jaguarmicro");
+MODULE_DESCRIPTION("reg_ctrl is a tool to read/write ARM64 system registers");
diff --git a/tools/arch/arm64/tools/reg_ctrl/reg_ctrl.h b/tools/arch/arm64/tools/reg_ctrl/reg_ctrl.h
new file mode 100644
index 000000000000..f6f96cf5d4af
--- /dev/null
+++ b/tools/arch/arm64/tools/reg_ctrl/reg_ctrl.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __REG_CTRL_H
+#define __REG_CTRL_H
+#include <linux/arm-smccc.h>
+
+#define MAX_REG_NAME_LEN	32
+
+struct reg_desc {
+	char name[MAX_REG_NAME_LEN];
+	u64 (*read)(void);
+	void (*write)(u64 val);
+};
+
+#define _REG_DESC_SYSREG(nm, rd, wr)					\
+	{								\
+		.name = __stringify(nm),				\
+		.read = rd,						\
+		.write = wr,						\
+	}
+
+#define REG_DESC_SYSREG_RW(nm)						\
+	_REG_DESC_SYSREG(nm, sysreg_read_##nm, sysreg_write_##nm)
+
+#define REG_DESC_SYSREG_RO(nm)						\
+	_REG_DESC_SYSREG(nm, sysreg_read_##nm, NULL)
+
+#define REG_DESC_SYSREG_S_RW(nm)					\
+	_REG_DESC_SYSREG(nm, sysreg_read_s_##nm, sysreg_write_s_##nm)
+
+#define REG_DESC_SYSREG_S_RO(nm)					\
+	_REG_DESC_SYSREG(nm, sysreg_read_s_##nm, NULL)
+
+#define REG_DESC_SYSREG_SMC_RW(nm)					\
+	_REG_DESC_SYSREG(nm, sysreg_smc_read_##nm, sysreg_smc_write_##nm)
+
+#define REG_DESC_SYSREG_SMC_RO(nm)					\
+	_REG_DESC_SYSREG(nm, sysreg_smc_read_##nm, NULL)
+
+
+#define FUNC_SYSREG_RW(nm)						\
+static u64 sysreg_read_##nm(void)					\
+{									\
+	return read_sysreg(nm);						\
+}									\
+static void sysreg_write_##nm(u64 val)					\
+{									\
+	write_sysreg(val, nm);						\
+}
+
+#define FUNC_SYSREG_RO(nm)						\
+static u64 sysreg_read_##nm(void)					\
+{									\
+	return read_sysreg(nm);						\
+}
+
+#define FUNC_SYSREG_S_RW(nm, sys)					\
+static u64 sysreg_read_s_##nm(void)					\
+{									\
+	return read_sysreg_s(sys);					\
+}									\
+static void sysreg_write_s_##nm(u64 val)				\
+{									\
+	write_sysreg_s(val, sys);					\
+}
+
+#define FUNC_SYSREG_S_RO(nm, sys)					\
+static u64 sysreg_read_s_##nm(void)					\
+{									\
+	return read_sysreg_s(sys);					\
+}
+
+#define FUNC_SYSREG_SMC_RW(nm, reg)					\
+static u64 sysreg_smc_read_##nm(void)					\
+{									\
+	struct arm_smccc_res res;					\
+	arm_smccc_smc(SMCCC_OEM_REG_CTRL_READ_REG, reg,			\
+			0, 0, 0, 0, 0, 0, &res);			\
+	return res.a0;							\
+}									\
+static void sysreg_smc_write_##nm(u64 val)				\
+{									\
+	struct arm_smccc_res res;					\
+	arm_smccc_smc(SMCCC_OEM_REG_CTRL_WRITE_REG, val, reg,		\
+			0, 0, 0, 0, 0, &res);				\
+}
+
+
+#define _REG_CTRL_ATTR(name, mode, show, store)				\
+	(&((struct kobj_attribute) __ATTR(name, mode, show, store)).attr)
+
+#define REG_CTRL_ATTR_RW(name, show, store)				\
+	_REG_CTRL_ATTR(name, 0664, show, store)
+
+#define REG_CTRL_ATTR_RO(name, show)					\
+	_REG_CTRL_ATTR(name, 0444, show, NULL)
+
+
+#endif /* __REG_CTRL_H */
diff --git a/tools/arch/arm64/tools/reg_ctrl/sysreg.h b/tools/arch/arm64/tools/reg_ctrl/sysreg.h
new file mode 100644
index 000000000000..4d93eedb6b7a
--- /dev/null
+++ b/tools/arch/arm64/tools/reg_ctrl/sysreg.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LOCAL_SYSREG_H_
+#define __LOCAL_SYSREG_H_
+#include <asm/sysreg.h>
+
+#ifndef SYS_RMR_EL3
+#define SYS_RMR_EL3			sys_reg(3, 6, 12, 0, 2)
+#endif
+
+#define SYS_IMP_CPUECTLR_EL1		sys_reg(3, 0, 15, 1, 4)
+#define SYS_IMP_CPUACTLR_EL3		sys_reg(3, 6, 15, 4, 0)
+#define SYS_IMP_CPUPPMCR_EL3		sys_reg(3, 6, 15, 2, 0)
+#define SYS_IMP_CPUPPMCR2_EL3		sys_reg(3, 6, 15, 2, 1)
+#define SYS_IMP_CPUPPMCR4_EL3		sys_reg(3, 6, 15, 2, 4)
+#define SYS_IMP_CPUPPMCR5_EL3		sys_reg(3, 6, 15, 2, 5)
+#define SYS_IMP_CPUPPMCR6_EL3		sys_reg(3, 6, 15, 2, 6)
+
+#define SYS_VNCR_EL2			sys_reg(3, 4, 2, 2, 0)
+
+#endif
diff --git a/tools/arch/arm64/tools/reg_ctrl/testme.sh b/tools/arch/arm64/tools/reg_ctrl/testme.sh
new file mode 100644
index 000000000000..92a6f79ee866
--- /dev/null
+++ b/tools/arch/arm64/tools/reg_ctrl/testme.sh
@@ -0,0 +1,17 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+rmmod reg_ctrl.ko
+insmod reg_ctrl.ko
+
+echo "start test read, expect values:"
+echo "
+0x0
+0x4000240340543001
+0x0
+0x2000315a10000045
+0x7000336f
+0x15401480136
+0x70300
+"
+cat /sys/kernel/reg_ctrl/system/implementation_defined/IMP_CPU*
+
diff --git a/tools/arch/arm64/tools/reg_ctrl/testme_all_cpu.sh b/tools/arch/arm64/tools/reg_ctrl/testme_all_cpu.sh
new file mode 100644
index 000000000000..7000508adeeb
--- /dev/null
+++ b/tools/arch/arm64/tools/reg_ctrl/testme_all_cpu.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+rmmod reg_ctrl.ko
+insmod reg_ctrl.ko
+NR_CORES=16
+
+i=0
+while [ $i -lt $NR_CORES ]
+do
+	echo "run on core: $i"
+	taskset -c $i cat /sys/kernel/reg_ctrl/system/control/VNCR_EL2
+	let "i=i+1"
+	echo ""
+done
-- 
2.17.1


