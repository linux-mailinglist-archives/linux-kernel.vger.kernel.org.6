Return-Path: <linux-kernel+bounces-392273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9169A9B91C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50567283D43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21661A0BCA;
	Fri,  1 Nov 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="U6YiNEDM"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2139.outbound.protection.outlook.com [40.107.249.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAB817C69;
	Fri,  1 Nov 2024 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466999; cv=fail; b=k8P4GIrDwDDIXlo3gcoh1rxoSQpeSmghi7pXZ2Fp8JsGvuNslDku1h3pQUhqR7/r1EM1M9s3qq5y7NipzNiAMl1sovA6sgIVpYoc+1HvfiPkYJHSGT1TNHBZ/tm8mht3yYGV9ONCwgRxNjlWMwu9sAnAgu55hxSyMLrGWyXb3U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466999; c=relaxed/simple;
	bh=H3AAhlxFbPhIGMyQSG2evwP45bJyyu4kB43Gcvd84c8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=mvBJl00bcBQxlEwUuUbz19lrRNZyzMIGFuyj/X5eooB1EHbx1ZO89I8JUfvZkwBZPimqH0+BiAxHaFaO/RJq2FfFoudQTeRqepPezGQNlc7ASlx9yGwTq8CSVJwzyXnmAd52KxPCePzb6iLVOmL/b5RG2a2GMwYroBrSks8v644=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=U6YiNEDM; arc=fail smtp.client-ip=40.107.249.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnNbdCqfNk6LWJfmgh50kgiF1B4bf2n3qHEKRCTmNHHzPC/0N431XYrZ1gSGz/7ZlBonxEd13qGtOGy+Aw/nBYVvbazn+87hD4C0bZIiBBHvuniRRxmsz5gsjqlSKX/Wl9RajTtc+y/IGzxqVCtQM1vZxNCLO4iStHp2lW2TXKv77MSN+iQNkUd62jXsquedOhooSXIbrAqYExBI80pzBv0SHkRFigtPmR74D42U7BgcXAI1tLdLfZQwya1zq2YhBRTKRPAJYZHPfgUBqBWzU2fjd+6PKvDxbbt2N1mfaDGUvaxy/d1e+c1TY+sn5ydaaEXRxpWam7BRP2Act06SOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLl0nn4nT3v9P/r5lc7I0XM8MyYiLKIrvxIyGcDkCFQ=;
 b=Vvv+hXPYl9eJeUDC1zOTrmDy6FOtjZ2zcnQrLpisLBUQ3v8SdfJX+9fv+j+YXQPupB7xxJ7F+BDwpJWUOpE2b9f/Y1KkSulZy5DhySag1IaHC59l6xoKTmwY0JxZQHUv4vnL1TWKoUt2oVvWh+1wsLPMw279OVeBA2Gor7xY9+PSvRfhaKwVQonGncxkw6HnkZ0n36HC7pvJjm05pYGNJPAqc1impQ5WVL07OkUpp6m1GKKUc8WDqbPHiiMSBl6n5e8seAo3Hz0Smk+6xwq+A6TlFyCSRb6oVEgh1tMHjjwRYavAR0fEIYsaOeHuignDLUTlAwC6uhQaMfrYJcXJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLl0nn4nT3v9P/r5lc7I0XM8MyYiLKIrvxIyGcDkCFQ=;
 b=U6YiNEDM6uANoPqeO4ULSH3u5n3tAKDVaFrl3JDxYpuVDdB4T7XIH5jp88YTrfVfAXe7FXm4ZwTZDYGBwQBNNs5OPkTdt6uauhm/aH4KdVS887kxTXcrlCPj2pzGrPGuw62PhgO3vbKtz5IpaDQcyrFwNGDmA+ImF4LrcHGs8Qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 1 Nov
 2024 13:16:31 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 13:16:31 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 01 Nov 2024 14:16:20 +0100
Subject: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: convert overlay
 to board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-am64-hb-fix-overlay-v1-1-080b98b057b6@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAKPUJGcC/x2MSQqAMAwAvyI5G0i1rl8RD7VGG3CjBVHEv1s8D
 sPMA4G9cIA2ecDzKUH2LYJKE7DObDOjjJEho0wrRQrNWmp0A05y4X6yX8yNhc2p0k2liWqI5eE
 56v/a9e/7AVRqL0ZlAAAA
X-Change-ID: 20241101-am64-hb-fix-overlay-5c3074974008
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: c01d435e-7832-4762-71bf-08dcfa7766f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nmx5eG5PdzFMRk00Vm56WlB1SUlsYzZEQk5KZ0drT0t5aWNlaXBsMDlxbVly?=
 =?utf-8?B?Q3Q2WWJPa1dwNDVJODAzWHQ4aDBDd2JzdHR0MGQ0SUNiaFh6dEJiRGdydGNV?=
 =?utf-8?B?UTBHNWdGdUZ4eHVGK1RTcURKYXlOUzRQVkl1WnFOYXdHazFwT3ZaL2JlVjJB?=
 =?utf-8?B?Y1graSt6UVlkb2QvTkdSSWlTZklhUTNsUmtoMW5CRm8wUk5ycGpYUW1zTGlW?=
 =?utf-8?B?UjZrSVlqTkVqZkNEdHdaR0c5dGZleVNXRWxUNUlyckxlTk1CTDFZV1RJUHc0?=
 =?utf-8?B?ZnZBbVZtSkUveEtMc05QTTBaVXpDcGR0SEhnNHEwdE9XYXkyanRuT3J4V0xn?=
 =?utf-8?B?WFFWa2dRV2Qxc0I4VTMvTm1kOFNjK1RzZEk1Z2Y4dWJLbDBZd2prbGFXUERv?=
 =?utf-8?B?VXlFZWsyOG1wcU05NGZSMzRsMTB3akJqM0o4UENjT3pKVzM0MWc4R3lMUXp4?=
 =?utf-8?B?emMxS1pWblVpanFXUVVyK1BodFBlV3N1RG84ekw4VExFczlLeVhNbzArbHRY?=
 =?utf-8?B?SVhwblJSYTk1K2FzdWlIcmc5dmd4N25UWjU4dWxHUlhBcE1IZ0Fpdlg4S3F5?=
 =?utf-8?B?cCsvT1ZrSnNSOHV6UkNOSHJxbmRlNkZ0a012TVYrSVY5NnFBMmFaT1orUjJ3?=
 =?utf-8?B?d2Ewd2dJaDVhdjNWd050VHBtaHZYclc3MEkwYk9YZjVvS0hYRTdHNUpXbUw5?=
 =?utf-8?B?ZXh5NDg3Y0FsQy84NnNnR05qTGZCNEVueDJoRXYwa0R2YU1Db3lFWGJvNEhH?=
 =?utf-8?B?WjVMdVMrc0V2b2l1T0w5T20zTHIrcjlGd25HMm95M2Y5WHRQTnF0bGdlZVFu?=
 =?utf-8?B?MmNXR3lBUkpxTnAwbmFicUEvK1E2em8zRWZkQlFVeWJZZ2YrdittMW1uSEdG?=
 =?utf-8?B?c1kyd3A1M29WUTN2MkFnTXVhUkJORzVZZmxtcVcyZ25FOXlSbzFUTTc3bFRq?=
 =?utf-8?B?Z1Z5UHEvaDduUlRZZlFFVUtsZjlxY1kwUDNxU1ZMdGhiM1FROC9UYjhXY1k1?=
 =?utf-8?B?RkVHMFRobW9zdFA2N3JRQ1lTaEdiZDZyZXI2NHlPTjJROExMMnBBS0dUdEtS?=
 =?utf-8?B?cmtja3h6bDc5em1MOHcvaDBhaWEvWnZmSitEUlVGa1Q5VnVtbFdsaEdZd011?=
 =?utf-8?B?ZDQ5RDJFZThha2Z3M1NsblZYaGdGenQ3eVBHZmorY3hXTHVrRVg2djgvekt1?=
 =?utf-8?B?NEdPbVVVeXQ5czNnTkJUWlRYTzVlajRlWHFJdzRHdURydmpiMnRWc0JhNjdV?=
 =?utf-8?B?alhTYzhGdllFNWpPZ3V2K053OXBXc3NQanoxV0VsblI4Ni9MUEdPTEpRR0Mz?=
 =?utf-8?B?dU0zb1RPVTV0SmRPKzNEdXpsNys3VE4vRktHSlY5aWNjRGxRUjNMUk9RTmR0?=
 =?utf-8?B?UE5KampSZkFYNFZMZjhiOURvS0RZb0NJWjl0d0R4TWIwSnJLN2NxN29tRFRa?=
 =?utf-8?B?alN2QlFPMFlUYkRRV1hWM1B3bC9xeVA1ZzlCSTBidXB4THhxYjdpSkFZWVVl?=
 =?utf-8?B?dlhjRk92eTBlMyt5QklqdWNYK2ZvUmc3MERuTmhxalVza1NodUIrNm5ZM2gx?=
 =?utf-8?B?cEUrZ0IvelNxZFNGWTJFWTFIMHd6R1h4WC8vTkRUYWJzS1g5QVF0dzRPSHkx?=
 =?utf-8?B?cGhmc3VuNVlETnE0Z3pscHFyU3pVZWNQSCs2V1UwdTNtT2FvSFYrT2ZkdXVV?=
 =?utf-8?B?NzJPVC9nbXYyL1g1Y0w2ZnBwdDBOK2dLQjZISmlZRTJSZEk5YkFXOVd0M1Y3?=
 =?utf-8?B?R0pJTHR4TVNMQ2tWWjZITGc0ODdEdGszeEVhVXhzTjhVVDNtMnRLYm1MVExE?=
 =?utf-8?B?VC8rMGV3aVNxYlhRUGRBOFp0TTh4bWg2elZsSFlmVkRHdWN4eC9yMjJ5NXlP?=
 =?utf-8?Q?mx8h05/SUP1GP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEV5YnhRZS9QYnZXOUdSOUl1LzUxZ0V0K1dtMlRXNEtBUmR6Q3N5d0pyUWg3?=
 =?utf-8?B?M2R3bHJhRG1GOS9mbmxjVlBRb1ZHTC9pYzR1RUdsL0ozZHowWVFWK1NGU1B0?=
 =?utf-8?B?KzVpRnZOcm43Z3o1R24wQjBVQ0xmTkJhWWRUcTZickZSRnZUcVRpQm9aZDFX?=
 =?utf-8?B?VHNRSURjb1ZEeVBIeXlDdlZlelp3cXlBaEc3VUttRXE4eVg4TWQzcWdHdDhL?=
 =?utf-8?B?VXJ5dkxOSDNIYmRlU3JEZ29wTDJBcGl2TFlQbThnTG9mT0V5TUlBdU1iTVAr?=
 =?utf-8?B?MjdOT0sxVGNvK1NrSVN1TGxOOFpRaFhpYkJhdW5IdTBwZ1VwSTV5YjF0bzQv?=
 =?utf-8?B?c2hXWHJnMzFFa21tV25ib2R4WFFHL3p0bEIrMGN5OEJ1anFvWlU3SHVBZGln?=
 =?utf-8?B?dG1VZTFEWXkwV3RGS1Y5OTRzdWtmYTdLSXRpMXcwSFZJYUc5MFNzQVoxY1FS?=
 =?utf-8?B?YTBaMDlodW8wRDZQUGk3MUNXdHY0UTE0cXVDeENxbERNTWgxOEd6WitSRFhX?=
 =?utf-8?B?MG9aTzVmZmZ5ZE1VUFZKMGVVb0UyTkU0RDFaQTczNHozWFdReDZxdjEwTGRO?=
 =?utf-8?B?QldDTkthV3JsZDlvRTVUcjk1UWZhSHVTWU1KVXlLU1ZLenprYkg0WFRvWnZF?=
 =?utf-8?B?L1E0UlA0MG05cEdKSnJMODQ0QUxBbmdCZHlvMFZobTF0TEtjNzhSb2EvcnRX?=
 =?utf-8?B?V0x3dm5vcWo1UkU0QXFGTS80dmprWU1CRm9uNXQycmhCSGRvZWZXU2hMb3dn?=
 =?utf-8?B?R1ZQTXMwN3lOS013WW9pL1RxUVh4bHdPVktmNjJvTCtrb0VUamEzdy9JN2pr?=
 =?utf-8?B?eDBCdHFiUmZVRk92UitFWnRRb3RQSzFFT3hMaHBwS0tHczdDV1FwQlNBZExw?=
 =?utf-8?B?anJRenJFM2FTMnhxRGNyZDZTWWpxVTJSTk5HbThlNE5OLzk0K2FhOUN1VVZC?=
 =?utf-8?B?U09NcFFNeUtEWlhOOTd2VHN2OHVkUFc4a1J5UGpZV3RWbkNFcm1IQWVBOEUr?=
 =?utf-8?B?WHA5R3JpbTFPeWhnN1cvN1FWVXdoVEhKK3NPanRDTytjN2RhR0gvYU9PSWU0?=
 =?utf-8?B?S2ZFQmgrTVh6allzMWoxbnkzLzN1QytzamJZdTFRL1I4YVNOZDFhMnUrVWVW?=
 =?utf-8?B?elhpczZ4aDE2eGI3STNoMnZxTTVIZ2dWZElORmlaNXJvQ0FBZ3NZZkZaVXoy?=
 =?utf-8?B?R05COVljZ21TS0tad2pEMHpIYkdPdmI1TUJxOWt1bUFrcjhsWlNmdk9YVUti?=
 =?utf-8?B?TkFYU21ldUJuOU11L3RDQmplWkJvcFNzVC9qSW5yby9ZZkd2eXR3aVJqcUth?=
 =?utf-8?B?TC9XM3prVFc2VnpHV3BTSXZ4b3lBUkIwZTNRSmFrYlZacUpZQmI0ZVRPWGM2?=
 =?utf-8?B?RzBkRHRaN0l3SHRQZ0pqTDlHTzNFWjRjbVpFMlNBZDYrdDdhZnB6MTZEVXhp?=
 =?utf-8?B?d1B2K1NzREpiV1JBOEpkemNwTUp0WEZVeFB4T0IzSnhtUG5mMEQ5VlpnVEhK?=
 =?utf-8?B?WERoMHNxakl6N0NOZUg4M2hCdWYzbW5hbnkwOC9MS2xIVGM2blFuTkc5SXh0?=
 =?utf-8?B?M2xBSEd3ekdsOFlJVWc2a05LZVlyK0Z6eGZ1cnEvc1N1eHBwNFJ3NjdxMnJK?=
 =?utf-8?B?aUEwZlZLbnFPcGJ1ZFhuazREV2VBOEdMK05CUTNmalFWOXQrRXNRTXZhWStz?=
 =?utf-8?B?N2ZYWHpMWXFKd3IzanpEajJic0VpQ094SEt2OE05UGwvemQ2VlVvTTJnVk1G?=
 =?utf-8?B?NDVDVkRVYXVlWElYVSsrTHRHK2grTzFBbjdIb1RYUVp2ellYbFVGUjNqaklO?=
 =?utf-8?B?K214TWYrN1U0V3JrNW42dkR2LzZ2aUF0YmhsTnZpa0krRjlnckYyU25oZEhG?=
 =?utf-8?B?UURLcktvZnI3WGhaeDdKcjBRR1JFL2ZLdlYxNmNwclp6cko3U1M5dWlBN2Yv?=
 =?utf-8?B?blFyRU1paTNYUkszc3dUQ2JpY0c4RFFlQ2Z3bkRQOFpaRDZpSktDdGJ6ZDNw?=
 =?utf-8?B?eTkwK2haa3pHMWpuSENseHNzL0ltOWJNaWk4ZWhRTGxQU3ZUVE91bHhYcVRr?=
 =?utf-8?B?T0haLzhNTEpMYmpIaHpDY2ZOQU51d042T05FaDNnc2hvWEFFdTkwdTIxQlNn?=
 =?utf-8?Q?1Cnn7Q+IbaXaj1ed2hkfcxBn+?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01d435e-7832-4762-71bf-08dcfa7766f0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:16:31.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHzU23gsM+n2brlGxagjffvL3Z8u+UbEuU33c98QnHjI0pksiTO6j3OJPtf1nJi1pTAI7GYYypjx2wRCJch6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

SolidRun HummingBoard-T has two options for M.2 connector, supporting
either PCI-E or USB-3.1 Gen 1 - depending on configuration of a mux
on the serdes lane.
The required configurations in device-tree were modeled as overlays.

The USB-3.1 overlay uses /delete-property/ to unset a boolean property
on the usb controller limiting it to USB-2.0 by default.
Overlays can not delete a property from the base dtb, therefore this
overlay is at this time useless.

Convert both overlays into full dts by including the base board dts.
While the pcie overlay was functional, both are converted for a
consistent user experience when selecting between the two mutually
exclusive configurations.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-devicetree/CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com
Fixes: bbef42084cc1 ("arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3")
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/Makefile                            |  4 ----
 ...gboard-t-pcie.dtso => k3-am642-hummingboard-t-pcie.dts} | 14 ++++++++------
 ...gboard-t-usb3.dtso => k3-am642-hummingboard-t-usb3.dts} | 13 ++++++++-----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e50a0b4082118fd13c3a7a0c1d291..562e6d57bc9919393920afe684a61a8ab58dcc21 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -41,10 +41,6 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-csi2-imx219.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM64x SoC
-k3-am642-hummingboard-t-pcie-dtbs := \
-	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-pcie.dtbo
-k3-am642-hummingboard-t-usb3-dtbs := \
-	k3-am642-hummingboard-t.dtb k3-am642-hummingboard-t-usb3.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
similarity index 78%
rename from arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
rename to arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
index bd9a5caf20da5b7f11266575f69f0f5dcc1a47ae..023b2a6aaa56689f712a6c1ede6ba427d746fe34 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-pcie.dts
@@ -2,17 +2,19 @@
 /*
  * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
  *
- * Overlay for SolidRun AM642 HummingBoard-T to enable PCI-E.
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53, with PCI-E.
+ *
  */
 
-/dts-v1/;
-/plugin/;
-
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/phy/phy.h>
+#include "k3-am642-hummingboard-t.dts"
 
 #include "k3-serdes.h"
 
+/ {
+	model = "SolidRun AM642 HummingBoard-T with PCI-E";
+};
+
 &pcie0_rc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_default_pins>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
similarity index 74%
rename from arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
rename to arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
index ffcc3bd3c7bc5d47ce9926a95a13af3f61182a2b..ee9bd618f3701047be4ac7502cb70e7d3589ff5d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dts
@@ -2,16 +2,19 @@
 /*
  * Copyright (C) 2023 Josua Mayer <josua@solid-run.com>
  *
- * Overlay for SolidRun AM642 HummingBoard-T to enable USB-3.1.
+ * DTS for SolidRun AM642 HummingBoard-T,
+ * running on Cortex A53, with USB-3.1 Gen 1.
+ *
  */
 
-/dts-v1/;
-/plugin/;
-
-#include <dt-bindings/phy/phy.h>
+#include "k3-am642-hummingboard-t.dts"
 
 #include "k3-serdes.h"
 
+/ {
+	model = "SolidRun AM642 HummingBoard-T with USB-3.1 Gen 1";
+};
+
 &serdes0 {
 	#address-cells = <1>;
 	#size-cells = <0>;

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241101-am64-hb-fix-overlay-5c3074974008

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


