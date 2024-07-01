Return-Path: <linux-kernel+bounces-236515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1891E348
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D473B21592
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202116DC17;
	Mon,  1 Jul 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdNREojC"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58316D9C7;
	Mon,  1 Jul 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846243; cv=fail; b=Y/jB2Re+vSRPSV0O5LDPpgSb74d2E35UmY9g2d/UKMEXs8TAEsGB+eBsarQ/BhVziydtuDq7IZysMTOSwQakLiaVr8A6qe/9wXYTHAimDxVb1LB3qd8h0rRb1L1PUfWFOtdJvZ9I5LoG6xvf3xVUq2h9SDgfu4w0BBhSnzJbT7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846243; c=relaxed/simple;
	bh=fw3MksJyhAw68VsBYYaJc4HIrPQE9U5fFN5w0fbrnD0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XqioGRsKm/aAjXVFOmHoZwGQEqvhvKQqK4iGzyhn+8SyEi/vUOXk/9r+KQhVtsZJmcL5W4ZlGyhnM/j2f7+XWHBHXlZvrBNkF2XLXREKZuoyDzrjb9CfmQRveYRqXdCvo/EQ0x8hg6569dQ30BE6SUbm5X4Zgnz/A+jOVpunZ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kdNREojC; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7+uAwEvG7pxw5xsyc4ggEfCBQI0fXE30fDWMGRgK4/AwnZDTch0fT1S1wBeaENtT3CsZxjLcTRFT0o68FbWSUUpekfAPNp3NiA7+CiJ8BqMQvKXwKbSzG9t/5MOJVUUJ0TISQZQEwdoT4RkSeYkWbU7qQrprbEuPfLWDJydxtQZJbgGkujS8AAJUmtj/EOsomkPBhC/Q+T65uzgvUJ8niKYoYeYLSJp/nxqyQN2BLazgGkEAJQLFRsxZr/wXaYAjuxzOTg6cHO3AvhqCBjjNV60+blB1f3/FFM4EefYUwzyK74gkY2qacRGQsS1RgSgllnJFthai/9ylSCPgIWitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25zwrmqAnqe6n4EfLpGkvyNw1oS186ZzdjMTpqcd9/0=;
 b=GbOsL5rcljW3mXa5ADTth5/yjTHylV/SA2DALhQrQKkJBuCu2+uzQRb4ax14wovASdFkI+LEoOCnDVANZpetVEYix+XTSQj7ObPWUG8C1hT/FmrjhI3M2t840fS34KRz+tx1P8kb8Q0rCerUiYmSCQMMSNRjlR4Lo/yURgCvUdqrJaiN6qd5LonCe4lyl7uStImr46K0kBRY2C8UhPFa9k1/8A/lhaCIGJOP2pZ7yAwn4HMqn6IHW460PUAiNBE58cOAKxBN21aBQQex+dDWcrzZ24aFRE2GtJqzl9R1jFuaTgBZ6Ijc09LmrYkgD29+VSug37paaqOnLhnEUmxmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25zwrmqAnqe6n4EfLpGkvyNw1oS186ZzdjMTpqcd9/0=;
 b=kdNREojCkUb5IaPUI56Ze8rp4rZbDQwMcYOjIG0XoveQcqNXXfLaOA8GH44gpBSzAGLrJ6ysn/dq/4xxQQdPTM9iRmtmdFYEc566LKVyas3es4PV3iRHTplE4lEuDQEjiJ2oSlkU11EH1lvW0+pHzASU+spawHD5r5Pj4hZ/7v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:03:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:03:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:29 -0400
Subject: [PATCH v4 3/8] arm64: dts: imx8: add basic mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-3-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=9484;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fw3MksJyhAw68VsBYYaJc4HIrPQE9U5fFN5w0fbrnD0=;
 b=9NoztnyJdr21oQJBuCM58YEoSbJdrxz0YvblwNQW8299KrV4WDflptVQfGRzLDMRckYB4z59I
 f+k5Yd+rnTOAaiW1IVEPt5wIqyilp+JS6Nn0Cwe38j3CD9NP5PfJ4fR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7e8b7a-c92c-4d21-d6b8-08dc99df0870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkRDdEYwWC8xODJsdG9zaTcrZVBnOVBHakt1S21aMkZoajBsanNzN2NlSGdt?=
 =?utf-8?B?ekxFQmc2VDZZdXIyZ3ZWeUVxUjlObjhQajJId0xqaXVYbG5lQlpSQ3IyQ3hw?=
 =?utf-8?B?TzBrQlNwVE0vLzJNWExXcmlQQzk2WlE3M0ZNMmlLTXN0bW43dzIxcGxMdjlG?=
 =?utf-8?B?Mk8xOTU4eXkyTjF1VGNzKy9KT1YzWmlNSFpSRURDci8yUFlLQ3FVaUFSVzV6?=
 =?utf-8?B?alhTOGZ4Qy82MHhLeUdZQ0lPQjBlUEU3RG9WMTVZQ0R5NmphYnE2Nmk1OURw?=
 =?utf-8?B?a1hwR1lJV016NUFodXhXQnZHaDhOaXlaK1VxR3VwVWVDWVYwekh1RU43YW5E?=
 =?utf-8?B?WGFjT0xuWDF0eUZ6NWZWS3IxN0pQR2hHNWdFYTNidm9oZnFiSzg1bmRwYkY5?=
 =?utf-8?B?Vnh1SU8yOVBwSlBPUUFQWW9TTmsrYnlaR3hNUDN6QTNpSWRGdTRuanJ3WDE1?=
 =?utf-8?B?WE5LM04zQUlIaDZtUzNrYjF2L2ZVS21mSWprT3NreFg2ck4xNHNCcHFZelBy?=
 =?utf-8?B?T1RaYkFWZEVOdDg1WXhLZlJ5NDBXRGgycXgreUg2a1BHenJBZFVKcC9XTXFt?=
 =?utf-8?B?WGtVUzhjbnlYeTRkV0phMmFQeG96eU03bmZYQ0pWNDhUbW5GaFhuL3A4SFEz?=
 =?utf-8?B?TTl0UGZFQ2xTcnVTbUNYaDFRL1YxVTVtVnU1T1JJVDY2VDEvVmhYSERxNU5m?=
 =?utf-8?B?SDlCR0hhMWZTS1dlUERMSmJkZzZjaGtvSnExbzJKazl0elpBcDFtK3B1LzFr?=
 =?utf-8?B?bkRPYnl1dXF5MXorazEzT3g1Wmg1MFR5R0RtQ0JIcWFqbEdmTUdieVZ6UVlR?=
 =?utf-8?B?VEtDV1J3Ullxa05IUkRjVlc1RGVwS1NFNExuejVtZ1BuZXJNMHR1M2JzelN4?=
 =?utf-8?B?QThTNXpBVUtuN1Vva2NVcCszNmNHaWNWd01jRzlZOWFML1hnc0NqTlFJc1Zh?=
 =?utf-8?B?bStiNHBka0xqS3ZlNHhNVWZwZ1lCWE5GajVRRVVqQlJMblFZN1lLUUNnemg4?=
 =?utf-8?B?MFI4RzF3NkpPQmc2anFrR3pOR0ZWdzBFWWl6aGUrN2o0RnhVeElJVGRTcFEy?=
 =?utf-8?B?b25LTG9Cc1kzalk3WXU1ZEJZUzlUdzdlYnhpbmdkTzRyeVpadXVLWUExY0xh?=
 =?utf-8?B?dzNzc1FWZ3dkRGFEczdQL3p0ZVF2NHUwMWZGODMyNXYxREIya2F0TC9MQ3or?=
 =?utf-8?B?RTA5TmVqeVNoSFRVMWpuK0dTQ08rbzV6RUNlZmJYa1dHcSszZW1WNUludFpO?=
 =?utf-8?B?eGZ6QU5ZZmJKay80OFcyWUpyQmJyUXN1UHZSYzlRK0RkcXdrTlFQaVNRdWpr?=
 =?utf-8?B?TnZQbXhhQlVuY0FTYlFKN1g5R0lXditHdDdpTkVVcFJJNmM3YlFBUzNOVDkz?=
 =?utf-8?B?WGY2YmZzMlJNcmlzNXJHZ0duOFF3dHYxbDhDTUQxMjU4TXp5YXg0aTZ3SEtH?=
 =?utf-8?B?RldGLzdiZVFicFgxbThNZWJFZGtlQ1VaVE1mNWFNY2NtekhnWElIZEFzZXpW?=
 =?utf-8?B?YTBBeUR4ditmRU9VM0ZaUDZjMXIzckVuQURqckY1ZEhLczFDQTI3ckZkWjNU?=
 =?utf-8?B?MlNiRU5jb0VFb2JrbW5sNXRxNVRNNStKTjNBRFIrN29uKzlCb3ZYdHV2aU8w?=
 =?utf-8?B?cUNYTzMxL0FIQXVNdGJqREdVOTFmdFJ2NmxwTnhMWjBtT1QwWG00eXlrSGkv?=
 =?utf-8?B?WW1HTWNzUEtBVEtaNHVlUStobW1YSGEyVGZDOGc3b1lhRFZWL1JGUERwSzdV?=
 =?utf-8?B?Wm0zS2ZXVzZKMkJBZTN4N0hJNFpvVmxyeHIxT1lyZlVRdW9COEJpZ0VPV1Nh?=
 =?utf-8?B?akd2cXowYlBPL0hZd2phK2VHSm1VZjgwNmY5WGNGd1BWdENIUWRsbE9pdXBl?=
 =?utf-8?B?eGFvUVREb3NEOUtXRVFCNnlRQThWSFBBVERibzQ1bFdmR2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1dnOXlqd2NwRTQzeTRFaVRuL2s5TFFQbTU5MHV1NHQxWDF5cUVrQS9qNU1x?=
 =?utf-8?B?SHVNMVdvNitJcURNTjFpMXRGWVJyd0U5clhyR2V3OThoZHdzbHE4SWpFTTBp?=
 =?utf-8?B?dkRsVVVZS3VjNUlSeitIU2NaaThFMVEvZUlWeXFjRXMrdGh2MmVxcVVidTBj?=
 =?utf-8?B?YS9lU2szRWZDRFA4N05Dc0ZaSGE2b3pRRlZ1azI5MTd4Mjg3aWFBQ09OMCtJ?=
 =?utf-8?B?a1Y4bkxnTnI3L0h1VVordmVBWDJid3N5clNrZXZya2VkdzU5OFZXMWhzZHU4?=
 =?utf-8?B?dnEzeXBEZkRMWnY2MnhOVWJKczhhQTgvV0NhejVTcFBCOFo2VDd4RVFTSnBs?=
 =?utf-8?B?K09aL3E5OVBxMmx1dVhkSnhPWFNBeEdBY2lReDB5SkZWTUVFWEwyODBjWWhx?=
 =?utf-8?B?bCtmM0JSZGZRbHZ0cmttWmY1ZXFkbWJjMmVSZHlnMXJmZG9aMzlEQVF2UldK?=
 =?utf-8?B?c2VMRy9zMmhMT1BPNTROem9idHVCUTdhcVJXV01zS2hTMDF4UkNFTStWajR0?=
 =?utf-8?B?Q0FBM3RKZktXek03NkdQVDBFQ1JUSWptQXVhRkl2Znkxd3hUSE5PRjJuN3lx?=
 =?utf-8?B?ZDB6SjE2dmJYSzNpRVVxTmxqaGxlZWlXanJhL1NJd1BFTjVuZU8xNzNUZ1Bs?=
 =?utf-8?B?UEJZOWpHUWxGNlRNTjR3R05XNUU1djJJbXMzVEphNlVEa2dydFlWTTV0UWh1?=
 =?utf-8?B?MnpRMnlmSytBdzdXeFJ1bldmem04RzJxUEs4RlV0ZlJUOVZ5d1ErK1dOaG0x?=
 =?utf-8?B?Q3J1MVdPb0hvc1M5RDVQeEhoYUhtWUVtdkJiNVlOWkJlS0Nrb2ZRMDVpeldI?=
 =?utf-8?B?ZXFlSGg0NlFXU29qeXN0RGx1UUhZcmZaaTRNbDFMMkdSRmZValRBUGp3RlN1?=
 =?utf-8?B?Y1ppRGwyYTlNR1FiTTZPUE9RclZHTFgzRmNBSTVBUGhGRWFBTnYxY1M1Q2Zt?=
 =?utf-8?B?MFNhK3pYSGNUejhsOWN3N2JONCszeURteXgyeDJoOCtjVHlZYXdlTHoxZFdY?=
 =?utf-8?B?YUt4VnNsNkFnVUg0YjgzUGJRTm45ZmpxSHRxTUp6bVhsb1dXcHBCRi94anhS?=
 =?utf-8?B?THg3VDVzZkxsakw3QzN0Tjg1SlNxUzJXUXIvNDY0RGxrMFN4ME4ydytCNUp1?=
 =?utf-8?B?TUNEeThhT2tHYmpiYnllY20yRTVxWEtETzNFVGZETTkwcWpTOVZ3ek5DbjBS?=
 =?utf-8?B?QXNMeEVFZW1NeXJvNGNoV1ZrWWR5MjdUNmNIMXVNWXk2WFRZTUV4N2t2Y29o?=
 =?utf-8?B?UC91RDFCTlVaWCtmNFZMQktaUjdWM0VaUis0WXpsT3llL29qK1o0NE5sTmxx?=
 =?utf-8?B?VkVpRUZQUTVZalc5ZjBFQ0NvcVIxWVJGVzBMWm5xTXVKRTlCb25IYjhwZEw0?=
 =?utf-8?B?eTNab05iWHYxVkttSm81UWtWSXVqd01pd2xLeG5OMExaUUpldzR6RlViS3Np?=
 =?utf-8?B?bjRSSjd2ZlhTdEFURDBjSkNTQjRUMTd6OC9HZkxuN3dnTHUvck9JWHhnb3lv?=
 =?utf-8?B?WGNraTR1RnpBNjVjcVJ4RDl6eWViYUhRU1FLTUpSOFd5bE1uZjF3QWM3ckxS?=
 =?utf-8?B?anlZaWEzT2JMem1Jam5yazNUTFJlbS9KbWxtelFBaWJvOHEwK3ZLUVVXMlB6?=
 =?utf-8?B?WFN1ay95eFhPRXIyRTQ1ZlNMOW5CTG96aElLMFB1WXNlUDgxNmVtem83S1NY?=
 =?utf-8?B?dllnWFZtYU1vWDl3N25ydDJwd1RyZCtFMnQrWlpEaFNaU280RkpqSUxDQXNC?=
 =?utf-8?B?c1dYbUJjeXZnbXJvdysrMFNIUElRUDJJSTZIbWMrek5uTnBEVDhkQkcrT0xC?=
 =?utf-8?B?d3FNUmFmdmhrZUQ0TnQxSWhBcXQvcmlhWjlSK09NSmVwakwxMzVTU0pENkxM?=
 =?utf-8?B?cTlOMnc3dDA5dXVCdG1ibndFNnVER2RhOEdubVIxQUFaMHRxanZtVGdPRHdv?=
 =?utf-8?B?M0QydTZncnFPM1NIU2txVWh0UUt4dE13R0sydk55bGl1LzI4NUY0WGpiUHhS?=
 =?utf-8?B?cC9PVUd6OG5VT3pXNEluamg5aFNzUmJ6QlNXeWZnZ3VpMk5ldFVLN2lkTHlO?=
 =?utf-8?B?U3QzbnJzT1E5aXlzT1BtOEZQbkIrTy9pRkJSdW56WWpjL1BkT0hoOGVQdlpO?=
 =?utf-8?Q?AFHk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7e8b7a-c92c-4d21-d6b8-08dc99df0870
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:03:57.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChX1ZEnBiQ5BaqHYu1VB5EmFUwVdWToG/fsshHuyP4fRCW02gxWJ8KDi8rPg0ut7S3HcCUezgw2PIY+0PWN6Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166

Add basic mipi subsystem for imx8qm and imx8qxp.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi | 130 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi | 138 +++++++++++++++++++++++
 2 files changed, 268 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
new file mode 100644
index 0000000000000..834c0472a8901
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi0.dtsi
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+mipi0_subsys: bus@56220000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_mipi0>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x56220000 0x0 0x56220000 0x10000>;
+
+	irqsteer_mipi0: interrupt-controller@56220000 {
+		compatible = "fsl,imx8qxp-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x56220000 0x1000>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_MIPI_0>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	mipi0_lis_lpcg: clock-controller@56223000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223000 0x4>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_MIPI_0>;
+	};
+
+	mipi0_pwm_lpcg: clock-controller@5622300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622300c 0x4>;
+		#clock-cells = <1>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+	};
+
+	mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223018 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622301c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c0_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+	};
+
+	mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223024 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x56223028 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5622302c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi0_i2c1_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+	};
+
+	pwm_mipi0: pwm@56224000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x56224000 0x1000>;
+		clocks = <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_mipi0: i2c@56226000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x56226000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+			 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		status = "disabled";
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
new file mode 100644
index 0000000000000..5b1f08e412b24
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-mipi1.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only and MIT
+
+/*
+ * Copyright 2024 NXP
+ */
+
+mipi1_subsys: bus@57220000 {
+	compatible = "simple-bus";
+	interrupt-parent = <&irqsteer_mipi1>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x57220000 0x0 0x57220000 0x10000>;
+
+	irqsteer_mipi1: interrupt-controller@57220000 {
+		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
+		reg = <0x57220000 0x1000>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		interrupt-parent = <&gic>;
+		#interrupt-cells = <1>;
+		clocks = <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+		fsl,channel = <0>;
+		fsl,num-irqs = <32>;
+	};
+
+	mipi1_lis_lpcg: clock-controller@57223000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223000 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1>;
+	};
+
+	mipi1_pwm_lpcg: clock-controller@5722300c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722300c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
+			 <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "mipi1_pwm_lpcg_clk",
+				     "mipi1_pwm_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+	};
+
+	mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722301c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223014 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223018 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c0_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+	};
+
+	mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223024 0x4>;
+		#clock-cells = <1>;
+		clocks = <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x57223028 0x4>;
+		#clock-cells = <1>;
+		clocks = <&dsi_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_ipg_s_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5722302c 0x4>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
+		clock-indices = <IMX_LPCG_CLK_0>;
+		clock-output-names = "mipi1_i2c1_lpcg_clk";
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+	};
+
+	pwm_mipi1: pwm@57224000 {
+		compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+		reg = <0x57224000 0x1000>;
+		clocks = <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
+			 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <3>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		status = "disabled";
+	};
+
+	i2c0_mipi1: i2c@57226000 {
+		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+		reg = <0x57226000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <8>;
+		interrupt-parent = <&irqsteer_mipi1>;
+		clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+			 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		status = "disabled";
+	};
+};

-- 
2.34.1


