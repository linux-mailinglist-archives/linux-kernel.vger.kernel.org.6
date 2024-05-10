Return-Path: <linux-kernel+bounces-175235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B09658C1CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F2E1C21679
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6579A149C4D;
	Fri, 10 May 2024 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wg4QeQMS"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA8148858;
	Fri, 10 May 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310718; cv=fail; b=pOAP1GUFED7Y5PMX8hBmr1E0ZGdj9tizPyq9dY28CTfBelgVvzPK1CHqL1ddvt7axymFrKgjLShW6sDVdBP9DDDCNCk/kdDRw6B+sAOQYktAJtxECoyTqqXuSM1rqtOUNBs54VyK904C4zIVs73deYki/dDh9lvBjH/EpKVhBdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310718; c=relaxed/simple;
	bh=Se/QtYFyGUXIP2ClMf1v2IXTHQJRK+EKqEVHx/+sKTE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fsXM1VN0EOAXIZSPBrfG9hNTI3GWmfJ1Jg2eI+5f7EeGDaChVBuhuyTSWKbdeM7sX9vLVEYoRpiviN5zBD7u5Fb7K8KyjXZFLdb1hwb6qt/LgGiXk9axLqyQBrzl5gFneVkmm2AunmB4+j8onFjcViXlHwuYA0JHysmxv2VFmvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wg4QeQMS; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZAsE5x3Q/tr3B7Vhzhqof12kVTt6hPlyiBpslZ5nh/rlqNgagLrkrc6/bc/hqdun2fbtwW5+Ty6dhwbiiiFiRLNXuNKW2afKjhNCAo+3Taeguy1QdU2TU0aE46VafNANtM3HmaaH5Hb0dIBY8fOtGAE17Z42gdajnHmk1kabNr9xx0d12l0EyXgOTTKCaVz506ejqZ137PXoJI2yJNCQtFExlIiC+HO8GBn4OtNsOznHg7xb5jBzGgWtDOHhKWPg72JK9hlUt5Go0tW+S8KS3TWHqmaKiBAFacYfeni1Ijg+iaWBMgRPh+1lx471GtY3K+saWvDLPA/m3uH3BzYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAp3vkdMcBldGCIqTt43Rw1xzhFks1J3RCl94yeS5MQ=;
 b=Itx4tePgiu3y7xFOdkwrkFQTLQiDJz5of8m+G+ai8VNo3t3TpvGJwXU53eUuUmIUs0w7xgeBkvGD0mZlcAjTm7/gsbJ+YUIeGa3WYtez0E8hH8Rpo0Q2+/m9LIelNLXGqDmoO2pFjd7jW+dgVFa2/CzHgQpos5Dn5LhiLMxwHYKt5fkHC7/ZRZvvUc7X5mTH8impqvPOCluw+hxZcdnNKdernpcJA9XPTXf+dI1VOs5/IkPLh3ZGJfePbuXpG7G3xrD3buC4kUbMi4aHJ8mk0R2bkXbbv2cg54WOrOlMLQD6LcLcd5SwKmIsqa7QXBEfQwsEt9B3/9b4QwTm5He96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAp3vkdMcBldGCIqTt43Rw1xzhFks1J3RCl94yeS5MQ=;
 b=Wg4QeQMS3lq4Q4r1PVrl+m/jY+ljED361ROnPbZZecY1V++z2Q1PyBuQW+fILuIXkXaB2jKq/k5Qso9KX98JdhFdSWRreWGuN1lEehua73uH4sYaypsAn7e8L0Y3MGngRwatDmmreRVQz+KzYQbc5ruUbyvR3vGZ/jwAlIJH9xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10135.eurprd04.prod.outlook.com (2603:10a6:150:1c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 03:11:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:11:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 10 May 2024 11:19:47 +0800
Subject: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Support
 notification completion channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-scmi-notify-v2-1-e994cf14ef86@nxp.com>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
In-Reply-To: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715311198; l=2485;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ZD6kTC1LKyAdyC7MdJ92p2toAQCDTFJKKmtOf1wMmI8=;
 b=8GlueLXWPwj9jQMFQS3L8HVkUhhTKAqLLvUUCDkabWiZxBnDxGmZxMdgtIWUDBEA54+C4CQ/d
 44gA86Vn2kACCzfeYu0AMEhz6QUC+AuRbJL0BAe6CfRWt2ik8ujilMN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB10135:EE_
X-MS-Office365-Filtering-Correlation-Id: 165504b8-2c7d-44f0-1fb0-08dc709ef185
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVVyVk9mRHFxZDNBZTlzT0JNSis4Tld4eDdOQmJ4dmE0cjQ0ek1MdW5GU251?=
 =?utf-8?B?Tm5rWWFscmhyNHptZVNud1BjR1ZlcDZyYXk0R1pvazdCQitidGpZTEtNMENG?=
 =?utf-8?B?VU5ianFld1kwalRBSDBnWWRrbWxBems5dWFVWU5JTjF0Rlc4bW0zTno4L3dl?=
 =?utf-8?B?cTB2Q2NaQ3FxcndsYmlLVmk4WmFyNWh1cFBxK3h0T1Q0M3ovYUNOdTYwaG5E?=
 =?utf-8?B?VlE2NWxScXV5Q1o3a0xxMnFQUllVZUE0WUp5d3U5MWYrbGNrUnBmMVkxYjJo?=
 =?utf-8?B?NVRHZkNGSTYzM0t2cmhPbjRCeFZSeU9DZjMvU0JKZjBpbUZSSFlWdko1TDNJ?=
 =?utf-8?B?WHZLUkx5bW1ML1ZEUENTaWN4UnJIdG1iV3lCcmNocWNBVnFTelZKMUtQa3Ba?=
 =?utf-8?B?TmFOMHBNeHhxeFJLTXZZQXdja0Q0cmR6Y3JwN1JjZjhWaS8rMkkrNDdjaFRO?=
 =?utf-8?B?dzZLOVowS3IxMUZlblpJZlJ6U2RheER4L0E1LzV5RmJrVnEwT1Y1YXVVUUM5?=
 =?utf-8?B?NTJlNWlsbVRnRVNuaUZUTlFJTnRJeEx0UGlTZWl4cTh4NE1ZODlaMjUxTGVX?=
 =?utf-8?B?N2NzTWRScW1XdDBYNndFSXpJUk5HeHBpRkJkVEVUOFRhYmNnbDYvV2RwemJp?=
 =?utf-8?B?bk5heDJaRExrVXhJMGxiOWptL2xrTlpad3Vid0dRYVU3ZmRTM3phS3Uzbkox?=
 =?utf-8?B?dkg2aFhkY1ZydHhDM0JMb1JBVGk4V0RqclhNREJ1TGxoK1VKTGlvMzdLU2JU?=
 =?utf-8?B?dm1BdlhiZElmS1N4MWszNW03STRsdzg4TkpoNCs4dFByM21yWXM3a1VrZXQ1?=
 =?utf-8?B?V0xvbkJyY1kwdTQ4VVdJQ3V0bzZoTHZVRFUyczZCR0xzSFdMZmdlRURIejE4?=
 =?utf-8?B?RXR1MGgxdG15ckg1SlA4bm1sSEpMUkdyRWcwK0daNGpucnN0dVNxd0wvZWRI?=
 =?utf-8?B?M0JjL09TbkhweUtvN3ZBeVk0NDhXN0FHaXlOVlRpcUtuaExQS054cjZYSlA1?=
 =?utf-8?B?d0ZESEF5VXhxZ1N3TnkreGJrRUdZRnpIelRaY21WQXhxck11NlFKV3BRa2E4?=
 =?utf-8?B?NmNXTXYvbXM0UWRXZEhqdDZFZGFOZ2ZYZ1J0akhucm1tWDJCZUdpTzE0VFlE?=
 =?utf-8?B?TFU3YXpUNTg4UTAwU05PN09Bb3hNbnB4T2pVK3hXbk1GSCtPbXhQcUwzRHV0?=
 =?utf-8?B?MDJreTFqMEJtbmZleWxsSElCeXpvellkamxxU0YrR1hwVGVKSWNuc1d6VldS?=
 =?utf-8?B?S29xK2R6TnhIOXBYT2F0c0NqT3RNT1hITzdZaUhLQ01TNmFObVhtWXBjc3ZN?=
 =?utf-8?B?MEpMWHp5K3pNZjJIQ05TZHVudmxUNnhLSC9XSFlpQXVqKzFHWXpmZEQ4Mm80?=
 =?utf-8?B?QnVLV25SRk85eXBNS3FCbGxzR0JjRGF6YjJPY3FnWFpkZHg2OXVBMU4yRDdG?=
 =?utf-8?B?NmFUaEVJdlFNbFQyWlVqbG9ZMG56YzJJUndOaXpndkhFbFdCMWxOZURXaTVo?=
 =?utf-8?B?bFQvUkZCeCtjV3BCTGVMR2pmVXBEckxwcTg2N0VncVVMU3loOVU1bTFhQWl1?=
 =?utf-8?B?bmZLUXhtN3lNSUk0UndiMjJXa0s5L2ZWZ253ZmM0ZUhqT0hYZEdWTkZsZkxK?=
 =?utf-8?B?dFk3SzVqdVN2NExHcGtyZjRoRjQ3ZGtZQmE5YjFoUTgzZW04akZoM1VjaGxy?=
 =?utf-8?B?UE5ubjF0TENVeTFBU09hWm44UllRcEhVeVhUVTdUanJ2c0pIdWZZNlQyayt4?=
 =?utf-8?B?clZRYXhXbmF2NnowYWtYdDFocnY5VmNkZkY4YitNczUxcVpnYWlBTGVRNTV0?=
 =?utf-8?B?N0wxMFBJYzZzK1pvVnY1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z24yalBvTVBvajkrNUhWc29TUGEzMW1nSTZGWG9wY1FzWjdHaG9PRk9BWDR0?=
 =?utf-8?B?MklpQVBzaG5kL2pUMmFwVTFubGxFWS9mRXQwTGQ3KzB5KzNoMXdpUmZSaUQw?=
 =?utf-8?B?MWNDdWRnNjBTb1hFZmdmaEVRZ2lmbWhDOUl3VkszWGk1ZC9SYk9ZMzJBNmRu?=
 =?utf-8?B?d1U1RzV3NWVtV2E4U3k4SGNnbTNySGYrZ3lMYnNlVnNXaDJadzZJdmRod3pP?=
 =?utf-8?B?eStoZndCZStzN1R0MC84VjVodTFDRU95Vk5zUWlqcVlBUG9TWVVFOG8wWDBn?=
 =?utf-8?B?Yks1dWpxd0tpSkdBRjlVYm5OVXR0aUYrRFZ1OUdMNTNBSlhmNWJNb2lQVHBI?=
 =?utf-8?B?ais4Y0ZCQTl6bFU3UDZ1REpSdjYrR05tRTU2STliMjBDKzdydHYvUFhiK1lN?=
 =?utf-8?B?dlFQTHBIZmEwMFpWakZkd05IQVJqWWU1cWNwVTZyTFZQUTR5VkVaKzBoZW5Q?=
 =?utf-8?B?N24xZzFSQ3l2T3RHWG9haDByWE9xbkFXclMrd2dKSWlVY0tTL3lsalpqblBX?=
 =?utf-8?B?eVplOStYUzJYbFZZS3VTNUxPd0x3UDFyMFF2WU1uaEtndDRtL2tybHc0RmY2?=
 =?utf-8?B?SlJ6bzV1dW84TElOaXoyVFhJbFREYzU3cHNGUnRmQ2UydjNzdUx0dVZuM2dl?=
 =?utf-8?B?V3VpcWp4alJOUGZFclhnV0ZqbnJwVUxIaG9mWEdVVGZtTWNNWUpXQzV3ejdp?=
 =?utf-8?B?Y1BVMW0xQ2FsUTFySE9VSjJjMUo1dEtydjVGYisyeFJXd2JwMW9pOEwxbEll?=
 =?utf-8?B?cWlnVmFXOUI0SVlPQ2VGYkdBbFI5MWs1M2RHUzArQmZUVmpmWVROQmcwZ0Z5?=
 =?utf-8?B?TmVHdk00YWNDMG13dWcrZUZSd2FvRXFrUzNBUnFRaUd2Z3ZzWDNtbStKc2hr?=
 =?utf-8?B?aGp3L0ZGRG1aRkNrb25hMzVKKzE5OUFqeHFONUIwcjk2UU0waWpGSnFoeHY2?=
 =?utf-8?B?ZlZSZ3ZFUnkrYXM1QVZ1UWZDRUYzUWxWcVNCaUt4ZUhaYlhqbC85WkY3c1pW?=
 =?utf-8?B?ZXVySEZWaUVJdVo2blBQWHZHN3pFM0dWQkZpc0N2b0MyYjk3cmhlR3EyOUNy?=
 =?utf-8?B?T25nQjBvejhTWnIxRmRuSWdSV09GUzNnYWt5bFhnekVGYjR1a08wWmNKVnBM?=
 =?utf-8?B?ejI5c3Q4K0FIK2NPNTF2b2VuM3JnbEFTOEpxNGtkQlFXQ3RueG9Uamg4eWdh?=
 =?utf-8?B?UERZQWlHdWFSdDh1cGNkMzVIbks3R1dMZW96ZHJDMi9oMTEvQXl0OC8yZDhC?=
 =?utf-8?B?dDVWYTJxa2JEdEJlTU91R1RDNlpBWnRoakk1L2IvU1BxLzV6VGdNUkRhbEtS?=
 =?utf-8?B?d0lxVHlWa1piWXJwVGhGa1FxYndnNEVFUUc2VWJCV1JueW1ESFgwb0VhNnVi?=
 =?utf-8?B?OUVJOHV0cmh2QzNlWVo4QVNZZnFNVzgrU0dkcDFYUEFIQjgxZ1lMNWxvUm5H?=
 =?utf-8?B?VURRUDgyMjVYTUJ6Q3VTZWMzMUFXbW5DMzJLZW9BckJQSDduY2FTVHBGcWFt?=
 =?utf-8?B?UldPZmxIVWVma3BzSitEbmFsN2dDakZKbTJQRzQ5bDZYbjdTeTRzczl1N2pZ?=
 =?utf-8?B?YXJqYzdKYjZCWGJUNmxkcHNMVUp1NHJXd1JFaHZXSnp1c0IyR0ZuYWdoMG9N?=
 =?utf-8?B?bFVteGUrWEJtd0FFYVFYU1V4TC9oUTBBS3RqWHZPS2ltelVaR085dHRTdkk5?=
 =?utf-8?B?SUxPNjZGYkc4R2JGOXg3aTdCSndKN0hoMllwWGF0TmZJN2xkSjBlOERwV1ZM?=
 =?utf-8?B?UXVDMHJyZllTQU9vVVI1RFAvSGhkQUZZOUhLY3V5dlBzSzhPMXVYUGRTZVBZ?=
 =?utf-8?B?d2Y4Y1pVWnJnb0NsTFdCSkFBUnFlc3R5aWVhTVhLaTdRbndpcTM2cWI2d2E0?=
 =?utf-8?B?cjdTTlZtbENhTnlHOUZQbFZrWC9aMWQ4RS9KQk5iclVwMkpQTHhpU3ZQc3RQ?=
 =?utf-8?B?aEcyMXhCZm9BUCtKbWNEYS84UUEyd1YwN0VOUDNBVXVJdG9BTm9WMUoyVzRC?=
 =?utf-8?B?amUrK0FnaXZyMmJpazNyMDJPZ0xFWWVURnJHRnV4VzVQVFJHajNXT05UUS9C?=
 =?utf-8?B?eTdqdG1vcEpveGc0L3FrclgrNzRaUm05OUhwZ2EwRVlxR3p5VllMQkRldy9V?=
 =?utf-8?Q?ptaKv0KVM7BUiBvEvYtME+7SV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165504b8-2c7d-44f0-1fb0-08dc709ef185
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:11:53.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDnkxUCdEPfX3l7rc6viCGdC28DrLzIpOAF3B4+oGyqrTy2Kf333vMlACIYbPL+QhplVgVxK7zQEVu4RV8c9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10135

From: Peng Fan <peng.fan@nxp.com>

Per System Control Management Interface specification:
" Completion interrupts:This transport supports polling or interrupt driven
  modes of communication. In interrupt mode, when the callee completes
  processing a message, it raises an interrupt to the caller. Hardware
  support for completion interrupts is optional."
So add an optional mailbox channel for notification completion interrupts.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 7de2c29606e5..308af58180d1 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -72,14 +72,17 @@ properties:
           - const: tx
           - const: tx_reply
           - const: rx
+          - const: rx_reply
         minItems: 2
 
   mboxes:
     description:
       List of phandle and mailbox channel specifiers. It should contain
-      exactly one, two or three mailboxes; the first one or two for transmitting
-      messages ("tx") and another optional ("rx") for receiving notifications
-      and delayed responses, if supported by the platform.
+      exactly one, two, three or four mailboxes; the first one or two for
+      transmitting messages ("tx") and another optional ("rx") for receiving
+      notifications and delayed responses, if supported by the platform.
+      The optional ("rx_reply") is for notifications completion interrupt,
+      if supported by the platform.
       The number of mailboxes needed for transmitting messages depends on the
       type of channels exposed by the specific underlying mailbox controller;
       one single channel descriptor is enough if such channel is bidirectional,
@@ -92,9 +95,10 @@ properties:
        2 mbox / 2 shmem => SCMI TX and RX over 2 mailbox bidirectional channels
        2 mbox / 1 shmem => SCMI TX over 2 mailbox unidirectional channels
        3 mbox / 2 shmem => SCMI TX and RX over 3 mailbox unidirectional channels
+       4 mbox / 2 shmem => SCMI TX and RX over 4 mailbox unidirectional channels
       Any other combination of mboxes and shmem is invalid.
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   shmem:
     description:

-- 
2.37.1


