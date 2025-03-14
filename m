Return-Path: <linux-kernel+bounces-561675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A0A614CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65B217ECE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF6202973;
	Fri, 14 Mar 2025 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QhNzIGRl"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE45201261;
	Fri, 14 Mar 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965856; cv=fail; b=egsu9xUX1r9qz3D12I0JEDiDlXjkfd0qiYmu/BZpnUmsw6lIbsy1B97DVMMLxFAV39UGClrIi6MUR2YuGb3YOcX0MgW55FIhDrVB4HsY7/T0E2H7PQZgGqf0J6O5Rng4LBtf2UXhBJHisYXT6wF7lRdAhvwrLbnD1T8UckMi4bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965856; c=relaxed/simple;
	bh=b58qjpTNAde+tyl9F3Gw1N7yFTS7N1gS1pJu3kaL6fs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eBxz+DPLcFi/yi3oOwW4oc85hU5zfGDxH09ZVXA4++ObbFWcZcUo+2M1wFkd9Q+Sqc37Y/LkQYYs9QPN+Knpf+cK6yQBL7/vbCOPO+AA4dCkGyXdbI0KIxVvaf7K0bUanR6u3t7ZpGISwvZP8FlJU4RM+EqR61LIJ5CXXpN436k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QhNzIGRl; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbWUiFWWlWOTjBLuF1tgkMxDFVRphUaqa0Z4d18j/k2yZQKo9WTwj7WMtj4nJjVpv0NwwuEdYhfbLDOdsXBZQqK4V6VnDIVNjyoU56HIRHca4eNUOgZTe+F9Um4zulUb5AMrTFc2ABrVm4AdH+OFT0ngExRIs0dOxQRxfKgmppoLF4/LDaktFdTvA1ReDbeGgk92EDLqojBq1zeJQqhsa1Hptlk8oEbVNVPj/P9LBPvb7/PWaW+eCtLBw2txYQRTE8DazfZy1cXRpbdSpPqvhQEeJv9nxtkSbwbQPw56xhwRy9A+uZ+xw6oarSu0FGJOJti5cXlcC0UFopLgtEgIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4Rps2R9J4BzL595zqIGTEGV+e7eLHDMo7J3LwqNLCg=;
 b=ijvg5D23LKOw25113a73tdhNyROaRBhfbt7EsDtuvo7Lv5LFEfvMEWnwpVi5QeTeUpzw7G8n01qcOhgneB/bOS3b+OBYvHlGHicYGp7tROC+ywcsAVPXsM2asSAShYZgk7jU2BIgP6ezWOjkXQ4cE47GvQH9P4vfju6hbOa8cVFluQtFBEHV1v1IieyLGBKYme+zVkxXlZgrVZME1heCNVwYgXp+Q1y77jkaBl+c5WJoOBNfi9n0TKG9A/RdWrUWb0Yflbvpo99gSofHpdOjXLlKCPuouIMMI4iszjA1vkFplBifuS+D2kjwyoO6KRKqRwlTDwQZzBapRuRqe3JxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4Rps2R9J4BzL595zqIGTEGV+e7eLHDMo7J3LwqNLCg=;
 b=QhNzIGRlY3U7bdsSogiaGV3H0JOb4f+ZeWECU+SH9NdRUPzIfQ057Pfdp9+ATRL8gNF21bJr4C1/XdBbwncMxJsiVM9mUFMGq/Uj/TRm/9wgNNdlSvVxKer7PBoXXtrtyFbKkYbQAxFRPq/+rO4+KYQDYFEFhb39oB5ISawhnZYxUR7/eAs+ljU2t73QeWsLmMTdXBsn6v1KRJPD7kAf73UOaXLPs3yhuhQ3R4QoDD0qqhY3CETlAFUUUdRv26zhth5NeQS7GSKCo7uCDZUZxYg2/EGInCKYi5eEgE3QaMjJzOHttSBhgqcCAj5h1cbhOthPt+ptizab5qbs2c+DQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 14 Mar
 2025 15:24:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:24:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Mar 2025 11:23:47 -0400
Subject: [PATCH v5 2/2] regulator: pf9453: add PMIC PF9453 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-pf9453-v5-2-ab0cf1f871b0@nxp.com>
References: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
In-Reply-To: <20250314-pf9453-v5-0-ab0cf1f871b0@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741965840; l=27837;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=i+WRbt+SU5y+lyJK09WKt756BM71pcfLqBDDdvzSbww=;
 b=odRDg5AA0TcvoZ5nnaW2aSu/sg05uU3SYrRTDEJCW/O/gJ/1dI8AJ/dWyib5g5UFokb1rK0kI
 9ymZM9GubVoAZOHavPV7xa+iakxECQq5rFotLOjaWAyQ8dulgYyzgdm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f06de4-4d5f-4c0b-c7c3-08dd630c4400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRrUjBHZ1F3YlNiMHlscjB0L1YyRm9uNS9jUG53NE9KRU05bnBBQUU5dVdP?=
 =?utf-8?B?ZEtScmdqVk9YcEZodlE2bTNoejZ2TDJ2ZW9SVERrS1NSMWp5Z1BkSFlMd3pi?=
 =?utf-8?B?a1pSYXIvbTVCNDFPS3YzMUhob1QxQ2lTYWxRSTk2eTZ6S3QxZ0dqeTRlYWF1?=
 =?utf-8?B?YkFlODgwa1F3THhXRGlTMGZ1RjFVcnNSL2RCRjdOZzJvRnBOd1ZjUmxIUSt2?=
 =?utf-8?B?NlEydkp1QnVsMGJkZTJtSnBSQUphelk2L3RlTGU5K1YwWkd1anJpWTcrQXhW?=
 =?utf-8?B?SUJxZksya1E0L3BIcGY0d1h0TDZ3MUtLcUJ0SXdLV3NUNVFZSGM4cDlEeS9V?=
 =?utf-8?B?bXBZM2g2b0o5eXpYenJDY1RwYjBVS1EyRTdwVXQ0a3RsKy90R2hCbU10U2dy?=
 =?utf-8?B?cFpwN3NrOGd5U0pIMTNaYUo0b1FpZnlYdzc5aDBUazJyNXBDNmQ1cGwrZjhh?=
 =?utf-8?B?UDlFRkxIdW00ZW80cFppNi9HNmYzZUJvOEs2a3JrWFNEZzJaQmNCTGtzRCtT?=
 =?utf-8?B?bWo2SHdjTE14UHpxOVJuOURmUlRTbjQ0a1g5dXR2WWxtKy9sYlZQMWZseVE5?=
 =?utf-8?B?Tk9rUkJHaUpBdE1xWTJQYjRnazV2Q1FJcitqSjdWMGpmMG54ekk2MXpPSXpm?=
 =?utf-8?B?akVIMEFiR0JVS0x0dEladXk2a3dJd0ZicVZQQmxnbFlISGFGbDF6K3pUbW1q?=
 =?utf-8?B?QzVYblpqSC9iekRSTmZudHNiYnM1MnBBRmE2emQrSjEwL3VGcW9DT3RuMDFs?=
 =?utf-8?B?UFVUM2k5VVA5eG1rOGlZQ0lPVEg0eGx1NHRuc2hNeXdSNTV0azVnYUZmY3RP?=
 =?utf-8?B?RGZWWWVGNlJCSkdPY2kvSFlBZllic1FlaFVlUW5oRVhXSnNldzU5Ynl1L05n?=
 =?utf-8?B?WUxubnNUeGVHcDFDKy9xdEZ1SHlxbFpqL0NjMXVCa1BudjR6NlZNYURsWFIx?=
 =?utf-8?B?TFRzQXlmMzN2ek04VTZTTmhwdysvMjVyZTh5ZE1mWG5QZHpCdERpSlJIUVlJ?=
 =?utf-8?B?YnEwVXQwTnBZR2ZOS0lwZWp1VlppdGxWS1BtaE9IbnpwUHY3U1VSZUtReU0z?=
 =?utf-8?B?c1VxcHQvQVpMTEFUTmlMK1ZaOVRIcTZyY2tFbzR6aWdvZjhDZStUdlkyWkgy?=
 =?utf-8?B?L21jWTB6VEVHMnowT3RES3BxczIwZHUwK1B4SFJ5ZWlwdFlJSjRpWFkxWnRP?=
 =?utf-8?B?N0VCK0xEVXlBTytsREh4ZmRMbDFuWkZuRXlFa1JUWS9aME02eHdwbTNNRGVi?=
 =?utf-8?B?MFBMQ29lVisxRnp1T0N6RnZOWkc1MEtKTWNDT3F5WkpyNys4WU82RWZTcHRv?=
 =?utf-8?B?UEtiS0NLTmZac0QrQWt0UWZVUmY3VUdQeWVJWTVDSWFOcC9meWNtU1hSakNP?=
 =?utf-8?B?elBIRENPSXMxS2FjcTdxWnZFNit0Q2JYa3Ara01uQ3dySlorMjBWKzRvVE1v?=
 =?utf-8?B?QWFtK291STd5RWpTVmF4Njh1bUE0cVV3bzl1dEtFbzhvbUhuZkhsQ0IvMmRU?=
 =?utf-8?B?Y1MvVzlaZ3liLzFWQXBneEREaUxMeEdOVk1waWRoaDk0a1QrR085cE1Ud01y?=
 =?utf-8?B?azFwbE5rbktTL3o4cExxMTNXYVBmUCtDRER6OGR4Y0JUZ3NCb2NrNFg4c0JH?=
 =?utf-8?B?M1JNSy9JS1E2d3BEdzBKQXdrWVJsQUVCSHQraHFjMzVvbHhjM1dyQ3lkZG95?=
 =?utf-8?B?eWFFRUdFMG1aeHZhQ1dzclREYUtqRGY0OUxEdHZDT3JjL2JjclMxVDg4dUFF?=
 =?utf-8?B?bWR4amdYVmF2WlBGcHlwZERRMXZEbXNxMGRBenNOaUQwK0FBWDJ3dlpkV0Rw?=
 =?utf-8?B?YW01cytmc0xJZUU3M1pybzN6RUVhQWplNU5VdUJmbkR1VndtcjBjWGJZYnFU?=
 =?utf-8?B?K3haUk13NkpaZHFFQnhsamI1Y2NHVllZS2oxbE4xRkZLdS9TN0xWc2ZzZnBX?=
 =?utf-8?Q?TdzHu3Zz+xM6xyX+A4ae9FnTFHHBpzq6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVwVEJJaFEvTkc4bFRIVjNyZlhkTjl2SEppTGRlNmJXQmpVNk5EL1lCWkxZ?=
 =?utf-8?B?bFFSRjc1V0JzWlkrSEIrQi9zZmlWOEdweWFmdTM1UVhTU29XVlRkOFNIendL?=
 =?utf-8?B?aHIxTmJHZVJlcmhPbW82dTFUcDlIQmVOZXkwdHlSNFZUcVVGbE5yKzJrSUtE?=
 =?utf-8?B?dmo1c2ZYWVFoZ2ZtWTdUVndwZjJhNXlPclZ6ZGo5RjEzTzdOVjhXTitISjZn?=
 =?utf-8?B?aWZ4dk5YcWd3YlRtNkp3ZEIrQVZCSW5OV0hwS05zblRoZVIvU0lhWWVKUkFl?=
 =?utf-8?B?bnY0UklrUEdjNk5HNHk3WjAxazExMHpmelRlYlowL1N4QUhUcW85ZE55YUN5?=
 =?utf-8?B?d0pmOTd6aW9xeERmSE81NEhkNGRYcnJiR3g2OG5YSmUyU0lKRExLWnpSOUhr?=
 =?utf-8?B?SjQzQ2F3Wk40RUtnQ042enlEdVdVT2g3N2c2SVF4NDdDT1Ura0Z3azVoV1Yv?=
 =?utf-8?B?aW9xSjZjVFUxY2cvWWlQaU1tMndkdjBuK3JocmFodjVhbElHdWpJaUxoTG1x?=
 =?utf-8?B?YlNRM0JQRTFRRFU1NHJQMEhNZnYxR3A3Nkc5eXZLbVdZdElMVmx5ekIzTTI0?=
 =?utf-8?B?Q3RWNDlOTTdKT3R4Nm5FV01vSHY4S2NuR2ExN3B6M0NGb003bzVUUGlocDdK?=
 =?utf-8?B?K3RQR1JIUVhRRXJEQkdzNEROSldwK2hDUFExa2ZsSUlYMHdsMTQ3N0U1bFZI?=
 =?utf-8?B?a0RJVEJQSUZxTkRyS2pEWXNIb1c0cHhPN0t4dDdmWGhTeWhRQkpVaktLelFz?=
 =?utf-8?B?RjlUK0ZPYlF6Z2JrRW5MbkVaMXRFaXFKZHBPamxHVUlMejJGWWtocTlxVEtk?=
 =?utf-8?B?UWEvMWUzTCtTSmovNi8xUnJVRm43TG9RUDg3UFkwaTRram5PRDZ2QndMZ1hp?=
 =?utf-8?B?VW1VaXZQVnVhWExGMk5vcmUzSUd5NnkybzRsRjcrSWMvSmo4RGRBRnVsV0t4?=
 =?utf-8?B?YzcvUit4WllHMENDWWphR3hWU0luSHR2UDV5VHoxZjZMbjQyZzhGWkNWMWpG?=
 =?utf-8?B?MW0zc3FsOHlSaEpta2FEajkxeTVrdEU0VlFRM2UzanA5UVNXS0JwSDlJTW85?=
 =?utf-8?B?R2I2Mm5jUVpRcW5oc0dvbjd0VUVJbmhiYUozSFhoL3BSWU15bk9ra0R1QitB?=
 =?utf-8?B?Y1F3ZDFXVGZva3RNa0E1SUZFWVdVSnZhYjRJVTUzYnovbURxM3VscWdOTmJn?=
 =?utf-8?B?MmFWZEh3NjRsamRXYmFKa0p3MURPQnorSElPSVIxUWtqKzBha1ZSTnU0ZGxr?=
 =?utf-8?B?ZnF4anJEWGJsejcvY0NOekt2TVVRMDNwOTlaUWpxNFF3OHY4SEs0bDlGY2pT?=
 =?utf-8?B?cG1CMEZ2YURnOW1ydHVjc0RMN3JHY2J0dFU1UmdKa1I4azZkZVUrc1NIT1lP?=
 =?utf-8?B?YjJ2amtSS1lOZ2V4TE5oelhqNlZwaW5YN00zY1ZZOUoxSTBGUUt1OHdINTZ3?=
 =?utf-8?B?ZVhkRXJ5dEhvbHk3eGhNaEZoL2VEeHF0U2pPM1VVOWVnVW8vV1lzNnY1OEpp?=
 =?utf-8?B?Z2NqWWpvU09VN3RZb3lSbktaNkxxdEV0WFAzY1J6T2lqU1FIaEh2Z2ViWG5G?=
 =?utf-8?B?eVVUQ1VOUlN0ZWFCV21tMUZXNi9YQ0ZHcFRqelFTdDZ6OWJFNU93ZjRTenc1?=
 =?utf-8?B?SXJ3OXR2b0hMMHdSekMxUFFuRUduVEhBbFJLZGxIa2kwL25BemxTNEJwYTV3?=
 =?utf-8?B?cGduZ05JYzVRUGlFZWNKbjBHbFJXa3BQZnJ1SHRYMlM1TEIzb2NIQ3dnejZX?=
 =?utf-8?B?c1hkOVVZQ2FhbmtZNjBEVDU4VTAzNEdPVjZiWmo4ZHlvUTJUK29qdlhiMmxi?=
 =?utf-8?B?cHFwRWU2QU9FY25KenI5Vi83c0xZV2Z0aUVkU2k5cm90ZTVqbDdUVnhhRUZo?=
 =?utf-8?B?TGFnOW9QaWpzMlk1Z3g0V2pYcVRPZktLNzRzUml0VnMvUktUZU93SFFUczZz?=
 =?utf-8?B?MEhsS1RXbWcyQzZrQmNYVnF3RmNyUU56dHMrUkN5N3VTTWNtZFlzVkkrWjkw?=
 =?utf-8?B?bzkrYjFFcEQvdWI0SHBxVkZlY0NEcXJUSnZuYTJxYnJ3ZzZqcFc2NkNiUm5t?=
 =?utf-8?B?YnprRjk4cWd1NVdYd1Z1Uk16QXZDOVhwSHhyYlRoVnVaS1Fxays4MXFEOWoy?=
 =?utf-8?Q?IsZQDOs92ls8eUqIs3+09ACP2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f06de4-4d5f-4c0b-c7c3-08dd630c4400
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:24:09.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFubQL+5E4otDlsIzA21kZ0HQSyJuvKEJeiQDiQ3R/p/21qIrLnA/WG1Wkvkdu/O5Fq0OEWDbl/01myhVbveIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730

From: Joy Zou <joy.zou@nxp.com>

Support new PMIC PF9453, which is totally difference with PCA9450. So
create new file for it.

The PF9453 is a single chip Power Management IC (PMIC) specifically
designed for i.MX 91 processor. It provides power supply solutions for IoT
(Internet of Things), smart appliance, and portable applications where size
and efficiency are critical. The device provides four high efficiency
step-down regulators, three LDOs, one 400 mA load switch and 32.768 kHz
crystal oscillator driver.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v4 to v5
- none

Change from v3 to v4
- fix GENMASK(7, 4), should be GENMASK(7, 6)

change from v2 to v3
- remove pf9453.h
- remove double space
- use low case hex value
- remove , after terminate
- use GEMASK
- change to LDO-SNVS
---
 drivers/regulator/Kconfig            |   7 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf9453-regulator.c | 879 +++++++++++++++++++++++++++++++++++
 3 files changed, 887 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 1236b3a1f93f6..807d07067951c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -981,6 +981,13 @@ config REGULATOR_PCA9450
 	  Say y here to support the NXP PCA9450A/PCA9450B/PCA9450C PMIC
 	  regulator driver.
 
+config REGULATOR_PF9453
+	tristate "NXP PF9453 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say y here to support the NXP PF9453 PMIC regulator driver.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8dca3567437f6..524e026c02734 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
diff --git a/drivers/regulator/pf9453-regulator.c b/drivers/regulator/pf9453-regulator.c
new file mode 100644
index 0000000000000..ed6bf0f6c4fe2
--- /dev/null
+++ b/drivers/regulator/pf9453-regulator.c
@@ -0,0 +1,879 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ * NXP PF9453 pmic driver
+ */
+
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+struct pf9453_dvs_config {
+	unsigned int run_reg; /* dvs0 */
+	unsigned int run_mask;
+	unsigned int standby_reg; /* dvs1 */
+	unsigned int standby_mask;
+};
+
+struct pf9453_regulator_desc {
+	struct regulator_desc desc;
+	const struct pf9453_dvs_config dvs;
+};
+
+struct pf9453 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *sd_vsel_gpio;
+	int irq;
+};
+
+enum {
+	PF9453_BUCK1 = 0,
+	PF9453_BUCK2,
+	PF9453_BUCK3,
+	PF9453_BUCK4,
+	PF9453_LDO1,
+	PF9453_LDO2,
+	PF9453_LDOSNVS,
+	PF9453_REGULATOR_CNT
+};
+
+enum {
+	PF9453_DVS_LEVEL_RUN = 0,
+	PF9453_DVS_LEVEL_STANDBY,
+	PF9453_DVS_LEVEL_DPSTANDBY,
+	PF9453_DVS_LEVEL_MAX
+};
+
+#define PF9453_BUCK1_VOLTAGE_NUM	0x80
+#define PF9453_BUCK2_VOLTAGE_NUM	0x80
+#define PF9453_BUCK3_VOLTAGE_NUM	0x80
+#define PF9453_BUCK4_VOLTAGE_NUM	0x80
+
+#define PF9453_LDO1_VOLTAGE_NUM		0x65
+#define PF9453_LDO2_VOLTAGE_NUM		0x3b
+#define PF9453_LDOSNVS_VOLTAGE_NUM	0x59
+
+enum {
+	PF9453_REG_DEV_ID		= 0x00,
+	PF9453_REG_OTP_VER		= 0x01,
+	PF9453_REG_INT1			= 0x02,
+	PF9453_REG_INT1_MASK		= 0x03,
+	PF9453_REG_INT1_STATUS		= 0x04,
+	PF9453_REG_VRFLT1_INT		= 0x05,
+	PF9453_REG_VRFLT1_MASK		= 0x06,
+	PF9453_REG_PWRON_STAT		= 0x07,
+	PF9453_REG_RESET_CTRL		= 0x08,
+	PF9453_REG_SW_RST		= 0x09,
+	PF9453_REG_PWR_CTRL		= 0x0a,
+	PF9453_REG_CONFIG1		= 0x0b,
+	PF9453_REG_CONFIG2		= 0x0c,
+	PF9453_REG_32K_CONFIG		= 0x0d,
+	PF9453_REG_BUCK1CTRL		= 0x10,
+	PF9453_REG_BUCK1OUT		= 0x11,
+	PF9453_REG_BUCK2CTRL		= 0x14,
+	PF9453_REG_BUCK2OUT		= 0x15,
+	PF9453_REG_BUCK2OUT_STBY	= 0x1d,
+	PF9453_REG_BUCK2OUT_MAX_LIMIT	= 0x1f,
+	PF9453_REG_BUCK2OUT_MIN_LIMIT	= 0x20,
+	PF9453_REG_BUCK3CTRL		= 0x21,
+	PF9453_REG_BUCK3OUT		= 0x22,
+	PF9453_REG_BUCK4CTRL		= 0x2e,
+	PF9453_REG_BUCK4OUT		= 0x2f,
+	PF9453_REG_LDO1OUT_L		= 0x36,
+	PF9453_REG_LDO1CFG		= 0x37,
+	PF9453_REG_LDO1OUT_H		= 0x38,
+	PF9453_REG_LDOSNVS_CFG1		= 0x39,
+	PF9453_REG_LDOSNVS_CFG2		= 0x3a,
+	PF9453_REG_LDO2CFG		= 0x3b,
+	PF9453_REG_LDO2OUT		= 0x3c,
+	PF9453_REG_BUCK_POK		= 0x3d,
+	PF9453_REG_LSW_CTRL1		= 0x40,
+	PF9453_REG_LSW_CTRL2		= 0x41,
+	PF9453_REG_LOCK			= 0x4e,
+	PF9453_MAX_REG
+};
+
+#define PF9453_UNLOCK_KEY		0x5c
+#define PF9453_LOCK_KEY			0x0
+
+/* PF9453 BUCK ENMODE bits */
+#define BUCK_ENMODE_OFF			0x00
+#define BUCK_ENMODE_ONREQ		0x01
+#define BUCK_ENMODE_ONREQ_STBY		0x02
+#define BUCK_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453 BUCK ENMODE bits */
+#define LDO_ENMODE_OFF			0x00
+#define LDO_ENMODE_ONREQ		0x01
+#define LDO_ENMODE_ONREQ_STBY		0x02
+#define LDO_ENMODE_ONREQ_STBY_DPSTBY	0x03
+
+/* PF9453_REG_BUCK1_CTRL bits */
+#define BUCK1_LPMODE			0x30
+#define BUCK1_AD			0x08
+#define BUCK1_FPWM			0x04
+#define BUCK1_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK2_CTRL bits */
+#define BUCK2_RAMP_MASK			GENMASK(7, 6)
+#define BUCK2_RAMP_25MV			0x0
+#define BUCK2_RAMP_12P5MV		0x1
+#define BUCK2_RAMP_6P25MV		0x2
+#define BUCK2_RAMP_3P125MV		0x3
+#define BUCK2_LPMODE			0x30
+#define BUCK2_AD			0x08
+#define BUCK2_FPWM			0x04
+#define BUCK2_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK3_CTRL bits */
+#define BUCK3_LPMODE			0x30
+#define BUCK3_AD			0x08
+#define BUCK3_FPWM			0x04
+#define BUCK3_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK4_CTRL bits */
+#define BUCK4_LPMODE			0x30
+#define BUCK4_AD			0x08
+#define BUCK4_FPWM			0x04
+#define BUCK4_ENMODE_MASK		GENMASK(1, 0)
+
+/* PF9453_REG_BUCK123_PRESET_EN bit */
+#define BUCK123_PRESET_EN		0x80
+
+/* PF9453_BUCK1OUT bits */
+#define BUCK1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_BUCK2OUT bits */
+#define BUCK2OUT_MASK			GENMASK(6, 0)
+#define BUCK2OUT_STBY_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_BUCK3OUT bits */
+#define BUCK3OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_BUCK4OUT bits */
+#define BUCK4OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO1_VOLT bits */
+#define LDO1_EN_MASK			GENMASK(1, 0)
+#define LDO1OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDO2_VOLT bits */
+#define LDO2_EN_MASK			GENMASK(1, 0)
+#define LDO2OUT_MASK			GENMASK(6, 0)
+
+/* PF9453_REG_LDOSNVS_VOLT bits */
+#define LDOSNVS_EN_MASK			GENMASK(0, 0)
+#define LDOSNVSCFG1_MASK		GENMASK(6, 0)
+
+/* PF9453_REG_IRQ bits */
+#define IRQ_RSVD			0x80
+#define IRQ_RSTB			0x40
+#define IRQ_ONKEY			0x20
+#define IRQ_RESETKEY			0x10
+#define IRQ_VR_FLT1			0x08
+#define IRQ_LOWVSYS			0x04
+#define IRQ_THERM_100			0x02
+#define IRQ_THERM_80			0x01
+
+/* PF9453_REG_RESET_CTRL bits */
+#define WDOG_B_CFG_MASK			GENMASK(7, 6)
+#define WDOG_B_CFG_NONE			0x00
+#define WDOG_B_CFG_WARM			0x40
+#define WDOG_B_CFG_COLD			0x80
+
+/* PF9453_REG_CONFIG2 bits */
+#define I2C_LT_MASK			GENMASK(1, 0)
+#define I2C_LT_FORCE_DISABLE		0x00
+#define I2C_LT_ON_STANDBY_RUN		0x01
+#define I2C_LT_ON_RUN			0x02
+#define I2C_LT_FORCE_ENABLE		0x03
+
+static const struct regmap_range pf9453_status_range = {
+	.range_min = PF9453_REG_INT1,
+	.range_max = PF9453_REG_PWRON_STAT,
+};
+
+static const struct regmap_access_table pf9453_volatile_regs = {
+	.yes_ranges = &pf9453_status_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf9453_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf9453_volatile_regs,
+	.max_register = PF9453_MAX_REG - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/*
+ * BUCK2
+ * BUCK2RAM[1:0] BUCK2 DVS ramp rate setting
+ * 00: 25mV/1usec
+ * 01: 25mV/2usec
+ * 10: 25mV/4usec
+ * 11: 25mV/8usec
+ */
+static const unsigned int pf9453_dvs_buck_ramp_table[] = {
+	25000, 12500, 6250, 3125
+};
+
+static bool is_reg_protect(uint reg)
+{
+	switch (reg) {
+	case PF9453_REG_BUCK1OUT:
+	case PF9453_REG_BUCK2OUT:
+	case PF9453_REG_BUCK3OUT:
+	case PF9453_REG_BUCK4OUT:
+	case PF9453_REG_LDO1OUT_L:
+	case PF9453_REG_LDO1OUT_H:
+	case PF9453_REG_LDO2OUT:
+	case PF9453_REG_LDOSNVS_CFG1:
+	case PF9453_REG_BUCK2OUT_MAX_LIMIT:
+	case PF9453_REG_BUCK2OUT_MIN_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int pf9453_pmic_write(struct pf9453 *pf9453, unsigned int reg, u8 mask, unsigned int val)
+{
+	int ret = -EINVAL;
+	u8 data, key;
+	u32 rxBuf;
+
+	/* If not updating entire register, perform a read-mod-write */
+	data = val;
+	key = PF9453_UNLOCK_KEY;
+
+	if (mask != 0xffU) {
+		/* Read data */
+		ret = regmap_read(pf9453->regmap, reg, &rxBuf);
+		if (ret) {
+			dev_err(pf9453->dev, "Read reg=%0x error!\n", reg);
+			return ret;
+		}
+		data = (val & mask) | (rxBuf & (~mask));
+	}
+
+	if (reg < PF9453_MAX_REG) {
+		if (is_reg_protect(reg)) {
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+
+			key = PF9453_LOCK_KEY;
+			ret = regmap_raw_write(pf9453->regmap, PF9453_REG_LOCK, &key, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		} else {
+			ret = regmap_raw_write(pf9453->regmap, reg, &data, 1U);
+			if (ret) {
+				dev_err(pf9453->dev, "Write reg=%0x error!\n", reg);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * pf9453_regulator_enable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their enable() operation, saving some code.
+ */
+static int pf9453_regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->disable_val;
+	} else {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_disable_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their descriptor and then use
+ * this as their disable() operation, saving some code.
+ */
+static int pf9453_regulator_disable_regmap(struct regulator_dev *rdev)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int val;
+
+	if (rdev->desc->enable_is_inverted) {
+		val = rdev->desc->enable_val;
+		if (!val)
+			val = rdev->desc->enable_mask;
+	} else {
+		val = rdev->desc->disable_val;
+	}
+
+	return pf9453_pmic_write(pf9453, rdev->desc->enable_reg, rdev->desc->enable_mask, val);
+}
+
+/**
+ * pf9453_regulator_set_voltage_sel_regmap for regmap users
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O can set the
+ * vsel_reg and vsel_mask fields in their descriptor and then use this
+ * as their set_voltage_vsel operation, saving some code.
+ */
+static int pf9453_regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned int sel)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	int ret;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	ret = pf9453_pmic_write(pf9453, rdev->desc->vsel_reg, rdev->desc->vsel_mask, sel);
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = pf9453_pmic_write(pf9453, rdev->desc->apply_reg,
+					rdev->desc->apply_bit, rdev->desc->apply_bit);
+	return ret;
+}
+
+static int find_closest_bigger(unsigned int target, const unsigned int *table,
+			       unsigned int num_sel, unsigned int *sel)
+{
+	unsigned int s, tmp, max, maxsel = 0;
+	bool found = false;
+
+	max = table[0];
+
+	for (s = 0; s < num_sel; s++) {
+		if (table[s] > max) {
+			max = table[s];
+			maxsel = s;
+		}
+		if (table[s] >= target) {
+			if (!found || table[s] - target < tmp - target) {
+				tmp = table[s];
+				*sel = s;
+				found = true;
+				if (tmp == target)
+					break;
+			}
+		}
+	}
+
+	if (!found) {
+		*sel = maxsel;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * pf9453_regulator_set_ramp_delay_regmap
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O can set the ramp_reg
+ * and ramp_mask fields in their descriptor and then use this as their
+ * set_ramp_delay operation, saving some code.
+ */
+static int pf9453_regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
+{
+	struct pf9453 *pf9453 = dev_get_drvdata(rdev->dev.parent);
+	unsigned int sel;
+	int ret;
+
+	if (WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table))
+		return -EINVAL;
+
+	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
+				  rdev->desc->n_ramp_values, &sel);
+
+	if (ret) {
+		dev_warn(rdev_get_dev(rdev),
+			 "Can't set ramp-delay %u, setting %u\n", ramp_delay,
+			 rdev->desc->ramp_delay_table[sel]);
+	}
+
+	sel <<= ffs(rdev->desc->ramp_mask) - 1;
+
+	return pf9453_pmic_write(pf9453, rdev->desc->ramp_reg,
+				 rdev->desc->ramp_mask, sel);
+}
+
+static const struct regulator_ops pf9453_dvs_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= pf9453_regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops pf9453_buck_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops pf9453_ldo_regulator_ops = {
+	.enable = pf9453_regulator_enable_regmap,
+	.disable = pf9453_regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = pf9453_regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * BUCK1/3/4
+ * 0.60 to 3.775V (25mV step)
+ */
+static const struct linear_range pf9453_buck134_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 25000),
+};
+
+/*
+ * BUCK2
+ * 0.60 to 2.1875V (12.5mV step)
+ */
+static const struct linear_range pf9453_buck2_volts[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * LDO1
+ * 0.8 to 3.3V (25mV step)
+ */
+static const struct linear_range pf9453_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x64, 25000),
+};
+
+/*
+ * LDO2
+ * 0.5 to 1.95V (25mV step)
+ */
+static const struct linear_range pf9453_ldo2_volts[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x3A, 25000),
+};
+
+/*
+ * LDOSNVS
+ * 1.2 to 3.4V (25mV step)
+ */
+static const struct linear_range pf9453_ldosnvs_volts[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x58, 25000),
+};
+
+static int buck_set_dvs(const struct regulator_desc *desc,
+			struct device_node *np, struct pf9453 *pf9453,
+			char *prop, unsigned int reg, unsigned int mask)
+{
+	int ret, i;
+	u32 uv;
+
+	ret = of_property_read_u32(np, prop, &uv);
+	if (ret == -EINVAL)
+		return 0;
+	else if (ret)
+		return ret;
+
+	for (i = 0; i < desc->n_voltages; i++) {
+		ret = regulator_desc_list_voltage_linear_range(desc, i);
+		if (ret < 0)
+			continue;
+		if (ret == uv) {
+			i <<= ffs(desc->vsel_mask) - 1;
+			ret = pf9453_pmic_write(pf9453, reg, mask, i);
+			break;
+		}
+	}
+
+	if (ret == 0) {
+		struct pf9453_regulator_desc *regulator = container_of(desc,
+					struct pf9453_regulator_desc, desc);
+
+		/* Enable DVS control through PMIC_STBY_REQ for this BUCK */
+		ret = pf9453_pmic_write(pf9453, regulator->desc.enable_reg,
+					BUCK2_LPMODE, BUCK2_LPMODE);
+	}
+	return ret;
+}
+
+static int pf9453_set_dvs_levels(struct device_node *np, const struct regulator_desc *desc,
+				 struct regulator_config *cfg)
+{
+	struct pf9453_regulator_desc *data = container_of(desc, struct pf9453_regulator_desc, desc);
+	struct pf9453 *pf9453 = dev_get_drvdata(cfg->dev);
+	const struct pf9453_dvs_config *dvs = &data->dvs;
+	unsigned int reg, mask;
+	int i, ret = 0;
+	char *prop;
+
+	for (i = 0; i < PF9453_DVS_LEVEL_MAX; i++) {
+		switch (i) {
+		case PF9453_DVS_LEVEL_RUN:
+			prop = "nxp,dvs-run-voltage";
+			reg = dvs->run_reg;
+			mask = dvs->run_mask;
+			break;
+		case PF9453_DVS_LEVEL_DPSTANDBY:
+		case PF9453_DVS_LEVEL_STANDBY:
+			prop = "nxp,dvs-standby-voltage";
+			reg = dvs->standby_reg;
+			mask = dvs->standby_mask;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = buck_set_dvs(desc, np, pf9453, prop, reg, mask);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static const struct pf9453_regulator_desc pf9453_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK1,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK1OUT,
+			.vsel_mask = BUCK1OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK2,
+			.ops = &pf9453_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck2_volts),
+			.vsel_reg = PF9453_REG_BUCK2OUT,
+			.vsel_mask = BUCK2OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_reg = PF9453_REG_BUCK2CTRL,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pf9453_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf9453_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pf9453_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PF9453_REG_BUCK2OUT,
+			.run_mask = BUCK2OUT_MASK,
+			.standby_reg = PF9453_REG_BUCK2OUT_STBY,
+			.standby_mask = BUCK2OUT_STBY_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck3",
+			.of_match = of_match_ptr("BUCK3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK3,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK3_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK3OUT,
+			.vsel_mask = BUCK3OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK3CTRL,
+			.enable_mask = BUCK3_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_BUCK4,
+			.ops = &pf9453_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pf9453_buck134_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_buck134_volts),
+			.vsel_reg = PF9453_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PF9453_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO1,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo1_volts),
+			.vsel_reg = PF9453_REG_LDO1OUT_H,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PF9453_REG_LDO1CFG,
+			.enable_mask = LDO1_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("LDO2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDO2,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDO2_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldo2_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldo2_volts),
+			.vsel_reg = PF9453_REG_LDO2OUT,
+			.vsel_mask = LDO2OUT_MASK,
+			.enable_reg = PF9453_REG_LDO2CFG,
+			.enable_mask = LDO2_EN_MASK,
+			.enable_val = LDO_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldosnvs",
+			.of_match = of_match_ptr("LDO-SNVS"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF9453_LDOSNVS,
+			.ops = &pf9453_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF9453_LDOSNVS_VOLTAGE_NUM,
+			.linear_ranges = pf9453_ldosnvs_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf9453_ldosnvs_volts),
+			.vsel_reg = PF9453_REG_LDOSNVS_CFG1,
+			.vsel_mask = LDOSNVSCFG1_MASK,
+			.enable_reg = PF9453_REG_LDOSNVS_CFG2,
+			.enable_mask = LDOSNVS_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{ }
+};
+
+static irqreturn_t pf9453_irq_handler(int irq, void *data)
+{
+	struct pf9453 *pf9453 = data;
+	struct regmap *regmap = pf9453->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, PF9453_REG_INT1, &status);
+	if (ret < 0) {
+		dev_err(pf9453->dev, "Failed to read INT1(%d)\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (status & IRQ_RSTB)
+		dev_warn(pf9453->dev, "IRQ_RSTB interrupt.\n");
+
+	if (status & IRQ_ONKEY)
+		dev_warn(pf9453->dev, "IRQ_ONKEY interrupt.\n");
+
+	if (status & IRQ_VR_FLT1)
+		dev_warn(pf9453->dev, "VRFLT1 interrupt.\n");
+
+	if (status & IRQ_RESETKEY)
+		dev_warn(pf9453->dev, "IRQ_RESETKEY interrupt.\n");
+
+	if (status & IRQ_LOWVSYS)
+		dev_warn(pf9453->dev, "LOWVSYS interrupt.\n");
+
+	if (status & IRQ_THERM_100)
+		dev_warn(pf9453->dev, "IRQ_THERM_100 interrupt.\n");
+
+	if (status & IRQ_THERM_80)
+		dev_warn(pf9453->dev, "IRQ_THERM_80 interrupt.\n");
+
+	return IRQ_HANDLED;
+}
+
+static int pf9453_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf9453_regulator_desc *regulator_desc = of_device_get_match_data(&i2c->dev);
+	struct regulator_config config = { };
+	unsigned int reset_ctrl;
+	unsigned int device_id;
+	struct pf9453 *pf9453;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf9453 = devm_kzalloc(&i2c->dev, sizeof(struct pf9453), GFP_KERNEL);
+	if (!pf9453)
+		return -ENOMEM;
+
+	pf9453->regmap = devm_regmap_init_i2c(i2c, &pf9453_regmap_config);
+	if (IS_ERR(pf9453->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->regmap),
+				     "regmap initialization failed\n");
+
+	pf9453->irq = i2c->irq;
+	pf9453->dev = &i2c->dev;
+
+	dev_set_drvdata(&i2c->dev, pf9453);
+
+	ret = regmap_read(pf9453->regmap, PF9453_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if ((device_id >> 4) != 0xb)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	while (regulator_desc->desc.name) {
+		const struct regulator_desc *desc;
+		struct regulator_dev *rdev;
+
+		desc = &regulator_desc->desc;
+
+		config.regmap = pf9453->regmap;
+		config.dev = pf9453->dev;
+
+		rdev = devm_regulator_register(pf9453->dev, desc, &config);
+		if (IS_ERR(rdev))
+			return dev_err_probe(pf9453->dev, PTR_ERR(rdev),
+					     "Failed to register regulator(%s)\n", desc->name);
+
+		regulator_desc++;
+	}
+
+	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf9453-irq", pf9453);
+	if (ret)
+		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);
+
+	/* Unmask all interrupt except PWRON/WDOG/RSVD */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_INT1_MASK,
+				IRQ_ONKEY | IRQ_RESETKEY | IRQ_RSTB | IRQ_VR_FLT1
+				| IRQ_LOWVSYS | IRQ_THERM_100 | IRQ_THERM_80, IRQ_RSVD);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	if (of_property_read_bool(i2c->dev.of_node, "nxp,wdog_b-warm-reset"))
+		reset_ctrl = WDOG_B_CFG_WARM;
+	else
+		reset_ctrl = WDOG_B_CFG_COLD;
+
+	/* Set reset behavior on assertion of WDOG_B signal */
+	ret = pf9453_pmic_write(pf9453, PF9453_REG_RESET_CTRL, WDOG_B_CFG_MASK, reset_ctrl);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Failed to set WDOG_B reset behavior\n");
+
+	/*
+	 * The driver uses the LDO1OUT_H register to control the LDO1 regulator.
+	 * This is only valid if the SD_VSEL input of the PMIC is high. Let's
+	 * check if the pin is available as GPIO and set it to high.
+	 */
+	pf9453->sd_vsel_gpio = gpiod_get_optional(pf9453->dev, "sd-vsel", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(pf9453->sd_vsel_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf9453->sd_vsel_gpio),
+				     "Failed to get SD_VSEL GPIO\n");
+
+	return 0;
+}
+
+static const struct of_device_id pf9453_of_match[] = {
+	{
+		.compatible = "nxp,pf9453",
+		.data = pf9453_regulators,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf9453_of_match);
+
+static struct i2c_driver pf9453_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf9453",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = pf9453_of_match,
+	},
+	.probe = pf9453_i2c_probe,
+};
+
+module_i2c_driver(pf9453_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF9453 Power Management IC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


