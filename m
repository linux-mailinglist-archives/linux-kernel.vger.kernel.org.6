Return-Path: <linux-kernel+bounces-257977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9069381A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BE41F22689
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9B14882D;
	Sat, 20 Jul 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="K1C8xrBT"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022113.outbound.protection.outlook.com [52.101.66.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD766146A9A;
	Sat, 20 Jul 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721485182; cv=fail; b=DX4ypnaqAD6dm4cxRVKGathgFCOJJyoCM4WZ/N/kkMAbOZ+1AExReb0/pzqymp4ue3rfT7SXTPZeY5iu5aaCdT3NFxBCF9oYVGuKu130ZOw5LmQV3xFY13ArTjuTpEu7RnK9K6g63A5dXOWD/o/FAr9XHKDbE28H1plooyMkdms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721485182; c=relaxed/simple;
	bh=RG7k+Jxo8OiCrBF4JljlN5pBCxeHVXNT1oN6GyoBJF0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WUw/mt74dDgHm0ntsyzIResEAIdABbhtR/ZATeT+m2aidgWFCHAhmttBBQI2B3pxIYy0Gha9PhF3YBO93iiuOYgz0fiBdKGCqOhvpbwXTetsBXUcfQAwo4y8J5uqkQmH1WGyFZLu/KuSHJLdS9OoK0/2GPoaltlroplx+2jZUjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=K1C8xrBT; arc=fail smtp.client-ip=52.101.66.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnX738214bUSpvKDwdFRjWAW4MmSBmJCnhqCeGQUfxjgEQ8umeTlh3WbTjFhC3r0YHw5MmHegVab7YJJCvByoJ2he9bJY8NWRkQMYVWfPWh46yY9q/Y5LbZ+HblHhz7U2yZY+3nJE8WiIGKtkqlDN5DD3jvYV29BJ2gKleOU+AwDK1/H0LTRYj/KV7+xpdZ2Ce25q8pXRA3VoLiLGC464RqAMQni3Rt4v+EHcmHMwjqWeSPQWbvhM5dEl2GeDIJzy14yD0u2ogxDbdrIMPt3VqxenmwARn+70rgwGS+pZFmBqNfdCqz9BWQQXlrhwO4AAgB6IvW89XXav1NSI0u41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1TvpnJM/87JmHTipVIiJzSXmMY0iIBQN6czOczN4Zk=;
 b=x+u1H2TjfZQ4LQeVHaSn1QXFOANQV8kpBBVmfoVCYkWA2e72lWt3SPdXPYGXOtx3TyJMktJBdNW+jNZBfPfX2JxHRY9DE+xYV+TtYTXjGFbnplMuJA2GQPLsFvyY73vTwGVsMvYN4XrXyqzyz/XAMhOzBSVgxVxhAklfAXLr/JTUpWCU3LRfSjbzr8XueHVWp6uthb4HVUoutwoQp8zXzq9NbCJvAfm8R11MNdP5j9iPXrW4WeEvUHP9iGiZejtQ1SIRelY0ufAbNzyaZ4xf55TLIFEM5nQus5bun/GneSPchJ56T1/IJUXLWMiCKA0A9nwMg9WZFhJAYu5X2UuSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1TvpnJM/87JmHTipVIiJzSXmMY0iIBQN6czOczN4Zk=;
 b=K1C8xrBTWsSm8saSUgIC3+kNcg0/Z61uOC3xPaEbWeuTA3dbsofLNg2mFP37z30A4acLjgOcYKqZWlCd6h9Dkzk3peCIYrXp5GpJo3r/HogLWsj8zI6N79lTht8mG8Gl9x05WDcSsB7m+AICGUE9tpPRaWmidP1LKcvzRJbR7Yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI0PR04MB10299.eurprd04.prod.outlook.com (2603:10a6:800:238::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 14:19:30 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Sat, 20 Jul 2024
 14:19:30 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 20 Jul 2024 16:19:23 +0200
Subject: [PATCH RFC v3 6/6] arm: dts: marvell: armada-388-clearfog: add
 description for usb phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-a38x-utmi-phy-v3-6-4c16f9abdbdc@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
In-Reply-To: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Konstantin Porotchkin <kostap@marvell.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI0PR04MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: 532cb528-aaad-4dc8-a97d-08dca8c6f831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UElTMEtmOURoUXdWWVpKY2NwWE9HRTBrVkJMbzRqRVdHdXRuUEsyMHBkMWQ5?=
 =?utf-8?B?NC81WUVpRmlCZ0Q1SHlwM3RNRlFrNHFMU2RIVVlqaW5QcFlHamRGWFFpcys1?=
 =?utf-8?B?OFZSMmdHeXdXa24wWjltRTRybWV6eG9hVjlYOVZ4RStIR09QT29HUUs2ZytE?=
 =?utf-8?B?WmYzbXJHZ0U0dXY0ZG13eDJka0lSWStMbmhCZzZSRzV0amErc0RlYkxSSUpT?=
 =?utf-8?B?REFieTlYMzdjUmhQM2Q2MjYxOE1hZzlYZ2VITkY0RVZJT0M4RXV0cTJlNmRH?=
 =?utf-8?B?azZNdVJWaE5PNTFPSXdJTDdVVElwWnlnZzJRZzZublczendoWC9hNkJ4Q2M4?=
 =?utf-8?B?Qy81OXB0TE1qaDhWaXhnMk5UQ2FDOG9RQ2I5elhJM2N3SzdPSFBQeEVJVFdJ?=
 =?utf-8?B?Mml2QWxDb2pYc0M2RURrUXdub1dxbW9KNVFGb2c0NmppeEx4MDIySVBjUFhv?=
 =?utf-8?B?NWxMYWNNZzFjTkNtZ2tnWWNxUjNTWjFsOGVvb1ZxRnVMOG5kT3BpamdhK0Zp?=
 =?utf-8?B?NmFNNjVuVkt6TUM5NDB4OUl6NE4wdnRhV2p3OS9GR0JMQmJSYUNYUVN4eXht?=
 =?utf-8?B?Y0ZmS3hhbEJoVGNuRzk1d3ZZZ2hSTnk1aFVFN3k3WDJVa2I3UEY4K09HazBx?=
 =?utf-8?B?WGpkRGlocWJHSHBNZmtwUGo1SnFQR1lrMTdiNVovNmVZVE12V1VMK3Y3bG1X?=
 =?utf-8?B?VW1ldWJBWXUvZk5kdzY5RjRVSHpaVTRjdVZHOXB3bkJaOFRVcmI0OS9ZeVpj?=
 =?utf-8?B?UytwVnlOSzB0OUh2SThVakpyaFU4OGVKQlVVSlFUa2NQbUZPS1hZUUZDSGsz?=
 =?utf-8?B?MjIrV2NSRmdZUDhBVU5FbTJLN3JDWmg1RS81cjg4VHVVQmd5dXRtdDhQNXJY?=
 =?utf-8?B?a3lXc0xWTE9Gdmd3c3JhcUdPQi9SbGxLZDBFZUxRdFlLZ0dXU0x4RlY2TFdS?=
 =?utf-8?B?SzBueFFDYzZxTTYzTmxQeVhFR0xXYi8wemhYNjc1T0xDVjlRTS9JcDFPTS9P?=
 =?utf-8?B?ejJuUS9JeGRiMWpPbjBrVXRBaFJWanh3NUFBUGtoWG9UaFR3a0JRWk11OFVh?=
 =?utf-8?B?em1QRDlDMDE1VVAwaHBCWEZNa2wxNUZDZ1VRUGxtbzMzM04rSW5PZFkxVWhH?=
 =?utf-8?B?WGN6Z1FJRlZnVlhneW9yQWJLSHZ6VUNQdDlhQ09PWmFyOUhPdkhnMzJ4NGhl?=
 =?utf-8?B?bGUyZWhhT2NEbEdLZ0tyVXE2Sng5ZGdqLzBNdjNJbXV6MVlBM2k1bUtlSDlY?=
 =?utf-8?B?OGJ0OStoamdCVGQ4YVdJMlJicG42SS9oZkVQRWpXek56V2JDR1NJNFc4eU5K?=
 =?utf-8?B?V1BrZElFdFZUVjdrR2lseXVLcUJ6ZTZLclVpK0gxSVdPOG83WXRvQjYzT3Iw?=
 =?utf-8?B?S2VoQ0hDMUR1bkdnVXgvTE1hTUZHamNHcTBoUmZKeGRpamkyTWlGcjM3MVJk?=
 =?utf-8?B?Y2tUWlNKaEM1a0xIQmI0OFFCeVVoOU95WEYxMHNEaWR4OW82MjZvT211MmhT?=
 =?utf-8?B?WkN4dG5mWlQ5WVZLeEh1MHRUdTBncVlDV1A1ZDRUckZNaTVwMEpvMEdUZ0dV?=
 =?utf-8?B?V1l4RmlLMDFTcGhEeWlLb0JrZzhZWUQva0NtVW44KzVxeFc2VnlEVWZRNy9y?=
 =?utf-8?B?b0l0b1A0RzVTUklMYTc0MFpPdVhhb2FjZXRIQVlRbVdOWFpoS0dxU0VCR3Bx?=
 =?utf-8?B?NmZDRTV0byt4RHVFN3orSDlkZnJtUUZBNnNORTNpYlZkRllWRTFPUUx2a0ZJ?=
 =?utf-8?B?YlV1OVZWR2hpdTdFbmlYY0REd3BEVHdsSWFPNG1zWW9SakhhNGdmamhKUVlS?=
 =?utf-8?B?SlViUkdCby9yYWMxbXFRN0pnS1d2WWdRQXpOYm5tNS9vTStTUEI2ZjNPS041?=
 =?utf-8?B?cmR5ekg5UXhmamNHV1Qxcy9BQ1dXMGRTUCtUSWNaYmJTRmFsVEk2TFFnbWZa?=
 =?utf-8?Q?soRMcQKkMuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdJL05LRGx1U2pHMzBLK3NDTGhxaXhwS2RNakZmbStLbm41QnM0M3A5dERO?=
 =?utf-8?B?UUFNTFljRGx3WGZmdHdPTFc5SmdoNDgzU3NZNmY4RVNpdkVlSjZtZHJJcHhX?=
 =?utf-8?B?REt5QzBxZ3ZBQTJpbmlqaGVlT3FKODNiLytOdUxDcmlvWjdzSHJVWk5CTmhW?=
 =?utf-8?B?aTNVQUZuUG40cTg5VjYrL3pCV3R5ck1zbDhOQ0dVSitnWlM1d3dXT1hPZUxx?=
 =?utf-8?B?MkkvRElXYVBpQzJLR0VsRGxtRUQyTG9Pa1A5bk9GL0xZc0ZOUDlINk40WCt4?=
 =?utf-8?B?dW9mR2NWQkJKQVhxcTVnc2ZqVVlYWHJoR0o0Smp6Y0JEa2dLVjRkcXAvSG5L?=
 =?utf-8?B?MXVWRlBLVEYvOUNrUEwvZGVoRm05MGRZMGVRV2l2dXVhN3plUUxIY2VDbUlm?=
 =?utf-8?B?bE1YVHNHTlc3dXpoQ25xays2aVdZUWJRNEpUS1RUZVNWdEtvS1hWR0ZhN2Fs?=
 =?utf-8?B?Q0dGRVZUTExwU2d4WmxSWGYrZnZVRUx0U0tZamJob2c2VkU5TmNuak1NKzRq?=
 =?utf-8?B?SmJrZTJpUUxqbDJpRkdCTDFIcXNXUk1OUlUzZG52N3NZdjVPM3l4QittTEh0?=
 =?utf-8?B?RkNCKzllMFY1WXJEMmdvRzkrNTRsM3FHejRldVh3S1lrUU5jeXJ2a3F3MkFS?=
 =?utf-8?B?RU0zWVliMjVncVBlY3NkdmhPdUV5N2RKWCs4YmhHMERKY3k2V1lYMGE4RVpV?=
 =?utf-8?B?YW0yTkJtbVF4RkhTbVlxWGFUQ09HRHJTdUkyWFJiZW5CYjBDQy91dVhqVTAx?=
 =?utf-8?B?RC9kaTkwaGF3d2ptNE1UN3FmSjV0aGU4V2FwS0Y5ODhzZmNIMHFvTW1OMU4z?=
 =?utf-8?B?M0tVcXlyczJOY2xvZ0pwMjZwR1AvbHpESjZRNisxc2s4TWlrSGkrclhwSDZG?=
 =?utf-8?B?T1lRMzlVQ01YMFNlazRkdmpHVXdWU3hyWTJqeHVIQXd3NXNoU28veTZxUkp0?=
 =?utf-8?B?bkZDc2JBRXdCM0pVSDFpaVB1dGphbzlHaktXekR0YTY4UGlMeklMRzl5cGhC?=
 =?utf-8?B?SDE1cXJMckV3RCtsSElnNHR0UEx1ZVBnTklzWXJxd1IrNzNVcHA2SDJoUHd4?=
 =?utf-8?B?QlBoenZBcjIrQmRvSGFNTzlkMU1jNmJtWXBGNkpGWFd6MGw0dkRPUGJ2c3A4?=
 =?utf-8?B?VkxVMkt5U0gwNDVaLzlacTNVSllNRzJ4Q3pRM0lCb2FkZEFUc0NacnJ0Vndx?=
 =?utf-8?B?dDMrRTdlVEttbFFDS0t2TElyYmxYbVgyb29rdEFlbE90L3ZwOURKQ0NxVnN5?=
 =?utf-8?B?bkRpV0U0MHBsOVVwS2hHOENCZDZJN2RuYkxZM2kyelQxV3Nrc1lLekxzSmNm?=
 =?utf-8?B?cDIrVEN0Rms5cC9lRFcrNEo5Nks3WGE3Zk9CdURQVHFvSklSNHBuYTBjbHJa?=
 =?utf-8?B?MjZqL2tFKzBvMlNvM21IK0plcklwU05uUW96dmQzMnM0TEdvcEhmVzN1T1pF?=
 =?utf-8?B?Wko2ck9wb2w2N2tKOXdCZTF0YWp1Yk53WWYrUG9ucVJld0oyL0YyS1ExN01p?=
 =?utf-8?B?UFR5TW5QU3ZBZmZhNjgwbWMvak1kKzVQRndUSTdXYVErL3ZuVU5Pd3Q5UjMz?=
 =?utf-8?B?OEFMbjhidGVlME93WHZIcExWZGMvTURDaU85a09BZjF4Qmg1L1ZiQityeG5y?=
 =?utf-8?B?VzFqMHYwUHRRSytPNkZoSGVUTjM2YW50QUZRSTZZUlJFY0VNa0RQQ21VSk92?=
 =?utf-8?B?Sm1aTXFON04wWnozeVR1aXhHdW5HYWRTM2srWEROeE9TSmF6dDBETmNDTFlu?=
 =?utf-8?B?Y01CYU5XRHZmdnlDenpTcnFkdHZNMjdnbnhQaW5RYUxMUit1T1hGMjdqK29x?=
 =?utf-8?B?QnBKdklROWZEWUFvWnd6d2lDT2hQR09vQTlDRmErUjI2N3FoK2pQdC9UU1Ba?=
 =?utf-8?B?YmJVTGdpbVl1ajlRMEJNdytYVEk4bzUvaFM0Y1pjTGtYSmZuOVd1c0xyek1s?=
 =?utf-8?B?TGY0SkpZdURmRXdkWjRDc2ROTGlQMDZ1TWNIWFl1SmFNalJmSVVMSnNVV3By?=
 =?utf-8?B?N080VWVOTWV2SUFsZURBTGU4akZIWlpTT1MvYjV4UDFkYUtIcHAvd1ZtU2px?=
 =?utf-8?B?Q3JraGZGa1l6SldjM0VoaFhWUnB2Wm1HTXdyMlpNaFQyTFJTN05LdjdHYTh4?=
 =?utf-8?Q?00WLFVJWUT+U2htNnk+tbKrmZ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532cb528-aaad-4dc8-a97d-08dca8c6f831
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 14:19:30.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB8edAAY2qJeqHIfI4Sh7i2x7S+NCcxiZCUCia44crYLRW5C/0s96iuE/e8MnDCL3DDcohO3NdaolR0UOqEA+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10299

armada-38x.dtsi now has usb phy nodes for all 3 usb-2.0 ports.

Enable, and add references to the usb phys used by clearfog base and pro.
Explicitly set dr_mode to avoid phy driver warning messages during boot.

Finally replace the usb@58000 and usb3@f8000 nodes with references to
labels in armada-38x.dtsi.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../boot/dts/marvell/armada-388-clearfog-base.dts  |  3 +++
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |  3 +++
 arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi | 30 ++++++++++++++--------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
index 308ad9d1c70f..3edb7988ee2e 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
@@ -102,5 +102,8 @@ rear_button_pins: rear-button-pins {
 
 /* SRDS #4 - USB-2.0/3.0 Host, M.2 */
 &usb3_0 {
+	phys = <&utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index d6d7cc885f4d..4f5bb5867f20 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -185,5 +185,8 @@ &spi1 {
 
 /* USB-2.0 Host, CON2 - nearest CPU */
 &usb3_0 {
+	phys = <&utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi b/arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi
index f8a06ae4a3c9..0497fe13f56d 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi
@@ -51,16 +51,6 @@ sdhci@d8000 {
 				vmmc-supply = <&reg_3p3v>;
 				wp-inverted;
 			};
-
-			usb@58000 {
-				/* CON3, nearest  power. */
-				status = "okay";
-			};
-
-			usb3@f8000 {
-				/* CON7 */
-				status = "okay";
-			};
 		};
 
 		pcie {
@@ -243,3 +233,23 @@ &uart1 {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+/* USB-2.0 Host, CON3 - nearest power */
+&usb0 {
+	phys = <&utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SRDS #3 - USB-2.0/3.0 Host, Type-A connector */
+&usb3_1 {
+	phys = <&utmi2>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&utmi {
+	status = "okay";
+};

-- 
2.43.0


