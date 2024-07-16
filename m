Return-Path: <linux-kernel+bounces-254430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D7933317
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EAA1C22123
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD5770F5;
	Tue, 16 Jul 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OriEyJQa"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023087.outbound.protection.outlook.com [52.101.67.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96869D31;
	Tue, 16 Jul 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163173; cv=fail; b=JmvZV9lq3a6UAV9wArfBCCy6slZ3NKnCXUAdN8DrIU2Quq4qQYIBGShQcZCOy2xWyG7FcnxmHLMTnm2ozogYfUZKQvQx7eLbvqXnHolKOnY8EInwleONSjF+cFewi7sDnPU10QpD+gnTJnuAZTZpXLFTneDvXmATYK1yMsVwlX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163173; c=relaxed/simple;
	bh=kIv5uJixOFXxsWQybqG7Hk0q+1NVtO2MLSxZuwEMikI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=c8xVknlLHRKuGKKZCWZb0PpZEf9dStJtS9amDafnu8iWztYOqAToQJX7qUeunu+8CReE/njCie1gcth3NC4IrPRdQPdmAWfKyQKRYAqEdTUHSiFCEdvevl9nAjFnKQjTFwWoIDwpoxyplQdOKtKYmcJN1BQnN0zwv7RXKAzmv2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OriEyJQa; arc=fail smtp.client-ip=52.101.67.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA2QhjOhGkJBQ3bBX40ChyesDVtduzshoWryTLywgYNVIGrGVtURO74RN8rSZPndrQl33x0Z31xUCvA9CLTkcC2WNu/3/o7QF8wRmoHsX5UpKOGNGsassn2DKDo3PV4uNFnfd+ChHaX8HG+4ODrYL9meSHqi1e7bwz1ExF+3OqKRSXUb2pU+QXJSkzKBdpdGSF3psQQ5TNVlpEM60YxKiRaBf6AJtvrx50jVJwXarcR9UgEfNKLBkS7PmJIzTCTfCmtxbmvD48yY378l2ad+E7IM6NOguS53MEVA3UdH1BUHurDA41ZHFvTakRsDGsUSWRP/cv6QpXvBJH6alxP3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgPpoMARCDZtwyufpwR5McVZjH4VaeNPTmvphkPPwO0=;
 b=ya6VHtGSc/4eW8TXLSlPSvfPVaftnKRcgNjg+1AcwrMTY1olvvTrmH0xPVXniV8RL6f3w3uxplcHD63fBrB7pekCarjBaeBLhch/Qn7w5KF00t7gy9NXo6kyzP17iZq53dw8XTkL9xr9bxwcZ5z4+mBPeG4x485rDZ2ljx2RK2bxVn87Dghe5S0aOMRU0qzDpOqJ2DQMSL5ydUkLUppuoaSu+9YtZeBfqtznQLVwaPQGOegevq84aERTo+GjAoEMp4HnqyNuLtyFxBDTWW2pp9mCq0PJRZMXbtIaFN3H9Dk/24Ul+Bw6tgbD2clnnpfAhlECnC8bSEOsOvyYgg0RgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgPpoMARCDZtwyufpwR5McVZjH4VaeNPTmvphkPPwO0=;
 b=OriEyJQamHS0LpmCFEgAOM+htuyZlepsk+vDK7uwXVlOSCMWDsxxu4y6fMmPhc60eLJAA4jEtKPyYR7USmxsOQap3MJDRLW+DKxF+EYo91Ir1jJEpPK/L/Jaw1kLvglxCYWJyZD8Ft0spohg+8u2nc5eGwBnPWzhsl22eknT414=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 20:52:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:52:44 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 16 Jul 2024 22:52:38 +0200
Subject: [PATCH RFC v2 2/4] arm: dts: marvell: armada-38x: add description
 for usb phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-a38x-utmi-phy-v2-2-dae3a9c6ca3e@solid-run.com>
References: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
In-Reply-To: <20240716-a38x-utmi-phy-v2-0-dae3a9c6ca3e@solid-run.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM8PR04MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbb9154-6edc-442e-c53f-08dca5d93e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czIwak9qTGE0UHBLUGlpeDYvbmtEY3Q0YzcrUjVUVkN5SS9sTHpPOTF2REtS?=
 =?utf-8?B?ZzFuN2g4V29NVVZNNGU4SlJiNFBwaHRRUkg5WmJMYk1EYjdBKytYSWo0UU5R?=
 =?utf-8?B?RHlZN01VaUMyT2cvdU9Ma0dQQ2NYU0FKU0ZaWVFRY0kxcXlEcWpYaDZiZWxX?=
 =?utf-8?B?REhOT1ZqL243SnE5cFdKL1ZOMkxvUm1PN3NiVTVUQmZCVnJJTCttUHpsTTA3?=
 =?utf-8?B?WVIzc0Rnb1lZN2xxK1kzRlJ3SGlROW9kTnlNZEErMWJ2eTNvUDFGY3M3UVVt?=
 =?utf-8?B?ajhKOU4rTHNMemwyaG53aTUwQkE4ZGIvWjdVUnRUaWpjL01RRmlCTmVwbWJV?=
 =?utf-8?B?RUVsUWU1N2puQkg0RDV3clBjR3JDUE85TXljNDZQdDFGcXhndHNYM2U1N2Qy?=
 =?utf-8?B?U2ZBSlltNnVVN3dLWDFJWjA4WnQzQ3VZYzBXeDN6cHkrWG9Nd1RiTjFTNThH?=
 =?utf-8?B?MThETEZEampta3FOTk5tSDNyelNtSjhwcnQycW0wWldRNks0ZVFNS2VIaCtp?=
 =?utf-8?B?NkYrWDR6Y2Y3dVJrVDZTREhVK2lhNUNoZHUyanpxYTVhQXdmTk8zZ0JOV3pI?=
 =?utf-8?B?ZmV2NGZUWUJHS0NDaUlJcWNwNDNRZlN1MXJWSW16eENFWmZzZzU3SnYxRU5z?=
 =?utf-8?B?WkNpdjR1VXBhS1ZiS09TYVF6R0FPT3NrUTVGZXYrejh5UGJTdUx3Wjd4VlRt?=
 =?utf-8?B?anVlSSthQkZhcStHWEpISzZrTGptZlpzdEJlSVVpNWFPRzBkQVQ0VUU1OXJX?=
 =?utf-8?B?RzA0V3htd0czaThmTVQ1cUN3dHkrbVovaGpQZmJKNnNBUk1jNmgvZUVjM1pY?=
 =?utf-8?B?bWtHZFE0a3JlVVFYTDJwa3plTnVaLzBJU1U1a1NSc1I0R2VFaXZ5VVdCNmk4?=
 =?utf-8?B?RzNKS3NQU0RmY3grQXZwZEdoTUlpV2hGUzJldGRXdzkrdzFKQzArOVRIMi9H?=
 =?utf-8?B?WFpCRUZjMlFiSkRpWGtqb2wrL0g5T3pWWWkzSTJ1K3VJdjBvTGNNYnNDMTd0?=
 =?utf-8?B?YktXeUhDOVJWQ1U4ZzY4M2ZwdU9YOFhjYmZSVk5ONEg5eGswWlJwUU84allM?=
 =?utf-8?B?U28zQUo4ekJEblVqMHpFNXdhU04ydldYNTBGdXQ2UW5LOFhXbVNJdEhabUg2?=
 =?utf-8?B?VGlvcUZBbnhrNnJLS0t4WVU0V2dNcEZTU3pLOHhLb01FcVZUWmVYWGtSYnV6?=
 =?utf-8?B?TVkrQkpzNkFtV2t4VjVTK3pGV00yTUkvbVFKVzdPSUdHRjhtaXhqYVYyOVJY?=
 =?utf-8?B?ZkgrSnVvRGI3SkU2Vy9mRE1mNXpxQ0JqdXJ6cmVYOVMyQVAvajZIQnhiS2tJ?=
 =?utf-8?B?UGgrOXVCV2ZrdWsvYWNOTmJiYnI4d01acTJOeWNBT1VSRzJaRnUwM0ZpZkpw?=
 =?utf-8?B?TEFTOHNETnZZODR3SDZKT3NWcGNVbE1WTitEVEJTK0ZSd3J6SUVVcDBDaDY4?=
 =?utf-8?B?MUh5UHI0V2NrckVUak5RQUwxUnRNYjZETG8wUTlnZ25wZzJvblMzelpqTXVV?=
 =?utf-8?B?R1VjaEluUUh3Njdua1NPelJYN0FRTE5SVEE1VHVCQXBBZEN1UThnaHlVNlFp?=
 =?utf-8?B?WXNtRk50Z281WnFsOERSUG9jd2p3VEY2c2NRdWhYdUFCemxVVjd1aHBicVha?=
 =?utf-8?B?eHRlaEJLeEp2dHNyQWVlQ2tuRTV0NnRzZ3BHejE2ZXJRelFkZUJPaDRFK0Ry?=
 =?utf-8?B?MDdBbm5MVzRpMkVma01YN0FqV1ZBMjFyeDZnVWRyUVhsTk5FaFluRzBCY0RD?=
 =?utf-8?B?UjdHU0I3ZDhuSk01c09xS0J6RlpBeTFMY2RTTXY1TUVGS0JFYmwrWVlrZ1ZN?=
 =?utf-8?B?dzFQWHQ5RCtEVU94cVdoa0REY0kyeUZqbE4xQWtNNmxIMFFpTmwxZ1RqYU9t?=
 =?utf-8?B?M1dBT0ZRaGtQMVRkYXJqVzZvS2x4amRjejExQkR4Mi9XaVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFIMXdqa2pQclcxb2R3N2RBdGJOdjdURzVONG1oV1VRSDlieHhaNGpqRm9D?=
 =?utf-8?B?ZXZpaHhkMkN5d3ROd25RdVZsR09IMjIvY1JySUw4UnVXWnpLcWdldUdneldm?=
 =?utf-8?B?MzJsL29jTFJsZEJFOWpEMlVYTWZ0NE5MV0Mwd1BjN3lsbjVWaTdXOTBRMW44?=
 =?utf-8?B?ZytVMFNCbGF5WVF6MmJPQzZtMTFCdlFJdkZzRE5mRHhkamNRemhtTzVUUmZD?=
 =?utf-8?B?NzI1TEdyQUhEemt6NmVERVpPMURrQnorbHlOVGgzZE80Y3ozYlo5VUU1TGhO?=
 =?utf-8?B?WmQwUXd1bXhNV2xJUEZrWHc3WW5uVHRHRDM3OC9RNEFXM3NGWEVvUUNOWHV5?=
 =?utf-8?B?N1lveEFzek5XYmdXUjNWK2hWa3BnMGRDRm00MUZUdklzNmVjSGtRL2xtNlli?=
 =?utf-8?B?eVBjTnhOcUNtTnZCS3I1RkFURG1LbzYzZXo0bThwVWEvY1dTcDhjSjJqdlFs?=
 =?utf-8?B?ZmVlcXN0anlZM0NJNEVxQUVtWThVL0VYYnFmcG40ZDYvb3JpMkQzRHNYN0hV?=
 =?utf-8?B?U1ROQXZBQXpvcTZ1eEJzSStNenUxUVJrZS9CdEJmMVJISTVrek4waUVIU0V5?=
 =?utf-8?B?Sno5QmpQTGVNYnBkeFRFNTlMOUtLTWlWR3Q1SUlNTVVLdFlqZFhxaVJ2T1B3?=
 =?utf-8?B?VXhHRTk5STJVdXVFY0VobnNaaVloSU5HaysrNEJudkFrRy94QjAyZlY2cWd2?=
 =?utf-8?B?d3BPM001Qnl5STFPNnJlNzlsT2FYNDBNejRlS0diTitRSENzVFZJQU9STjBB?=
 =?utf-8?B?Yk9tZTE2cWZFYmpkaThCTWEzSG50Mm1ZS3phM242SWhkT0E0YS9Rd0psRFp0?=
 =?utf-8?B?eUh3b2orTFNNSktnc285Y3g5cXNXZ01PSFBoUUZDYUN2TWJhWUxscTlzSE5v?=
 =?utf-8?B?KzBPeElMaXRlRkN6VFR6QnJQZThuRGEwQkUrK1RkMDE2Vnp4b0wxRHdjUVNB?=
 =?utf-8?B?Q1JJYmFYeE1rdnZyTDNjVW5MOGx3c0xOVzVqMkV2UUVVTHErZDBVNVFacHIz?=
 =?utf-8?B?bksvUGxVNi94Y29TTFJZSCtoL29mUmh1clNadkZwWmpCOHNTQkdxYndPTjRs?=
 =?utf-8?B?Yzl2ckQzYjdSdStqZUgxeDhJajJtcnZXeC9pY3Z0akJxaU9xc3Bka2ROTkQz?=
 =?utf-8?B?dTFSaDZBUFFOWnBYYWF2REhPOVdBbkc1dzcrZWxTZlVXalJtQytIR3U3dTNP?=
 =?utf-8?B?Y0NsSnRBMjNNTUZQRlRFZEcxR0RabWRvdDl3c21EbjFuNFA4Y2V6UlM5aHND?=
 =?utf-8?B?ckxWNWJEdWxDMGFtOUlCTjNCbFZrZG54cHZqK3I1Tk5YMURhMS9IVmZ1VnZu?=
 =?utf-8?B?TG0wYnlhcXZUdUJjT2pqT1JMS1I1ZmhuMHAxeHpiNHZrRGhMUE5CV1FQc1hK?=
 =?utf-8?B?U1VVa3lRTVhDTXg2WmhLTWFleHJLc3lpRkV2c3RSbGE2VTF5dHNkZUNPRjFn?=
 =?utf-8?B?TGdvckZROHJpdVc4VG5RU0FtSWZXb0tMdlpDNUFHcDNGc2JkaWpPZUcwSXJs?=
 =?utf-8?B?UnphMTl3Vm5vUUdiaERLR3ZRS0lNaDV5WG8xY09qNlhFZ1BSNWwrVWFjT1U2?=
 =?utf-8?B?V0k2cGtncTJZNkV2Wk9TSmtzc0NqTWQzTkRja0Z0WC9HL0xELzZlWC84SVJu?=
 =?utf-8?B?eGw1Z2w2bkJEQjRFY3psMW55RG9WdXlZd3c4T1crM2ZuZkVCY0J6NU85alNt?=
 =?utf-8?B?elZxazFXSEEycjl0dEpSOGh6Yk9ZQVd4WEVvbVhiV0l6dm95MHpscWFva3k4?=
 =?utf-8?B?NUJ2K3VjWFdNTHVQN2Jod0p6bjR1K251aE5WNC9vZ1QvbVM1L3k1YWNkWEpl?=
 =?utf-8?B?aFdXa3dYeGxRcm5QbzlNUGhtVEJGVHpUOUZNT0xrK1VrWEhqY1VYVExkMDhH?=
 =?utf-8?B?RmtpMy9sWVNhdy9PL1lIMk9VWmZrVkgrcjhiRFk3bW9KQnlRR3d1TDJ0VXdF?=
 =?utf-8?B?SmE3ZzhRb3ljc0tKOGJHYUx3NWU5ZVJuMnVMRy9WQlc2L1hLVGg4Ukpac0ky?=
 =?utf-8?B?TFRONEx1dXJlSmNnQjI1VDBQTUpyRDcrUU96dkNmY2txaUxyV3o0c2pNRmo4?=
 =?utf-8?B?WEZWSVluSGg2UWd5dFcwbSt3TFJXS0NVeTRQbElJNkxNSEVTUG1mNnBjNnJS?=
 =?utf-8?Q?nNIrke/Dta8v9JYxcbugE3r1o?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbb9154-6edc-442e-c53f-08dca5d93e13
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:52:44.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9HGy0otIDKklpOflQ3rJJKdsrUelBf37E8vn8HW4LaWFGPxn0wMxgre537q7V8sIg5elXs734MHCDarI6Dzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

Armada 38x has 3x USB-2.0 utmi phys. They are almost identical to the 2x
utmi phys on armada 8k.

Add descriptions for all 3 phy ports.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-38x.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/marvell/armada-38x.dtsi b/arch/arm/boot/dts/marvell/armada-38x.dtsi
index 446861b6b17b..701a1c0c19ad 100644
--- a/arch/arm/boot/dts/marvell/armada-38x.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-38x.dtsi
@@ -392,6 +392,11 @@ comphy5: phy@5 {
 				};
 			};
 
+			syscon0: system-controller@18400 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x18420 0x30>;
+			};
+
 			coreclk: mvebu-sar@18600 {
 				compatible = "marvell,armada-380-core-clock";
 				reg = <0x18600 0x04>;
@@ -580,6 +585,30 @@ ahci0: sata@a8000 {
 				status = "disabled";
 			};
 
+			utmi: utmi@c0000 {
+				compatible = "marvell,a38x-utmi-phy";
+				reg = <0xc0000 0x6000>, <0x18420 4>, <0x18440 12>;
+				reg-names = "utmi", "usb-cfg", "utmi-cfg";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+
+				utmi0: usb-phy@0 {
+					reg = <0>;
+					#phy-cells = <0>;
+				};
+
+				utmi1: usb-phy@1 {
+					reg = <1>;
+					#phy-cells = <0>;
+				};
+
+				utmi2: usb-phy@2 {
+					reg = <2>;
+					#phy-cells = <0>;
+				};
+			};
+
 			bm: bm@c8000 {
 				compatible = "marvell,armada-380-neta-bm";
 				reg = <0xc8000 0xac>;

-- 
2.35.3


