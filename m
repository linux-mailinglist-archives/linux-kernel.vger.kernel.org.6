Return-Path: <linux-kernel+bounces-441069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABE9EC8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A31883206
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102F1A83F0;
	Wed, 11 Dec 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPL/PodU"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FF1A83E0;
	Wed, 11 Dec 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908919; cv=fail; b=Wv5AWB6e5goTVGhY7AEVuLs1aalwdBi0wK3AEx53G8B6uqFSy2/x6KgbsOkZ+rgKJ7Fap51d1132Apzs6Qm8LD0vVw2MEEIm6D403pOkUfkMZhSqiRUWnzfmmwzzcPjc7pK7gomlTGfmRLpqci+IWn+K+lz2TpOkgrEJgZTCQBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908919; c=relaxed/simple;
	bh=raQzm6P05sSpELHD5c7NUpOEjFeK/SpWWKRD17SIpN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xa+rpSm82tQu98qYe0wxRVDFjSrV0vJnH92vm+0qAnWNJzQwmAkF3i6mM5n295Ga+uOh4H1jAFzhjdn0Xc/hH8QULEE2kzu6mGow80vcl4aETX8l0NrWC80zVtBXdzXCAwI67mx7q4giz8GYjP0uup6lk32JLvqvIEuhOyBIgpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XPL/PodU; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhn7q11qGXNKI4vr6YHwzdWTuAfMcPxiO098YC3hH6JFKO82dri5XTmJa9S4eIR5jA8KGRwlR1fmylMfOY3Bpn0wTTvda2FFcceJwgOhfWBU5IdcdAinDgKr6RuMH339vrfpCkuUiKDu7rRs1pB1DBQw8zE+XxRS5X82ku212Oxhl64I+XHUAytmBdmTLo6JLHpCz6PSXWvfN1KcM9BrX/fJn66nc5PBR3KbNjyLN/hrACIbRqpXppNeBkzLYNs0nImDs9A1AuN3EDM8H5yRlLtOvRl8IS3hsD9g44wmc6mWnW9xjVVFnGHYRUvF0yZswF0F/+Dy4GN5D/CG4X7KNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmyd9sdiNMFb8OmZzpig0UzzlaiG1p2O92spgKxM+w0=;
 b=YaIlln+T7+PGWvJFVRguAi13vVynx5iIM3KEeQGSYcLZRfqJ/iyiWg5aEQF6lLmv+yVmDoNHq+NplWSLhxUCTzSwCa5Dc1XhuP+1b1YSAOfNbkXP/bt9MXp3X7u9RHSV+rFGweN0JaZTN9/dhp600hvruqPEWGPQ2NZwBtk1g/4AeIwurIPupdXXHTKXA6aX87IT5Ucd6O26Au8dFfihPRAl8tEGVEFlU5SriuxK2SpLgi7Xinwo6ioI/rEppCyrqkeDQg6yWeRurWMHSOROeCiiVR0sa6tvyx8l/zNW4OjarqPR+cqw2XUSo4dpLiy7HZUQfbpiNa7DLs8zfTtfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmyd9sdiNMFb8OmZzpig0UzzlaiG1p2O92spgKxM+w0=;
 b=XPL/PodU5u3qFlVpHaSnee0LiXdNauPz3UmCGGEo+NOJawiJm8a3xJNMq62O2c1akqTtF/xon3sU8TwwRLKk5bj8G39ydrFqdQqh+KxLcli17WYfkQ/HndS7Qy3w5Y4p5yWxapuxlnMjuvhBARDO/brMN9p8vzgk5FRb8af5gkiSQqU7cRrbkkxgqQGuTJH2Xv2dxZh9RkXzrYA5R6+etizp8dROLPVxf1P5UAv6PFTetUL6CyE5NVTQPngW4tpoBB6fM5uiFnJDLX2dg3xdx/CixCw5kINh3lBljBjkWyqp946IdTku3YOZ6F4rAMNlK68GWsm/YwCql5ZSTGFv2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 09:21:54 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::88b8:8584:24dc:e2a1%5]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 09:21:53 +0000
Message-ID: <f1382b53-d2b1-4622-af37-69431f764f79@nxp.com>
Date: Wed, 11 Dec 2024 11:21:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Configure imx8mp dsp node for rproc usage
To: Daniel Baluta <daniel.baluta@nxp.com>, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, festevam@gmail.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 frank.li@nxp.com, aisheng.dong@nxp.com, daniel.baluta@gmail.com,
 laurentiu.mihalcea@nxp.com, shengjiu.wang@nxp.com, a.fatoum@pengutronix.de
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20241210125338.104959-1-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::11) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|DB8PR04MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: fb282d29-81cf-472d-2817-08dd19c5405b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDZ3NDlFL3J2SDFEWFBjWFZMTG9Ca3FzS1RwUG92UWRSczFQZVUrd0RGNlRl?=
 =?utf-8?B?Ti9UY1pFenhPK0UvOXBOTWFhRGZscCtMV0xUWHBRRFRIQm1iSE13V3lrcU13?=
 =?utf-8?B?bDJiTEpTZFpJTTJtZER0MXhhMldPWElZVk0vYWtnMDZvM2pnUXIyYjljdkp5?=
 =?utf-8?B?aWRzcDAzTkNvWnRXMG9rL29iMEJjYWs0ZFloeTk3ZHp5eStaR3hkYTd4cjRE?=
 =?utf-8?B?dE94UVFldFk0NUwvZDNDaFNtaFgvamhjMUN6N1ppWjJqSDZmcG00amJVMjRJ?=
 =?utf-8?B?YXBSdnVHOU41ZmVwTEFRRUQyYVUzcWxyQlVZR0dBa2Y5MEs5TDVGa2cwZ3Z3?=
 =?utf-8?B?SkljSDlFa1FtV0FUVXNodDQ4VzI0WjR4N0lXMDJMclJ2RjZlQmV5MWIyRUVn?=
 =?utf-8?B?VFF2dTNkZnlPTGxFRE5Kb0RydGtOU0xVUFhBNUNZSmN3bGlOZFpOUktDVFVQ?=
 =?utf-8?B?U0dOQkh1U3E3QlZtZVdYL3BEMWRrQ3RiVHM5OXRwRERRTXV3cGpvTmpoOE5T?=
 =?utf-8?B?U21vaG80N1JGRzBYY0JPNzVaNVQ0YnIydURNd1VJUmxER242Sno0RjdWc0w0?=
 =?utf-8?B?MmpWU1FRcWt3KzczWU8wSTNhRWlGb3EzWDNNMkdiWHRoeGRSS1JNeXlCeWxw?=
 =?utf-8?B?WHZjVzZvKzRUTTlpWFQwVEZtVHRuNTlXMEhKSGtQS2RwYkhqQXpTRExnbUxy?=
 =?utf-8?B?TUlCcnZDUDFVZFdaOTFYK0RIVXFnYS9VUnBjYjJzcXZlUDdFUXVhTS9ZRTBs?=
 =?utf-8?B?Zm9BMFQvNVdyamN1WCtsZzYwZlJEYWpHUkVjdFdMTGJxMXpGUW9GL09iSnA2?=
 =?utf-8?B?RkdzZ2k2QlZ2UzNicmFYcm5DMnU5cUFXUktiZWRyeUVCZUZBbWdFSW9YS25B?=
 =?utf-8?B?WUlhdE9pSDJaZGxKNUdsTkx0WW03bjdoTjBOUjJwdUtxcExiTGFVbTBIbGhG?=
 =?utf-8?B?OXRhZHpCclh0NnVTMFBjcStFSmd0c3ZNeU8rRHc4ckFWZUR6V0l5enVqMXRx?=
 =?utf-8?B?UmR2U2Yzby9RYVRaSnhPeFpqakt3dWMzYnd0RURiSnBOYkFDU1R5eDZEdy9y?=
 =?utf-8?B?M2xMQklhUnVQbnFVY3huRTdHSDVEWjFZSUtvY2xxQW94dUhFTXUwVS9jMVVI?=
 =?utf-8?B?YTBuN3lGSkw3bkRBQlFXa01nelJVYnVoTmRTbnRaU0cvRU9hcVBWYjJxbk96?=
 =?utf-8?B?eG9hTDR4dWRGMHBiVnVtVk0yc1RVVnNybE5ia3ZkR2ZiOU52SWRGa0hJV2Fj?=
 =?utf-8?B?Zjl4MGFxc3BOZExVTDlMVjJNZTZ4MXBYV1FqM3FIckVMd2tWZDNRVmtibGtP?=
 =?utf-8?B?MTQ1Q0UzSzNQSTdJeU9zNXlsWHBmVTRmeHVXMGk3VEZrNkNFcVpQTzc2RFNT?=
 =?utf-8?B?bitLT01WRzFtczMzdFVGYTNkTHI3VHFCazVscXE1MGpQaUJRTXFSR2twbkFN?=
 =?utf-8?B?YzdMc3FYWTI5bVVqZWVyaGlOVEpvbU9hYUJFbUtTc2phQ2w3K0JFSHZ2Ui9z?=
 =?utf-8?B?VTB6T2tmMW9wV2Y3RGxTelFVaUhDcE04S25MRlFmbXRkOUFWLy84VXdCck1X?=
 =?utf-8?B?TDFGU1J0N1Q5YzY2cDhXS1RWSVk4V3BOVDhuYWdxNU5pRWc5aitVQTJDVmJG?=
 =?utf-8?B?dzU4cStqajNBUElsQ2c1N20vdHFTaWVPNmd1SDVvWFdzbnZhd3VpYXhFNEd4?=
 =?utf-8?B?ME90c01pcWg3YTJlQTN6SnBQV0d5Mkk2OUVQWmNBa0swNUlqUmNhZWJOWkdz?=
 =?utf-8?B?aVB4enRXcjVlODkzclFlU0wzTjBrUjhwelROZlhXS2NXK0lGNUF2NE5CWndr?=
 =?utf-8?B?SEVzOE1tWnhqbWhJYW1ndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZyYnNaVEc5QTRiTlYwNXp3K3pXS1duOFU3c3hmcDZyTjNlNEdIS2JlOEw1?=
 =?utf-8?B?WldZcnJoWDh0ZGUzSHFGalZSMHRaN2wyQTFPSytFTmFzclNLZUlwZFRrUnlk?=
 =?utf-8?B?a2lIVndoNFFLeDZidlhJWHl2V1ZPTk0yRHBMeDJLOURlZEZtaFhPdmFZVGVR?=
 =?utf-8?B?TUxJUWM2cmwxR3YraFZUNDUzcHhlTEVjeGIrWUgrYytqNGltNFhwSElqZjRS?=
 =?utf-8?B?b1V6cUhPOWFQbE15cVVOOHhtYnNHUVhwMG9DU3hmYTJsOHpjeVdDUFFCdENt?=
 =?utf-8?B?VUN4Q2gxNVhrRmRwVXQvTitaVFVtV2NDUWp2Q014bExBcmtRVmpad3JUMU1H?=
 =?utf-8?B?UEZuRjR6V0VoV3NaUmY2QTZrcGJjOUhQdXRFMklMcjFPZ0h4UllxM3VjaVJR?=
 =?utf-8?B?U1kwbkxsWXowdHVSYTRSNmNMQitxSkhvWUlpQUhjOFNVRFdJK2NKWEd3RlF6?=
 =?utf-8?B?alhBanA4aWVUQlNzcDR5Sm1YM1pLWVR4RCtBNTRFSmdmTlpFMCszN214ZDlI?=
 =?utf-8?B?N0M0RHJick5CeGQ4YlVOSE5aWHRHSUVHaUk4eGNpM3dicHYrVisrUW93OUJX?=
 =?utf-8?B?cmxLNXE5RzdCOUJ1RWt1UmtLZjBkVW5NTXJDanRjMDhCRDkvVUI0ay9tSnkr?=
 =?utf-8?B?YTI5dFQyNWZwUWNxWlBYTjNBVVErck1FZ0ltRnNCKzZQeDVCZUxPWWJhNzIr?=
 =?utf-8?B?a0NzaWFkZjNXMVRIYTZQNjNyTmxLTmxubDlCK04vWCtvb0ZYTW1wN2pXRHoz?=
 =?utf-8?B?eXM3bG9yQWhneUxuZ2FSa2MvNnkvdE1nWlc5MzNrbnVrcndIamc2SUdEOC9S?=
 =?utf-8?B?STlYMm9CMVF4RUtyL1krNTRZR2xGMmN0dlNLc0lPc0RrM3JHNkpraUdvbHhO?=
 =?utf-8?B?amFMRWs5YUZNWC90SEN4UE1Fdm96Ynh6UEFpd0QzRzdzaEtDQStrSDlFUGFP?=
 =?utf-8?B?UVpHclFRaFJOOTBkNFhveFRuV3FaNVA5NVNvbll6VVRaMzY1Y3k5R2JRWGEr?=
 =?utf-8?B?U2YxKzBKUUdxTzBLVStaRlBmV3BTandxdFhqZG5PWFd0Q1grMWZ5REhmc3Z6?=
 =?utf-8?B?NSt5ZG9VNHRXWXQ1OHVGcFd2Z210d2JSUFBGaHByb1lPeUo3YWdESlpJeHJq?=
 =?utf-8?B?NnB4SzA4VWxiV2RPZVpEWFE3T3VvNHRHb1hpcmJuRlcreG5abjVURndOTE5i?=
 =?utf-8?B?dThBdUNTOGJ5TkY3VTZFQmRTWXp2OTg4V0toYmNVSnZuK3hFTEVPeFpRZVBw?=
 =?utf-8?B?cGttdk5XZnp1OThRL2xFYVNPZEJ0dnNyLzlmL0t2UXA3M0ZDZGpLeTYzeVU5?=
 =?utf-8?B?WG9zZ0ZXaFM4QktqZlI1TXlUTHVvZktRaFRYVmFGKzRQeU8vWldHZERNMVJR?=
 =?utf-8?B?eVNveXdkNFE3dVNZNDI3eVNraWFxcVZFRjJjdVExZUU4VnV5b1NsL0FodXJ3?=
 =?utf-8?B?eHErOE9LR296UDRNNU13M281R2w4ajdMcEpuclg3Yk5VUWV1Y3o2WkdTc3F0?=
 =?utf-8?B?VUtUQ0g2Si81UExtdnF5TlNpMVVJN1dlaWV6cTJEU0Zucjc3bmJoZHZic3pF?=
 =?utf-8?B?aVcxZytyckRrdks2NzNmQ213UFIvWm84Z3BBSFpjeG8yWTd5SmdSRUtyTGNk?=
 =?utf-8?B?bG40Wkhja2t5dHVqT1hwTG5nbDBpTmhvNTNEKys3eW0reUhUWGtBUk1TMGw2?=
 =?utf-8?B?UzRFdGRCYTdSc2kyd0JhY3hjNWNCZ1IvWXNEMkIrc213RmszQk41Z0dDNm8x?=
 =?utf-8?B?cGU0TlA1ckQrYmw3Z1prQnVzMExFZ0lGSU5DVk01M2lSR254OFM4Y0xPbTRo?=
 =?utf-8?B?bWM3ZzRXd3NsN1owVFd5UjgyMnRaYmZNOG9QQmdBZmI5ZXpWb2RKVmU4NUY2?=
 =?utf-8?B?SUtzaFc4ZlJzSENkdDZSQTM3YjRLS3hsVVNnQUYraEZCcnMycmFQcWp0SW84?=
 =?utf-8?B?N2lGelg5RjhlbnlGTW9MQkdOWUdIeFlZb1p1NzRIZnU5TWQzVGJXTUNkdWVP?=
 =?utf-8?B?V1ZsS0o2eTNHeWh6am45YXhvaC9EVmg0WGZaMnJGTGR3d3FFOGlEUTkrNzBZ?=
 =?utf-8?B?SnhOSktuaTh1Q1hXem9uem5uZDNCaGh4bDJkVFBqSzJYdDVvWmNMVHBwdjhi?=
 =?utf-8?Q?eM03uRCUkpCDsAnJzAXldvVPn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb282d29-81cf-472d-2817-08dd19c5405b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:21:53.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbYmX/eD+LoXryjncsl0Wal+PrgRJI1ZC0j3zPBepj9nr2dfA7xLjpx88iM+WqxCl1FzRRZDsA9Vo4GAuDJfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906


On 12/10/2024 2:53 PM, Daniel Baluta wrote:
> DSP found in i.MX8MP SOC can be used by multiple frameworks in order to
> enable various applications:
>          - rproc/rpmsg framework, used to load for example Zephyr samples
>          - Sound Open Firmware, used to enable various audio processing
>            pipelines.
>
> Current dsp node was configured with SOF in mind but it doesn't work
> well with imx8mp-evk dts. SOF controls audio IPs from firmware side
> while imx8mp-evk preffers to control audio IPs from Linux side.
>
> So, configure 'dsp' node to be used with rproc scenario and later will
> add a separate dts or an overlay to configure the node for SOF.
>
> This patch series configures and enables dsp node to be used with rproc.
>
> Changes since v1:
>          - document syscon compatible as pointed by Peng Fan
>          - do not disable dsp_reserved node in the dtsi file as pointed
>            by Ahmad Fatoum.
> Changes since v2:
>          - Fix dts example in patch 4/6
>          - Frank Li commented that we should handle the reset using the reset
>          interface. I have two objections on this: we are using some bits from audiomix
>          for reset together some other bits from DAP region. Also, the implementation is already upstream!
>          Frank Li agreed that it's up to Rob opinion on this.
>
> Daniel Baluta (6):
>    arm64: dts: imx8mp: Add mu2 root clock
>    arm64: dts: imx8mp: Configure dsp node for rproc usage
>    arm64: dts: imx8mp: Add DSP clocks
>    dt-bindings: clock: imx8mp: Add syscon compatible
>    arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
>    arm64: dts: Add dsp rproc related mem regions
For the series:

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia


