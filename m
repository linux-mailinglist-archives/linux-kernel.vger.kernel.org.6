Return-Path: <linux-kernel+bounces-322503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018A79729C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9492860B8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6861C17ADE1;
	Tue, 10 Sep 2024 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="g5TkMsTn"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2129.outbound.protection.outlook.com [40.107.22.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465516DEA7;
	Tue, 10 Sep 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951014; cv=fail; b=Lr4jos+5b0ts3TL5UVFHZ34WNA1XMiX8EPgzssh5KwIuDpi+vUZ1cCRQxv4om2693DTDpFEBo9BcUVoXLOw6UxH74uVRVEZTgPt7SyLTbcveWwk4MTpTzP/Oq7FUsBw+FH+2zSMZ1lPW9Zn3xOiKuGD2lwhWaPI9dryxUI/ATo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951014; c=relaxed/simple;
	bh=YVM3DZ7fgaoo8AFh+M3YkPej1hFJg8F+BScixOg8fGs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uQbC1JCkRU/nr38bEIC0Y9Ap3WYE5qvzrvz0RE77u/99hJmB9q0/3w7Bbl1Ox4upvKVP6whFVd876q7IjlYch0d5g7tfeKlunwQDs4LNHrtl4iG4CUrXC3jf65I1aSMJxlazvIg5D6dNdo5z9fmyQk5IrWrtB1cjcUH3cgeqmM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=g5TkMsTn; arc=fail smtp.client-ip=40.107.22.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGilCikrkQu4OKodnItzEDaoxGinwUkp8bKm0+VoZs0a3t5/iy2q1jNOo07OOO9+B4I4JsL5ugKi15aOzR4/sOKj+UCeu2/LeTluT27jtRwGdF8dhvRBsvrSkScip7ohqBmaMCwoSxqi/hscJfj6sDMeuED5Ci4qhcG+IS1FgfSFEZXaRl4+urryh1rPQN5hoNiTHGh6mLypVkZFloWidJxNwzskne/8wo+iO+um1Mb49/ZLrIaP7qvP47XtzQqLhzWm0zkDOmw6r+IUU4UtElwera8FlvfhsXbmI/XkwpHfrwSzv0TkIuLByX0OldnCPhRU+gHi7Mw0nKOi6zw3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v92r3FTUai8Ga057ufLrC5WY0BB4bHr/sq0UNPy2Lro=;
 b=n6FK8uTohVZxxBfDgB00o8orfDc/Fx87tY41YV7C8uEcoFj+5tYDCrioWSmU72oB6CEt2yPhBNs9Sr7CNIJsuZqcnaZZPQquPtYQFi8x6O8cqBIGfdAdZZfKi9n0bNz0dsfEv5eCxR7QNm6M7K/JIMxxWhEjdwLN9Rw28oVK9qJjT1SpLwdYWtjzU2dIvQJ7DvQMu3BIRM+pOiBg/IYmmW5KxVrcFzVMlHrOB8mk4tN9EBgI+TJsaGdRdQN82VQfAvccJeiXHcGFoD9faPfEJTDaOA86CAssbzryE/oFVQh7aJKw3WeKMTk/JMP+bXvJY3p/9dxBRgpfnui1T2fdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v92r3FTUai8Ga057ufLrC5WY0BB4bHr/sq0UNPy2Lro=;
 b=g5TkMsTn6Vm/9/58bw9jqksbOUVKA34Es4zhIuS6cxZXmMPDBN1bXE0mwJ8SRdhB8Ielozgy13so/p0B3Yk+/LhWXFWLlJzo5b+oUYelwkjrMoiMed/kYsce5V8Q6vjNcZtvOl45Fu2GCswfIAQePpJCKUSLzrYFLKplTD7GmGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 06:50:07 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 06:50:07 +0000
Message-ID: <ef218f6b-7c24-41f2-a3a3-fcd97c29886d@kontron.de>
Date: Tue, 10 Sep 2024 08:50:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx8mp-venice*: enable NPU support
To: Tim Harvey <tharvey@gateworks.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240909215359.780561-1-tharvey@gateworks.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240909215359.780561-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS4PR10MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f39afa-40de-4dec-cff3-08dcd164ce54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnlRWGcvL3VPaFA0SWswZE5hTUhNYXl4M1lTa0VUbDQ3ZzVCZTRFbk5nOUh5?=
 =?utf-8?B?S0o1SXJOSnF2L21OdlYweE0ydFE4RkJmaDZTMjNFTzkwVzNYT0R1STljQURl?=
 =?utf-8?B?TzdkM2dCemc3Q2NESlF5WFVTaEl5NWFtQnhhVXpKVVJKZE01K01BZEFsQUp4?=
 =?utf-8?B?RmdldkNlQ2lqMDdpclhhak1EMUJrN0xxa1pYWVRNeXk2U3c3dnZDQWZST2hJ?=
 =?utf-8?B?MWhkRnZrVk5CeGNQNDUzdXlzako4NHdsd0lIVVk1dWxiTUdvMGc4WkZ5ay9s?=
 =?utf-8?B?eEhOb1VHU1p4WFdKd3JFQnFHdmZycVZqYWdUOFBKSlF5ang5K3R0dHlrcDJF?=
 =?utf-8?B?VkxEKzEzVkNoUjAxejhNMm1JK2RpZSs4OEZRU2x0VGdhOXd0aHg0V2dwV3Zh?=
 =?utf-8?B?SXp6RXJVY1ZlSnF1bjZsendYcGRaaEc2TUY2ZG5XT1JGc3hKd05LTVEwc0xz?=
 =?utf-8?B?V2R2S3B4N1RvVDM4NEF2ZlUzbmtaUGI2RkY4dFhRYWZNekEvczFUQ0RoTWpL?=
 =?utf-8?B?RnRIQ25kaEZDNTdNQnNYVWk3S29vZzBsTU1uQ2FFR25QcFF1RjBkRmtmMGtO?=
 =?utf-8?B?Y1JCVytmdVR2MktpU2tJSFpRWjdZMHZUMmtnNkl0b3FRam1OdkQ4SXAwL0ZT?=
 =?utf-8?B?bERXczVkaVFXZ3oyY3RSaEl4OE5jeFVxTDR5Q3RnQnUya0szdXhQRmVTeWpz?=
 =?utf-8?B?Sy9VR0RmZnJaem5INzAxSEFZUTQ5NFUvVktDRkZkNzVtOVRwT0Rxd1h3azBn?=
 =?utf-8?B?bFgxa1NzQVh5cUphTlB1K0d1d1JibVRSNVcveUdyTTNqYnkxWmJFZXB0MTZO?=
 =?utf-8?B?bjdBTzFXdlhBS24yTWhSb0xrL1NKV1pGb1BHR1V5cUJzZzJzV0JRV2FZWUVj?=
 =?utf-8?B?dXJZNXRSbE1pa1dGai9hVzUrT3FTelppQ0JEZ3ZHUEptT0VYZ1lnRkQ4MWxy?=
 =?utf-8?B?SWRKdVJoVkhzMXZMSHhGTFkwdGhQdTFhdW5LZFhyZ2pUMDB0T0ZrZjhxQVUx?=
 =?utf-8?B?VXgzS3pNeUw4T2s4aVRoM0xINXRRSDFPS3dNWkNSSzJRdXJ6OEVqQlE3RXht?=
 =?utf-8?B?MzhKZ3duSGZLOG8wMHdqdUpka0gzSDFySjVCaXNqNlc1SWFUaHZvL2ZBL3Ns?=
 =?utf-8?B?bXV5ZHhVUHNxT3ZReVhzd3BxTEFPYks3VUdsaFI5WmpkaWc3WkxFUVlzUUxX?=
 =?utf-8?B?QldrNnQwRWNGOUpGYVFjOW9Wem55NHU5ZG5BUUV1ckZ6Z0Z1NWZwYjJYeVhy?=
 =?utf-8?B?TWdpOWJLekNVQ0Z4RU5DbGFKanBhS0xiUFZMYUxrNnUybEJMZFFkb2IwS3NP?=
 =?utf-8?B?R3ZZUmo0Zmg2UVpKQXVkaS9tQy9oSkZwOXR1cTZzcVFkRHR1RG5mUzNnVDc5?=
 =?utf-8?B?d2xxMjlGdVpTZE1vUW54N2hGL09PQlhRZjlqSEc4NGMrcWNQWDdhRHgyZEF2?=
 =?utf-8?B?K1AwMHc3T3dxOExuRFVHSGtlV011a05ZWTZ0bnpGb1hhdEVycnJNMjE1T0ll?=
 =?utf-8?B?bWh6cno4Y1JrRjhZMW11QmwvTGxreDNZay9nckh2VTljbXZYNW5hN2VVYjNx?=
 =?utf-8?B?emV0RmY0ZVQzd2xKeFdZcmpoNFh4a2J3QzRKNFFrRER6aUdoYUhMVFhLV3ps?=
 =?utf-8?B?aWxNMkJWcU9nSG9jZ053dWVrOGUzVmFTREdFU2tmeG40YzJPSzMvdHRiZDdG?=
 =?utf-8?B?NHA0bitReFpFWWE0RmpMeDkrcW40RFNLdkh4bnd2MHQ0TGdXYmxCNnFLMnR5?=
 =?utf-8?B?d1B4S1FoTFdqcWNsVHNvTU5Kc3JzMGJUNit6RFNHREpNOTBaUzg2ZzFuV0Fh?=
 =?utf-8?B?WnVHY0tEYnBTcE5FY2psb2dsVG5Ha0lLcmhFbUpGVzJCd1JXazBsS1JkSXRP?=
 =?utf-8?Q?KPXUrUs6UoTGE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGE1WjBGeHNvT0Q5VkhpYXgzVVNxM3JDcnR6RWVuL0Y3QlFobERXR0tOUG5I?=
 =?utf-8?B?K2pPTDM4NVhwU2RBTWZBTVlsNTJXTTYvK1VSVUdPaUZ6MVY0SnNLelRGbUlo?=
 =?utf-8?B?L2tuQ3AvMkpqOG5lUU1IWlNoNUVrc2RSR1BoVlBnc0NOT2gwWk5qNHJlbk05?=
 =?utf-8?B?RUducWhCZ0VhMWpnbVZZQlZ1SHhKRkwrdWFTQTQ4OEF5bVFRRVRaWGFKSmxa?=
 =?utf-8?B?amZSZlJjSHVlNDN5bGY4V0RxSHhpenpUMGNvcmVuN0xZV2o1bDFxM1ZQUVlz?=
 =?utf-8?B?Yk1jblRLT25wWXIwM1hqeE5xWUhIL3M4cXZTTVZGZ2FZQk1VTmU2bk82Rmx4?=
 =?utf-8?B?QjFNbnNhYUdqSjRGNVBjYTkrNjFHMCt1Rmx4SjhEQmNXNGxsdm9NYm5IRXlL?=
 =?utf-8?B?a1NiMVdsazlMVnpqNkt3RXNRSkkvOEQ5VkZzVHpIUG1ncysrTHJtYjkyQkN0?=
 =?utf-8?B?UHlmRHFjWGp3VTM0NStrM1NEOWxCNEM0MzFhZ3I3RXpuNmVseHlTanVCL1Yw?=
 =?utf-8?B?eGFsRDRYRDk3QXd5bHh2a0cxQ214N0M0c1lja3lHSkQ0NDEyUGxXeEtiSFJR?=
 =?utf-8?B?cjNJYVB3NUE1YnhCczhEY0tXUWg0aVgzQWh4RWpaRXQzejBhRy9oT1ZvOXlV?=
 =?utf-8?B?d21aenRtUE5UbHNyVHpwdmFRZ0xZZkJySFJwVVpvc0VkN1dqbWVTaENWdDhT?=
 =?utf-8?B?ODVXbExBT0d3bWdhV21NcUpIMGlvcW9xZ2xiVG1iUlZYUE9yOVF4R2trZEZa?=
 =?utf-8?B?VlZrUTBCUHl4cjJZSmZXaStGNWdoOHZBaCtua2lSS25jMUl1NjZSY0VXWjJK?=
 =?utf-8?B?MUZYanpuWndDb1ZnU0ZzN3kzUXQvRy9KNW8zaTlQbDFQdGk5THM3YTB1YVBM?=
 =?utf-8?B?V2pTODZwZGF3MGovOEcwZmdUamc0anJRUWNiZkFJeFlDNUo1b0RWTzNveWhs?=
 =?utf-8?B?ZWZJL0tySWswYnRYaTdMQlpZcFkyZ0xDUTZVU3djQUdPYlV0Nk9VQ09CVWJa?=
 =?utf-8?B?NHc1OVJrM0FtMTdIK0NTTjFiTy9yT21XcVNOR1pNQ3RKem9ucy9EckxZOTg5?=
 =?utf-8?B?NTF5Lzl5V2lUOWxZZkZ2Uk8vamhXd0dsZFZXdFVlVW5EZkZyYnJjRXFxTzZ4?=
 =?utf-8?B?TXBQOXF3My9ob21EaS84OEV0dy9pTGtWbGt0Y2NlcVY3SCtxbTM4MlBFOWRU?=
 =?utf-8?B?aHMwWERXaURuKzBDSVR3TXU0VTdMcFZzRU5UMGJaLzZFNXdjQmZ0TW5WZmN4?=
 =?utf-8?B?bGp3WVJSWitYc1NxRUJvS2phcEd5Y3ROWGlITVUvbGIwY2pVUU1MQlFPRk94?=
 =?utf-8?B?RkJQeEF5TXl0UmpFcDVIbXd4Ull3aStncUFQV1ZoYnZJWXFWQlZJUnlzN3dh?=
 =?utf-8?B?K1F1dFpJQzNsSFdGd1k5TGJJc0lMOXltdERXUm52ZWMxVEYxbSt6TDVjVlRL?=
 =?utf-8?B?eHhLQ3UzSE1weE96MVVTdVorVGRoY01TalNkRFJob0ZGd0dUTGdHeWRaVzZ2?=
 =?utf-8?B?RitreWl0aUc4U3k2WTB0Q3RWMU1rM2tuWlZqN3duUEVGYVVBUnVoTm80Qmdm?=
 =?utf-8?B?anJzS08rdm5XZ3dtMGExWVdRcnM0dU5EOHZTbU1QSWtxK1RuRVlhLzJpbjRW?=
 =?utf-8?B?MVNBMkU2RUpDSEljT0N1VXRRTXBvcjhtMm5LT015SGtZUW9aanpsL2VoaUhQ?=
 =?utf-8?B?ekg1cWd0MkFocVdOQ3h2SElnaldUUUFrTmZtV2krSlpBSnNsMTNjOFMrWFhj?=
 =?utf-8?B?V1dDMjZ2YUtaQVZMYkY1dFZ3MHA3Q2g1WjhVOU1mSDRZcm5JQ2NBSDhvZDZE?=
 =?utf-8?B?MDUvczl3UjFLcG9wR3Vud2Vpb0tXR0hZUHVGNmxmUFFMZ05ja3p6U3IvRm1M?=
 =?utf-8?B?T3JKTy80VDRBUkZvRkozbDBnUzR2Y0pXQnY0cThqS2pka3hienpDU2xFOE9C?=
 =?utf-8?B?WTQvV2NOWnBiU2I5OGNYbWpLKzJtVzhUbnRZWDYyWGRhODBQdUlyWXhqV3Zv?=
 =?utf-8?B?NjVvSWJZS1hTR0QwWjBZTVZmNkF2RU9nYVprUklJNDBHbXdvUEsxS1BwVmly?=
 =?utf-8?B?aTBRdG0zSXZyWlU3OXZ4dzUzcDlZNnVWTFpuU3FUdUFpV2dzcWxzdEJNMmtV?=
 =?utf-8?B?N3RFdytQaWpPbDVnMU9lbmRhMlAyVXBMM2RwN0RFbEdKSWEzeU9oWm5oVWdO?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f39afa-40de-4dec-cff3-08dcd164ce54
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:50:07.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwd0WQqaGS2d8CoOaGE7vV3XEDtvNaltlxA4NxzyhlrGxkyGHUet4LxLtQFFTNo4tjRhyoO0Sl144WCPf9/m2gMiPv5s2DcJN1MVMZ9JW5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5497

Hi Tim,

On 09.09.24 11:53 PM, Tim Harvey wrote:
> The IMX8MP has a VeriSilicon (Vivante VIP8000) NPU which
> is supported by the etnaviv driver. Enable it.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts  | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
> index 6c75a5ecf56b..f0211a96855b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
> @@ -393,6 +393,10 @@ &i2c3 {
>  	status = "okay";
>  };
>  
> +&npu {
> +	status = "okay";
> +};
> +
>  /* off-board header */
>  &uart1 {
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index 9885948952b4..8a04b66a4afc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -666,6 +666,10 @@ &i2c4 {
>  	status = "okay";
>  };
>  
> +&npu {
> +	status = "okay";
> +};
> +
>  &pcie_phy {
>  	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
>  	fsl,clkreq-unsupported;

I think there is no need for this patch as the NPU is already enabled by
default in imx8mp.dtsi (same as the GPUs). Or do you disable it in some
intermediate devicetree include file?

Thanks
Frieder

