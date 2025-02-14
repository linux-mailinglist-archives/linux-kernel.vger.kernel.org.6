Return-Path: <linux-kernel+bounces-514725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F7A35ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D11F3AA589
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF524BC1A;
	Fri, 14 Feb 2025 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="fbba2Acj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89BB2163A5;
	Fri, 14 Feb 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526698; cv=fail; b=DgBtMcO+YPIebyZm7KcW42rVC/5bK+kWjWI3aFTovKFczNuZ56FlMVsPLk7pUwpK7DXXGniF5kwqErTr26PgKEi/gWHsftSjpc34DqlDedybjXU73x/LszI3uy6wkE0PLpyxz86Jr/NkeNstWWWNDXEe+b/eP+Ilc7j4+4RdMJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526698; c=relaxed/simple;
	bh=exuyxasBspQ4jRGII8OPVgxBypSD7TcMF3ezgjtWdP8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cs32HPDBJfo5T1mi/b/Hz0L3lxc6EM11WDyeZwSltYri+LDzcvKPuUUN2xIwNmMatwu3yIraRo74k9HTWdYKW1blmUaBVqFpz4kXZx7sa6hO4DOXHpQrtK3C1xwQAMICwXXWtLUfjpNTC6TE/rdC2oW78L079pgab94Hff7k7QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=fbba2Acj; arc=fail smtp.client-ip=40.107.255.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFdoxZdv9Idcz4ZvBt9Y3Ji60KSxFPc8AMMJrvrJSEoKGrwU4YX9ggXQxD/I4cdWs36eBJPwN7C961+nWP5yHGxeQ96OdfKs6RX+byPw2153Mx1knFn/Zw2qR4hhFdI/0t5iBjNfcgS6PKcwx6GTc3AlQiefCtG98jHAsjs+eDSK46Gb9pbl8nCmo4gKmA7yEBJRWoOMzaTTjr0MmZeNhZ6Fiqp1mjnT28XY58KfDGVJIwfplHsTnyS2ugh2XTZx7TBAUxT95xfYzS/i1ij9+rhzoveiCF6tGAZz8E7QYrYEzPpFcqdCtyCxr3TDu7PzSty595mp+1y/h2/imhGO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WszC8fhjLFI047hUcNXHd7sMKPutQxHPN/QvhOHIq5c=;
 b=TZknqOFwWz1kQtfpKNn4CRM/epPb3b6ay49KlB35Vh8B+BVHy8SKIG1KrkaMy6bWMcAlHhAC7HBDIOrFWwz8i4b6Nuhh41xYX19vhlWjv+U/9VR0q+9qA9V8/Q14eXjDIBUQd69V27d1ManM7UwXPCbmApfCP2EcmRR1sxVtN95PKSwLqyzTsybw4RfNSErs4Pst5X0GhkI82H0ZB1wcTUcdQN/uVOYBYNr8XYW/REWBaekLTNE1ssyPlty5ztP70s7xUPC7X9Ny0r82npq7hx8ERgz+T2ThBmS1B4CNttKiD61r147Qh04LvlpiFMJnKsgTW2nHp+9B+VwBJTzN2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WszC8fhjLFI047hUcNXHd7sMKPutQxHPN/QvhOHIq5c=;
 b=fbba2AcjrWRv5lZNYCbAicxqlrBrsadrUlIGNz8rZkrCf7qo4/xkoWW19RgBKREf03LvlFkywGpHxM78aghwAPXXbIxxi6uI8E9TeAutpEeDKQxvvL/uRoBb6mEoT87a6YpjQON0MPV3ltkYNoqvg59au8gZKgI2MiLPAG6MSrMzp6g4ljo2riSlFGg7WtRsOXijzeglxGku/kEmwVQ/HgauGJH6jIpH5ILLSvmXg55iRFLCelQUwwaijjy2fhOH8Joa4Jb1ss6cDpxPw9RW/2ocTPDXyeCFhnsEzz42aYbPsmzBpZGIngmSqG+SiTiKrG2I7G57AjciB0OtcC4s3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
 by SI2PR03MB6782.apcprd03.prod.outlook.com (2603:1096:4:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 09:51:33 +0000
Received: from PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d]) by PUZPR03MB7135.apcprd03.prod.outlook.com
 ([fe80::ecac:a387:36d8:144d%3]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 09:51:33 +0000
Message-ID: <d2677180-9e98-4ba0-86c7-7e1e499c4456@amlogic.com>
Date: Fri, 14 Feb 2025 17:51:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ASoC: meson: s4:support the audio clk
From: Jiebing Chen <jiebing.chen@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>,
 jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com
References: <20250214-audio_drvier-v2-0-37881fa37c9e@amlogic.com>
 <20250214-audio_drvier-v2-3-37881fa37c9e@amlogic.com>
 <1jed00zy4i.fsf@starbuckisacylon.baylibre.com>
 <1j8qq8zxzn.fsf@starbuckisacylon.baylibre.com>
 <67aa2e46-b63e-4a7c-8b14-37e2b63d44ec@amlogic.com>
In-Reply-To: <67aa2e46-b63e-4a7c-8b14-37e2b63d44ec@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To PUZPR03MB7135.apcprd03.prod.outlook.com (2603:1096:301:113::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB7135:EE_|SI2PR03MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: c690167a-3140-4ac0-91f6-08dd4cdd29a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3lhRzFLekp5aXhxTm04enpuVGpRR0JhalMxZjdoUUNYakt3RE0vdFhWZUpE?=
 =?utf-8?B?bEJmTTBBTXJ6RzcyZ0MvaUpadGNOdFJMVVgydnVaM1RiNW5ZNXkrajlKUGNF?=
 =?utf-8?B?U01LSHBlSk5GeURiNE9KRytUY0w2SERvVTJsbmRkMEFFdFd4OWZldTYrWm5F?=
 =?utf-8?B?aTIwYTlDRGU4dFZud21mRVVhbTlOY1ppUThhVWwzTk9YUDNwL21hYU5sQ1dz?=
 =?utf-8?B?ZEp5RDdqOW4yYWJoRkdpN0FOTWdsUHBnT0cxL0Q0WG5oVys0VFAwYmx3NTBX?=
 =?utf-8?B?ZnltcmNQellkTjRBYzIya09DdzlzRUh5M3NJMDRHeGl2eGZxak12UkVKLy9L?=
 =?utf-8?B?NEFYTWNONEx2Q1B6OXZvYktKS3dxS3FZckloR0VXb0hqRVJGcVpBQ0IraGNr?=
 =?utf-8?B?cGFRRy9mMzk2QklXWW95MUdtQUFaRVZkWjdCekdCN0VXQ0orRUFkZE4zUGtH?=
 =?utf-8?B?UGlhbHVUYVRTZXN2VEZnV1RicUZWZTE2c09jbnpiQmFkQzNmSGtvc1dNRGhB?=
 =?utf-8?B?SldqMlZpL3U3ZkRidmNPYTEwdFdSelFWdHF5OUpOMTM4S21DQW0xSmlSS1Qw?=
 =?utf-8?B?WW1oM29JU1hkLzVnYVFjTnI1R0RuWWJDNjFZODdORks1bXVHZC8rZVlYNnMz?=
 =?utf-8?B?Q1R5Z05YWW82TUtTazJEd1hMVUpwcXl5ZXpaQndFVGxvL082K0R4QXY0T0Nr?=
 =?utf-8?B?UXhDb2xBQ0pkR2MzenNvT2VTZWdDR3B6d29sQ0Z4czhwaTZlLzgvOFlaaUVl?=
 =?utf-8?B?bzh2UmVaM0pmYXVkY1hPNU50dzZsSVJ3Ym50VkdhN0M5R2pxRUpGaTdrSkF3?=
 =?utf-8?B?TlBwRFdjNVhXMU1tbWNUOU4rVWZuSTIzM3BLbUhaa1Y1ZUFBRUMxd3dLaEVr?=
 =?utf-8?B?VExLNkc1dmRIODhXTUkyZzduK1g2OXUxSkZVUUtxUFpOV2c4MldLWmltK3Nv?=
 =?utf-8?B?aUc3dFhVZ0RrKzcrUFB2T0VrK1FGeDZSTjZXaUxKR1NZYmo0SDJzLzdUM2xm?=
 =?utf-8?B?c3d5Nks0NXFqazljQkRQZmtObW5mdmdBQ2I0MFBOYjZXeTVzbHE1dUtGZVdZ?=
 =?utf-8?B?T0x5bnNMREF1MWpuN1hiVjJuaDlSc1FFTk16V0pvbDNNdXFrdFRONlBGaEEw?=
 =?utf-8?B?K1ZPVjdQbnB4VityMGFPR1dRK1Q2ek50UDVrR1JWT3dtM3FnWGZIb1VMeU95?=
 =?utf-8?B?dndWY2tVWVN6VWxHWVE3aVNaQkhhQVV6SkZvYUc1aDI2VW9FdWcrNkxmTjRu?=
 =?utf-8?B?VGV0dnQ0ZTlEcDhyc1Q3UmVDR25nUkh2RWlRb29lZmtFV2hBWU92cHNrSVFk?=
 =?utf-8?B?cG9PUHF6Y05sWG1jVXlMdS9zbnFvVVlwNTVibnpPRE1nMzN0TWRnNHAwZHpZ?=
 =?utf-8?B?RXc2SHM3ZVY2ZXRqb2ppbUZlR2tXcmhyc1dxWDIyZUNNSlhwWXRJOTZKWWhk?=
 =?utf-8?B?VE0wSW5NMVQyM0ZUM1RkeWQxN2JEMUtpUXNML09xRm02N1BVblF3blYycFpj?=
 =?utf-8?B?akVwM21BRGZSZDhvR2tDOTRiemp5WEdPYVpoamVINnR4ZDBVUXY5V3ZCSDRx?=
 =?utf-8?B?NENsdW5ibmd6L3BuVk1uTkJaQzZhS1gweXkxVEpZYlY0WExmYW4yWGFoRFdt?=
 =?utf-8?B?U3FDdWhGWGkrbWNPOTBuU2pvYmpDTjRaT1Z3REFNZU5jNEtXUC9mM0YzTGFz?=
 =?utf-8?B?Ri9iN0lmZ1V1ZjNNbEVQM0NsMnFCQUVnZjdxc2lldzdZeFZGcXBoYWhmWmxu?=
 =?utf-8?B?WjNRV3kvd3RWbEQweE84Q3d0WnBXMEJ6aEltU0o5RXRqc3JReXlGR0NNdlhz?=
 =?utf-8?B?RlRxYlpuclAxRDNZWmRpdk5xZ2M2QXNYSktuL280YUowU1o0aTd4SVNFb3JX?=
 =?utf-8?Q?phIe14ErF5Bb/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB7135.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTB4and3QUdRdjRXVC9GSEFSRmxUWG9WMkt1N3J3djlSc3Nra0hYMVVxY3pW?=
 =?utf-8?B?QTJ2TzZaWXh1UnBjS0ZqOFV5UXUvMzIzNnVrYVdhdHdjbDFyYXBacmpoS3RC?=
 =?utf-8?B?c0JVNmxubUV5STI0REFaenlRRk53em9DZm1IRzdpWC8zamdsQnBvbnFhUS9I?=
 =?utf-8?B?YURMSk9iSWxBZURYUWpDZy9mZHpwMVlLUlkxS20wMHorTFh3YlNtbWJySkc1?=
 =?utf-8?B?ZFJwUVc4QStPMk96MXFSc0g3L3Y5YXQzaVROOGhPS1hWTnRTbGxzSHoxTkxp?=
 =?utf-8?B?eWdnaXlBais0UlA2M3FZN0VKR2N2Mmp2K01KWjhTYnYrbHVYKzRBcnZQbjBt?=
 =?utf-8?B?QmZKWU5qOHFmRXdIelBSbTVGdE5peU90ZENFM0NWdUprbUJYU3F3eEpwSmlK?=
 =?utf-8?B?dm8zZlJmSW9CMkxLbVhMVHl1T2t6S1F5RzIwcDdZSjI0b1p0UTNwbmZINXBv?=
 =?utf-8?B?K1Q3NFNyTWhkd0crdTAybytZMTN6cURKZjQ0N0lBaml6bUhSOUxUZ25CQmxw?=
 =?utf-8?B?L1JnU0J3MmVCei9UeHJPTDJVKzdmQjlIK1RudXU5UU1ZeTJSQWJxRVZUQW9t?=
 =?utf-8?B?ZzhnQktFQ3pKdE1WL0QrbVJsc2ZNUWRjaFV0K0hpQVBiOGVWVUkzck55SWRC?=
 =?utf-8?B?elJENytLK0dlbWx0dzV4VXBYK2VnRFo2VUZPSURPMWRCOXEydGZjNnNpMEN6?=
 =?utf-8?B?OFArSURBeEsyWDY3VWRxNEVCTkFBYXpHd2dLN0VnZS8zeGhMd2RpQjB2T2Jj?=
 =?utf-8?B?cjlrWHQ1d2p1UVBIWHlSd0Rva1Z1NHhsWDJwNit3MFdCNkZ1QnNINVo0MnMr?=
 =?utf-8?B?RHlXQ0xUODcySEIzcTBTZUcxcVRta2hwWlNxTE1LZzJUQzgra2RtenBIb21s?=
 =?utf-8?B?VEtUT3M3TFMycnVLZDU5dENNQnIxOGI0Nkp1T3E1aG5aVTdydTg1MFFtWFkr?=
 =?utf-8?B?QVU2UXF2TXloQmhrTWdJOHJ1QnFRaUtTcU9DT2lTSm92YlFkL2pEak1HbjRm?=
 =?utf-8?B?MWtNQWhsbkw1UHFyWGNrdUZrR2pOYks5NnBkalBRMUVMQ01DZFNoTEtPcXpZ?=
 =?utf-8?B?Tm9SNzYrMEdvS3VrWWlsaUt2SEk4UndVVUNDNDdrVEkyMVVSRmp2WkF6cFpv?=
 =?utf-8?B?Z0k0YjIwdEZVRmFnc0JjaVpVQlFzejlPaEVDWCt2WjNyVGxuR2trQXFJd1Fq?=
 =?utf-8?B?SjBjY1d5Y3lWSXJZYnNDcHArOVg5Y05GeGhuSUJzdzFPRU5UTzNiWmdYb0tp?=
 =?utf-8?B?QzJnVXBpbjNobHhhNzZQYkl4Q3M5MWs0ZHFQTVJRUytUcmc1VFM2SklNc3Mz?=
 =?utf-8?B?di94VDhVdDN4Vm1OV1FEdE9oSWgzTER3VjZ6OGp2T0VDdXlEN3BLSW8ycVRN?=
 =?utf-8?B?QjNjbDhxSVl6eGRwc3U0UlMraFg3ckpJMmZ0b0R1VHBLYWFSRXorR1dvcmNS?=
 =?utf-8?B?OHl4VHEwTzY5Tzd2SHppTUNRZTZtbDBkaVAySnJPL0JKRFErci8relBWRE5R?=
 =?utf-8?B?WkpNZFJ1WUxFNlRpMHpKMTRQaTAxNlo0OHJSU3BSSkpxNldGQmtOY3BOMElw?=
 =?utf-8?B?eXpud2ZwWVF5RG1qYWYwUDlyVDMxdXNabjA5Q1NZNWtpaFNEL2FKcU5GbUhM?=
 =?utf-8?B?YzhyS0gwb1FHemdzMTdJSTNtZk40QlhqRm5hQWZ1UjFyVUg4L0duN29YOHh5?=
 =?utf-8?B?RFRBMUNZSml3cE9ZQzdPOVRBK3BCZG8raUxVYVR0emZQR29JNnliYm1rYmlr?=
 =?utf-8?B?bjZmZUxmZ2djZE9XWDh3MHdmYVpjN2prN2FWQjN3QzBtZnlpcEtWaVFvbCti?=
 =?utf-8?B?NitKeDNDaWJJWnNJb3RZblpBRWd0SzZHd1hyRVB0Z3l0OS94OVhEUXYvZDFX?=
 =?utf-8?B?eDZiTWxUekd0a0VoYXhqWVA1MEIvMlNPSE5sTnFpblMyaXJka3ltMUxuMWNj?=
 =?utf-8?B?T1RmVmhkeDRiV3lORHd6RGFYY05rZ29WV21UeHhoSllrYTRCa3F1bC9CZVha?=
 =?utf-8?B?M09ZRGNIY0Jpclg4cDhYSXFVRWRuY0MrVlpVbFh6RmJ1dkQ1c3N6czdndkdr?=
 =?utf-8?B?REdGMEVDOGVUcVgxV1V0UE9DQklHbTJkUWNkUEpZUEtRWGN5b3hlcklHUG5j?=
 =?utf-8?B?TWVJK2puZE9vQk81SUN4VjFBSUFzcWVGTEtmVEg4UE53UDd3VlVWRkwrMVBn?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c690167a-3140-4ac0-91f6-08dd4cdd29a7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB7135.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:51:32.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2KS+MtUj+IUU/Q1e8PLHlLCtlr0BtjdkijfxUfQI5HMaYuneJTRS9G9WRqioLv80+teHeiW1PjbIlNOk7VR8hKObY303vco2XsW2BgRyGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6782


在 2025/2/14 17:44, Jiebing Chen 写道:
>
> 在 2025/2/14 17:17, Jerome Brunet 写道:
>> [ EXTERNAL EMAIL ]
>>
>> On Fri 14 Feb 2025 at 10:14, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>>> On Fri 14 Feb 2025 at 10:13, jiebing chen via B4 Relay 
>>> <devnull+jiebing.chen.amlogic.com@kernel.org> wrote:
>>>
>>>> From: jiebing chen <jiebing.chen@amlogic.com>
>>>>
>>>> Add the audio clk tree for s4, add new mclk, sclk and lrclk pad.
>>>>
>>> This disregard previous feedback about the compatibility with the
>>> axg/g12 platform.
>>>
>>> Is what follows really the only difference between the 2 ?
>>> You previous reported the difference would be significant and now 
>>> this ?
>>> I don't get it.
>> And the title is wrong
>
> Hi, jerome
>
> The s4 mclk pad  is different from the g12a ,for g12a. the mclk pad 
> not to add the div factor,
>
> for the previous version, we only test the internal codec, it didn't 
> rely on an mclk pad,
>
> if not use the external codec(dac/adc), old clock  id is compatible, 
> so the old clock id still work,
>
> based on your suggestion, we re-added the full clk id for s4, the s4 
> base on sm1,  except for some
>
> minor differences between the mclk pad and toodec and sm1, everything 
> else is exactly the same
>
> This is the s4 mclkpad  register

mclk pad0

bit[15]:en

bit[10:8] pad source

bit[7:0] div

>
>
>>
>>>> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
>>>> ---
>>>>   drivers/clk/meson/axg-audio.c | 410 
>>>> +++++++++++++++++++++++++++++++++++++++++-
>>>>   drivers/clk/meson/axg-audio.h |   4 +
>>>>   2 files changed, 412 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/meson/axg-audio.c 
>>>> b/drivers/clk/meson/axg-audio.c
>>>> index 
>>>> 9df627b142f89788966ede0262aaaf39e13f0b49..e70559ee0fd8deaf9858b0592e839fdf49d05886 
>>>> 100644
>>>> --- a/drivers/clk/meson/axg-audio.c
>>>> +++ b/drivers/clk/meson/axg-audio.c
>>>> @@ -323,6 +323,16 @@ static const struct clk_parent_data 
>>>> lrclk_pad_ctrl_parent_data[] = {
>>>>       AUD_MUX(_name, _reg, 0x7, _shift, 0, _parents,          \
>>>>               CLK_SET_RATE_NO_REPARENT)
>>>>
>>>> +#define AUD_MCLK_PAD_MUX(_name, _reg, 
>>>> _shift)                                       \
>>>> +    AUD_MUX(_name##_sel, _reg, 0x7, _shift, 
>>>> CLK_MUX_ROUND_CLOSEST,                  \
>>>> +            mclk_pad_ctrl_parent_data, 0)
>>>> +#define AUD_MCLK_PAD_DIV(_name, _reg, 
>>>> _shift)                                       \
>>>> +    AUD_DIV(_name##_div, _reg, _shift, 8, 
>>>> CLK_DIVIDER_ROUND_CLOSEST,                        \
>>>> +            aud_##_name##_sel, CLK_SET_RATE_PARENT)
>>>> +#define AUD_MCLK_PAD_GATE(_name, _reg, 
>>>> _shift)                                      \
>>>> +    AUD_GATE(_name, _reg, _shift, 
>>>> aud_##_name##_div,                        \
>>>> +             CLK_SET_RATE_PARENT)
>>>> +
>>>>   /* Common Clocks */
>>>>   static struct clk_regmap ddr_arb =
>>>>       AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN, 0);
>>>> @@ -826,6 +836,49 @@ static struct clk_regmap sm1_tdm_sclk_pad_1 = 
>>>> AUD_TDM_PAD_CTRL(
>>>>   static struct clk_regmap sm1_tdm_sclk_pad_2 = AUD_TDM_PAD_CTRL(
>>>>       tdm_sclk_pad_2, AUDIO_SM1_MST_PAD_CTRL1, 8, 
>>>> sclk_pad_ctrl_parent_data);
>>>>
>>>> +static struct clk_regmap s4_tdm_mclk_pad0_sel =
>>>> +    AUD_MCLK_PAD_MUX(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 8);
>>>> +static struct clk_regmap s4_tdm_mclk_pad1_sel =
>>>> +    AUD_MCLK_PAD_MUX(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 24);
>>>> +static struct clk_regmap s4_tdm_mclk_pad2_sel =
>>>> +    AUD_MCLK_PAD_MUX(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 8);
>>>> +
>>>> +static struct clk_regmap s4_tdm_mclk_pad0_div =
>>>> +    AUD_MCLK_PAD_DIV(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 0);
>>>> +static struct clk_regmap s4_tdm_mclk_pad1_div =
>>>> +    AUD_MCLK_PAD_DIV(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 16);
>>>> +static struct clk_regmap s4_tdm_mclk_pad2_div =
>>>> +    AUD_MCLK_PAD_DIV(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 0);
>>>> +
>>>> +static struct clk_regmap s4_tdm_mclk_pad_0 =
>>>> +    AUD_MCLK_PAD_GATE(mclk_pad0, AUDIO_S4_MCLK_PAD_CTRL0, 15);
>>>> +static struct clk_regmap s4_tdm_mclk_pad_1 =
>>>> +    AUD_MCLK_PAD_GATE(mclk_pad1, AUDIO_S4_MCLK_PAD_CTRL0, 31);
>>>> +static struct clk_regmap s4_tdm_mclk_pad_2 =
>>>> +    AUD_MCLK_PAD_GATE(mclk_pad2, AUDIO_S4_MCLK_PAD_CTRL1, 15);
>>>> +
>>>> +static struct clk_regmap s4_tdm_sclk_pad_0 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_0, AUDIO_S4_SCLK_PAD_CTRL0, 0, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_sclk_pad_1 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_1, AUDIO_S4_SCLK_PAD_CTRL0, 4, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_sclk_pad_2 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_2, AUDIO_S4_SCLK_PAD_CTRL0, 8, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_sclk_pad_3 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_3, AUDIO_S4_SCLK_PAD_CTRL0, 16, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_sclk_pad_4 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_sclk_pad_4, AUDIO_S4_SCLK_PAD_CTRL0, 20, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +
>>>> +static struct clk_regmap s4_tdm_lrclk_pad_0 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_0, AUDIO_S4_SCLK_PAD_CTRL1, 0, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_lrclk_pad_1 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_1, AUDIO_S4_SCLK_PAD_CTRL1, 4, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_lrclk_pad_2 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_2, AUDIO_S4_SCLK_PAD_CTRL1, 8, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_lrclk_pad_3 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_3, AUDIO_S4_SCLK_PAD_CTRL1, 16, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +static struct clk_regmap s4_tdm_lrclk_pad_4 =
>>>> +    AUD_TDM_PAD_CTRL(tdm_lrclk_pad_4, AUDIO_S4_SCLK_PAD_CTRL1, 20, 
>>>> lrclk_pad_ctrl_parent_data);
>>>> +
>>>>   /*
>>>>    * Array of all clocks provided by this provider
>>>>    * The input clocks of the controller will be populated at runtime
>>>> @@ -1257,6 +1310,177 @@ static struct clk_hw *sm1_audio_hw_clks[] = {
>>>>       [AUD_CLKID_EARCRX_DMAC]         = &sm1_earcrx_dmac_clk.hw,
>>>>   };
>>>>
>>>> +/*
>>>> + * Array of all S4 clocks provided by this provider
>>>> + * The input clocks of the controller will be populated at runtime
>>>> + */
>>>> +static struct clk_hw *s4_audio_hw_clks[] = {
>>>> +    [AUD_CLKID_DDR_ARB]             = &ddr_arb.hw,
>>>> +    [AUD_CLKID_PDM]                 = &pdm.hw,
>>>> +    [AUD_CLKID_TDMIN_A]             = &tdmin_a.hw,
>>>> +    [AUD_CLKID_TDMIN_B]             = &tdmin_b.hw,
>>>> +    [AUD_CLKID_TDMIN_C]             = &tdmin_c.hw,
>>>> +    [AUD_CLKID_TDMIN_LB]            = &tdmin_lb.hw,
>>>> +    [AUD_CLKID_TDMOUT_A]            = &tdmout_a.hw,
>>>> +    [AUD_CLKID_TDMOUT_B]            = &tdmout_b.hw,
>>>> +    [AUD_CLKID_TDMOUT_C]            = &tdmout_c.hw,
>>>> +    [AUD_CLKID_FRDDR_A]             = &frddr_a.hw,
>>>> +    [AUD_CLKID_FRDDR_B]             = &frddr_b.hw,
>>>> +    [AUD_CLKID_FRDDR_C]             = &frddr_c.hw,
>>>> +    [AUD_CLKID_TODDR_A]             = &toddr_a.hw,
>>>> +    [AUD_CLKID_TODDR_B]             = &toddr_b.hw,
>>>> +    [AUD_CLKID_TODDR_C]             = &toddr_c.hw,
>>>> +    [AUD_CLKID_LOOPBACK]            = &loopback.hw,
>>>> +    [AUD_CLKID_SPDIFIN]             = &spdifin.hw,
>>>> +    [AUD_CLKID_SPDIFOUT]            = &spdifout.hw,
>>>> +    [AUD_CLKID_RESAMPLE]            = &resample.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_B]          = &spdifout_b.hw,
>>>> +    [AUD_CLKID_MST_A_MCLK_SEL]      = &sm1_mst_a_mclk_sel.hw,
>>>> +    [AUD_CLKID_MST_B_MCLK_SEL]      = &sm1_mst_b_mclk_sel.hw,
>>>> +    [AUD_CLKID_MST_C_MCLK_SEL]      = &sm1_mst_c_mclk_sel.hw,
>>>> +    [AUD_CLKID_MST_D_MCLK_SEL]      = &sm1_mst_d_mclk_sel.hw,
>>>> +    [AUD_CLKID_MST_E_MCLK_SEL]      = &sm1_mst_e_mclk_sel.hw,
>>>> +    [AUD_CLKID_MST_F_MCLK_SEL]      = &sm1_mst_f_mclk_sel.hw,
>>>> +    [AUD_CLKID_MST_A_MCLK_DIV]      = &sm1_mst_a_mclk_div.hw,
>>>> +    [AUD_CLKID_MST_B_MCLK_DIV]      = &sm1_mst_b_mclk_div.hw,
>>>> +    [AUD_CLKID_MST_C_MCLK_DIV]      = &sm1_mst_c_mclk_div.hw,
>>>> +    [AUD_CLKID_MST_D_MCLK_DIV]      = &sm1_mst_d_mclk_div.hw,
>>>> +    [AUD_CLKID_MST_E_MCLK_DIV]      = &sm1_mst_e_mclk_div.hw,
>>>> +    [AUD_CLKID_MST_F_MCLK_DIV]      = &sm1_mst_f_mclk_div.hw,
>>>> +    [AUD_CLKID_MST_A_MCLK]          = &sm1_mst_a_mclk.hw,
>>>> +    [AUD_CLKID_MST_B_MCLK]          = &sm1_mst_b_mclk.hw,
>>>> +    [AUD_CLKID_MST_C_MCLK]          = &sm1_mst_c_mclk.hw,
>>>> +    [AUD_CLKID_MST_D_MCLK]          = &sm1_mst_d_mclk.hw,
>>>> +    [AUD_CLKID_MST_E_MCLK]          = &sm1_mst_e_mclk.hw,
>>>> +    [AUD_CLKID_MST_F_MCLK]          = &sm1_mst_f_mclk.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_CLK_SEL]    = &spdifout_clk_sel.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_CLK_DIV]    = &spdifout_clk_div.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_CLK]        = &spdifout_clk.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_B_CLK_SEL]  = &spdifout_b_clk_sel.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_B_CLK_DIV]  = &spdifout_b_clk_div.hw,
>>>> +    [AUD_CLKID_SPDIFOUT_B_CLK]      = &spdifout_b_clk.hw,
>>>> +    [AUD_CLKID_SPDIFIN_CLK_SEL]     = &spdifin_clk_sel.hw,
>>>> +    [AUD_CLKID_SPDIFIN_CLK_DIV]     = &spdifin_clk_div.hw,
>>>> +    [AUD_CLKID_SPDIFIN_CLK]         = &spdifin_clk.hw,
>>>> +    [AUD_CLKID_PDM_DCLK_SEL]        = &pdm_dclk_sel.hw,
>>>> +    [AUD_CLKID_PDM_DCLK_DIV]        = &pdm_dclk_div.hw,
>>>> +    [AUD_CLKID_PDM_DCLK]            = &pdm_dclk.hw,
>>>> +    [AUD_CLKID_PDM_SYSCLK_SEL]      = &pdm_sysclk_sel.hw,
>>>> +    [AUD_CLKID_PDM_SYSCLK_DIV]      = &pdm_sysclk_div.hw,
>>>> +    [AUD_CLKID_PDM_SYSCLK]          = &pdm_sysclk.hw,
>>>> +    [AUD_CLKID_MST_A_SCLK_PRE_EN]   = &mst_a_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_MST_B_SCLK_PRE_EN]   = &mst_b_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_MST_C_SCLK_PRE_EN]   = &mst_c_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_MST_D_SCLK_PRE_EN]   = &mst_d_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_MST_E_SCLK_PRE_EN]   = &mst_e_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_MST_F_SCLK_PRE_EN]   = &mst_f_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_MST_A_SCLK_DIV]      = &mst_a_sclk_div.hw,
>>>> +    [AUD_CLKID_MST_B_SCLK_DIV]      = &mst_b_sclk_div.hw,
>>>> +    [AUD_CLKID_MST_C_SCLK_DIV]      = &mst_c_sclk_div.hw,
>>>> +    [AUD_CLKID_MST_D_SCLK_DIV]      = &mst_d_sclk_div.hw,
>>>> +    [AUD_CLKID_MST_E_SCLK_DIV]      = &mst_e_sclk_div.hw,
>>>> +    [AUD_CLKID_MST_F_SCLK_DIV]      = &mst_f_sclk_div.hw,
>>>> +    [AUD_CLKID_MST_A_SCLK_POST_EN]  = &mst_a_sclk_post_en.hw,
>>>> +    [AUD_CLKID_MST_B_SCLK_POST_EN]  = &mst_b_sclk_post_en.hw,
>>>> +    [AUD_CLKID_MST_C_SCLK_POST_EN]  = &mst_c_sclk_post_en.hw,
>>>> +    [AUD_CLKID_MST_D_SCLK_POST_EN]  = &mst_d_sclk_post_en.hw,
>>>> +    [AUD_CLKID_MST_E_SCLK_POST_EN]  = &mst_e_sclk_post_en.hw,
>>>> +    [AUD_CLKID_MST_F_SCLK_POST_EN]  = &mst_f_sclk_post_en.hw,
>>>> +    [AUD_CLKID_MST_A_SCLK]          = &mst_a_sclk.hw,
>>>> +    [AUD_CLKID_MST_B_SCLK]          = &mst_b_sclk.hw,
>>>> +    [AUD_CLKID_MST_C_SCLK]          = &mst_c_sclk.hw,
>>>> +    [AUD_CLKID_MST_D_SCLK]          = &mst_d_sclk.hw,
>>>> +    [AUD_CLKID_MST_E_SCLK]          = &mst_e_sclk.hw,
>>>> +    [AUD_CLKID_MST_F_SCLK]          = &mst_f_sclk.hw,
>>>> +    [AUD_CLKID_MST_A_LRCLK_DIV]     = &mst_a_lrclk_div.hw,
>>>> +    [AUD_CLKID_MST_B_LRCLK_DIV]     = &mst_b_lrclk_div.hw,
>>>> +    [AUD_CLKID_MST_C_LRCLK_DIV]     = &mst_c_lrclk_div.hw,
>>>> +    [AUD_CLKID_MST_D_LRCLK_DIV]     = &mst_d_lrclk_div.hw,
>>>> +    [AUD_CLKID_MST_E_LRCLK_DIV]     = &mst_e_lrclk_div.hw,
>>>> +    [AUD_CLKID_MST_F_LRCLK_DIV]     = &mst_f_lrclk_div.hw,
>>>> +    [AUD_CLKID_MST_A_LRCLK]         = &mst_a_lrclk.hw,
>>>> +    [AUD_CLKID_MST_B_LRCLK]         = &mst_b_lrclk.hw,
>>>> +    [AUD_CLKID_MST_C_LRCLK]         = &mst_c_lrclk.hw,
>>>> +    [AUD_CLKID_MST_D_LRCLK]         = &mst_d_lrclk.hw,
>>>> +    [AUD_CLKID_MST_E_LRCLK]         = &mst_e_lrclk.hw,
>>>> +    [AUD_CLKID_MST_F_LRCLK]         = &mst_f_lrclk.hw,
>>>> +    [AUD_CLKID_TDMIN_A_SCLK_SEL]    = &tdmin_a_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMIN_B_SCLK_SEL]    = &tdmin_b_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMIN_C_SCLK_SEL]    = &tdmin_c_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMIN_LB_SCLK_SEL]   = &tdmin_lb_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMOUT_A_SCLK_SEL]   = &tdmout_a_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMOUT_B_SCLK_SEL]   = &tdmout_b_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMOUT_C_SCLK_SEL]   = &tdmout_c_sclk_sel.hw,
>>>> +    [AUD_CLKID_TDMIN_A_SCLK_PRE_EN] = &tdmin_a_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMIN_B_SCLK_PRE_EN] = &tdmin_b_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMIN_C_SCLK_PRE_EN] = &tdmin_c_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &tdmin_lb_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &tdmout_a_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &tdmout_b_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMOUT_C_SCLK_PRE_EN] = &tdmout_c_sclk_pre_en.hw,
>>>> +    [AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &tdmin_a_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &tdmin_b_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMIN_C_SCLK_POST_EN] = &tdmin_c_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &tdmin_lb_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &tdmout_a_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &tdmout_b_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMOUT_C_SCLK_POST_EN] = &tdmout_c_sclk_post_en.hw,
>>>> +    [AUD_CLKID_TDMIN_A_SCLK]        = &tdmin_a_sclk.hw,
>>>> +    [AUD_CLKID_TDMIN_B_SCLK]        = &tdmin_b_sclk.hw,
>>>> +    [AUD_CLKID_TDMIN_C_SCLK]        = &tdmin_c_sclk.hw,
>>>> +    [AUD_CLKID_TDMIN_LB_SCLK]       = &tdmin_lb_sclk.hw,
>>>> +    [AUD_CLKID_TDMOUT_A_SCLK]       = &g12a_tdmout_a_sclk.hw,
>>>> +    [AUD_CLKID_TDMOUT_B_SCLK]       = &g12a_tdmout_b_sclk.hw,
>>>> +    [AUD_CLKID_TDMOUT_C_SCLK]       = &g12a_tdmout_c_sclk.hw,
>>>> +    [AUD_CLKID_TDMIN_A_LRCLK]       = &tdmin_a_lrclk.hw,
>>>> +    [AUD_CLKID_TDMIN_B_LRCLK]       = &tdmin_b_lrclk.hw,
>>>> +    [AUD_CLKID_TDMIN_C_LRCLK]       = &tdmin_c_lrclk.hw,
>>>> +    [AUD_CLKID_TDMIN_LB_LRCLK]      = &tdmin_lb_lrclk.hw,
>>>> +    [AUD_CLKID_TDMOUT_A_LRCLK]      = &tdmout_a_lrclk.hw,
>>>> +    [AUD_CLKID_TDMOUT_B_LRCLK]      = &tdmout_b_lrclk.hw,
>>>> +    [AUD_CLKID_TDMOUT_C_LRCLK]      = &tdmout_c_lrclk.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD0]       = &s4_tdm_mclk_pad_0.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD1]       = &s4_tdm_mclk_pad_1.hw,
>>>> +    [AUD_CLKID_TDM_LRCLK_PAD0]      = &s4_tdm_lrclk_pad_0.hw,
>>>> +    [AUD_CLKID_TDM_LRCLK_PAD1]      = &s4_tdm_lrclk_pad_1.hw,
>>>> +    [AUD_CLKID_TDM_LRCLK_PAD2]      = &s4_tdm_lrclk_pad_2.hw,
>>>> +    [AUD_CLKID_TDM_SCLK_PAD0]       = &s4_tdm_sclk_pad_0.hw,
>>>> +    [AUD_CLKID_TDM_SCLK_PAD1]       = &s4_tdm_sclk_pad_1.hw,
>>>> +    [AUD_CLKID_TDM_SCLK_PAD2]       = &s4_tdm_sclk_pad_2.hw,
>>>> +    [AUD_CLKID_TOP]                 = &sm1_aud_top.hw,
>>>> +    [AUD_CLKID_TORAM]               = &toram.hw,
>>>> +    [AUD_CLKID_EQDRC]               = &eqdrc.hw,
>>>> +    [AUD_CLKID_RESAMPLE_B]          = &resample_b.hw,
>>>> +    [AUD_CLKID_TOVAD]               = &tovad.hw,
>>>> +    [AUD_CLKID_LOCKER]              = &locker.hw,
>>>> +    [AUD_CLKID_SPDIFIN_LB]          = &spdifin_lb.hw,
>>>> +    [AUD_CLKID_FRDDR_D]             = &frddr_d.hw,
>>>> +    [AUD_CLKID_TODDR_D]             = &toddr_d.hw,
>>>> +    [AUD_CLKID_LOOPBACK_B]          = &loopback_b.hw,
>>>> +    [AUD_CLKID_CLK81_EN]            = &sm1_clk81_en.hw,
>>>> +    [AUD_CLKID_SYSCLK_A_DIV]        = &sm1_sysclk_a_div.hw,
>>>> +    [AUD_CLKID_SYSCLK_A_EN]         = &sm1_sysclk_a_en.hw,
>>>> +    [AUD_CLKID_SYSCLK_B_DIV]        = &sm1_sysclk_b_div.hw,
>>>> +    [AUD_CLKID_SYSCLK_B_EN]         = &sm1_sysclk_b_en.hw,
>>>> +    [AUD_CLKID_EARCRX]              = &earcrx.hw,
>>>> +    [AUD_CLKID_EARCRX_CMDC_SEL]     = &sm1_earcrx_cmdc_clk_sel.hw,
>>>> +    [AUD_CLKID_EARCRX_CMDC_DIV]     = &sm1_earcrx_cmdc_clk_div.hw,
>>>> +    [AUD_CLKID_EARCRX_CMDC]         = &sm1_earcrx_cmdc_clk.hw,
>>>> +    [AUD_CLKID_EARCRX_DMAC_SEL]     = &sm1_earcrx_dmac_clk_sel.hw,
>>>> +    [AUD_CLKID_EARCRX_DMAC_DIV]     = &sm1_earcrx_dmac_clk_div.hw,
>>>> +    [AUD_CLKID_EARCRX_DMAC]         = &sm1_earcrx_dmac_clk.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD0_SEL]           = 
>>>> &s4_tdm_mclk_pad0_sel.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD1_SEL]       = &s4_tdm_mclk_pad1_sel.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD0_DIV]           = 
>>>> &s4_tdm_mclk_pad0_div.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD1_DIV]       = &s4_tdm_mclk_pad1_div.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD2]               = &s4_tdm_mclk_pad_2.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD2_SEL]           = 
>>>> &s4_tdm_mclk_pad2_sel.hw,
>>>> +    [AUD_CLKID_TDM_MCLK_PAD2_DIV]       = &s4_tdm_mclk_pad2_div.hw,
>>>> +    [AUD_CLKID_TDM_SCLK_PAD3]       = &s4_tdm_sclk_pad_3.hw,
>>>> +    [AUD_CLKID_TDM_SCLK_PAD4]       = &s4_tdm_sclk_pad_4.hw,
>>>> +    [AUD_CLKID_TDM_LRCLK_PAD3]      = &s4_tdm_lrclk_pad_3.hw,
>>>> +    [AUD_CLKID_TDM_LRCLK_PAD4]      = &s4_tdm_lrclk_pad_4.hw,
>>>> +};
>>>>
>>>>   /* Convenience table to populate regmap in .probe(). */
>>>>   static struct clk_regmap *const axg_clk_regmaps[] = {
>>>> @@ -1678,6 +1902,174 @@ static struct clk_regmap *const 
>>>> sm1_clk_regmaps[] = {
>>>>       &sm1_earcrx_dmac_clk,
>>>>   };
>>>>
>>>> +static struct clk_regmap *const s4_clk_regmaps[] = {
>>>> +    &ddr_arb,
>>>> +    &pdm,
>>>> +    &tdmin_a,
>>>> +    &tdmin_b,
>>>> +    &tdmin_c,
>>>> +    &tdmin_lb,
>>>> +    &tdmout_a,
>>>> +    &tdmout_b,
>>>> +    &tdmout_c,
>>>> +    &frddr_a,
>>>> +    &frddr_b,
>>>> +    &frddr_c,
>>>> +    &toddr_a,
>>>> +    &toddr_b,
>>>> +    &toddr_c,
>>>> +    &loopback,
>>>> +    &spdifin,
>>>> +    &spdifout,
>>>> +    &resample,
>>>> +    &spdifout_b,
>>>> +    &sm1_mst_a_mclk_sel,
>>>> +    &sm1_mst_b_mclk_sel,
>>>> +    &sm1_mst_c_mclk_sel,
>>>> +    &sm1_mst_d_mclk_sel,
>>>> +    &sm1_mst_e_mclk_sel,
>>>> +    &sm1_mst_f_mclk_sel,
>>>> +    &sm1_mst_a_mclk_div,
>>>> +    &sm1_mst_b_mclk_div,
>>>> +    &sm1_mst_c_mclk_div,
>>>> +    &sm1_mst_d_mclk_div,
>>>> +    &sm1_mst_e_mclk_div,
>>>> +    &sm1_mst_f_mclk_div,
>>>> +    &sm1_mst_a_mclk,
>>>> +    &sm1_mst_b_mclk,
>>>> +    &sm1_mst_c_mclk,
>>>> +    &sm1_mst_d_mclk,
>>>> +    &sm1_mst_e_mclk,
>>>> +    &sm1_mst_f_mclk,
>>>> +    &spdifout_clk_sel,
>>>> +    &spdifout_clk_div,
>>>> +    &spdifout_clk,
>>>> +    &spdifin_clk_sel,
>>>> +    &spdifin_clk_div,
>>>> +    &spdifin_clk,
>>>> +    &pdm_dclk_sel,
>>>> +    &pdm_dclk_div,
>>>> +    &pdm_dclk,
>>>> +    &pdm_sysclk_sel,
>>>> +    &pdm_sysclk_div,
>>>> +    &pdm_sysclk,
>>>> +    &mst_a_sclk_pre_en,
>>>> +    &mst_b_sclk_pre_en,
>>>> +    &mst_c_sclk_pre_en,
>>>> +    &mst_d_sclk_pre_en,
>>>> +    &mst_e_sclk_pre_en,
>>>> +    &mst_f_sclk_pre_en,
>>>> +    &mst_a_sclk_div,
>>>> +    &mst_b_sclk_div,
>>>> +    &mst_c_sclk_div,
>>>> +    &mst_d_sclk_div,
>>>> +    &mst_e_sclk_div,
>>>> +    &mst_f_sclk_div,
>>>> +    &mst_a_sclk_post_en,
>>>> +    &mst_b_sclk_post_en,
>>>> +    &mst_c_sclk_post_en,
>>>> +    &mst_d_sclk_post_en,
>>>> +    &mst_e_sclk_post_en,
>>>> +    &mst_f_sclk_post_en,
>>>> +    &mst_a_sclk,
>>>> +    &mst_b_sclk,
>>>> +    &mst_c_sclk,
>>>> +    &mst_d_sclk,
>>>> +    &mst_e_sclk,
>>>> +    &mst_f_sclk,
>>>> +    &mst_a_lrclk_div,
>>>> +    &mst_b_lrclk_div,
>>>> +    &mst_c_lrclk_div,
>>>> +    &mst_d_lrclk_div,
>>>> +    &mst_e_lrclk_div,
>>>> +    &mst_f_lrclk_div,
>>>> +    &mst_a_lrclk,
>>>> +    &mst_b_lrclk,
>>>> +    &mst_c_lrclk,
>>>> +    &mst_d_lrclk,
>>>> +    &mst_e_lrclk,
>>>> +    &mst_f_lrclk,
>>>> +    &tdmin_a_sclk_sel,
>>>> +    &tdmin_b_sclk_sel,
>>>> +    &tdmin_c_sclk_sel,
>>>> +    &tdmin_lb_sclk_sel,
>>>> +    &tdmout_a_sclk_sel,
>>>> +    &tdmout_b_sclk_sel,
>>>> +    &tdmout_c_sclk_sel,
>>>> +    &tdmin_a_sclk_pre_en,
>>>> +    &tdmin_b_sclk_pre_en,
>>>> +    &tdmin_c_sclk_pre_en,
>>>> +    &tdmin_lb_sclk_pre_en,
>>>> +    &tdmout_a_sclk_pre_en,
>>>> +    &tdmout_b_sclk_pre_en,
>>>> +    &tdmout_c_sclk_pre_en,
>>>> +    &tdmin_a_sclk_post_en,
>>>> +    &tdmin_b_sclk_post_en,
>>>> +    &tdmin_c_sclk_post_en,
>>>> +    &tdmin_lb_sclk_post_en,
>>>> +    &tdmout_a_sclk_post_en,
>>>> +    &tdmout_b_sclk_post_en,
>>>> +    &tdmout_c_sclk_post_en,
>>>> +    &tdmin_a_sclk,
>>>> +    &tdmin_b_sclk,
>>>> +    &tdmin_c_sclk,
>>>> +    &tdmin_lb_sclk,
>>>> +    &g12a_tdmout_a_sclk,
>>>> +    &g12a_tdmout_b_sclk,
>>>> +    &g12a_tdmout_c_sclk,
>>>> +    &tdmin_a_lrclk,
>>>> +    &tdmin_b_lrclk,
>>>> +    &tdmin_c_lrclk,
>>>> +    &tdmin_lb_lrclk,
>>>> +    &tdmout_a_lrclk,
>>>> +    &tdmout_b_lrclk,
>>>> +    &tdmout_c_lrclk,
>>>> +    &spdifout_b_clk_sel,
>>>> +    &spdifout_b_clk_div,
>>>> +    &spdifout_b_clk,
>>>> +    &s4_tdm_mclk_pad_0,
>>>> +    &s4_tdm_mclk_pad_1,
>>>> +    &s4_tdm_lrclk_pad_0,
>>>> +    &s4_tdm_lrclk_pad_1,
>>>> +    &s4_tdm_lrclk_pad_2,
>>>> +    &s4_tdm_sclk_pad_0,
>>>> +    &s4_tdm_sclk_pad_1,
>>>> +    &s4_tdm_sclk_pad_2,
>>>> +    &sm1_aud_top,
>>>> +    &toram,
>>>> +    &eqdrc,
>>>> +    &resample_b,
>>>> +    &tovad,
>>>> +    &locker,
>>>> +    &spdifin_lb,
>>>> +    &frddr_d,
>>>> +    &toddr_d,
>>>> +    &loopback_b,
>>>> +    &sm1_clk81_en,
>>>> +    &sm1_sysclk_a_div,
>>>> +    &sm1_sysclk_a_en,
>>>> +    &sm1_sysclk_b_div,
>>>> +    &sm1_sysclk_b_en,
>>>> +    &earcrx,
>>>> +    &sm1_earcrx_cmdc_clk_sel,
>>>> +    &sm1_earcrx_cmdc_clk_div,
>>>> +    &sm1_earcrx_cmdc_clk,
>>>> +    &sm1_earcrx_dmac_clk_sel,
>>>> +    &sm1_earcrx_dmac_clk_div,
>>>> +    &sm1_earcrx_dmac_clk,
>>>> +    &s4_tdm_mclk_pad0_sel,
>>>> +    &s4_tdm_mclk_pad1_sel,
>>>> +    &s4_tdm_mclk_pad0_div,
>>>> +    &s4_tdm_mclk_pad1_div,
>>>> +    &s4_tdm_mclk_pad_2,
>>>> +    &s4_tdm_mclk_pad2_sel,
>>>> +    &s4_tdm_mclk_pad2_div,
>>>> +    &s4_tdm_sclk_pad_3,
>>>> +    &s4_tdm_sclk_pad_4,
>>>> +    &s4_tdm_lrclk_pad_3,
>>>> +    &s4_tdm_lrclk_pad_4,
>>>> +};
>>>> +
>>>>   struct axg_audio_reset_data {
>>>>       struct reset_controller_dev rstc;
>>>>       struct regmap *map;
>>>> @@ -1822,7 +2214,6 @@ static int axg_audio_clkc_probe(struct 
>>>> platform_device *pdev)
>>>>                       continue;
>>>>
>>>>               name = hw->init->name;
>>>> -
>>>>               ret = devm_clk_hw_register(dev, hw);
>>>>               if (ret) {
>>>>                       dev_err(dev, "failed to register clock %s\n", 
>>>> name);
>>>> @@ -1886,6 +2277,18 @@ static const struct audioclk_data 
>>>> sm1_audioclk_data = {
>>>>       .max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
>>>>   };
>>>>
>>>> +static const struct audioclk_data s4_audioclk_data = {
>>>> +    .regmap_clks = s4_clk_regmaps,
>>>> +    .regmap_clk_num = ARRAY_SIZE(s4_clk_regmaps),
>>>> +    .hw_clks = {
>>>> +            .hws = s4_audio_hw_clks,
>>>> +            .num = ARRAY_SIZE(s4_audio_hw_clks),
>>>> +    },
>>>> +    .reset_offset = AUDIO_SM1_SW_RESET0,
>>>> +    .reset_num = 39,
>>>> +    .max_register = AUDIO_S4_SCLK_PAD_CTRL1,
>>>> +};
>>>> +
>>>>   static const struct of_device_id clkc_match_table[] = {
>>>>       {
>>>>               .compatible = "amlogic,axg-audio-clkc",
>>>> @@ -1896,7 +2299,10 @@ static const struct of_device_id 
>>>> clkc_match_table[] = {
>>>>       }, {
>>>>               .compatible = "amlogic,sm1-audio-clkc",
>>>>               .data = &sm1_audioclk_data
>>>> -    }, {}
>>>> +    }, {
>>>> +            .compatible = "amlogic,s4-audio-clkc",
>>>> +            .data = &s4_audioclk_data
>>>> +    }, { }
>>>>   };
>>>>   MODULE_DEVICE_TABLE(of, clkc_match_table);
>>>>
>>>> diff --git a/drivers/clk/meson/axg-audio.h 
>>>> b/drivers/clk/meson/axg-audio.h
>>>> index 
>>>> 9e7765b630c96a8029140539ffda789b7db5277a..2dd1c41d775da8f91ed281470d06e9c970cfc92c 
>>>> 100644
>>>> --- a/drivers/clk/meson/axg-audio.h
>>>> +++ b/drivers/clk/meson/axg-audio.h
>>>> @@ -66,5 +66,9 @@
>>>>   #define AUDIO_CLK81_EN              0x034
>>>>   #define AUDIO_EARCRX_CMDC_CLK_CTRL  0x0D0
>>>>   #define AUDIO_EARCRX_DMAC_CLK_CTRL  0x0D4
>>>> +#define AUDIO_S4_MCLK_PAD_CTRL0 0xE80
>>>> +#define AUDIO_S4_MCLK_PAD_CTRL1 0xE84
>>>> +#define AUDIO_S4_SCLK_PAD_CTRL0 0xE88
>>>> +#define AUDIO_S4_SCLK_PAD_CTRL1 0xE8C
>>>>
>>>>   #endif /*__AXG_AUDIO_CLKC_H */
>> -- 
>> Jerome

