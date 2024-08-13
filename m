Return-Path: <linux-kernel+bounces-285053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64BB9508B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6721F23B62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558B1A08CA;
	Tue, 13 Aug 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="av/+KPl/"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD41A08A4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562140; cv=fail; b=qs5ymOac4KkbeAmllTCLK8rCWnkioYMY6/523N3Hb/yivrE7ecwm+HYAnQ4LTSR3X9NbjuBUUDHDQpMsGgdysy2y/t7eW4/DgQBYiAzE5MEvxP5MSnZiDSW6x7PY0tFJj/uq+hKfWJ68Ae9NZHn0ADeDwprJ4W2+3QChtLWr8Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562140; c=relaxed/simple;
	bh=EgTA/bzPVGwsyEemXX3hWkQUEBTDZOU6gFrO4erNl9A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FO/a8sdbqCs7m7XGyvxg/D6dU2T8udU4ZxVozEIC7K4uNgzR7om4AYasERKU3WAlUCtz7088FhCyfHZdaB/pifL67pnMiVXy6SiCxzCszs7PZdk4J9lTheBRBCmIBytADaen5Fq7CC39dntbg29JDyH6J9sHXqjTJRoIPxpd3rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=av/+KPl/; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N54LHIJBi4gBsgxheopBM33C0jujZ3uhryNmucyIF/JWsL1oCMSLPvxSLoNhE/iRbkRgHmMeh79iO8cLu3AAVc8bXDLEAuL/H48Ab3hyYeJurVOCpulOmji2x9fkHqAzhMTOub+LBKUhOj+k5GVwfvn2/UzCa0USl0Yl79zTrvdRxt2NnpAMVc6dK4MNsQwyCjP1kUWsw26js4WnrSH58sgqF6sNPGq+7DKiCp2zb18lPjrUuGU6Tjpf7ESpks7o8WhCpRES/2uAXBVoLxwDXyBBtnMWH1kznTDriDxWCDaGbbe41ugB8gynzZGje7WIPTWEBka7WfvMh+3mXxDW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZHzogEyoKA0FrCgQ8jcF7EjjYfhLpLTAtbn8jWUYd0=;
 b=rwen0AVrNMDJdIQvBYNqSR1+8Og7r+zLtLZbxGpRDGsYXNAGatLtp/gD00E3zW3YWkbwyeVmkxGXQqIEQx6cdOBVLStFgcso+fYBYgzgAa+0srfPmAoGCTNpBW/VJfqq7wkvfqOxap/C/yfcsormp1qHhYWEi/2POkB9m07WKUILfPNf7y7orMueXC0ZHsc8+KfyPkhHSEcW8ToZ7+O8k+0PHRyevHwXUd73xNmNiRd6wg+BQv/McZhcUG2IaN3QkUmARL24kJpCCq0vEwbGGizB94atX5K70OTJ04Qev+SHdr7wSGw1fC8wlalnh5c+IEq6zTVYPkeG3CRecDTfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZHzogEyoKA0FrCgQ8jcF7EjjYfhLpLTAtbn8jWUYd0=;
 b=av/+KPl/CBKGG4ecG9MgfMQuYxxyWLeWxZKkrLg5VRxE1b/waiNgTZ/PiewYNHs4ucRu88O0dN9MqhZAuWMoZsHHufmaf51FIxAQ4chaZrV8CH399Exyiz5vcrQnUrUEtuzoCIFDuGLX/lcWIFqBb3UUcc/10+plWNn3atf9QwUxoG6p2wmGE5WVD7lLUU5/ZqqCP8MnuvFBUMqXMTLlv+8vAe0Wk/JEhH10QjiWFFf4pChis7JfH5kHJkKoGtUI/4poyaRg32Kn6xU87E+at5I0zHIzCIuScUvyHzcJZuLj4gZWy6BZWa8YX484PC0Zu2Um1FoKfVJKR3hmb8oqwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 15:15:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:03 -0400
Subject: [PATCH v2 05/11] i3c: master: Fix miss free init_dyn_addr at
 i3c_master_put_i3c_addrs()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-5-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1049;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EgTA/bzPVGwsyEemXX3hWkQUEBTDZOU6gFrO4erNl9A=;
 b=hAyCF0YFRChaiv4lpD1eZFkklFLhkx9di+Z7RRgXgHdEd1oR1LfWRPDbFWb5htqhitnhuMBpw
 NgIixKn1c8NAxnTZ0YyAcu7h4Y/VY69pvSbgKhDQKjjJiUJeXdtTLAm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 143c2f17-ecec-4e42-2a28-08dcbbaac880
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y1JRREtXWkdrVUxSWGhVWWxzcTdBVXhBanIrVU8vcVU2V2JUdnplMzBiN1lv?=
 =?utf-8?B?K2ZodHlhQkxJc2FjZWRnQkthN29Vam9BbG54ZGZBdHBGYTVjZEFqYWlhRGl6?=
 =?utf-8?B?eThTRmRiT0d4NXNnd3JQTml2VDNMdVRoeTVSL2FVVDY5RDNpY2ZOdk5xNFh3?=
 =?utf-8?B?eFlDWUpoQ3Q2WkE1WlNJOGtwd3l0VW9uaVUxeXJHTHlwdG9KMXhWeWRKemVn?=
 =?utf-8?B?aHVlazlNWEdpc2RSVkNGaFBWRUp4b2p3M2xxUXBSS3RUY0FOS0lUN1pFNjNX?=
 =?utf-8?B?UWd0bVcraXplSjU0dWJGUFJUMHhmc2xxZEY3ZmRRWjJhNkVKZEVDaW05T0E1?=
 =?utf-8?B?QTdMYTc2bVFPWkNFdUZMZElocWNMbDRLS21qL2s4bDBQUkJ1MW1YWGxIdU5W?=
 =?utf-8?B?WlRNT0U3ckdPSTdaa290MnBUZWhYSGpHTzgwaUxiYWhLT3J4b2I3SHkxK1JD?=
 =?utf-8?B?UzhuOW5YSEJqMjNkS0FJbnNXaDFGNnpLR0UvbHVoK2ozWHhyeWNvUUN0cUtz?=
 =?utf-8?B?U3NYWFpUeERPZWNxVjBjVVJNek9JOWxTMk82MUI3ZW5ZVXdqS2lCaElEd1J4?=
 =?utf-8?B?TW11UlFlS1pia2N2MVdMd3VnR1lxTHkyc2l6eG5DVnJKenVuT3R1cHRjY3pq?=
 =?utf-8?B?YXZsSTFLcVhzQkpEMGU4UVdMSWNGQkJPT3E2ZHBJdmZZakZMOWo0U1Z6R01q?=
 =?utf-8?B?eHRPMldHQ3FsTFVRMG1QMXpwNjBxMWttdXhhdHo5N21NUDFrL1hvZWU3TUZE?=
 =?utf-8?B?UWI5V20rQzlCTCthRmRjbWtickJ5TW9MQzZrb3pYWWEyQlo1cnRHamxHR2Ro?=
 =?utf-8?B?VzVVemdES2NtYnB5KzdxRUQvL0trR21TQ3hLYnk5NWg5NElmcVVSdWJEUmh3?=
 =?utf-8?B?ZDd4d213NFRjRFhTYXNvdzlMM0JaVTFNbS8zbkZxN3lTazlpYVNoOCtsYVdR?=
 =?utf-8?B?L1piQWtDYy9ZdFVjMkVhNTU2a21CVnZtS1RKYitPSUFtNXQyRkhHUTNpcDNy?=
 =?utf-8?B?M09CWEppanRFQ0dUVjVXMnJpQWc5NW0rT3lFK01qOXJ2ZFhSV25SVi9weFk1?=
 =?utf-8?B?bFR0TS8yU2FQV1FZZ1dBWDVNblVoc0l2Sk9QMkJDS1FDVUN1UEY4SC9qb1Ex?=
 =?utf-8?B?SXJnWkpoemRlSS9LcHpDN3dDQXE5dzNXMGI0ZTB0NndFcnR5WG9DT095Y1ZG?=
 =?utf-8?B?Q2VOSXlyamZNN3BSeThsMU84a2RuSUVrUHZsaHJTUzI1alNPUjMrSGV6MWtD?=
 =?utf-8?B?cVpzUzJpZGxSOERCakx6Mk1DMkRKZmZiVFFTaFpCd3JuYjBYSml1dnd1bCtB?=
 =?utf-8?B?dDYyMXBSOUlSZzYrbE5zY0ZIVmorQU1YWlhOcVlyd0JIYkFuTFB0ZjRVRUZU?=
 =?utf-8?B?cTlYOU1Xa3FJMjJHeGRjMVlON2ZwVS85Wm9wdnhwbEw5WEJhS1V6YmFlc3k0?=
 =?utf-8?B?MStVZzVFSzFLb2Y4ZU1Na0gvMk1XMEZBYXI3b1E2dW8vMGdmTFp3U1VValhp?=
 =?utf-8?B?eUZYSDRLanVBNWc5SGpuTzZmVFA1MHB6eTRjUmN3MG4zMUx6NnRPUVVrYVlK?=
 =?utf-8?B?eWs3U09kL1lhejFhK3ZlWWNZWEQxbE5WcXN4SnJWT0ZpdEErMHczSHo2eDdl?=
 =?utf-8?B?UGNXczRxMWtQdjIyUHRFSmZvOXpPazV0eWxWa0lSYjBJa0p6TWdzMHU3RUJW?=
 =?utf-8?B?VWUyRis3Rk1URUU0dkJIL21JN3hWdzlJTVpEWjNEZ3pqTFJjWC9MQ2gwTVdK?=
 =?utf-8?B?bFd1aXF6a2ptQ3dmdkFUNHA5SDRtSTdUR1E5ZmVWOUZJUU9TckFuVzRnQlFz?=
 =?utf-8?B?aGc3elJ3QWkrM1l6SWMrNStaSFlwZVArR0pKSU95SzlDZ3lDTW5OaC9jeVMw?=
 =?utf-8?B?YmVwWHUxMDNxSDJWSGpHd1FYOUhCYlZJbi95dEVqU0FtOUE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b3VjTk1sbElMcjBFREcrelZhOGw4d1VWNHd1Tk1IL3ptbTQ5dk5ENzVUNThi?=
 =?utf-8?B?S2piQTdQa3J4S0VrRldXUXdEdklMZ2VDcER5UU04L0w1clVzSWdiK1llY1Ba?=
 =?utf-8?B?QW1tK1BJZVBsVmtTU3owYzZ5M2hJMHNxczd3cXAvUm1HTnVOMDBnRyt4RnQw?=
 =?utf-8?B?TlBpSzBrdVBnR1l2anJVaDRKcWZobUU2Nkdoak5xQkNPcDYxa1FVZHZOWllG?=
 =?utf-8?B?OE5RWUZNRnJtMGVnOVhuL3Mza2g1bzM1ODZmNE9JbzNoREJXMUpSdWVWNHJ2?=
 =?utf-8?B?V3FMT2VSaHl6bDFTQTdaMGR5UUYyQW1CWFM2N25ZREgySnpTYTE4Y0g2R0Ft?=
 =?utf-8?B?amx0NWlMckxGUHplVmRFdFR2OE1FUVU3YTZQL1JKMEtySkNveE1XWFBjMmxN?=
 =?utf-8?B?T2d2VEJaSFBVMTZtWDBxYk1sMy9md0Q3M3FSL1g2ZU13UVUvMlkzMElRSW1n?=
 =?utf-8?B?QmMzZmJsRnBpcXFTa1EzeFRObjh1dXdRVW1ySXJHSW1wd0tHOE5HcUp4NTRj?=
 =?utf-8?B?Q05waksrQ0VPU0g3YXpoNmlLYWs0dW5malZQcjkyT1FrL3FGRmdQckFoU3or?=
 =?utf-8?B?QjFRVlIwckVLY1NScnZkYWM5MS8rVVUvLzBCa0k4aVFCdmVObVZqU0M2eHBw?=
 =?utf-8?B?dEpPTWJjN2pESXA3V2JyQ1ExRmpDRTE5M2hzWE9QZm1xRDBFR2d4b3RRaUFs?=
 =?utf-8?B?eHF0NEhDMkhMVS9zeitRYm85d3BHbHVUeXByR1lvTndCNXpFVTQ4a0NENVFR?=
 =?utf-8?B?TEhYdDNKZnpzc3ExV0dKem5ZVXpqVkV6d242TlNzYzRTT0xjY3FMN21NRWMy?=
 =?utf-8?B?c0NyT3ZRSUJraXVyQ0hRV1NaK2ZaZDl1MTFJMFRtdEVmS2dUWGhHV1VWOXZt?=
 =?utf-8?B?SXBlTndrdjFLdERjUy8raEVnS2JGN1VlSXV4SkdnTHViYStUOURuU2FqbVZt?=
 =?utf-8?B?aFUrMWVqVkJHWVdWRjA0K25lZkNSTkVXMGxJMEp2KzNrNGdaVk5YUHRpSFMv?=
 =?utf-8?B?czZEVlFOK0xaSGhJVDNGU2RSTHVJRzBqK00rbXdRaHdsSWRyOUZsdzBESXBj?=
 =?utf-8?B?aDlMbWVKbzdtQmRPaTZlbnJHOHdrUVRwNFg3SXZhNlBWcGwwY1k2V2MwV0dS?=
 =?utf-8?B?aTcwUVg3Wm9xLy82NEVTaWlSTFNING5TVTRESkVpQzlIUXhlQUpFVW9iNUds?=
 =?utf-8?B?d0V0T0ZtSEhINlVpdngyRm1xdm9kSzRkT1ZyQmtyUTNVS3N3RTFxb0JNSkRw?=
 =?utf-8?B?OFAyeEg2LzVtTERNT3BEcEJQU2JQUTA2dWsvTUY0Z296bmVxc1JrTVVicW5o?=
 =?utf-8?B?QUZGTFFTN3dJQTNkazN5OEFRbUlvS0NsTEUvUWhYYlZ6OC93c1BXOFduQlF4?=
 =?utf-8?B?YThIZ2NBRk1ZTjRMSDdNOE55WTBwWnI0MWxPcjBRZ2VjOSs1ckpFRC8rTTR1?=
 =?utf-8?B?VUQ5TEE5aHMrcFRuclVLb2NQS0w3b0xMaW12Yk9ZcUtqZmNEaXNpTVplMERY?=
 =?utf-8?B?RDhTakZRb1RmZG8vRkM5dlowWHZKenJtbDkyZkhubG5QZlMrODdTNldYYUo0?=
 =?utf-8?B?cG9YNStibm8yMFpRSy9ZRURJTWxueFN4R2FVV3hJQWhXSDloR01mVDBQSzNi?=
 =?utf-8?B?eHRKa1Z6SU1QMjNoRlIrS1dHbW14cEhxYnZacEpPdjR0dzZXZmVuRGZLU0l5?=
 =?utf-8?B?SDNneHpHckpJWko1SjBIWDJmVmQxWFo5cjdrOE1OckVIZTFaL3oyRXlTWDkz?=
 =?utf-8?B?WUI2VXViaWpOZkcvbThzUEo3Tk5PVjVLaENxWmUzTm1BTm9sNmQ4R2dvVUNp?=
 =?utf-8?B?ZU1YM3E5N2JTdnlqbUpFNXJmZkRhZDdwU3dhZGF2S3BsVGZhZndEYWhpRUFr?=
 =?utf-8?B?a0tSOEQydWlMSGNsWmRsVmhzd29pNmJTTmV1eGxxd0I1V2tJWnhtN3VGb2Fj?=
 =?utf-8?B?eThZZDJ0dTlOYUtETmV2bU8xQVhGZTBSOXJjM1ozbU5GR21IYUY0ejluSGhp?=
 =?utf-8?B?NVhRZjJtNUdzS2RLWEpQa2tqSmVBYnFhQk5iRFQ0SlZBeHI2cHltajJoRk5v?=
 =?utf-8?B?ZFlZRm5xZDl3QkJveHBrR29PVTdLYjF3YS9mMGwyNWdBWTBDNHNVYTlnWXNz?=
 =?utf-8?Q?uXFI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c2f17-ecec-4e42-2a28-08dcbbaac880
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:36.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGP9IvjK7pKiApvUiP5rIRfHvCgEsL5VYQynwGuby0p/Oj+06aO4FWUrhD9e7feyOwLOwgQOp7emY+MQhJZr1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404

if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
                                      ^^^ here check "init_dyn_addr"
	i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr, ...)
						             ^^^^
							free "dyn_addr"
Fix typo "dyn_addr" by replacing it with "init_dyn_addr".

Cc: stable@kernel.org
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c8eaeada54781..65642e5afdcfb 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1442,7 +1442,7 @@ static void i3c_master_put_i3c_addrs(struct i3c_dev_desc *dev)
 					     I3C_ADDR_SLOT_FREE);
 
 	if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
-		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+		i3c_bus_set_addr_slot_status(&master->bus, dev->boardinfo->init_dyn_addr,
 					     I3C_ADDR_SLOT_FREE);
 }
 

-- 
2.34.1


