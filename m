Return-Path: <linux-kernel+bounces-566242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC7A6755B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F83AC47B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B166F20D4EE;
	Tue, 18 Mar 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Err8CBXl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAC20D510
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305230; cv=fail; b=PcDz6WGmQzD6TflfbzzeKKQ/IIgSw/mRSXSJimr0BPQ0S1BykWupNrgbMZ/PmBsRoqtHrxQU96tO0O2/Y418KdktnI+Rcgc5GFftsV0fJJyz2kvREtMlErvRunIDsjsmcFCtfZTU8OKhJGoU6ziglDlVmoKvHSr7NoPE+fa1F2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305230; c=relaxed/simple;
	bh=3Ekeb79ufQHyPvLMav9XSEYOosODP8eA2loaTlw7HVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxZNEiHPdPNV9rOBouVd+ZN5PV0VUzgbIbjd28UPY9qeHNTf2pPHMeqV/n/oc3k7nAWUwaYI+NFUF8CgfLtAdFf9P//xiavzxWxkrAijtklohis3Zf4XselLQL/TOkaHJIHrfhOw4dRDa1dgEoFwGK1MtfQhhWBG3Mq5zyMcYfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Err8CBXl; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEK46n5+YejyIrBNAJvyyoA5ZXaR6O971/ulaYWXhGI61VkLZwJZUdxUzXfjQ8/5LZOsh0b7jH5IjMdo8I02g5KXBZoZHbLzoPG/YaXAkUhfsi9xAZGiFSV4SSEt+9NOz1TuW6U9HTOe4v9KJ+E9exrcT58e9OEPUAsHJJ0OmXzHWKclD02T0NWQqsP+/sCUqc7mjqIhrcyEsECOuNBd+qVjR5i44Byd46xEOTfevCpmBIVWEovN9lJ4NcJViPLk6xTC4uV/OZeeyVGpNJJBxRSFc5tpXFRxZn0UCu36jdqNh4DKpaX+8HsueL6alZyfFL20Qo0s5yYrNTU+GAh5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG2jfe/GVz6QXwuMny2pglGQCa1u0xnkFtw47yRKBIE=;
 b=O0FO0fZY7DvxqzrUdKZfNArmMlsLiLPwdYHtw850EHVryTB2rvkHe762390zYrupm7L7300e84x9DB9NJByCRlu0oYApRxikgiRsmvTRe+m03/96s8v1nFO5ds2YMSG+2q63+1JeFSgJtfCv/8bff2zjW8OojNUjyOqUKIMNap5O5bJxUQJeEDy1fL0h3P50vSFNCvaIDCF624+88CDwDvVGhX7WS9+w+li9q2/K3+xQ5CtfUCzsa93ysoJ8iqQD63SuVwlmrwkuzPCGSA+zabQ2wyO6xzGEjqg4ko1uOooyVgFoiWcTyeZZSX4fQ4jc4is6ruz6bZ3F3Wzl5OF6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG2jfe/GVz6QXwuMny2pglGQCa1u0xnkFtw47yRKBIE=;
 b=Err8CBXl5BHs05Mc5lI2MhXR3PZ5WsSwUU12c8BkOv2YTpBa9HmVJpjX2127KyM6ouHb3RtwiK5AVAo98H1MJg8DtjvSLR5tnci3MIpCUMjqWiT0ANvW1phq65qVUeQiupidZXRyEw1SKXWWZc4y0dnvC8Zi6Qs5aznqrt9Mg3PLeIcTZDAUscln/ef8+ohXnpK9IA+IxQHzfoLty5v83RhY+XKxtqOcHjqSLvN0rs80ueLC1GplNZhL4lRanCFo6j+F0I/kwrVT1n2Xd0vS16xPmImy98cwUDyXg/SA2iESWH/XfrefU0i8A/H4hwKLxg97T7u/933ezeSd26gH2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10906.eurprd04.prod.outlook.com (2603:10a6:800:277::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:40:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:40:24 +0000
Date: Tue, 18 Mar 2025 09:40:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: fix signed/unsigned mismatch in
 dynamic address assignment
Message-ID: <Z9l3waI5EdrWmYC3@lizhi-Precision-Tower-5810>
References: <20250317101516.19157-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317101516.19157-1-qasdev00@gmail.com>
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10906:EE_
X-MS-Office365-Filtering-Correlation-Id: f35a0f3e-74d1-4c70-f7c1-08dd66226f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T01rWFp3Q0xBSU5UYUw2NVJ5b3M3TWwvNTNQQWhBN3hGaFFlbDVpUXJwODZZ?=
 =?utf-8?B?blFKSTZ4czljRnBtVWJlaFB6V09kditBQWtjWnJQUWZwdGh1Z3VXVDBrdzcr?=
 =?utf-8?B?djNtd3pnUXpCalVqdnAwbUllcWxPRzlCYjlhamZFSEdzZFdWZEYzbDFzV0cr?=
 =?utf-8?B?NjZMYTRzME1oZkltazRCMCt1OTZHRHY1SXE2d2kralpHdXZ3azFuMGNvcS9Y?=
 =?utf-8?B?T0xUV1diaUppZmtnT1Y5WDRNUkZydWJoSGpRR3ExSXU1d2dZaHpCb0xIRXlp?=
 =?utf-8?B?R1NxQWgrZVFOeVVkMHdvSGtBdnpNUlNQSVRrL1lmSjh3Z2FDaTRlMUhSU1Iy?=
 =?utf-8?B?R1VUQkxBS3NRMWRKUXJON0tva0V0N3VUUERJK0dhUUNNL3AySkhaMnBiWlNK?=
 =?utf-8?B?SEtWOHorMy9SZHVoalJDZzBZcUhpdnhBcDRaRmdzRVIrRUs4RGxtSDhhY1Q5?=
 =?utf-8?B?ZnRLaHAvT3JsM0hVaUgvR0lhOExNUzM0VEF2cFVYZE5WcjdpcGRib2YyNy95?=
 =?utf-8?B?YU1JSGpDOFhtNDFMYVppUmhOVm5EVjFWMUNMT212V2hMYkJpRXVNOElrRnZM?=
 =?utf-8?B?aHA5Q2F2Nkp3cFZFbEdaNEFhZUREaE40WmNsQnIxSGEybjhQMEg1dVV5aTNt?=
 =?utf-8?B?bmRwT3BOVnNLU1BBWWI4dTZPUWhJVjlLR01nV1pwdWdFejNBa1ZCaWNFRDl6?=
 =?utf-8?B?b0p6c0ZKajVLVGZMdlAyMjJ4bVZ3UFNrU0ppWUpaa3BEb252aURJSHh6RU0x?=
 =?utf-8?B?NEJ2c3VmcitSWWhMc3NSWTU3UGVOQnNseFcrcHh3bzZYNDU1VTFrd3AwTjdy?=
 =?utf-8?B?d1NZUStFcjE4eHNMeUpDcnVVeGNNK2ZOUTFjVThLaVovQm05dmN0SmFxY0l4?=
 =?utf-8?B?SUJ2RUhORE5ObTlpS3FLYmxQakxRRCtqMGhWRjgwb1VVVUJaYmxqa3UrY0k1?=
 =?utf-8?B?VG0vckxjblZ4NVkvVmU5d1QrcXo5WjBOS1RpSDdQN21zVUtNTUJXWUxKditU?=
 =?utf-8?B?cmZsckV6Rm9UZmMvc0ZmcGFZWkNjWVRkalcrSWdyUEdnYnpVdXZkcFZzblVD?=
 =?utf-8?B?ZGNxSnlzN1M3RzAzZkFNSk11NHRvK0ROVWliMU4wbGp4cGFGbC9LNVM0NU9E?=
 =?utf-8?B?NlROMWpZYzlyN2o2U0p1ZVkyK21tb25SeElXcEpmVVJsQmRjcFlTVHB4dzQx?=
 =?utf-8?B?MmFaMzVYOUtSZGl3dEpyanM1UWt4ZGRPOTcyeWNnM216d09ma1h6YWZPODlK?=
 =?utf-8?B?eGl1b2VrZEcvWmFCZitDWURGN2hiY2xTM2thQ2YwTFFzUllLR0srNitvaVdk?=
 =?utf-8?B?RWZBd0g1aVRTVTc4YU9vN1pvdmdzV0JMcW9mRGlORzJQZ09lQ3hhZ1NIenRS?=
 =?utf-8?B?NmhiYmVvTS9RTGF3VFNnMnVBVmhXRHhkYVk0NnRqZjZDU2JTcTYvNHExbFUr?=
 =?utf-8?B?cmQ1cURJbnJuZlNJODRKMG44VEVDcDlvNjN1OXZWOHVTaDJ0YnBrRzd2NDBE?=
 =?utf-8?B?UEZxSGZTaFUzbVBId1F0b1A2aXpRbzZKcmd3UDZOaHh1Rjl5OCtLUXV0VW9u?=
 =?utf-8?B?eGZJeGI0dHJKSTF6NjY0NEVLNUVpVWFMWGNSU2pwYUpuazRqSDNaTHVFVUJ5?=
 =?utf-8?B?cVZUSU5JU212NkZ2K1EveFR4eTVtb1pmd0phdkZ1bXU5aDFqdzZ0NTJETDU2?=
 =?utf-8?B?djJ1M0pycWpDSFhBOE9DWnJQejlaZlF5UkJJOE9uaUdYdGFRQVJhQTEyeTlR?=
 =?utf-8?B?M1Fyb3NGTVg3RllpRmdKaHUxdHRJMkFBNVA3eEJacWhuUkZSNFR1Qngvd1Fa?=
 =?utf-8?B?b3A0QUZYVkw3WFlGMTg4eU51T1ljTEI5Rnd3aHA1K0x1L2R1WUdKd3lSenlD?=
 =?utf-8?B?S2RNandobDY1SEFiODhELzFUN0ZYeUphNDBjM3FDWklSYWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEx1YzEwcVlhME1jdFdrQ1hzNWhpMytkWmxIU0RwZEY3Y2lMT01zRUo0REth?=
 =?utf-8?B?a3Z2MWhOZFZGamZaQzZGOU1Fd1p2UW9MVVVqQThSWldTUEVaZE5RekFFSWUx?=
 =?utf-8?B?aWl4QmYwS09LTEVrbUxqY0VhazdQVVVqaXhVczR0T1grQURQSkdzVVo4Tkg4?=
 =?utf-8?B?UlFqUFBabmtuajNqdU1Ockc0N2RaK0NzOFowN245aGJwRC80Z20wbTc2ZjZG?=
 =?utf-8?B?cndxcDR2Ujg1Y3VvaGF4VG4yM21ZejBRc1FiNU1hd1l4NjFOY3hDTGNjU3px?=
 =?utf-8?B?Nno3ZVVNYm5kMzNWaVJVdlljNit0SHNiRDF0b2YzZDRDOXJuTGFxV3JJdEhP?=
 =?utf-8?B?d2JDWU0yeHhSYVd4QWo3dlVCa1RFc1FjdTJPOGdGN3pubnlhZUNwaEJyVmNi?=
 =?utf-8?B?QTFSY0x4bTJDYUd1aFF3SWhXaW1aeW16L0FYUWVXblpiS3NoS0x4UGI2cE9D?=
 =?utf-8?B?STlPZUZzZWdYclVrNkRGU2Q1eGU3VTB0aVhCaWY0UVZucDNlWFJBblh0Y2ZM?=
 =?utf-8?B?MzFTdWN1Y2NKRTNqVEZhc0VUdit2MExsMkVRRWdPd3ZUNEM3NjhsRmR3OU15?=
 =?utf-8?B?Z2xLRVVQazcydGtFaXIyOUpOUVlVZWo0SmN0cjlTRi95RlN2d2ZDSFFKaWdm?=
 =?utf-8?B?ODQzazFDZkdnQmx5UzNBNEEwQnFvRTRiUnNIMGJUWFRCWlZ6RWxIRFV4V3ha?=
 =?utf-8?B?akRoQXlzQ1dCQUdzOFlIc0tCVHM1K1VoUXBuZUNoTGpqRzhWM0JZTVlCdURx?=
 =?utf-8?B?dWpiMUgzRHFBQmZqL3JLbUJQblZnWUNPemk1YWRCeHdyMWF0b3JPM1dXMzN5?=
 =?utf-8?B?bDloRk5TUFVBSmg5M2t1L3RxSGFFZXhmallYRGFpT01UMisxLzd0NjBoVlQ2?=
 =?utf-8?B?cFNGVXJ1S3ZyeGFoeTdJbzZKTEN1Z2E2TkljUk5ZRDdrWFM0T0w0LzBiOVhq?=
 =?utf-8?B?VmdaWEJTemk5a1l5azNHc2pPZHpWSTVrSWZ0czNCdU9OdnJCNWVQOWFaNklL?=
 =?utf-8?B?RFkyRUdESXUxR1FjdUJPOHpnRWJ4bEVrMVZQREV0WjFqbzNCanptTnBJUzFi?=
 =?utf-8?B?R3dDdFEvNkdlMTJGb2NNV1p2d282dEFnVlJJZUdxQldIRC9KODlReXRDZlRs?=
 =?utf-8?B?OEIvOUVPNXRydmZaTm5ZdE5XMG9ENTdMdnpqcVhSTHVHRHdMQUZjUHVKa25S?=
 =?utf-8?B?WVlvTGFVMTlyK08wbnlqL3laUkJLVDh3bTB1U0NMVlJHSGZ3NkZFWWRPc3Nx?=
 =?utf-8?B?NXlrelRDdVRmRmhKVm16T25ONkdvNWN3b01ZVll0b29IYXVrdFo4dG1MM21M?=
 =?utf-8?B?cXVpZEFzUFlHOUFFMVpFK0pzK0dhS0hzdGw5cFVTL3FEZjlvRWw1WGdrQ0lp?=
 =?utf-8?B?MmkrWVQrTFpFL3NWM001WEFJZU10ZjJmQnlqdjNjVHFEK2xydkJ0T2tBMGtq?=
 =?utf-8?B?Zk40ZlNrVDV3eHZnRTVjL1R2WEJReXJFWFBkQ0haSHZYazFmUWRYZVNyK2Fu?=
 =?utf-8?B?TmxlTTVNQXFuTXgwZk44Vk54K0Rpakg2bzlUVmZhM1B5QVFySUF2eXZpcGpL?=
 =?utf-8?B?a1VDWVQxSHNscStnOFJpREc5cjV0QTFDVXROYXlCNCs4VWpEd2s0SGxEM2dN?=
 =?utf-8?B?MXFBUGt3K0RFWndIVEkzVUFmYnYrRUt6NEFVYVBSWEVKTVNNN3cxdXMrZjli?=
 =?utf-8?B?aVNNQi9kSDNMK21tazlBdVpkZGRsL00vUC9hemhJT2sraHluV0s4YlNHYzNP?=
 =?utf-8?B?OWd2dVNJd3NaNjdEc1VMalVBTFNOVjFQNHpPNkV1RGNBbVhGdWZhQ2gycnN0?=
 =?utf-8?B?OE5WQ2FUZFVLQ1ZZYUtxMm8yMGhrWWZ2REtGQzFSZ0k4aVF6YmZYSS9EMis0?=
 =?utf-8?B?TWxaeU42QWthTG9maWRtN21iUDJnVEhreitid0Nqem51L01IblgwN1FIa3lI?=
 =?utf-8?B?RFMzaFJFWE1YZjB0NERkWWlpcmdZTE5DdFNjSEVIZW8rS1pPTnpYbFFrd2Jn?=
 =?utf-8?B?L1d1dGRSemYxcHVPdHpGdEFNMnNwZUs2R1Q0aWdqMklVTERYamUvTkRZR2dp?=
 =?utf-8?B?VkpDK2QydHN3ZWhTWEdrTWJVSVlwalA5UEFQbFFPdS9WaUdxdGl4ODkyZFQ4?=
 =?utf-8?Q?Xrio=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35a0f3e-74d1-4c70-f7c1-08dd66226f44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:40:23.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Az1uNEloROkRVaQkWPnmBfr1GkQJzavF+QVcjU/FgOecBKbNN8IyUowdMDTO5CyUjdRgvUenZ+CvHFK5/8fN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10906

On Mon, Mar 17, 2025 at 10:15:16AM +0000, Qasim Ijaz wrote:
> svc_i3c_master_do_daa_locked() declares dyn_addr as an unsigned int
> however it initialises it with i3c_master_get_free_addr() which
> returns a signed int type and then attempts to check if dyn_addr is
> less than 0. Unsigned integers cannot be less than 0, so the check
> is essentially redundant. Furthermore i3c_master_get_free_addr()
> could return -ENOMEM which an unsigned int cannot store.
>
> Fix this by capturing the return value of i3c_master_get_free_addr()
> in a signed int ‘dyn_addr_ret’. If that value is negative, return
> an error. Otherwise, assign it to the unsigned int ‘dyn_addr’ once
> we know it’s valid.
>
> Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---

Thank you for your patch, but similar one was already applied
https://lore.kernel.org/linux-i3c/174225158210.1593610.10018812780731849409.b4-ty@bootlin.com/T/#m5120e1c362e7e57f4cab139a45410fde421c2f37

Frank
>  drivers/i3c/master/svc-i3c-master.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index f22fb9e75142..eea08f00d7ce 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -998,9 +998,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
>  			 * filling within a few hundred nanoseconds, which is significantly
>  			 * faster compared to the 64 SCL clock cycles.
>  			 */
> -			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> -			if (dyn_addr < 0)
> +			int dyn_addr_ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> +			if (dyn_addr_ret < 0)
>  				return -ENOSPC;
> +			dyn_addr = dyn_addr_ret;
>
>  			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
>
> --
> 2.39.5
>

