Return-Path: <linux-kernel+bounces-318406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360C396ED4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7135DB22AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03688156641;
	Fri,  6 Sep 2024 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ZyT52GoS"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A33C463;
	Fri,  6 Sep 2024 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610422; cv=fail; b=f4GrwMqs6zON0VLg1tNbMPSlAYxtIloy6hS6oUbgp5WmjJy8ige6BBofWcf4FKMZlJWHgpsa9ph17wjctl4mwEuRWJnaN27NXQmYbMiwZ6ad2qgl61TmHvF/qrYgq2ny80WOnxcQqOuDR8nU+yMm5S4yoN333FqzX7hxFVoNsao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610422; c=relaxed/simple;
	bh=s3sFZKZTsV2zSokhbHK1Jh/Oh+5suzFCVfV5cALgoTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L/MUYZOg+Xk81hkr+RLZrFb4qaN2V8GCtVnb4HuOHI1B/Agy8JM1NS1ENRDfpzZW00jxWIvGUIc/o+kPl65DsHx386ocPvTfGPsbdkr2FRmxKMJqyhp2ZnJHNGxE5r573cYBGKxjUrw43vg1PAG+IdTM0hGkJBdg58N+jHSF4No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ZyT52GoS; arc=fail smtp.client-ip=40.107.255.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQFFMJefpbP2UWDtcQHfmNNbkmzHtWv0sLaiXwIt04nOy8UPUOjM88vuOjl+jza5Q4qkvComvowDm0n/9BhChGibhfvrBSqRH2mda6cIX+dFFACEztF3JNdw6Uif+Uzb6jkFqAaBdnMXVvX/yne+0pNaogzRJgHhz/U6SyQbEdTnRg2shehosXCqxhuQKmwUn9rwjKggWCe4mujpTrZTJnZBWK9YiyHeVpT3Er2JdgL7psXR7dFiHXXMKRFaaZQTaw3AKx4ngOkMwQIS0RRaoLuzXczxuBYvIglirOa4wGFMZxFHRFNra+EdkW/QzbzNfigyp8BUu5b9RfRgZ919gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGjAOgKpVinZ4T8BB1bLKFcKSKrnINQ6lGHGKzYA8Co=;
 b=rkiv4RhQUXsw3RAaNSEdbrdieO6BjUeMRxHcKPf+cYhRbQOHtf/0ipEmS0WzgBPPDIS/6QM5jda7ac6hjABS5oydMsFDsjMwS6rFvmSd8bHiVI+88iRlOUhswoe2ZKgqc85zBvwektDSxY8rRHokwmpSVhcNggEvWnEiVA2vtzHH99emJVdUM2ZQFuxob8wnWFrbQq84IvTALK+lGBdCBtcMs1x+IwiL/SGbTIz9mBGL5o7nC6xEWbc8JVcJ3Nyz4KQGZxDVhP7FV9YI778mJeITpZCHvKbwA0VGdXTh6wqDs07UBMc7wY0qD8Rkv+lO9BwgRXmdR6JjuO4hkKViXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGjAOgKpVinZ4T8BB1bLKFcKSKrnINQ6lGHGKzYA8Co=;
 b=ZyT52GoS3sWdXmJMKZIWgdx8yFV0BY7u/HHpApkYiu9Swub76V+ODSbovrvjDZHSYItOfsf0PAGwo5rFeCoVN/yCAH0Ip5w4Pi6qtjII6C4EWSnaKwm7Ogco17vaOp25AkoGm9sF/taa7dSRGe3qDAGcLc5N7vpsSQm0nNwZWfJNXI5A5dA1WGeg3Y4KOpteWzqemqFILygJVfCcxwcshQExIPMN/strNoqcYf/0QqjwBdfRM0pkNnMWTQL1cT933s6VEevrRqJfghevJaTRaaiq4wfN8V7lxBlfVn3YzEty8bENJQNNWZEkK3JOZJcbA8YYX/ngxpB4m5Lv+x5uig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB6470.apcprd03.prod.outlook.com (2603:1096:400:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 08:13:38 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:13:37 +0000
Message-ID: <ceb00323-7956-4259-9f12-08045396da89@amlogic.com>
Date: Fri, 6 Sep 2024 16:12:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
 <1jo751qn4u.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jo751qn4u.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: c3df7a12-c356-4e6e-99fa-08dcce4bcf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3lWd1cvdVVBZW15Z0RmQjdNU0VYM3hvNkErVjVibkh1N0Zwa2M3SHVmSTZD?=
 =?utf-8?B?UkwrMGxpbDZheDhRSDNrZ04yNzdreVZmVUVLbzJ2Mks0OGYwMmVOQkJxU1JH?=
 =?utf-8?B?YUVsSU9EUFcxWG5lVVQwanJBcXVnbk5nL0lqMHlOUTE5U1lRYXVZVzF5Y09t?=
 =?utf-8?B?enRoWVhXa1Q4TG1CZDZOVUtkMFdnTk42eGZyZWtWKzl3bFM5UmY0R0N3eWhG?=
 =?utf-8?B?TkVHTjhBRVpxUllYd01NNTU4SUVJSkIxMlN5d0VIdTF4cks4NG96aVRhVjNw?=
 =?utf-8?B?cnZmN2U2YmNFeVBGRkdld3hkQkJDNncxKy9YSlZjeldSL3V5YkhLM2V1VmIr?=
 =?utf-8?B?VXhLSzMwM3czazMvV1dsWlZsYS9JSUh3Y2ZVZUFGazlLb0pEODlJa21LeTlS?=
 =?utf-8?B?dHEzUGt2ZUJ1bEtOZFJGb2NvNnhYVkNTMEtFb1dZbEVOcEd3YjhYaTRNUVFt?=
 =?utf-8?B?MjNuM1JIbDNtZ1dpTXkvVWEvREo0cUtmQTI5Qkl6ajRBVWh2WlZEZlY4UVJU?=
 =?utf-8?B?RGRWUC9yZzVka2taNWw2Y1VZQ1htVTdNVDVtZ3BZL1JmSUhkS0N6MVhrWmRV?=
 =?utf-8?B?cWM0VlFFVDJRcWJyUzRKL0hnTmtDYS9JNXFuVU9wenZLUm5heGtaWDI2QmxH?=
 =?utf-8?B?NytkdFZZRWlzWVFBN1J0c2ZXaTBKMjg0VEh0RjVTejZvaWhHTWFwTFYzdk0v?=
 =?utf-8?B?WGlONFNYMUtWU0ZPbTY5cjBmTUgwbWFBR21JN3RMcThDUUxRbHo5dUo3WG84?=
 =?utf-8?B?OWVhbVgrV3hIUjlsL1krc2VDSjN2QjhvVWtIQmQ2LzZ5bldOb2pGbGJJN1RF?=
 =?utf-8?B?R1J2REMxb09BNmlsOHlFazZqdklSUlYrQmVWYmQ0T1lObTZQWTBObDhYcm9p?=
 =?utf-8?B?cHRjWThqeENjUlVWcUM4a2Y3aHV0N0xKcTJFcmx6TFYyWDBBQ3E4ai85K05q?=
 =?utf-8?B?Unh2WUVhejNoeWZUaHBiZWFmNEtCSVZkalp3S2w2NTBSM3o3dUs2NHlqc3lq?=
 =?utf-8?B?ZkhaN1M3bFV2QnBETldmMlJWbjgvSm5VUWNiV1VUQkhZc2pEUVFSMTVYVXA0?=
 =?utf-8?B?OS85SkJ1THlpdnBnVG1hY3ExbHhldUJHakVYQTR2U201QlAzTU9EekdpczZu?=
 =?utf-8?B?akc0VWU5Vk9obk9zVW5OM1BvNVNEem9VaWsvQ2JZU2tVWTlUNUFHS1dIQzNC?=
 =?utf-8?B?ZTU5dk93Mlcxc0huMEkrRlVhdUFOQ1pZSkZtUzE0UndZcjBxbUxKUTREZitS?=
 =?utf-8?B?eUVVbmlGeTd3UExwZFBoM251ZThVSGlPTHhIRlNXdmgyRlZUcmxmYTVNbDdI?=
 =?utf-8?B?NEwvL0hhcnJPVnV2T0J6c2ZoSCtJTXIrSytwQkIyUnlqZ2ZCWGsxc25ZV2ZC?=
 =?utf-8?B?bjU1RnpuU3BMYnhyNFY0eTdsU25IbS9aSGR2UURTTDV4Ky84V2pYS0pYdER6?=
 =?utf-8?B?SkJtSkY5WDhaajhUTWpEYks3bWkxNThPZkZ6TlNDSWZlZHhONDBJTmh4enpR?=
 =?utf-8?B?dlpHU1BKY0pGbTU0cVphdGZydTEreGFVVXloVmNMUUt1VWZiY2JVVnBLYzJi?=
 =?utf-8?B?U25EV3d0U1hyaUZJUlBQR1oyS3pNSHZXb0tKTGpIN3pVQkd4Wmgrb2ZuY2Y2?=
 =?utf-8?B?NnJrWDM0STJUNW1iL2JNMytwYXZzZzliUDZZOEZmaW1CS1Y1a3F6bTJtem5F?=
 =?utf-8?B?VXVlcVdOeXlKNEt4SjEvVG1pdVluOUkvdVZrOXVRVnJlU0ZsVkhtL2FITWI3?=
 =?utf-8?B?RjJsVldNcmVEdVIvYkRSdVVSZUF6N2tDUThMN0tJZHpGQzF5ZFhyTENDdTFa?=
 =?utf-8?B?ek01a3dDMXJFWGdsaTk4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhDcHZiQWdHbVB0d2NXOENrUk9vUWgzeFI3UjBwVk56RVNybmxlaUEvVGZY?=
 =?utf-8?B?dktTOTBjWXJXY1JzOG9QQmpIRFBNY2hQTXBVd1ZkMGFRcUlQeWU2MThIL1o1?=
 =?utf-8?B?THBSckZlNUV6ZCtDMWVRRFhrcnlVMi9qTkJoWmZVWko3NEQreldtWkNhRnpG?=
 =?utf-8?B?L1FXdXIzK3pjQmhlVkhGMm5GSmlabkVBN0JSTmpweUhYNXFOTEtPWlQ5S0Y0?=
 =?utf-8?B?MEhSakovcmxLbEpTR0dzMEE0WFVsMUp2V1I0RU9hYnQ2TEdmMEo5TGVuS3ZM?=
 =?utf-8?B?Nk9rQTlJOTdCU3FxMkRhdGEzb2gwQkdqbnUwTENBY3hyYVFNMHl3MDV1dmhU?=
 =?utf-8?B?M2k5emYwU2tBd1hCYjB0c3pwZERsTDUyRGxoNFFxNW80TEZib1lQd3VlOElP?=
 =?utf-8?B?S0xQaFgvdlFvRFY4RW5xY0xIaWkrdnFPY2psa2dySWJSSUNsd2liSWdqTTFm?=
 =?utf-8?B?dEVaQ1I4VDFUblIrSVpoNkhVeXNVeFB2RERqNE51d3E3K3N2b2RPaS9aTTR6?=
 =?utf-8?B?VDBYamM4T1Y2dkxyVnhka2Rsb2h5cnk2UjZ2STRubGVuQXNtVG9kZzFtMWU3?=
 =?utf-8?B?Yys2TWJDSUFRV05yLzNqUEhoZ0MxUExRN0w0WHV6dzAyMVZkMHAwdWM4VTdD?=
 =?utf-8?B?NDk2czg5NDR6dnVURS93bFE5QnFoTFJJNGRDZmsvNzdzYTJFRVNiZ0dUVFAv?=
 =?utf-8?B?L2Nyd2tETjhCSlk1dCt0UE0vTk4vME50c1UyQWJyRG5CK0p3aTFKTUY0THNY?=
 =?utf-8?B?L0VwY1NCSWp6SmJBN0tkZVVFbjJLWTM2N1EzeEszZXEzM0IzMWRYU2YvemRN?=
 =?utf-8?B?VW0xRlg4NWdraUkzVGFMQ3AwTUUxS0lYUW5uVFcwbzVEMlY4QWwzeVdIVXZJ?=
 =?utf-8?B?bWNpQVdvVURoWi9FaTgzcTRpcXhSZE1DTEVMUi9WTGdSenZ4K01TckZ2R2tG?=
 =?utf-8?B?QnFaMmJFRTl6clhZSkMrdTgzbEtpaWxDR01LcWtxcXdVRC9NdnF6U2pDQU51?=
 =?utf-8?B?bVZ1NnM1a1BJcHRQMFBtV3o1enJxdWcxckVjdG5iTExxamtobEFDTDExY0tO?=
 =?utf-8?B?clpURzhnUVJIOGFZUjFvbXE0dGZxQ2dBeFJ1WjhNN1hTZE5xNTBZTTVSZldw?=
 =?utf-8?B?YzY4U21CeWtmNm8xcDJIa0E0dVVZc1FDei85eGUvaVB1OWZHYWZQYnJDc3cz?=
 =?utf-8?B?dEtJSHQ2V0pVRHZVYSs0QVFTSjdvRVJQd09hN1FIalpvbmEveFlQNW5nRVYx?=
 =?utf-8?B?Z2N3cUhqc3RPNk13dlFMM0M5M2QzSnRTeVdHTjBTNHRuV3lid25LSG9XbVRl?=
 =?utf-8?B?U1NmMkVrRmYvUmNZUG50SmRXMTNnUnZ0c1Z6YkRHYms3QmxWUlFZNmJqeVkr?=
 =?utf-8?B?TEIrQnE2V2QrcVQ2ckRKZlV0R1A4WUM4SWJtWVU1Tzlya1kvOW1mUzVteVRS?=
 =?utf-8?B?Z2p6ZmwyQUZNb3lxVXcyWWhGY29ZRTFtdXBObEVDY3hwMkFBM3VVOWphd1VY?=
 =?utf-8?B?SEg5eEliTVdocFhGeVAwN3JUYi9VN0VuQXNqamdYN3FkTXFZaEZzMlBxazA5?=
 =?utf-8?B?Z1A4MkZWVHJReERvOWpUdHM4c3RPWXRBUXNJajdpb0lvRE93VFM1R2Y0b1Ar?=
 =?utf-8?B?RlFhWlNKK09MVGJlUHJUK2Q3a1NZQlBSNjJvbjE2czFzaWdKb1k3amVPaVF6?=
 =?utf-8?B?amJjYm5NL0RxcXlWdHJ4Rm1idFZvZ3g5NzFNYVBlc3I2OHdocDYrZXBhalcr?=
 =?utf-8?B?Rm90YWhNY1dHWGJCWnN3US9uY1owREYzWmFhbFBCOVlBNmhsNlJhWkRqamZE?=
 =?utf-8?B?TEptanlWR2ZYLy9iQ2ZXU2xueEhMbFluVENWLzBzTlh3eHROVmNNZnNoQWU0?=
 =?utf-8?B?QW9jUnpqMExUNk1mTEg5cDVxa0U4eVlGNmdHWlZuSGNtQTQ5eGs5ZWNsbUlp?=
 =?utf-8?B?RklJOGpVTzFIKzQ2cEJ0L1I4MEdNbExTOGM4ZTNMUDNyWGIzeGIrVWdUUjlM?=
 =?utf-8?B?MFdUK2R3WFBMSWoxdmlHM2FxQ29DZkY2R1N0cnNFL1JKOU9LVzEyWlN3eEE4?=
 =?utf-8?B?SnVGNkVScmtueXJ6Z0pJMkVHL3prd2dNNVo5NTFhcnR3TFJ3cU56cmJ0T04v?=
 =?utf-8?Q?Mz2TlVjZHJvOSZ3IccSfVGhGQ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3df7a12-c356-4e6e-99fa-08dcce4bcf64
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 08:13:37.8100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORKEmruE3q2ytGBcowRvDW/zISJRatFxKAznzpTQZzupbGS7x0PK11WihqbdHEZj4FU9hQcZI4C/Kv64N3XL5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6470


On 2024/9/6 15:04, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 06 Sep 2024 at 13:52, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> Some PLLs with fractional multipliers have fractional denominators that
>> are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
>>
>> The hifi_pll for both C3 and S4 supports a fractional multiplier and has
>> a fixed fractional denominator of "100000".
>>
>> Here are the results of the C3-based command tests (already defined
>> CLOCK_ALLOW_WRITE_DEBUGFS):
>> * echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
>> * cat /sys/kernel/debug/clk/hifi_pll/clk_rate
>> 491520000
>> * echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
>> * cat /sys/kernel/debug/meson-clk-msr/clks/hifi_pll_clk
>> 491515625       +/-15625Hz
>> * devmem 0xfe008100 32
>> 0xD00304A3
>> * devmem 0xfe008104 32
>> 0x00014820
>>
>> Based on the register information read above, it can be obtained:
>> m = 0xA3 = 0d163;
>> n = 0x1 = 0d1
>> frac = 0x14820 = 0d84000
>> od = 0x3 = 0d3
>>
>> hifi_pll calculates the output frequency:
>> calc_rate = xtal_rate / n * (m + (frac / frac_max)) >> od;
>> calc_rate = 24000000 / 1 * (163 + (84000 / 100000)) >> 3;
>> calc_rate = 491520000
>>
>> clk_rate, msr_rate, and calc_rate all match.
> Thanks for the detailed description.
>
> Is there a possibility this applies to the g12/sm1 as well ? HiFi PLL
> has had trouble on these SoCs since support has been added. It sometimes
> takes a long time to report a lock. So long we consider it a failure.
>
> There was no such issue on AXG. If you check DT, it is the reason why
> AXG use the HiFi PLL for the sound card and G12/SM1 does not.


I have confirmed that only the hifi_pll of the chip in recent years has 
this feature,

and g12a/sm1/axg is not like this.


I confirm that our sm1 uses hifi_pll, and I have not encountered the
situation you said. There was a probability of lock failure in pll
before, which was solved by adding 50us delay in meson_clk_pll_enable:
@@ -378,6 +378,8 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
         /* Enable the pll */
         meson_parm_write(clk->map, &pll->en, 1);

+       udelay(50);
+
         /* Take the pll out reset */
         if (MESON_PARM_APPLICABLE(&pll->rst))
                 meson_parm_write(clk->map, &pll->rst, 0);

This patch is also prepare to push to upstream later.


Another detail is that the larger the frac value, the longer the lock
time, but the time is at the us level, so that the timeout in the pll
driver is not triggered.


>
>> The test and calculation results of S4 are consistent with those of C3,
>> which will not be repeated here.
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>> Chuan Liu (4):
>>        clk: meson: Support PLL with fixed fractional denominators
>>        clk: meson: c3: pll: hifi_pll frequency is not accurate
>>        clk: meson: s4: pll: hifi_pll support fractional multiplier
>>        clk: meson: s4: pll: hifi_pll frequency is not accurate
>>
>>   drivers/clk/meson/c3-pll.c  |  1 +
>>   drivers/clk/meson/clk-pll.c | 22 +++++++++++++++++++---
>>   drivers/clk/meson/clk-pll.h |  1 +
>>   drivers/clk/meson/s4-pll.c  |  9 +++++++--
>>   4 files changed, 28 insertions(+), 5 deletions(-)
>> ---
>> base-commit: adac147c6a32e2919cb04555387e12e738991a19
>> change-id: 20240904-fix_clk-668f7a1a2b16
>>
>> Best regards,
> --
> Jerome

