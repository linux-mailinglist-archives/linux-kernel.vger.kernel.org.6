Return-Path: <linux-kernel+bounces-232851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ECC91AF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FAAB2922A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA619AA63;
	Thu, 27 Jun 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGvM43LO"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD3197A98;
	Thu, 27 Jun 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512862; cv=fail; b=IekVg1MohJOtiiYb3gHXy7a9xVH7z1qF71ZXggyijyO2aMfMWiku+wdBXQpdq+1Qfsh7eVcehEng7WjCS7rdRYKIWej+ypw76jWdkAQeEirXbzpC3DH/uKwKb2tW0q1gE8F0NJBCUx69mMpDsJxpSXBNpEpl5FB9gVsvyWHmZig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512862; c=relaxed/simple;
	bh=drCapCWkq/TFsIfohoySU5vhRDJDCgQRfe1pP2Jdyas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dW4dKSWNdtfk/2JYTNkNHTFvMm3uOXrx1X0DVbCBfcwoYamTF4syzn0mtvcZsY3N666nk+T1dHZxIbEfsqW2Hx1wiFQexjtxBKeZT1abXSKZYaFV7LGDCUhEH3hyCZOub151Dwif+hZMkQ7DZFQaU8ss2/wLuggJzLaAX7/KXTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FGvM43LO; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/jB7lY5wqO9Arr/az9JXcp7mFYh6NQeIx3wBLGhWo8yj898ku04ibUsgDjnOHKgiU/gBGrMz44QnMN6gYqFmtXd8vJA3pxtMw2eA5Vu9FnY8trieV4w/2ygzdDL255LxnSkz5fpjJQYdhhPchG/A+/ZrTJS1AgVs9b4G2awUUE6SxYr7D9Ia+WJ2xosqP5K1USFF5KzoYoQoUnAaUdg6rYul5BtJwzwFdXAkBHRKLgKLvjn1qGD3YGESaE/01qafUCcJT1WjxR1gSF6vlrrNexkUsA6fapl2ZMG1pbQOJX+1PiD2q6Asb1f/Hm2jRZBOadpF6AKPd00mzLhJ3XxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+wbuscEtE9CCtm4Dm13G8aFxIlEtcJbXP3dB7KcpJE=;
 b=G6V5vU3n4LBwrVLIRgNYKCK1NSvVzspL1OJ37dNVZpLKeoZSNa5DraAU2gK+YvEvEwOsXrQ91VldWhWWgGzjC5UtbtHDFEPv3MKr7Xx/TalvLqfRKIWIjPGQGODTNL+guJK6a9EoDPNS5CVx3gZsBJJgg/+EE3KC+YtaCd0sDfTctSkSrzBvWSJGc/eaTr6XMlygXM+bvVwSdV8SwWJgxHBw4m9orMdCeGG3v7ZeVljK2qQxDESc2Ej8yrTeISVddarjf5/vZCN0PLjKp1Nb7KnC72hXqrDxA0VRa2Skx5wkoea7Zb4ezCKJIobfGs9+XQnKiDwRN1FVWqvfGZ9GqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+wbuscEtE9CCtm4Dm13G8aFxIlEtcJbXP3dB7KcpJE=;
 b=FGvM43LOuhE7oIaa6stGagtrTfYx+W4N9B26lfv2wYQS89OYA8pnCPcJJ335GVn2IAtjBOO1npA5fWYb5a/AK65C9WmsG6oYQUykC+3sV3lmjtMjNmttOmazI6mu11ueh1TwC5c3RS1ceEx3PqOu+i4xeObuO/dsU7qJDAFYus4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11057.eurprd04.prod.outlook.com (2603:10a6:102:48f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 18:27:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 18:27:36 +0000
Date: Thu, 27 Jun 2024 14:27:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 07/13] arm64: dts: layerscaple: add #dma-cells for qdma
Message-ID: <Zn2vEe//vELVxRae@lizhi-Precision-Tower-5810>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
 <20240626202533.2182846-8-Frank.Li@nxp.com>
 <CAL_JsqJDOgGWqggWXE-_jv6oQW9nekxU-4Fui+2JFZ6DWUqLtg@mail.gmail.com>
 <CAL_JsqJ1X8rRfVrw0gGeiiQaK+9RekNFSHgXR3zhcNRNw5y9mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ1X8rRfVrw0gGeiiQaK+9RekNFSHgXR3zhcNRNw5y9mQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11057:EE_
X-MS-Office365-Filtering-Correlation-Id: b9090194-bee8-48e1-c998-08dc96d6d1d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlBUckdaMXhaZFlmdkdUeUVVNE5ZclFWTlEwRXRseXExSWNOdVZpNHk1dElo?=
 =?utf-8?B?T252Z3Ntak1SaFp4MTJueFBPZHdFNTdNVEo4dU40bUJVeVpSZjBQREEvWVVQ?=
 =?utf-8?B?YTkyN3UzTW9LZUxiVmIva3RUZlpoNE5RRFdySlJTOVB2L2VTYnhQdG9qRnlQ?=
 =?utf-8?B?UW0vdUxsdS9sVWhTdElEdUZkMVNQa3ZxK0FCbU5GQ0JIQkNkMTRGVkQyZmRm?=
 =?utf-8?B?UElLTjNsREdwRkVVUDFjbTE1T3BZK1RlRlNOOVRSa2lsTEhvZjVicVpNT0g1?=
 =?utf-8?B?UU8vZWp1SWFxZEhsWGNiMzFqcy9ETzRMWEZ3RUtZSjJRMHhJRllUVGFsMytG?=
 =?utf-8?B?U3UyT1NVZlZma0ptRkt3VnhXbWF3dG85UHgvVS9NRWlLdmczMUswa0gwN1hD?=
 =?utf-8?B?K1dPTE5SUWxSa3ZwYmJtYXB2Z2I1ZXN6RWtyTXpudUZGL3pZcFYzYXVhc0R4?=
 =?utf-8?B?bkRZZDZtcnc0T0IvQVdMa0lWVWY3MTRzQ0RCQVM1Mlp6ZEhIWUVQY3h6L3pl?=
 =?utf-8?B?RG02V1lNbndTVkovblhQcVE4L2kvTzZjSWZ2VnkwUVNsaC9yaEJnU0tMbGJW?=
 =?utf-8?B?YTAxYlRiUFBlOTh4VnB0aXJUbDYrYmo3ckMyRGNMcWo2N25LTGlucnByMHNJ?=
 =?utf-8?B?aTlKUTNQdW0xTWJsUTdJT0FBdCt2bVFLRnFqaWxwM1ZMaWVFZUtwWHd2MC9G?=
 =?utf-8?B?U3NTQWxTUjRZT0JBWktmZVFKRmJIbVl2OVZYOUwvQ0YzOG9vNG5yNGh0dSs2?=
 =?utf-8?B?U1ZqY0puTmdQNUFzeTdDSFo5YlhESy93cDYrRWdHMDFlSjVmOEQ2eHhZZSsv?=
 =?utf-8?B?WTFpcUVNZEQrSDhQVzR2L2FOZWZVSUx6bXdxVWcvejZxeTF2Rk0yRGpscnp0?=
 =?utf-8?B?N0NacW1IYzY1WjZFdEV4MFdPQnFUZEUwam93NGNJcFlFWjRHV3pMR3BoeVdv?=
 =?utf-8?B?QmN1NHBWSHFzOGsyNm00S3RqcXVnYlhpV2dNbFVSaEtJcjZVQ1ZPa25ZOXNp?=
 =?utf-8?B?aW1oZ0o5NkFSbVhjSW5kdGtRV0hSUGY5U3RmNjY4WXFVYVRmSy9kYy94REpn?=
 =?utf-8?B?VkZZTDBNb2tucG93bEJ3K3VOREJYalFPQVNpWVVVa3BKZFpWQjkvR3Nmd0VB?=
 =?utf-8?B?TlJ5L05ZUS92bTJYc3ozR1pkTkliTFEzVloyWVJpd2ptcmh0bFNDOFNIRGRX?=
 =?utf-8?B?UEF1blRHdEJpUFFWWjRjckRGbWpBcDJsdHhuNWRlTUNzcUpyNkwzNGhtNHcw?=
 =?utf-8?B?bkRGNi9DYXpBN2hlZjk5NU9OSDBSQzh5M2FEUTFka1E1UWJLcCt0Ly9qcjk4?=
 =?utf-8?B?WDlJSHUzZVB6bCtoU3hRd2FQVGlOL0FiWW8vUTBWRXNCeC8vRjV0NHk1aGd6?=
 =?utf-8?B?RnEwR0crQVZwcVE1MXFaNEFWb3ZFQmlZMmp5a29QVWplVTROMDJiZE8vVStU?=
 =?utf-8?B?dkVpTGNIbDUyeHN4VGpvckExQWM2VjNzQVNNbGpna2o1VFY0L2FOS2xpR0lN?=
 =?utf-8?B?M2FxM3dlWU5tbUJDbEpvK21ZaU82K0NNSEJMbE15bWErMzBOVXpiS01GZXZv?=
 =?utf-8?B?Y1BUL1pueFV3aWtNbUNvNUhIa3JSY2kwUkc1OVBZaG9oSHIxenFDN09rTERz?=
 =?utf-8?B?WFFWSk55VVgzMXdjc1kwdHhPLzFkbW1TMmZ6REdiQitySzJCcnI4TnFzNExO?=
 =?utf-8?B?T3hSa3hFR1JHc2ZuUzdJNk5LVk9ObEV3SkF6S1ZnUmxIdWVqWCtuWnJCb2Rv?=
 =?utf-8?B?aHdWKzFZaEdrTDJsV3d5WU1FeXlIamttRGdnYUtCdXI4QnBFQXJtTDJOaWNK?=
 =?utf-8?B?N2l4U3J1YVM1Uks0c2JyTnA3R2ZJZjZZdTJCWGpaRmNmUXh5RDRvaEZuN0kv?=
 =?utf-8?B?L29BVktMbE51Mlc0dFFVTmtYc0FRTVV6QkJUTnFyM1JVbUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWU2QjFpb3J1YmxxQjZFTE5UZlJGa3ZReVZTallUL0hOWGx1blRGdEdBbEY4?=
 =?utf-8?B?L3pQeVFxRUQxbFUyL0huQ1VVbk9JV1VWMVNEVFM0aUZmL1k5Vm1ydE1maFhz?=
 =?utf-8?B?WjR5aEptNGVIMUtxV2QyWUpsbjNENTZWQWRzR3F2c1crSXdiVWl1VTdGYlh2?=
 =?utf-8?B?Z1hJWjFEcnhmT2tMWC9ZOTh6Vlc2OVcvNVQ3ZUVJWDJ3TDVHd1RvNmptZDIz?=
 =?utf-8?B?QzlTcEZTdGVYd3NLWlcvOU11eHJpZDlBaFZWcHhTWGtMU251YVRDTDZPQm5V?=
 =?utf-8?B?YnpVNGwzUkJJTDl0N3dtOVMwb3UyZndJanAyWm5ieFhzcFFhYkJ5alFxdXBk?=
 =?utf-8?B?NzFZbnRCWHNzd0VOaHVZODU5OGE3Rk5XK3N4NDlFL3kyb255Q3YzL3lvQlZH?=
 =?utf-8?B?c1VzVWovRFBYdllsanZEVWRyNFYyR3JSRStnaHhJODBYTVEySkFRMTJjbHNJ?=
 =?utf-8?B?cXdzT2piZDN0ZnlIK0MzRTZDM05FOExRTm1YQjlWQnZaSS9LaGxlZndBU0tU?=
 =?utf-8?B?MjI5c0haOGRJeUVnNk1BUTB6d3JOS1h4SUhvcEIxMlExeVQ5SjhqeW0zRXRr?=
 =?utf-8?B?a3hhY3BzSFphVFZxTFNqZW9lWEdyR3A3bzJGMFZKSjdTSmZtZW1YaVg1SDd2?=
 =?utf-8?B?T0ZvdlAyZC9wQ1VBMWV3NWlkbWJKa2huNmk3cjhha2I5MFU4NktzTFlQNlNk?=
 =?utf-8?B?NjdCcTY4a0E1RVJZdG9JSENVK3dpRmpBbGdLUDRuZjRiNFF0NHJGWDZyTnZs?=
 =?utf-8?B?RGVhM1lwejlLVVVuZFN2QVREQnJjZWxPNUYrN0RyZ0cyOXhMTmJ2c0tjN3FX?=
 =?utf-8?B?YVJoWDg3bk1WTWNXbnJSclJxOWhBY2Rwd3l4Q1A2eWczeWl2Q1kzTUZBR0k0?=
 =?utf-8?B?dVRWUmJ3VHB1Tnp1bkRESDU3TWNUejFOazczdk5MOXR6WUpvbTVWQTFLUkhh?=
 =?utf-8?B?TXNQWWhDaGl4bmxMT1Q1emxpT3YvOHRUVVZSeXFMdEtOWkpsbWN3RkVGRDlp?=
 =?utf-8?B?cHVMeUd5blRJc0lxY2Z5VkJBZmhmRWtWMkV6ZlIxODR0N0dWVFN6S2hEWmpp?=
 =?utf-8?B?b3lteW1DU2h3SGVqZXAxZUZZVmpSUmVvcDRGU1JaMm9MaDUvV01yakpXeFFy?=
 =?utf-8?B?VmFLWlYxbjJtdVpQc2xORUVEZFR4MGdiQnFLZmQ5SG5penZCUjdNS2lYTDN4?=
 =?utf-8?B?TVVaUGQ3UTI5SkVVUHFFSFY3eHFkWjZaRUpSUExvUytDaUFFdFFqdk5oNkRY?=
 =?utf-8?B?YXR2VHA4NklybktEeGpwbzk3R3ovOER5OWl2QVlQU294bFRYOFM4bklqci9h?=
 =?utf-8?B?dERBZUlxSlArUUhvUlRlWGx5QVV6YmkvZE5QZHU5VWF6dzhiVUZJME9XaXdU?=
 =?utf-8?B?OUs4U2dJd0hXR2U1eURxYlhHTHFXNUc5TzZIMnl5ZkpURUgrZnZKVmw1MnNi?=
 =?utf-8?B?WjNqRVNRNlh6OEJTYWI5dkozRjJrOGp3TXJSUnBhR3RaRm9tQ0xFdldYd0dD?=
 =?utf-8?B?Zy9kbTFlMzU0RUFQMDlUcFJiR3VPTnNzdmdzWVFYRkRtOEtXSSsvYVhQeFJY?=
 =?utf-8?B?N2M4UW15YmhLaVhtc3NSb3RsWG83YW0wY0U4b3c1ZG44eXNxMWU5TXFUMHNo?=
 =?utf-8?B?V0FRVysxaFYxOFNGYmx5SU1PZm50dmp6d2VEWjhZaVdSb2V6T21mMDl4ZTRq?=
 =?utf-8?B?M1g4TzRpMFpOQ1cxMk90WnBuU0ZZdGpSZjdCcU9lSmhrajlwemxPSTV3c2ht?=
 =?utf-8?B?TkJRWDkxbnYzeVM2YXVCek1CUSs2ak5FOVcrVDNmZ2lOV0ZpbFRXVmpNKzZm?=
 =?utf-8?B?T1RwaTdxR21maWYvOHFoRWtPdGk0dkJKRllQYXh1ZHBGWitoRGVaN1VpZUw5?=
 =?utf-8?B?ZFpDbzJiNkxHeVlhR2QvREF4K2pHTGlIdHNyNnJVMjhKbmNmSUY0aEZ1eTJV?=
 =?utf-8?B?V3VoQkpNanltN0s4UWlZdTJCZUlOcE0wZ1Q5UmNWOEpOWWloWFpldjViTXA3?=
 =?utf-8?B?VHRjU3lUMDhPM1AvdFFMbytFK0tXTWNpN3JZd08xR3hOMUlVcjllaXdib3BB?=
 =?utf-8?B?TzNzbGM5NXJ4bDd1Q25tbkVvMFIzNzk1aE8vSTRPM0U1NFhTMHgwVk1NN0t2?=
 =?utf-8?Q?/Rtg1cnnmDbC6SiVbhXzv14X9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9090194-bee8-48e1-c998-08dc96d6d1d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:27:36.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3j8gBfEdYzDjZgm/X8mJidS0DSk3bUPo0qJbXUYMpaDAYvG7uyNiYL9JTMKJA7Gsqu9XTsVNL7r4smnG6GRCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11057

On Thu, Jun 27, 2024 at 11:22:57AM -0600, Rob Herring wrote:
> On Thu, Jun 27, 2024 at 11:17 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Jun 26, 2024 at 2:26 PM Frank Li <Frank.Li@nxp.com> wrote:
> > >
> > > Add #dma-cells for qdma to fix below warning.
> > >         dma-controller@8380000: '#dma-cells' is a required property
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
> > >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
> > >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
> > >  3 files changed, 3 insertions(+)
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Except for the typo in the subject...
> 
> Frank, while I appreciate the great number of reductions in DT
> warnings on FSL platforms you and others have been working on, your
> work is sloppy with issues you should find yourself.

I found the typo after I sent yesterday. I planned fix it after collect
some comments. It was already in shawn's tree. I hope shawn can help fix
it.

Frank

> 
> Rob

