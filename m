Return-Path: <linux-kernel+bounces-414742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3C9D2CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F67F1F22D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25271D12EA;
	Tue, 19 Nov 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CNEy2ggP"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2117.outbound.protection.outlook.com [40.107.103.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FB14AD3A;
	Tue, 19 Nov 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037615; cv=fail; b=T+zB5nWUiXiC8bpv0xmTR9f/axpnCLRFI7iiPEOqQ3yaXQ8hsE+2E0dGXmIl2WRgZuz9/FpeTdypRNnnK7zm38KczwCQ6WoB5icwRaU+kLETRTpX0Bc44BKLg82Mrxx3s18NRfWh6Ks8On5XaBx5WnxnOk/vBDLfmENhYnc5d9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037615; c=relaxed/simple;
	bh=H/zOuDyjl6E9L+q+Ot4pdfrWywKHCxi1mMuErlf0mUc=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=fpG0ivIU04N5tjm3Sh3OFZbtUIXqA8euqVxqyzmSrnxB8iv/wkJAzdC95RGlMraSx306RfhHXroKO6IOXHNTm7iF47nLfHDs6pIs/1YJzZ/urCuHU/7CReIVmPu9smuda+bhUj1prqItgRrO6HZTzFgMZBBJB8JwlqGEgyBim50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=CNEy2ggP; arc=fail smtp.client-ip=40.107.103.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPegKBYL6wJ5L0KmyBwcbT4LsQ+CnTgSsOLUX9W7xrRtSX28RcxcW5oKfTDibR8PifRHx8a/ERG4iTK/Jg86tKlqhheUfEvEXJ4BBWTUyU+caMsI3tvuMV80TrGYh1WzFKJAemkn33FtP0hxt7KQNstOfvohcC4c0vlaIXiOIvU0zlP7Ddn7F0s1175TJbIGK6SHJ9V4FOiPPLZ7jyUd8vANGkoQI/r9e47w8QUm+mFFdGObhb2d7CCByjLzJ0KUPpWWD9aqasGS7cVZArYUswuaINZNIdScsPu7Mx9OHhIEpu5kiDMJqQjZBkeIL0RJhuQuA8gKB6SzK4hp5diZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnEHMWVrkZ1/bITH7A9C9+PnDrBmXvHdjqSXze1pXk8=;
 b=gGrlohYy999NLwizg1PaDpkXUy48JsHswhBTv4aD39jkckHYNceISTbarBxnk/f2Wh0ldSClGQ5ONldzZKvOPmks1nFVrn5AFPfd8qwZk0JP2T7ayel4LTOqmBnFilBQUmfD2OcWl1gZciXLqlA8PMNXUl6gPcvoxQXxtLwaEkAtBzHtpty7XFUnUQuCELKyvcfupQ46aNdOo9y/IGauT6TRbJYpVbOpD4NbYVgiLavMEBjcveENETU182+upLlwmqZ8x/DFPAy+9r324MvaLco3zCaw6/9tlAH1ezBZXcqqDAxVPEnAitgzpjjlSF4ioUrnTMVJOA82cQ0L/ZJqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnEHMWVrkZ1/bITH7A9C9+PnDrBmXvHdjqSXze1pXk8=;
 b=CNEy2ggPyBh62hKikKfI/GQwsOdg1esnp55Vaj7lEzk3k3u6q6knc4mlpCHOKgVFsCkSNEvzkwEsFUwc1GegxaRBA1C5YmYRAzYwWPqWqNsc0E8PwQUy7ouRetd0BOXtR27Hcvb9HdkendZR4dY8iyDnMqKzYZgKHIQI4xLYeHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Tue, 19 Nov
 2024 17:33:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:33:28 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 19 Nov 2024 18:33:08 +0100
Subject: [PATCH] arm64: dts: marvell: cn9131-cf-solidwan: fix cp1 comphy
 links
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-cn9131-solidwan-comphy-fixup-v1-1-6e7446434204@solid-run.com>
X-B4-Tracking: v=1; b=H4sIANPLPGcC/x2M0QqDMAwAf0XyvEDjhE1/RXwIbdTA1pYW3Yb47
 4Y9HnfcAVWKSoWhOaDIrlVTNKBbA37luAhqMIbWtR0R9ehjT3fCml4aPhzRp3defzjrd8vITM+
 HsyA4BlvkIib++3E6zwuBK+7xbgAAAA==
X-Change-ID: 20241119-cn9131-solidwan-comphy-fixup-aa1870913d0a
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB8PR04MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 585d21ca-e196-42b5-6f7c-08dd08c04799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0ZCZ1BYMkh1cjkwT0ViZHJNbE5nOE93N1dXQUQzZ1hEQmlNbHNIN0pIMW0w?=
 =?utf-8?B?SFdCbHBoWXB6MXNUSFdJejA5SmlOVnN2K1pwWlZ2dU9aa3R1U3lzVnVQT3Uw?=
 =?utf-8?B?V2Jwc01VYnhPeXp0Q0tvSUlCWTRmc2VGVmV3RnN2NDBBL0xMVXRrWFNxc1Bq?=
 =?utf-8?B?dzd2RXdMNE9oRGhlc2xaRWpUUzYrUWJGSTlNOEM5MXFxYXhTa3ZCUVZNS1Nk?=
 =?utf-8?B?RkxvZUkvSVFoNEM2dEgvdGJqOG1BdW1QOXAxeWtJczg0SmtQY3N5VTlQQkNs?=
 =?utf-8?B?blRnUXE0TnZEODhLZEQvM09HbERoOHZ1RkVqdUVJelk3WnE2a2g4WjJsVmdY?=
 =?utf-8?B?S212RHNDbzFUMjVkTWxXQ01kMTBWeUJUeVZZaWowNHE2bFJSRmRsOHpKQTJN?=
 =?utf-8?B?QXZGangzclVsZURmcEZ4aUR5QVNhVkJJd1djOWdFRUxEN1pkSFBoQVNlZUFJ?=
 =?utf-8?B?R1k5T3Y0Qk5VOTcwTWc1THZ6ajZqNHJRaHB4RExaYUl0VzEwanVLeEZ6YjRX?=
 =?utf-8?B?SkF3R2xKR2tOdGpYV3hpdUE1OFp5Y2w0NjVyNWVuc0lYU3UvUm4rbzVBZ3NH?=
 =?utf-8?B?Zm8welVMTE5jV3gybnJVOENuZGJWYXdBNU1sUWROR3pSQzhONmtsR2VqTEhy?=
 =?utf-8?B?b25ieUtwdTRRcUFyUlVHZ05Xd2JyOVB2L0RwWVNlaHQyU0lscSt2SFdjdlJE?=
 =?utf-8?B?Z0FPVzJmQnhKNXR4aFJyUXBBY1R6MzFKb1ljdTJiaXYreEhESDNqRVNoRWVv?=
 =?utf-8?B?Y2ErRDBzUEVkUDROaVBHOXcwTUtiaWtGbmJhTndYUFd5ZmpFcWpMVnF5WVkv?=
 =?utf-8?B?Zzc4SFNpVnVaQzRRTDVrbEZnTHVPd29IVjAwanZzSzBZYjA0YldBdGJWZDRX?=
 =?utf-8?B?dE5hTjFiZ0lSYVB4dy9Jd1Z6OENOdk9SQlRrLy9qVG5iaDYzNVl5RGNCa2Ur?=
 =?utf-8?B?UWZPUklQQWlkVk1YUDAyRTdCdVhzRm9EZE5mQXV5UTB2M1V6OXNSdVRXODk2?=
 =?utf-8?B?Y0c3TEw4dFVGTGVLb1pSYnF6d0ZaeUt0eHFlZENQK3JQM1Rwb3VFQ3hzRTIr?=
 =?utf-8?B?ZUUvRnlJWUJnT0J6d1ptVFRnRFhENmVCbWdiQUlscHVPaG5GZEQzZUpWc0pR?=
 =?utf-8?B?T0cyUnYzWjh0RW1hcDM1dGJMUU1wci9uVkdPdVU2TVI5U3ljbmlpNGxvTHhC?=
 =?utf-8?B?RElmSmlpWU5pYW56amEyMk5TUXNOc3RxY2FOSy9tM01SM1pUTnF5bitoZ1Fj?=
 =?utf-8?B?RitydXRobkRvdUloQzNZSytmaW14b3VmZGs5YTA1a3Q2ZmpQR3Bqd3I1WEli?=
 =?utf-8?B?bTZGODZkbXdGdUl0dmthc2QyaEJldm1IVStmUGZ1Zm55N2d0Ukh5YVQ5UHBr?=
 =?utf-8?B?SERRb1ZGVFd2SnRudmc1K3M0K2RGRUhGUWdib0c2SitVTEx5NmFaWlZwcWIy?=
 =?utf-8?B?M0JEZU9iSld0STVmWmMrN1I5S1V6eWFsbCtLclRWRGU5ckhRWnQwcjQxTjJr?=
 =?utf-8?B?NXZrdCtFUnE2WTlCNGF0UWh5QXFvZVJ5SUVaYWlIRjVCeDR6V2E5YTBoVkQw?=
 =?utf-8?B?aHovV3EyY0FMdG5GNlhiWkh6YjQ1V0RxaGRoVDNLa3ZrT1VCL0c5UTJHVjFO?=
 =?utf-8?B?QWhnRWJUNEVWR1o0VUlxR3hYaFJVWUJGWkFDQkVyc1RFZmRTOUgyRitscEsy?=
 =?utf-8?B?QUtRVzkrTXhHNzMwQmJ5WnpmWFZwTE4wRTc2aVVHb3V6c3ZGQlVxb29vKzVD?=
 =?utf-8?B?U2pMbVpaaUFva0RYRTlxaHRrOHZPMTI5L2xNWURiVEpySzUxWTNWV2t5dmUz?=
 =?utf-8?Q?Pg7mjWej8g5MRe8hh5mDVEZdcDmBHJYiX7sFk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC9YZlh5cXJ5ZVNlcjBoUDFza0dyMTZ6OTh0bU9RcUd4ZlhzaGJHek1VeE5i?=
 =?utf-8?B?dXlhbVg0L2VYb05IRUgwOHNYMzdxTUVkQVdmb3UveXA0MkZ3RU9ma0c5L2tD?=
 =?utf-8?B?WG1GZ2tpR09tZ2ZROVhoWDFVR1Y0RURvUnNnNlZSbkRZcFFSeXNsdTEyZWFj?=
 =?utf-8?B?dmVwSWJIMlVBeXRuMWloeUNzR1IyYWJKR3VoMTlkOFB5U2xtZS9PUzlzSGI3?=
 =?utf-8?B?cVpaRFdpVzdySGFRNVZNM0dTcDhLWTRHdmVTQlhsc0l1UXVnZnJ0WU53YWZn?=
 =?utf-8?B?OXBPVmtXd1IzM3pSOStwTk9YV0FkN21WOWNPdk4vZFhCYjMyN0Y2ZXhJTUZx?=
 =?utf-8?B?M1F4THpBZllCbXZEWndaZXE5VUVmL3o1cVcvdGhkQnN6NURtVFRUSjR3Yzd4?=
 =?utf-8?B?YmhFclBaakJoMnhrSzdHckttblNxMVErWUdOa3hEQXljY3UzczFLSWRNelFT?=
 =?utf-8?B?WHppWURSaVhaWE1WeXAzQkxYd2QzQ05ObmNrdi9rUGNmRVlMNndvTzE4N1Fn?=
 =?utf-8?B?MVd6RCttNDVFS1k4YmcxMEZXRzErMTlOUmVjcTUzV1ZyS3M3T1N3UTZEV1Vt?=
 =?utf-8?B?eWZaRG50bEZheTdRRzJ6QTV5YWZZMWYzY2hCcHdiSlM3NHFTL0NvSG5sSGgr?=
 =?utf-8?B?WUttc290Ump0dHFiRFFNN2RYSmFmYUVXWjMvRGNZQ2MwdG0wMHNOS1pmVEF2?=
 =?utf-8?B?VEdiMkFRNVhBTWw0clBKc09waVBkUWNnWkR2SDNxditpQ0pkUktuQUdlM0Zj?=
 =?utf-8?B?VktqMDN5UVNka3VlUHRGdHFYbm1Cd05JeVRXRkcrNUlzSVFGZlFLYjdaaFJM?=
 =?utf-8?B?cmZhaEk3cmpCcW5ZR2pHQnhmMytmSFNCbWlLNERCdTk5R3NnR3NRMmdSK016?=
 =?utf-8?B?OGU4Ulg2LzZ1bGZNalJaUFFhM0ROUC9lRVovakJpU28wWUE1Yld6cDZwaEZp?=
 =?utf-8?B?anBsM3BzMDRkM2NUQ1A2Q1BpYzROTGo0UUUxRCtNMnpld05lZW85YWZrOW8x?=
 =?utf-8?B?UVIxMEV3VGUyTnovT2xabDdQcWd6cERlNkhUTGdXN3V4TmF4UE0xN3NDb0NV?=
 =?utf-8?B?WkcxTXBlazFKTzNGN3QveHJ0dHlRVEZVOVM5aDU3K240cEh1RDJMaUdYa3dY?=
 =?utf-8?B?b3hBZUhGVmVGT291cUtWeGszUFhUd1FaaGxUZ3FBYjE4RXIxelNwc08zQU1T?=
 =?utf-8?B?MENSK2F4b1hDcHorTWJURk5pZzhRS3dCZm9GZHNKUDhoZWQ2cXF2S25GNldv?=
 =?utf-8?B?bzNPVGJ2Rms2bXdVT09uckRsM3IzU1NwZnBDd2gxdm02QWRIU0NNR3NzcTBa?=
 =?utf-8?B?MFhLSVNrZkIwZlBLS0NxKzNOVklqRVl1aXk3c01yVG1GYnlJWGxpMjYxUTQ1?=
 =?utf-8?B?Y0MzWnM4QmNTZEMxWjkzR2VhOFVwMWc1WGRXOEl5K0hYT244dU0wbTIyNXF4?=
 =?utf-8?B?SHl6ZzdYQWR1UW5TeXdxZjVLN2plbm1XR0toL3VsUy9aNmJyODIvN1Y3U2kw?=
 =?utf-8?B?KytybGJQVFpYTExkWjJBQWcvUzFhYlFicjdYcGdWeFlhMWEvTER4SnRZdTZB?=
 =?utf-8?B?ZFRxYW05dXJKT0xLd203RmVPeiszaHNTd0I1NzMrc05EakltUW9Gbkt6Vkor?=
 =?utf-8?B?VytzOGYrY0IwR0FDcHpXYkMrVmt0NTZ4NkFGQWJPZ2FiZVc5c2Y0cm55dnFP?=
 =?utf-8?B?eXlHLzVsTG1zeXU1cDJKOFkvU0NPWnJsWDFwRFNzTDduYjM1bERla2hoSGFT?=
 =?utf-8?B?ZzlXYkkxcyt3WUtRekx4Qk9UWWo1NXQvamRrWG4xUWM5UUp2VlZ6RWVsdjh2?=
 =?utf-8?B?dE1hVlk0VjZUMGMyeGxadUtSZVhWTStCTXFFeHZnNHlyeGQvQ25TNXBrU0hM?=
 =?utf-8?B?d00rZmx3Y0xTK1J0a2RCS2hLM1J0VDArdFgvMnhhU0RMaTlJQmhjYmttWlph?=
 =?utf-8?B?RzZuMnRpVXdGNEhWNDZ4ZkxiK0U2VUtVczl1L0pVbEZpSklxbmluSURBb1dX?=
 =?utf-8?B?SExWOTIwVmJlR3FwRkNFR2tSeUUrK0J6cWNJNWsvaHRseXVFazJSemhySTNx?=
 =?utf-8?B?ZUp3cmNVNmFxdWFMSVNKWFRHdExYTjVlczB1S3UrM0lNWVBsR0xnTkdyTmpx?=
 =?utf-8?Q?E4nfUwVQLEKoOAuUsEeOGZhGa?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585d21ca-e196-42b5-6f7c-08dd08c04799
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:33:28.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHsgB8ehJ5qiAEH7l38klhqibL/Um6cdxVsFhBKRhurWZLBu1xtQs3X9F19SUrCIlbgQbfAK0lGuhZtqDrYfWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

Marvell CN913x platforms use common phy framework for configuring and
linking serdes lanes according to their usage.
Each CP (X) features 5 serdes lanes (Y) represented by cpX_comphyY
nodes.

CN9131 SolidWAN uses CP1 serdes lanes 3 and 5 for eth1 and eth2 of CP1
respectively. Devicetree however wrongly links from these ports to the
comphy of CP0.

Replace the wrong links to cp0_comphy with cp1_comphy inside cp1_eth1,
cp1_eth2.

Fixes: 1280840d2030 ("arm64: dts: add description for solidrun cn9131 solidwan board")
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
index b1ea7dcaed17dc0205d1ae91d4178dd1f8313a5b..47234d0858dd2195bb1485f25768ad3c757b7ac2 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -435,7 +435,7 @@ &cp1_eth1 {
 	managed = "in-band-status";
 	phy-mode = "sgmii";
 	phy = <&cp1_phy0>;
-	phys = <&cp0_comphy3 1>;
+	phys = <&cp1_comphy3 1>;
 	status = "okay";
 };
 
@@ -444,7 +444,7 @@ &cp1_eth2 {
 	managed = "in-band-status";
 	phy-mode = "sgmii";
 	phy = <&cp1_phy1>;
-	phys = <&cp0_comphy5 2>;
+	phys = <&cp1_comphy5 2>;
 	status = "okay";
 };
 

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241119-cn9131-solidwan-comphy-fixup-aa1870913d0a

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


