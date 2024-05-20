Return-Path: <linux-kernel+bounces-184168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4B8CA379
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C102810A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846B613A271;
	Mon, 20 May 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebqTPVEJ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F291139CFA;
	Mon, 20 May 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237716; cv=fail; b=Jbt5sKMXHsX9iv+zTb7D1JxfgI+wry+VAyS7SPh2h8/5Gav7trVPpS4T6WsK3KqSP1T0RIn7lLFKcWI6KsEygzl4d8P9S6RBoZEEDfbpqSMLOrm0taEX6zFfI6JCRYyzrgx2FwzSPBTkzlWeN18eONejXqT0b6GKKJJUHDYM7bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237716; c=relaxed/simple;
	bh=oWaM/CQyojbHgWGiSFA4WtRWbVzpTxVKkfl8L2eWRyM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=awjeTd+EGZo7i8RDa+IOkW7q3F4/jISMxLnKZN6ke/h2LKW4xu6HXH811Z3nao9yL0qGIjFvsi1YF10a9t03wnQ7iddxKkwZq1jE8M3g+LMESlXxDkmcC9jk2+xB0ss320E/1K6O7feiIL+rtZQrwqZSXCTjzlR/rvpG6ZlPP/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ebqTPVEJ; arc=fail smtp.client-ip=40.107.7.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dht8J4dtAEql0+ThqVdiEpLBsYMvxMbMxIlDUvmqoS082apX9AhcDFNhCT2nINgcznO/yBHdOazRitaY2f3PV4Q9mBM8T25GJaIYpACaGFEeVp6TixHSqqdGzRVs1hNm0nEZn3PdPVubPA/6E2oERYcXD2T04npE4FzQ5RX/BCPS87c6TzdYKHsdH9CVvnxwIL17RoujCs+h8KczjLYJPw2KmH9DyGHIE5Y3lf/cT+4iAE4XD7xzC2Tzrht97A+0Y18P6jJs/yBUqooIoJgY8LIg3cO2nBLYVmf4WImMpqGnWpeMKzNLsutUfZgcUQb4daMIGIqPyZYXcYYQr1gHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STLaoB1KKhGKq3jjdzpSjfywUac8hgqZ5hBTD7tKRSQ=;
 b=Aq4FbTwFAKhRgKCHSzHgMscJBQUN4EdaPf6RcTeLoPEYQereFjw53z5y3czqDebnJ4Wv9euz/6lSGfAevbjzZ0dsq85yQyfAJOAwmEUQwpcCXfbK0LEAcJhJjUrXC/OJiFz+tnxbH5Gt0wxro/tSevo23KJ0iJG0wjUzG5htluSdCIvC9zJLjwBzjZv8kjMgIfwZ27yKo7NPYaDU/cVsuwfrDGzXbrvlpVvUAXl0ZuJVz0e1Zw6++f4MQAE0bUv3WptVnFoaiaP4sjJ2GKFa0R61KDP23G7j7SD4RKZTNriGYKmqqf+2p73b1YyhMMI5xg7qnmEvEVyK871pQTQ8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STLaoB1KKhGKq3jjdzpSjfywUac8hgqZ5hBTD7tKRSQ=;
 b=ebqTPVEJeW8sK5zv01vI6F8Yttk+8TxFDbrkG7DEPkY74nY2e+JBGalSiQ6V+B6fYdXy8/gigeQ3MkI5e2TiaxlrLZMXelOgtx3Gz7LjOa8LUD6NDGdvLeVaEe37wAaCXBP9lY2+yCR3boyYyoKZeOe/Terqj/iqY+AGRSg2aI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 20:41:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 20:41:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 May 2024 16:41:32 -0400
Subject: [PATCH 2/2] arm64: dts: freescale: ls1028a: Reorder sai dma-names
 to fix warning
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-ls_warning-v1-2-6851155356c6@nxp.com>
References: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
In-Reply-To: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716237705; l=3223;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oWaM/CQyojbHgWGiSFA4WtRWbVzpTxVKkfl8L2eWRyM=;
 b=sujunTehnApY95qzIyoFEqTFhQDRiLW+qUpZKwfYwFDsc0DS/Ue4OGmOGz0/zCuLMyipZz5hL
 nBrjLPpzR6zClLMg8pjc93dQwMoc8XrJqZiMDzxPe01OEDC7cL1L6i7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: b51fbd97-a16c-4f30-c6ec-08dc790d47d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVJad0NxUGRNVG1pZUF0RTI3NldnZFZEMkE1azRHMEMrUEk4bGNwSVF4NXVV?=
 =?utf-8?B?S09WcGhrOEkvUHdpVzRqU3p2Y3BtL21JTGR1MG9yWEV2NTBOQkMvVURsQlBN?=
 =?utf-8?B?WjliSTEwVlUvdHI1UGlFQ25HeFZreXBvczVoZUQ3Z29EdlZKcVMxV3o3TDg5?=
 =?utf-8?B?U1Bha00xV2dEekw4MU5FSlRWc0tKakl3ZlQvTmhCVEl4TlZkck1rajFZQi80?=
 =?utf-8?B?VE9EalFnc05DN3h4TGplemNFOTh0Yml3bWtMRGY5bGEzQXlsekc5R1M4K2cv?=
 =?utf-8?B?c2RpZ0xXTW0vbXBnNStOWUtWM0hmMlFjTTNhcmU3dnhJNFIzV0VCUlFLc2Yz?=
 =?utf-8?B?Y0xvVm5ldmpVOTBXblNUeVNORFdFQ2lqckEwekYvOE81Tk8vaWJpUnZzVmlG?=
 =?utf-8?B?V09ma2hJQTMybyszNXdJaVJsRWx1alZHYXlqVzZkWjNMeEEzR2dBdVhzS0VU?=
 =?utf-8?B?TEFLSndNTmM5OWU1cGZFekw1UnpYWmF6OFhIYWNlMzRyRUpKNlUxM3c5OUdI?=
 =?utf-8?B?Wk5zMHEzbVJUdjNOUTY2b01qTEl1eHdwUDdqYmE3cGl1Z0NKK2RHYzBrQnVH?=
 =?utf-8?B?dVhGWExvc3Mvc0pyMmlsdGxKdXlRL0xSZTBkd1hXUlRuUzhna2JkbGkxVSsw?=
 =?utf-8?B?UktyS2pmZWdWL0g2MXRoU0krSThSL1hMTStoaUVUV1BKVys0enVRckVxRC9P?=
 =?utf-8?B?KzNKYlBqOVVoV3d5bmtWbGNLMTgwZkFEdW96V2t5dmdxSXdGOW1KMTE1V2ha?=
 =?utf-8?B?ZUVkNUJoc0VGN2RVQXdRbHB0MGVjalRYNlliaTZ5d1JDTGp0VVdwdmV1MUFI?=
 =?utf-8?B?Mmw2UjRoU0IraHpDUzhHb1V6a0l2dUdpVUwzaTRubFJpNzMybGU5UVZaN1c4?=
 =?utf-8?B?K1JPSG9TdVdZUHB3MGg0dXF3MkRvZmJXVTc0TzlyOEN6VkRPam5hQkpWUEht?=
 =?utf-8?B?ZkFJVUgwQU1hUTROblVvdmYxRTlWUFBQVFBUVURJb0FKSWlXbytaTk1kdFJB?=
 =?utf-8?B?L1BQTFNpZGZwUk1DNmZRUmFZVGNKcnNpV2lqVGRhYmVjUEFMU3BZbTVJTHFB?=
 =?utf-8?B?czRYNk8vR0drQ1F0TGxkSzRjWkJkcG1venFiMmo0aEFFL2pSK1hvbUw3Tmdj?=
 =?utf-8?B?WHV6aG5MUHdmYWswTFJHemdTZVFKRjJCaHVRRkVML29XTWFlYUt4ekt5N3dT?=
 =?utf-8?B?WVlvSUl3cmk4bzZWQ3djK3A3elZuSlhLQ0N6UGQ5bm9oQnhmSU1LWnNIVUZu?=
 =?utf-8?B?RGlWRTVCaDhPMFJKOW9QK0hTYldlSG16YUZacjdtTmpoaldEcnAvaVIxaDlX?=
 =?utf-8?B?UU1sR2JUd01uT1ExWUpqazhLNFkzK2c4TkhhdDlhNFlFalIyQVZFTE9UWEVi?=
 =?utf-8?B?dGwzSVY1cDRUOW1DUEFNOFBKYk9hL1QySFdvdEM0aVh5c1k5bUZTSThtb1VB?=
 =?utf-8?B?MTVQakFqU3lmNFdqbG8xMlZzY3ptRXN5NHBFRTcwUFZHenNBQ1lLcXNjclBK?=
 =?utf-8?B?eFRvMXhsdFhTYnYxRkZrRUhNMEZkblJKZEdsMm53ZXhsNkJYN3h1ZWo2V1l3?=
 =?utf-8?B?aVp0eklIcElZVk5hVmw1QnBBTnVIaEpQU3cxZU8zdUw4MFZLaitLZUlIRlZi?=
 =?utf-8?B?OFhDMWkvSVRMSnpoNmx0RlQxZFcyM3NSWnVuZFBlZVUrRXJwSEpDbTV6YjZO?=
 =?utf-8?B?L0hVaTRpSHVOOWZheEIxYWkxNTJWbW04ZXVudVNuR1hRUGg2RjEya1h3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1lvSk9hMXAwN2tKZFdmRlNpVmh0MmZNN1dUUnZ1Wm5WZVRMb3IvK0RmUWF2?=
 =?utf-8?B?UjdreGx4SGZJNWt3ZlI2aHVEU2c0Q3FXRnJHeWFKOWduTEFhNWc1SndtTVBU?=
 =?utf-8?B?WERaSUdUOXRBa25aQVduL0hLU3VPVTlNVjNBMWM0VVNNczlqSDZjVzBJNGFR?=
 =?utf-8?B?RWs2WkljSWMzQ1RQY3pGR0UrSWx1MmN5S0tsb0lPZkJHWWY3MUdjRFFRVjcz?=
 =?utf-8?B?UVRvejZkWmgreXJWZjdsTkt2OVVBWUxVVUx3VDVEa3hIVzVaeHcwczFiVmpS?=
 =?utf-8?B?Y1cwTzdjOTJ6YlEvazBwcU41WDFxUnN3YzRQZi9FVnpsSlU1WS9lbUp2U2tQ?=
 =?utf-8?B?U2puR0tXaFNPVzNjN1ZPTnRMY2xqR0NLbG5QYURsK21YUnRTSnByN210MnZh?=
 =?utf-8?B?SCtuNjFsKzUvcUxJaVdnTDh1eU4yQXhyb0dyN0lMTTJOS1VmZkQ4bk90d2FQ?=
 =?utf-8?B?TnB1Q3oxS280UjJ4MEU3RFZsalpFZFRuWE9KbFJHeTh6Z3hkeXVTTkN6SWRY?=
 =?utf-8?B?aHZSbWNiS1hzQjdHZUdUNVdmLzdsNERibFA0Q2JGRlFMUUd3TlhLVVBwUWFH?=
 =?utf-8?B?MlZWTk5nUmx0bWFYR0IxbzhjbUtFL0xwQS9nYXp6NmcrZTdRcWE2SW1NSmpv?=
 =?utf-8?B?NHpSeHVVam1yc0pBOUl0WnoxaXpaRE4wUUxGQkZ2NWxxSUp6ZTVvRzQvc2pH?=
 =?utf-8?B?NTlpaTNMSjNhZmZZQysrUnFYYTVGTnJoZGNZUWlUNTUwRFRtRWFZS0R4SUc3?=
 =?utf-8?B?NEdremxQSVJXTnZUVnFwMEI4aVk3bG11WkxTbjZzUEYydEJab1NSWGxhL3FK?=
 =?utf-8?B?Y1pQeDhMUFNISkNqUWhyZXozcFc1c0g1QkVmazg4TGp1T1ZmSmlDNWRsU21U?=
 =?utf-8?B?UjZrQ0d5VEdHUVVwOW9nbXo1RXhjQ21ucDhzLzhlMlNXWUFvRVc4aCtQZm9z?=
 =?utf-8?B?cDNKMGFoVllqbU1iRCsrVDhjZGNleC84cHlRMUxzL3RKa2crTFRsYlVoZ1M3?=
 =?utf-8?B?K1Q4SEg2U2ZpNjBXc2ZISk93V1BSWGVRZFBRYk1rNXNwOUd0Z1hRa3UyY3hF?=
 =?utf-8?B?ekR5Ym4yWndGeGpTS2hKU0s0UXUydWg4QVN2YUZzT296WktNeDhVeXpoME5F?=
 =?utf-8?B?ekNMNHRJS1FDMVB0YTJNamRkSUltd2ZlUE91dDZyZDF0ZzN4Wnl0aXlmalh6?=
 =?utf-8?B?cUovQ3dTMGUzN0tQRzhwTkxZa01INkVRT3F4ZWNjMkVZYW15dkpCdVFZc1lH?=
 =?utf-8?B?Z3FFU0pmbVp2NFRrZ0kyODNyYXVYK2NQdEpOTWlXR0xoR0JsdkFSNnpuTC9z?=
 =?utf-8?B?MVhhY3hOVHlKRVVYelNtZDllTGplMzVNaFNjSTZiY3llbWdoQ1l2M0ZQc3N5?=
 =?utf-8?B?cnBYci9Bak1CeE4wTzY5K0REZDkxTjNOL0NqeFpnc1Z1UmVUbzY4ekdja2x2?=
 =?utf-8?B?aGxLdHJ4aUV4NjJDYmlmMFU3TGdRSEtNc216dU4yelJKajRKZzA2UndmS0RO?=
 =?utf-8?B?NUZHN1FOblpqckx2RTJuUHpPK3ZsYVkxQUJSS1IxSzFabjZKbkdwSENZRlFS?=
 =?utf-8?B?S1huaVhtSFAwcVZ5ZzZJTWhGVGl0OFF2TmUxdnVaVDQvbjN5NmNmRUFmRnA1?=
 =?utf-8?B?V2J4V0NWVUhGaUtCbVg0VHZhN00xTUxPZXRNb3ZjaHZ5QjN2WFEwaEV4RDk4?=
 =?utf-8?B?N0hGQXFZaHpLVURxeXBNMWZnQ01yZGJHaUNqNEptSHliK0U5bElWS1pBV3I0?=
 =?utf-8?B?ME1xL21vQ2RiVStSMTZiM2hDckhlaDZhdG45RFJYU3g0M3k0L2d3RU0rU1p5?=
 =?utf-8?B?WElPOENyK2JtS1IvM3JIdCtpUk8vM3Z2UWlmN3lzbEVCNG4rdWxZWUFtMVIr?=
 =?utf-8?B?MGd1SEg4MVRvaEFwbnBxQ1pLUTkrT2FXcGhoTVlva3I2dFE5d3J4RHpNK2Ns?=
 =?utf-8?B?NkRzUGJYVWw4bW1wTEJFc2U4WkxJZ3BoMDlSTWcwZjdSbk52T2JEWXgxWnBY?=
 =?utf-8?B?Y3Q1ZE0rbzdGVFR5VUJ5VGpLbURTMjNYeHNZVUlpSXhlNmIrTElhUmJHN21s?=
 =?utf-8?B?UW1XSTM5bHNNZGIwSFZRTHlvUENjS0p4TGExTENzWG53NE1xaFNrL0N0TXlE?=
 =?utf-8?Q?sxh4XhZFqYlm7CAWCwpyqjnok?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51fbd97-a16c-4f30-c6ec-08dc790d47d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 20:41:52.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m95kr00zuAVB1S8GeBPhbZsqtmwngSAAykMaXdHkeryD7AMoBuU71Zil7q/0U6um+bD2/7nEh4hPWeKs/9EPIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385

Reorder the SAI dma-names to ensure "rx" precedes "tx" as required to fixes
the DTB_CHECK warning.

arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: audio-controller@f100000: dma-names:1: 'tx' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,sai.yaml#
arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: audio-controller@f110000: dma-names:1: 'tx' was expected

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index f8b19b54e2afa..6552d404d1310 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -903,9 +903,9 @@ QORIQ_CLK_PLL_DIV(2)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 4>,
-			       <&edma0 1 3>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 3>,
+			       <&edma0 1 4>;
 			fsl,sai-asynchronous;
 			status = "disabled";
 		};
@@ -924,9 +924,9 @@ QORIQ_CLK_PLL_DIV(2)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 6>,
-			       <&edma0 1 5>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 5>,
+			       <&edma0 1 6>;
 			fsl,sai-asynchronous;
 			status = "disabled";
 		};
@@ -945,9 +945,9 @@ QORIQ_CLK_PLL_DIV(2)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 8>,
-			       <&edma0 1 7>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 7>,
+			       <&edma0 1 8>;
 			fsl,sai-asynchronous;
 			status = "disabled";
 		};
@@ -966,9 +966,9 @@ QORIQ_CLK_PLL_DIV(2)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 10>,
-			       <&edma0 1 9>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 9>,
+			       <&edma0 1 10>;
 			fsl,sai-asynchronous;
 			status = "disabled";
 		};
@@ -987,9 +987,9 @@ QORIQ_CLK_PLL_DIV(2)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 12>,
-			       <&edma0 1 11>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 11>,
+			       <&edma0 1 12>;
 			fsl,sai-asynchronous;
 			status = "disabled";
 		};
@@ -1008,9 +1008,9 @@ QORIQ_CLK_PLL_DIV(2)>,
 				 <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "bus", "mclk1", "mclk2", "mclk3";
-			dma-names = "tx", "rx";
-			dmas = <&edma0 1 14>,
-			       <&edma0 1 13>;
+			dma-names = "rx", "tx";
+			dmas = <&edma0 1 13>,
+			       <&edma0 1 14>;
 			fsl,sai-asynchronous;
 			status = "disabled";
 		};

-- 
2.34.1


