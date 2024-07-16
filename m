Return-Path: <linux-kernel+bounces-254432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B0B93331B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291D41F23F03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D638813D63D;
	Tue, 16 Jul 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="c53JvZl6"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023087.outbound.protection.outlook.com [52.101.67.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0FA13A88D;
	Tue, 16 Jul 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163177; cv=fail; b=u5kjDHfmS9421kclhZEJBScrPzAYCW8O9Opi4FgDPZGgbELiu/oSq1/M/2QJwsMMaDXOIKx9Se5jm7M87Ntrs7VohXDbBOYTXrZ5UzMyiu7+mRG0NlRKB+G3XFYbmveWRvqMHlH56vACP3VeIvLTDri0qStnJng77KUe9wYqzxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163177; c=relaxed/simple;
	bh=skDfnGRBBREUjLX77RLZ9oKcfP5sQBv9tQf4fFXEniQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P4mw5FyCAqzp+qH0ql0zw9HrU0iDg3UL1TftiMB557TfGVXdfjBdJCZMRg3YlJ/7XZ3U4IvvsIuPcCombIl5XknGREuV8X095HnT+NWBIF8TvA5VkXOSS70zcqDl4pN18J9OCzJPzSGFFWW6sDV32vZfeFvqh6SMf+iLzJaW2d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=c53JvZl6; arc=fail smtp.client-ip=52.101.67.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGFrO2fHB1A/FNj6QaVwMmuKvYbOYu1voTUKReg8ANsJtJhXEetLlODVuVSEYDePiH+H3MhfoCqpa95CETK7qGGhFtPoNxqEr0J9iLRBUW2jGimAJ7NPyZpRZarJ9tTlx2zhygRQ5puh7EY6xiUz2GfLfZnilQHSuZWCTNQ4GmvSETRixHs7qRyGUcuY19kQXYbgsUgU2w1jz+DBp5AhuVqiGro6wmPkXgDvx25PTY6tmo9VeKbo9eyqw98VIYykUN5QO7w74/GwHGCxsJ80WLpGrboxQ7S2f41LvVKbTlJSeyGV2xTsbRBX6BdTtLJFHlwVGvCa/iJ1POJrwRsQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qx8HfbcMS/xYfx01GPXfHOt2rGcViQ8W1/DHS62asc=;
 b=PZXGMVMpBtlEcVXX3lU7MZ4qRGkqwZg+o6keANrtpmhj7yUI+iYUmQ+GBy6+Tecz59V2aHJ3cXyvuHlviTeJbGIg1xweo+nFn9ZzStXbE1IFxngdxPmBvYg//VBK3VsyyCaop6mh3cK4Lo4Vdv0QMUuWJD9ioYosMZ+RBSs1vssQgxMwCqaR61S+Wda4csCz3xKcBLaFdqm2R9o/l3Kjv2sTeSlxrImDqCswiplG4meCCQqmAFTu9SjdUswJxNGIbDjEmg7T5ODgYLRgUUbzdQarMPftDnX534+Rlax4h4PglMLKgiN6DD+a1gFB4yACMhstpU4SGl/YWX3DjzfZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qx8HfbcMS/xYfx01GPXfHOt2rGcViQ8W1/DHS62asc=;
 b=c53JvZl6itbuovAXJPEiTPW9dU5UBJ/0IydRfi3Q4tq7QVH76SyGT0T2GD24OJugVplWwz4tuGj1PFxHeoDsY3sJYkNEsp94RRdSn1f9dJjFq1BVUcCaU3yyl5skSUZ/7coR0xEpx9uoo5BAIhKYAmHwwy4O+2/5tJyU9bVfMHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7907.eurprd04.prod.outlook.com (2603:10a6:20b:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 20:52:45 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:52:45 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 16 Jul 2024 22:52:40 +0200
Subject: [PATCH RFC v2 4/4] arm: dts: marvell: armada-388-clearfog: add
 description for usb phys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-a38x-utmi-phy-v2-4-dae3a9c6ca3e@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5b5c8b2e-c893-4398-bef3-08dca5d93ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUpqbXRRUThlTHN1d1FXVzMzQ3dNaFVxZDVXR0UxK0JEMzB1N3Y2d2p5WlQr?=
 =?utf-8?B?K3Q5Z1ptaThDNE5BRW5OMWNKdi94bHc5SWs5a2FoUjQ5WFcwVjF3NXlNK3BY?=
 =?utf-8?B?RmtldlhPV0h5UXA1c3dZQ3V0RzUwZjIxUGVyWW42Z0pRWFo1Y3JHR2NOZXZO?=
 =?utf-8?B?VlVEbTZLK0NkTUlmREF6SWo5UEM0TS9mUkFlQ1RlQ0FjdXlJM0Q0MUJmb1Bo?=
 =?utf-8?B?RGY0RXBWVkNwKzh1UjlmSFZDejdzaXEyZDRtTVRkLzM5QlJ4WkhJaFNVSGpm?=
 =?utf-8?B?TFhrSXB2SXQrdWVFTC9JdTBDNFZmYkUrZXlLRjN1MzYwS1NGWTErRlpxanh0?=
 =?utf-8?B?dW93Rjl3aGxYeGNJTjRhbFFxcCtsTWM5YjVjR2RNWlhqRjlFeXR6MUxGdFJ0?=
 =?utf-8?B?ckZXQ3BSdStYT0pMblppSEp4RDZnYXFNZDVZeG90dlM4UnQvbnZ4WlhvK0FV?=
 =?utf-8?B?MzJKSkd1VTB6M2JoVGVEYUR4Z09wVUp1UnJmYmJZNmRIQkg0N2JmZnBOWjNi?=
 =?utf-8?B?Qkx4MHY4NUJacGdueGU3NG1PQmVYUytxTkNpUnFSckJwMFBaeXF5NHpjeExt?=
 =?utf-8?B?eWw5bW1hcFRvS21pcXg5dlR3RWs5d0JsTEVvRkJBR0ZCbURXZHQ5MWtLVDIx?=
 =?utf-8?B?TnpQOHl6Wlk4MlZ4a0QyNnVTYlljWTFnWG42cERXTUFEOWF3SnB1cUxQNGZn?=
 =?utf-8?B?WHBQNnZPK0p6aC9FY3dtc3lrMjY0Q0ZsOGI0ckNrcFJreU5kNUFLUUZENnJR?=
 =?utf-8?B?ZC94czdndVNtWjk4ZlhoOWtLSVlXZ3hHNWtPakR4MFpaMHVUWGJrR3FWWW4r?=
 =?utf-8?B?cGtzMnNFOXljaUE1a1g2VFcrZ1daeXNMTEVYNjBORjAzMmZ3V0Y3LzJuOHJD?=
 =?utf-8?B?cnhhcWw1VUNnK1BjV3JOVjhtblhDTTVlSHpIUDNBOVhKd3dTTUt4SkJ3amV3?=
 =?utf-8?B?UVJFU2hBRmV0eFU2T3psN0ludlNsZDJtcmc2bUxabjFkdUZHaHdhL2Vic3lD?=
 =?utf-8?B?TnBhVzVvZHBoRmJZSWsvc0NlNGIxdzJhaGZtaVBFTXc0RFViMCt4ZzZPbnZR?=
 =?utf-8?B?dFZCcXlWbTUxM0JKMHpJQlE0bDBXSWltK2dPekJLWWRxSW9RajRHS0hnRjZ0?=
 =?utf-8?B?SmJ4ZmxNdGQ5cXJEaFAxcGVxejFBcWdvenpQc1U0Rkx0RFFwOFZNOE16WVJI?=
 =?utf-8?B?ZnZQTUVQai9wRGxnVmUvdThTSExkMUNyNUkzR3VEYU1Udm8raXhZdGk3NmN3?=
 =?utf-8?B?L1VNSDArWlplUUZ6bEpZMDhBME9IcXNBSnUvZGNZcEY2RWdScVVteXRqbFc5?=
 =?utf-8?B?Q1hKSTMxOUpBMTFKcmVMYUM4UE4vSGF4cmk1MWxwL2dRM1Q0T283TXN5aWQ1?=
 =?utf-8?B?QklsWVJjOEQ2d3NPRE0rSTBpejNWeHBWcVFxZzNYdmlob1JjQWx4WTRpRTNK?=
 =?utf-8?B?QnkxRnF1SWtJYWpJQUxobFE1eHRXenF2Tm10S2pDUkk4ZGtSeUZwQ1lvWmhu?=
 =?utf-8?B?aE4yWkVFY2JOclFkQmpVYnByNHB0eDdqUnltRVhVSlZSMkhYMG4rakg4cWxn?=
 =?utf-8?B?L1dWUW1kUlhKVnYrcHo3MXVVT1orWjhTZDFUQzN4OWR2WFFnc211OWg0bVJB?=
 =?utf-8?B?TzZQdFFEMEkvaVJhdjFNWDFmbnJZRDdCWXhhTnNqRWJtaDM5a29BNHQyQXRi?=
 =?utf-8?B?ekk4a3A3QjZoa3YzeEhPV3lPSGE5Z0VmeUpvOVFUblFkUkRKVmc5TjNCQ01v?=
 =?utf-8?B?ZWg3SjVzaTBHZGYrc20vUGhOOUJSVFhOcHZJMy9ZNlBQVHJGRFlnWEVoS2dS?=
 =?utf-8?B?Nm1aOEsrcndpa1h3TDlNRTlseThSWkZ2cmRVMzNIMmNjUjU5Rk40Z0ZQZ3Rm?=
 =?utf-8?B?T0xjRXdSQndrREx6WThKdkJ1Ly9XNUNuOUptRVRKOE81MGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJLdGI1c0ptQU5jbWNjWWlrcmFxOEN1c2Z5MTh5RmhMaVR0YTJPMlQzNDlC?=
 =?utf-8?B?VzlqNHBUZ0JLT0lmeE9TalNnK3hwWUJZZjlEQlBiZUlQaDlqSDZvdEoxdFFU?=
 =?utf-8?B?aTdoMWM2QU1zQXgwbHdCQTRCRS9UUGJrQ01DMmhPZ2Q4aUxSWXR6MTBkWG9p?=
 =?utf-8?B?UDZXRTNGQ0lHZ1Z2b2JvRjJGTVAwSHo1MGlJYjZyeERuUDQwbE5GRlNoNkg4?=
 =?utf-8?B?NGVneXJjUHNBS3lvK0JtbmJ0cFVtTTFZOCt6dmJaT1lmTW5kSmFiZFZyZEpo?=
 =?utf-8?B?QjVXcTBjZHY0eVR6SnE1VkNWa1drWlQxSlFDdXlJZ2cweEdaNmZYc3E3bGRs?=
 =?utf-8?B?Vkp5eU9WenBCcW1wb1RLMDZLQ1RSUi8zTWVCTCtKbTN3NkFJSWNBUnFpcXhj?=
 =?utf-8?B?SjFEZEhkbk9mZ0w0VklMTENxaVBMbWVLNE8rNlZjRW51a296a1BuMXcrTXAz?=
 =?utf-8?B?cEFJRTl3NlVkSzBnaDREY1BHbTlKeG9VdUludWgyQlFpVDhrcjd4bTk4enpL?=
 =?utf-8?B?Z0c2NElTa3NRTDJmMlZOYU5rd01GamVSMldub0FaL01WRVZWNWlNUTh3cW9U?=
 =?utf-8?B?QzYrdEpNWC9QNlpCMVE3WlhjMkt5dE5GRU0zWEJTT3gyOURiUHlUcC9haVRw?=
 =?utf-8?B?OVFNQnQ5cmNOd2syNGY3WnhoT25YS3NhRncwZzJDMlVBa3ZDcTU1dmQyZTh5?=
 =?utf-8?B?dmZ6d1NKQ2c1MTNBcWVrQUlhbHZpeThicVg0cWdvSmgwakkwSE5rNGxqeXBK?=
 =?utf-8?B?ZVptT0JnazFSVENWUEU0SUVHeTEvbXU0M2lRL08vYTE1WEJkdlE0SXNLemFM?=
 =?utf-8?B?SldqbGtBQVYxOEVidFNVb05MOGdNL1V5bnBQOWNyam5wQWNyZ1BwQVR1T2Rw?=
 =?utf-8?B?aXJCeUt2NEZ6NGdyaEF1NmVvenowdDVOSTRWZ2xURXVpTFJFU21mV3JObi9R?=
 =?utf-8?B?R0FFTWZFanQ2TnY1dFBzbEZGcnR1MzRTM0JlWHRIRXhPcCtGMEdwSDFsSEN4?=
 =?utf-8?B?cFg3N2hnUTlRdGp3TjlXekJEdjhkMURtak5xcGVwd3QrcG9VSWgrczVXL3RP?=
 =?utf-8?B?RHN2SG1lV0pkTHptTXprSmdlM1NldE51UkZJRDVOcjl4a0ZveXJnZXdXMmVh?=
 =?utf-8?B?dUNTNTN1SzBLVnkwWHNPQlloZmxUbWJDV3pJNzdtYThRaisvUzNNak96TWts?=
 =?utf-8?B?R0tQeVBWbTkrSDV6MlYyMUthTmlZaC93d0JpbTRSVXFxM1haSXprYkxrL0ls?=
 =?utf-8?B?Q0QwM0doeXBHY2ZlUlVDTFM3L09KR2h6R2tSeWJocVVkeXJ2SmNaNkZWQjJ5?=
 =?utf-8?B?NjBpb2UxaEp3Qytka0toZUdFSEJESHhqZnlZV0hWOXRYQWlWLzRSVkZZUk9k?=
 =?utf-8?B?MFIweGFHMitnQWpqV3N4V0xYUjBCc2tSdWYycWhjeHY2TzYzSVpCSlgva3A0?=
 =?utf-8?B?WklKeEU2TzNoaG1FdXhGaUVDU2VEcHNnTDB0bjBoU2QzRjlwYUplV1I1dnR3?=
 =?utf-8?B?K1dENE9ZTVZEUHJMYWRsblVZOW01NTBjVlgySzNibmhKamlsV0lsbzJjenEv?=
 =?utf-8?B?K05oK1NNOHRyeE54Tml6WVk3R20ydkVmRnp3UmJ0RVhJdjIrRlRqQVlRU2R5?=
 =?utf-8?B?cTBldUtQWFRvVktEak4zTzVkVkFENUN2ZjNkL0FUOHV0b2ExY1BVTk1DWjNF?=
 =?utf-8?B?dklsanFFQnRSSFlnd2x5T3hiYnFEeXJyM21DUDc0SmJBOTQxOUN1QWhYVjlk?=
 =?utf-8?B?ZHhFZkw2bWZVajExYmJ3RnpYNWRJT1JzMXcwWFBRb08ydS9nMFBoWUR5dE5I?=
 =?utf-8?B?MjJkaGNnVWlrajYweStDSHdQRjFndjhlSUJ1LzlVSVY1aGI0Z0xWcVVsNUxZ?=
 =?utf-8?B?WHlxYUVyZkRHM0hybGJ1Mlh0SFlMUGdlNlRTa204ZHhyMEhhazZybmF3eFBC?=
 =?utf-8?B?MWRSMTV5cm5jNzZiWHA2Mk1HVGtvMllqQkovTUVQVkgzOWlOaHZ6bjNVRzAz?=
 =?utf-8?B?N3hsYnU0SFBCNGI0V0RqeVNhY0p0bnFhUHpMbEw0Lys2WjZ3amcrTFg4ZWNk?=
 =?utf-8?B?K21mTFgyQmJNRi9OSzk2a1NseGZsTis1OWJoSjZiU3E2T1lEazkrUnpYQ2V6?=
 =?utf-8?Q?D4g535WU72J8vZ0sBz19TKfOX?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5c8b2e-c893-4398-bef3-08dca5d93ea0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:52:45.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuNd1jUQgXdJ1Y9P38ZFd7E+kip0x19Uad8VLZNvCu6uFxwy6u4eCD77rheMpVaTY7vXNj9bQiVXmkZoQuSGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7907

Clearfog Base and Pro use three sets of USB-2.0 signals going to various
connectors. Only two were enabled so far without links to their phys.
Further there were some minor issues with usb port descriptions.

Firstly add references for each phy to the corresponding controller
nodes. At the same time redeclarations of controller nodes are replaced
with references to labels in armada-38x.dtsi.

Secondly enable USB-2.0 controller routed to Clearfog Base M.2 /
Clearfog Pro mPCIe connectors.

FInally add missing dr_mode properties to stop utmi phy driver from
complaining.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../boot/dts/marvell/armada-388-clearfog-base.dts  |  8 ++++++
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |  8 ++++++
 arch/arm/boot/dts/marvell/armada-388-clearfog.dtsi | 30 ++++++++++++++--------
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
index f7daa3bc707e..09ba024e432e 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog-base.dts
@@ -66,3 +66,11 @@ rear_button_pins: rear-button-pins {
 		marvell,function = "gpio";
 	};
 };
+
+/* SRDS #4 - USB-2.0/3.0 Host, M.2 */
+&usb3_0 {
+	phys = <&utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 09bf2e6d4ed0..4f5bb5867f20 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -182,3 +182,11 @@ &spi1 {
 	 */
 	pinctrl-0 = <&spi1_pins &clearfog_spi1_cs_pins &mikro_spi_pins>;
 };
+
+/* USB-2.0 Host, CON2 - nearest CPU */
+&usb3_0 {
+	phys = <&utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
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
2.35.3


