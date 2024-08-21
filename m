Return-Path: <linux-kernel+bounces-294753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32E959214
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA11F24316
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFD1E504;
	Wed, 21 Aug 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BSTjy3+W"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E081E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202928; cv=fail; b=bk1lQFm2z4ceQqpQbJmYDArQPutt1uXPzU+cO+8738aUEUmOYUdlMqlgStiowDFtimYJtBz8H7MWVoL+WiHGPN4SN59Avll/IdIi3f57DBBrO6Y/Bxab/7gm7VX8QnYIEsBrHpED+CUrHb/64ZAHRUFuUqeJjZvnj/gi+oPixDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202928; c=relaxed/simple;
	bh=Azy7/7ftbr3uxGA2+M94Nt5rdy1V9UYK97v5lazeZnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HiVSNFqZKt9xdEwv+KUsA9uwbHS2GofU8P4WAJLp9SSyQ1M/L0S1YellU+jSdOBduA8ubxtKPUA0ToUQSyvU7KBmBaUnIkKF2yKK6ycACcw9zBTRDOqPLUec+iofbo3ZtOQGDRTiJhbLL1cudQjxzdObfg9E39EvjDhshajlJVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BSTjy3+W; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTBkdNPF077XWHpKi6oFelFlKA35d61YlhEcRkT0rSkszFcqWKbQFN6UY5Bi/KmIcc4WQOq2VlvZ4VoNuoSt905YI0tP6XajxigfzXhi1JlzEUXKLkuHl8IkLq2kGvyt7R46QiZPTWmHTtlgKjxEXntn0nJXTK+OG42OqtbredxHdfNnACaDBwYOn4jC91pEsrrQsY0Q8KieogFXn6cAZwNWV/st7AIf5YfWH+C5TAXEtj1HAaoNpNCOq76tPnsqCXmFXbJLO5G+SXvj1REBaiM8hdrUbLTUAlegq4FZsepTDzhh54Vb0sFxHHrVqG0udWhWb2ID+bKU7kOaW6gQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+wtAMgLzOBFC9FkzeFrV4FO3VOGF8Fd+uezp8RUg5A=;
 b=TNdJBu7Oue5/IBhx0MG5QovEGMA+Rekj0oZ+7QCazqE2yfJS8D7XWbF7s6SukKD8mWPeMyrUpKmOHp02cfcE2qZRdNdDI+5W70SyUfhWwAKGWzW7uPOMqyjfIBOp1Dc49Gt6E0LqcFAwU6i0Hn0WJ5kz+cKM76nPHyOHaenyUxk3DfD6VPMLV6OFFxmIrwgLg5fIFuTU0xJefXCo31XZVgK7p/U7+w6/1R3KTjvGh8hPaMEliJxyP53vVBG4lR8RxJg+j3pNUwMdSMs1Yl6+MEWUpJil2e8RfCZOar9Ki5D8w7CjbgFPd2UBZQgBqX9utbva+J7IUHYYfzlBRYoDJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+wtAMgLzOBFC9FkzeFrV4FO3VOGF8Fd+uezp8RUg5A=;
 b=BSTjy3+WJ+BliuiTm/c6kbRqgXCV/x8A3piiowxlKMOTiKNS6+3jh1y9ahioOy1DKkObG8xXHPFd4Eu1kaAI5C/oQe3C1K+OuON7CrM+2fWFuxYbFa2jujneY7ihqOIueQiZPSjrilnZqtf4MlVCXUcStHqQdCa5M4tl4wo0sR+YkJcpYSZEH+GfpIFs/KLrpJOr2z72/U5FukO8hxNuJ3YhCRKoJ20ww9rTw8Dh7Hbe3YMna0xJzW/jmPBSX86O+wGJmQJqmXeRNg7DFXfq7x5zjKBjIMaDfuQGislhA6B/4Ab5Kka6FDwLuQmDt1taGGsHE6MSC7E8YCjI/z3bYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB7170.apcprd06.prod.outlook.com (2603:1096:405:b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 01:15:21 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 01:15:21 +0000
Message-ID: <dfe8d6e9-97f8-46e9-bbd5-ebe9d11ca625@vivo.com>
Date: Wed, 21 Aug 2024 09:15:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: jz4780-efuse: Use devm_clk_get_enabled() helpers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240820102333.133503-1-link@vivo.com>
 <7b31732e-00ca-4792-a16b-156689862c5b@wanadoo.fr>
From: Huan Yang <link@vivo.com>
In-Reply-To: <7b31732e-00ca-4792-a16b-156689862c5b@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb3333f-1db5-49d2-31dd-08dcc17eb9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkl3Kzh6NTdNK0Q4aWtGRW00WFpidE1NejRJQTRiUjV2OGNVYysvMFl2alRO?=
 =?utf-8?B?UUYwblQvbGZrZ0ZraGVrVVM4cVJiRDh6WlE1eDlGWnduM2N2UzhvblNEVmdU?=
 =?utf-8?B?VXpsSG9pcmJwV2tSM09JeDIxM0hUcjFRWVIraEwycXVIaWhDcVBtUGdEa3BW?=
 =?utf-8?B?TWdJTGgvVHFWZnRwcWxCUXVaTitKcTVHTmdzRUlWUzZoZmkyWHpDd3VyQTlP?=
 =?utf-8?B?a0NiL2E4MDNBMlY1bXNiZFJ0c1ZjMzAyWFVkNDUyNTF0dWdrdE1DVGdMU2dz?=
 =?utf-8?B?OVQ1cm8zTEJESnRJS3l6NlJDdmJ3bVhtY213MXlRNkFVZzRsL0ZOdW40YlAv?=
 =?utf-8?B?RTQ3Wk1yNUE4czd3SWwwRDJ0cHlMK2NocWhvSVc2Y2lPd2ZWTm9RaU5ZQlk5?=
 =?utf-8?B?eDNNeVlzOWF5RXZFTFJlSXZuSVpreUh6Y0VncTE4WmhHMHlRYkU5ZFdVd1B5?=
 =?utf-8?B?TjhQWmdmTnIzYVduUy83TStJaW1rRW5iVFNvQnVZL2ZMT1l1TW42Zk9QQWJp?=
 =?utf-8?B?ZGpWYXdlV0RwakdRM2xRVjZPNDU5RDFVdnhqa20rOUNtRmlFckZDVVNhc3Fv?=
 =?utf-8?B?QTgyYmNub0VuMjJHK05XTnpmZ2o3Ym5laGRJOVdJK2VjUXJYSUJXUm9PMkpX?=
 =?utf-8?B?dngyOXd3bFl2N2p4cGlFYjhCeEFUTFBmYmpyTTB0UFRyeVQrMDV1V3lXMzlZ?=
 =?utf-8?B?WmY5RzNvZnBrTkpOT1o0bG5QeCtHS25hWGlVM0VSeWpyREZqM292cHk5NjZ2?=
 =?utf-8?B?QjdEU3QwUmk1OVNVUzJJVFZRdkptbVhZaExsOXRFWjRlcmcwbXV1N01yVnZY?=
 =?utf-8?B?V25NS3FPYTZ5RnhWTkVUZ0pVN2kyczkzeHI3ZkpHNEhaWG5TUEYzNiszazNU?=
 =?utf-8?B?TFNZN2YzbUtNTUptTGNDS2VnQlpLTUluYUZyTmhWcVR0Z2x6UnhlMGhiQ1dM?=
 =?utf-8?B?d3RiUkZJTkdneGlPb2lEVFQ5T2xTQm1SckFIeEtGZFZXNERDdktDaEtSekhp?=
 =?utf-8?B?ZEhOMnQ5eHg4clBjQ1VsME1nSjB3VDJKeEZmb1ZpdzBackNIYVB1eWRJbzhJ?=
 =?utf-8?B?clNYYkNaeGVmM1NqdUVlb1lVdHhRemZ5TzdlMnNuVFFXaVIzRUp4VGkxbCtP?=
 =?utf-8?B?NGFSZmVCWGNGZEhELzUydW5HcEJzUzhrUHJrZHA3ZWJpQXVabnlSY3UxWksr?=
 =?utf-8?B?aWdjKzYzdTlmSFV1YlNBSHFjVzMvV2FIQlBEb1BtTzZMME1UWGV4Q0lmb2ds?=
 =?utf-8?B?YmxmVXJYb1IyZzRZeXh4S2d0elF4MU9nVTc2VXUyWlh6WGVyR3NiQmJ4eTQ0?=
 =?utf-8?B?YVV2U09yTDEzeDRzUG9rMy9rR1dRUUFsU1g2cnNKNnJ2a0tob2c1SzhMcXJt?=
 =?utf-8?B?bWNYSHlwUWlrYjRtaTVjaDlDWldURXhibW5NNVRJRUlhM1dNK2JRWEgrR2hs?=
 =?utf-8?B?NWt4S3llMXRNa2JVU3VLOGFvRWNMeGtTSEpiTGRTeEEvNHVFSlQ1WXlJOUFq?=
 =?utf-8?B?RmVtUTdPKzdwY1AyRU9jZXlzMndDb3dDTzNHQmN5OU9oZWxEcWJSTzVLbDFF?=
 =?utf-8?B?QnhlU1JJcHA0NUJQZUVCZFpXY3VRQTZPaGhBOUVZYmo4K1JIYVRweFBnNWk0?=
 =?utf-8?B?SG51VHNCL3ZxWTNrVDI4M2ViNHpWUE0yMGZTZnM2VnBzS1dnQ01rbHB2dCtE?=
 =?utf-8?B?WE93d1Z4aHlvZVJIc1dZUGdTbzhmREgrcVhmcTFoZU4ybERwRlZzcjU5R2c3?=
 =?utf-8?B?RldPeTNpUWRXb09PZWN4YjBzMUNORXN2YnR5YXlaamVsTnJoSFkzeHhCb3Vx?=
 =?utf-8?B?aWJMNFNYMlI5enVGRjRPT00veDV6TC9IdytuOGVkak5WcEEyQnhDL1Z6S0Na?=
 =?utf-8?B?NHFsUFpQamRUc3lHbEdTWjkxR3A0RDFjS2RPdUo3akNTNVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3VhUDZQRm1EVmRPM0YvcnRIajgxbjcvaWxwZGZPblpHSkE2VGZWQ0RtcHhG?=
 =?utf-8?B?bmMrS1JRUHp2T2NWS2ZRamxORTNoL1l4RG83OHVSd1UzN0dwQVkyREh1eUFR?=
 =?utf-8?B?cnAvc2Joa09MSTNzUWpESHpzMnhOWnBZNFZMZkRRQXpqMlE4QjY3UXNMbWEr?=
 =?utf-8?B?UCtheTQxY2hYTEJoRHp6RW5BbXpXYkd2eWRyNU1iZ0podWY2SEgydXlSR3o0?=
 =?utf-8?B?TTZwUWFKQVRZT1lGY1pmUjV1QW1KUFY1UzJwL0xlVXQ0R2JkM0xXaEtMYWNF?=
 =?utf-8?B?YmJjam5XU04rNXdPNkxuV0tMYnhwN254TVJJSlhOYTNoVGd4ZEV2eHBzcVF1?=
 =?utf-8?B?UXVIbElLRXdWNVp5UFNrVWxBMk0vS0xLL2ZNQzlZNktrelg3cXpBYld4MXdG?=
 =?utf-8?B?K0Z3Y2VJZy9wOGIrVzB3YnJoTjhBcjJtS1hadTN2ZWlWakxkTVRNS0RWOE1t?=
 =?utf-8?B?VFVZbFNLaitJVmErMmpoSmVoenNpUXdkY2tSN1BBOGg2OEUrQjBacGlqVi8r?=
 =?utf-8?B?cHlNWjRzMkhTdGFVai9KUlZOaTBXMUVrVTlDK1RjOWZJU05mZHFUVE1KM0hs?=
 =?utf-8?B?TExHQXVveFg4MzQzK2k1cXFOMlBFMzZVckI4Mm9DWVpLNHRISytwMEY3bjRY?=
 =?utf-8?B?R3Q5Zk9nYW4wYVlkWnlzZkJRTzc1c1ZDVjEzcHhtZVFkSE9VakdVZmRGbXdv?=
 =?utf-8?B?eGNDdzRhZDdTa01vdkJoaFRWVktLTjhiaWpQUUJTVkFrdDFvSHg1U0lldmdv?=
 =?utf-8?B?RzM3UHhOWWFqbzc5RzJ6TFAzQkR5T2RIK0JMME51NEdwSUxlYTRmWU9XaGFX?=
 =?utf-8?B?aGM2c2g1QUlaNkk4ZC82NHlEZUtxVW1qYnBZZCtjWGlJbnlFS3dPa0xDd21E?=
 =?utf-8?B?OW9wQkdqcHpucnBCa3NsSFpsYkdRaWtDSWFORXFhbGl5Q3dCaWc1MWplU28w?=
 =?utf-8?B?T0h0MjJid1lIOXhtamxlNkVnN0NoUGVibWxMdkM3OFJwYUVRTjNRZWZOazV6?=
 =?utf-8?B?RVdHNHpCZGNwTEpjVFdkTzliMnVSbDVxZ2xBRmxoeUdvd1VXbnBOZmRSMTBH?=
 =?utf-8?B?RjNFQk1zVUVLZWVoVHBPZlZ1QUlKRzhoa3Zzakt5bWg3dEl6dnIwZE5POU9u?=
 =?utf-8?B?UStlaHFTcGVhYzJObkI3V1dYdjVMc0lmdUIxWngwY3FVOEVla3QwMSsyM2Nx?=
 =?utf-8?B?Z1NXQUJxejZOTDlaQTZXNDR0cnFzYVpPT1plQitUVVR0OWtRaVlQMis2RDZS?=
 =?utf-8?B?WWNVOWsrN3ZPVHVCZFFMRkFXQjN4S1R2VmdRVGN6alNCdU5RL0JCMVNGMWdm?=
 =?utf-8?B?emE5NGgrTmZ6VmZWWWphb2xPTk0xUnBZaTRSMExzbUgvdG82L2tEUHlDbVBs?=
 =?utf-8?B?aWQ1OHBQcTlSS1hOSExkcGhtY0dNRXJCYjkwOUFBM1I5OFNVUXFaaDZuaEZS?=
 =?utf-8?B?SG9GWnpjdUpDMG5EWTBpV2NITTk4OW9jeXF2N051Sm9vMnB6WDlMTHJMOEQ0?=
 =?utf-8?B?MU5oVE5hOFI5NFM5SGdNeVVTUWtrMDZDYlRDNDg0cktDdXliOGVaVW4yaklT?=
 =?utf-8?B?cE5adVRWandpSFFVRU1lbFRzS3pjWFFtZlZwNlgrNnZWMGhVUHdRUmE5cGVI?=
 =?utf-8?B?N2dXR0NNNmZhTFJnK2Z1SC8zV1greVJaV04zOHo1NE9uRjhoZmJBTDFYZWFs?=
 =?utf-8?B?WU9MQWM3U0tWQ2oxcTdzM0RsSXNBMDNydTNUVmF3ZC80QnUvNGhKOXd4M1BJ?=
 =?utf-8?B?VnZTN0xyeGR2ckI1QitlcUhYeGcyYjJDNXIycmlTSGZ3UzVxWHVmdk1SZ0J0?=
 =?utf-8?B?Q1BUcllLY0hwWDJZUTkvTjJ4YTNzQTlWRjN2VXVkaG54L3ZJZlN0S1hGRkNF?=
 =?utf-8?B?WUlkT1NLSjg1SlREQ2lwbmRjV2tpeEtpVTJacHBZTHFwZVA5SVM2SXoxTTlH?=
 =?utf-8?B?WUV6aFVlUCtuSWZhU1pMSy8wcVFVS1VzSkdsSVBkNnFIUW9yb0k5Vlh3Y2d1?=
 =?utf-8?B?Q2l0YU5IM0tQNFc5bkZXUGljNWt4RlJRN0xaMzU3dGNkTEErb1BRdTlrd3hs?=
 =?utf-8?B?TDRqVkN3cU5reUUvUnJnVjI1REQyZjM1QnprRllVTHVKZ1dPbWhZczZSU2l5?=
 =?utf-8?Q?Nzkx409GCDS1XlUuuPnc87tYX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb3333f-1db5-49d2-31dd-08dcc17eb9ca
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 01:15:20.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PSYCFXqp7YcmiEbV9ehQlkqBIj2RMzVt5yMupy/KSYUtqhEeD9e4I6OgTKjHKS3qh8dthyZql3LmbZekcvTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7170


在 2024/8/20 21:21, Christophe JAILLET 写道:
> Le 20/08/2024 à 12:23, Huan Yang a écrit :
>> The devm_clk_get_enabled() helpers:
>>      - call devm_clk_get()
>>      - call clk_prepare_enable() and register what is needed in order to
>>       call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code and avoids the calls to 
>> clk_disable_unprepare().
>>
>> Signed-off-by: Huan Yang <link@vivo.com>
>> ---
>
> Hi,
>
> if you want to go 1 step further, I think that 'clk' can now also be 
> removed from struct jz4780_efuse.

Sensible, I'll update it

Thanks

>
> Just my 2c.
>
> CJ
>
>>   drivers/nvmem/jz4780-efuse.c | 18 +-----------------
>>   1 file changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
>> index 0b01b840edd9..2b5badfbf22f 100644
>> --- a/drivers/nvmem/jz4780-efuse.c
>> +++ b/drivers/nvmem/jz4780-efuse.c
>> @@ -131,11 +131,6 @@ static const struct regmap_config 
>> jz4780_efuse_regmap_config = {
>>       .max_register = JZ_EFUDATA(7),
>>   };
>>   -static void clk_disable_unprepare_helper(void *clock)
>> -{
>> -    clk_disable_unprepare(clock);
>> -}
>> -
>>   static int jz4780_efuse_probe(struct platform_device *pdev)
>>   {
>>       struct nvmem_device *nvmem;
>> @@ -146,7 +141,6 @@ static int jz4780_efuse_probe(struct 
>> platform_device *pdev)
>>       unsigned long rd_strobe;
>>       struct device *dev = &pdev->dev;
>>       void __iomem *regs;
>> -    int ret;
>>         efuse = devm_kzalloc(dev, sizeof(*efuse), GFP_KERNEL);
>>       if (!efuse)
>> @@ -161,20 +155,10 @@ static int jz4780_efuse_probe(struct 
>> platform_device *pdev)
>>       if (IS_ERR(efuse->map))
>>           return PTR_ERR(efuse->map);
>>   -    efuse->clk = devm_clk_get(&pdev->dev, NULL);
>> +    efuse->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>>       if (IS_ERR(efuse->clk))
>>           return PTR_ERR(efuse->clk);
>>   -    ret = clk_prepare_enable(efuse->clk);
>> -    if (ret < 0)
>> -        return ret;
>> -
>> -    ret = devm_add_action_or_reset(&pdev->dev,
>> -                       clk_disable_unprepare_helper,
>> -                       efuse->clk);
>> -    if (ret < 0)
>> -        return ret;
>> -
>>       clk_rate = clk_get_rate(efuse->clk);
>>         efuse->dev = dev;
>

