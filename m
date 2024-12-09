Return-Path: <linux-kernel+bounces-438048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C769E9C2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FE1281936
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E914EC55;
	Mon,  9 Dec 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XGN/xNbX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4D2C9A;
	Mon,  9 Dec 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763310; cv=fail; b=GjChcd0/bjKy+PJwgjwJ2CmWm6WjiPaEk02JgmN8S+e0pz5fssQ+d8BNx6H894mPHQXz7oWnBwGrnM23e7nnh1MQWhhgV2I+Q/2ZeMP09IkPq4vYyTL/HsRmwKRAZsnq8swaBOxVmxcYRtVQ4EU19rht/7yCzLl938HEmno6CnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763310; c=relaxed/simple;
	bh=/lvt8+YBCP3SwDAGV6nH/AgQnNYQmuGIghC4IyioQoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T/r63cN499laLpAMG91/lFB/FS6/suoq4EDX7tIKwCRy8i52tLQl6WOlBEGicj1O2xylmLg8wgmaVBI9IhEVt9lhRcv9aZwnXKpOPOoz9Ll+QL+kBWMPPwlma8XYQeTigOFTD92IoPtDst4ZroTcIT/p3k+j4z3lqGPpY8v/BBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XGN/xNbX; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lldWL/tUuMQsXJD1CrwaRJa0IlEov6HV+BNm0r3zjLRqywoC8/vpkWKIdDKLUZe+HlDE4Rs/1tnrPiWFDAf0ItOoDxrPQdnZVGC96RAj2xa+/qJTbp1yBxuTkWYhb9IipCKDPa9SjPMxhp88+3JdliT0f9FY/Bd1u4WnR0TGzpkW1InM36AH4kSURKuIxqjeHTXuz2vEPDfZUgLGQiIRRSB8vx2YRUldhRBvouQz7X9u2BkK1jB3mKQBw7oqWWkzmnkHRUS43xref0zqF8ItEty1kxo7zb9uOVdU/idl5Ar2XDDycj+ryzP0jYHwlyjALjBHPQjDzTrrK81Po6/Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItXAMmdxz7bRIXo7ZOjt3K00uox+NoY8JgCJXD2U8IY=;
 b=bF8Kvbn8gVtAWZc30mlUFLkOPi34loL1QH1L5zbJK9+1wyEI4MkbvcjRG8dsDTmKuVIqdHYpSX6P80YP+7bxs/XYJc4Hx+5/RauiBUa/zgVeHGK86+AoLJsz29X3XGGuS9oWT548sme+CuEQl2yXiRrirjnzv5rx8DDvs0ANQyQVEXbY83e75nQ5M0U784ZUhPf52cMLbFSYflqWzBVVmnNusVUkbB+dQLx2GPoFE5KNfhu+AiF1g7g0ENqmyypoyxpb2G42IvPWn4fYdldgG0rSkSOg73OS1LK/PSDPaJU53NdLnY2hynU2eKYxmp+oni8bTGNIhpdAbQzCaWH8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItXAMmdxz7bRIXo7ZOjt3K00uox+NoY8JgCJXD2U8IY=;
 b=XGN/xNbXqo5KRgsmypbeMj8sJ43aaasII4Nxmdn0368n64dB5bZ4ABWQTQP6SUgoKOGXAL5abCZ0caw7lakN5eG/7YeJhQqIL4JyOhnplgLqdAC/cefpIWBp8xJ3bCV/oWBmOS2JpzHU3yDRvX/85qvziH08RPT7HGztWhDIDgN1nqplUm30lKtn6ZRplABOpzdzxqSBlDPytTeivpmwi754N1cT6wD0w0mWBDjL+MEVgw1Jikw4Wc1BcqUwogDSRs0uJsWFrE2dIVJyKB17JZP2sJMJmLW7qy53mEvszKodq1dwT58o3Xd3kH+l7DcHUh5BwH2Q6xELu4JqpICsGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GVXPR04MB10660.eurprd04.prod.outlook.com (2603:10a6:150:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 16:55:03 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 16:55:03 +0000
Message-ID: <64332634-751c-400c-9f46-7903ec85fe03@oss.nxp.com>
Date: Mon, 9 Dec 2024 18:54:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g: add I2C support
To: Frank Li <Frank.li@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 NXP S32 Linux <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241206123119.1688712-1-ciprianmarian.costea@oss.nxp.com>
 <Z1MwkyWka3yDm8Ez@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <Z1MwkyWka3yDm8Ez@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::25) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GVXPR04MB10660:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fe2fdb-8269-41f4-4a0f-08dd187239eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2dPcWZwaVJIS0JLZHU5Q3Fzb0hNMk1waS9RSWlnNVcyOW1ta3VCUUt1TmZk?=
 =?utf-8?B?QzFVTE9wVm4rb21yRVo5Z2Zvb1hjNlBrYXhNQklLdlNJUm43SVZRcHVoWGRO?=
 =?utf-8?B?b0dySWRYSE1nQ25kdXhUYmg0bkhUdXRSSlNSTEdPUU1zdE5pVFJkb1kzQlpq?=
 =?utf-8?B?c2lyR1RrSCsrQ1l3QmlYODM0SzUvanBVV090YnZRNUJmQkM1ZW1veHd5cXpG?=
 =?utf-8?B?N2hSZG52NXdVWmsxV2d1MkY3eUx0ek1RMXAybDZ3STNETTJHRXA0Z1hGK0FX?=
 =?utf-8?B?bS9yTXFjQXI0bXJ4OTlZQmJUVW9keDd4YXc4ZGM1TmxVOURnSnQzcVdYcHpu?=
 =?utf-8?B?aWIxSm03NFpORlpKWVdJWEtwSzE2UHpjRW12S3R6RHBISW5ueW9adU9YcGFO?=
 =?utf-8?B?OUJhMnF5QlM0NVhacUVDbzNuUVFxYnRXeGxFWUJBVXdQbFRyUWE3MENoK1ZL?=
 =?utf-8?B?R093OG42VTQ4ci9JM1Y1TnNlSkFaVnFYbUFGalFPaHo2L21Xd2VaLytQUTN3?=
 =?utf-8?B?NFg2Z21sYjRHandpWVl2ZkdZUjZ6WU41SnVYTVJQSURKdmRPcVJ1TVF5OTVk?=
 =?utf-8?B?amZ3OWxKZTFDM2x0SnB1RkhZc0xNVG9IV3RwOE1qTEtaTk9qd0ZtL2RPTkhI?=
 =?utf-8?B?WjJPMDA0U05LVHNNS0gwSmxuZ1JmMzFYS2JTYnRnZjVKaGhWUVIrY1laUjhu?=
 =?utf-8?B?RVB4eVNSTjhQOERSNDJvNEdaS0lpS1RUVExsNWNRTjJsSE12eDVFc3hTb3Jk?=
 =?utf-8?B?WTlmdTJlWjM0S0RTNXd4WmQ3b3lRNlQ0TWN5NjJuOTVsZElkLzBkNXFJd2lI?=
 =?utf-8?B?Z2VtUWpJYlMrcVhCaHdId3dnNGlaY0E2S0dRMVBzWmQvVWF3YU5MUjdGT1Ro?=
 =?utf-8?B?VVhsd1FYOG50UVBjbUxscGN6Q2Zzd2hZcURFU3pDREdhZStNQ3MzVG5VVDcw?=
 =?utf-8?B?cXpyMzQ4T3ZnOUNsMHZqdG9TS3VJVG1wb0JFN2hxYUFCU0YrWDQvZktsV1Aw?=
 =?utf-8?B?SlVkU2Y1UkZqNndBRGhqck1QODVoY3BCODlDUFBaRy9Zbkl6Uk1wMXpudGto?=
 =?utf-8?B?b2Fqek02Q1lEZWpEeVZwNXhmM3h2T25BZWt0QzZUTGRFTk51bjVMTEl6VlZm?=
 =?utf-8?B?Q3RFdnQ3b3IxNXlIRXBYWk1CeXdycHhyNTJmM3FyNy9PU0F4Y3ZUU3pXbTY4?=
 =?utf-8?B?VDA3eFV1eDRaSTlKSG41Zm9PeVVOOVFCWVVkOExYRUl2T0JpQ1owNUJxbXpJ?=
 =?utf-8?B?SnUzNWZjalBLZk0zK3VSL2FVY25QUWtCMUFaeFlpZllvTnV5Nm9KdkFzR0F5?=
 =?utf-8?B?emphVDZLSjZVbjNnWjU4NU1KbGhIUEt0N1BSSDJIYmpwU2h4UTZUSVZ3dXhk?=
 =?utf-8?B?ZVZ1dnovblIvbU1uWlI0aUZlejI5TkovQ1N1RmV4RFpoY2RmZ1B4WjF5MlAz?=
 =?utf-8?B?bjcxWlB6WFFHWmQzajdpMVRSeHZxeHVNeHJuZ0FtSTVOMmJDdGgvVkhSN3cw?=
 =?utf-8?B?bjY1ZmEvZEU5RGFvTldKVjRJU0FBbTVBeDdERmRzYjNUNnlhOGk0emxFVUs4?=
 =?utf-8?B?aElObFNSK24vOFlYUXNOQ20vU2szRDJ6Qm9KZkRYRWsvTFRpRXowS3RCemlB?=
 =?utf-8?B?N24rU1ZYVHRCSjErSjZ1MndtZ3Yya3g1WUhSL25kcVRDOGllQy9WTTdEaGEy?=
 =?utf-8?B?N1FpcUw4VEViWlAwdGUwd1lmNjl2dUlJYzJHWndMWEVON3AxQWdUUmNhRTJl?=
 =?utf-8?B?ZENDQjU3QnRQdjJtL3o4QzlMV3hmSkxkRFRUczhJWWVJbWVIMXZQQU9kejJp?=
 =?utf-8?Q?BAiW4w4heXO4aoay4E9ej+fXbjOC0zsowilGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZtb25LcHg1NktFajhxYklFbFVQWjZYT0VBZjdHT0NWQTluMXNGL3ZvRXFH?=
 =?utf-8?B?RlN2Q2NUMlY4UUdSZ0hRMkVwVmdvcmU1TTM1TlprT1ZPZDRiWlpURiswd3hT?=
 =?utf-8?B?RXEwSGViOWZuZXJPL1FEMEFUYlhwc0FyYWNTazVqMS9SRzRJTjZiUUV6VXo1?=
 =?utf-8?B?RmJwb0lJdDRtbGdKcnNad1RpUTFORjlUZ045SVNNK2pLblpicUpBSDRoOTRP?=
 =?utf-8?B?a1RQRlZwRm1CaUZOVVJ5QmNUYXRjZXIyelREMUVzOFNhRmNYQitqd3dmWDFk?=
 =?utf-8?B?NFZ4ZXdlS25kamdqaVFpbTAyd1Z5dUtMSVBWK1ljVmljRFR1WUtUOTNDMUwy?=
 =?utf-8?B?dDdSbXRTQzUrZ1hoQUtzdmU5NXFnV1JUM1RjSWVmMEw2enFPK1FjQ3VCcncz?=
 =?utf-8?B?dGRRVUpGWXhjd1FieERTVGVXZ1lKejNNRHhMZHpNajFaaGFBWnI0KzhQWDRp?=
 =?utf-8?B?dURFOG8vN1B6QXNxaDVORzNRVGtFTVhoMTJqc3ROM0tSSDFPT2c3Z2ZnWFhi?=
 =?utf-8?B?bEZhWFlYS1JaWXlrcGVJUnVXalpGM25VKzliZmp2aXVWL2dQKzNlRnpYU0dm?=
 =?utf-8?B?V0RlZTlpR0NhOE1OdHJla0JLRHBOVzJwNHNEb2prRXR6K3NIencyTk5GcUUy?=
 =?utf-8?B?VStxRDB6bmRTclFuL05rWGFwUlJtSjVVY3ZFRW5XSWVESTNYZlVyRzArUGU1?=
 =?utf-8?B?UmtBSmlGb0JGdUZ3RHBIcFc2MHRoVEFCWGduVXEySTA3cUQ0Q1ozcWRVYzF2?=
 =?utf-8?B?dFp6b0dhbXphaWNNVHp4Y1BXNW1lTVlCai81QnNYd1A5K2dHUFJ0UmNFb3dU?=
 =?utf-8?B?OXRNVDJ4eHNyRGF4Sk9UYUhMYks0NWdDVnNwZTZFc2s0WmhEZ1dFZm4rbFVY?=
 =?utf-8?B?aWhWUXNwRTBZcDc2VEw2VUQxTmdQSlRrdEpaTjNsTkhSa3FZR1pEanQzWCt3?=
 =?utf-8?B?VlNsM0tpYlYyTlhHazZUbjBjNzZYV1U5TGRYbXdjZmFudmpsV0NCSnFwSE9h?=
 =?utf-8?B?SzFwZ1pNTjBrbDlHMjNBdk1ucjd4QkhvRWgxYlhSa2M3MHlNQ2xVRUYyOGx5?=
 =?utf-8?B?akVncVBwME10UDlFU205b3Z0NFB6WC9JVDYzVHB3clgyV3BueDdpSEYxMTJv?=
 =?utf-8?B?SURjTFY1cU5ZNlNTdjFxMm5CSDFvVlc0TmlERVJrWTJiRkJZamlmeHN5SjVu?=
 =?utf-8?B?VGY5TXM0bWZiYXQrYzk5d1VaUkd0MUtsdEdmS3NyOUdzZnhBZVdjRkVpSU4w?=
 =?utf-8?B?Wms4eHpNV2hVNk1mWXU3NitiV2pFMEFKOWxSWko4WDJJcFhCVzNJRjdtMGU3?=
 =?utf-8?B?ZHh3S2tiQzZzT0NYSnNlSTdsSXg0OWVQaURzYTNEd200VGNVT0VJc1czOUZr?=
 =?utf-8?B?cWpHc0FOMExJQitDaGtUTFFPaHltc0VaMGpIcnM3UkJ6cnVCUzlZMkZZOVhS?=
 =?utf-8?B?NE5nc1VhVWpmV2lvNi92MEZCbmxvb3Q0Z3hJK0JOMDF5UlpCNHRFRFhBQkJJ?=
 =?utf-8?B?ZVVOMTByZi9td3VkWjQzODZoTGpKczBTTWFFMi9hVDdVQWFZOXA3bmhYY0NS?=
 =?utf-8?B?UmxkV29vb1MrM2s4WUd1V0xJczVHRThkRURzRkU4cFduRmxSNmJmcGtXUExW?=
 =?utf-8?B?SjNLSnh0dXNucXA3SWtUWnZSV0lCQUdVLzhZa21yZUVGVnRka05vdW1oUXUr?=
 =?utf-8?B?MURqeWJROWxMaFB2RjduNEtBNGVod3gzY1JZMmJON01uMUJoeEk1RjI3Q1JB?=
 =?utf-8?B?cnpDQmdVNmlZdVl0N2wvTkx2WWJBNnRjcnFCSzJCcndNazAxdWFLVjg4QWdt?=
 =?utf-8?B?VFRxbFV4RmhzcUh6TlhhSWlvajA2QVlLTXRtdWNmRldyaEttdWlKM2grTkh1?=
 =?utf-8?B?ZjFCczd0WUo2NzUvcUFicy84QThOOC8zV1VhUlRsa2dyaU5BSmpQanZOOHgz?=
 =?utf-8?B?Mm5tbWs4ZTJEeldFR290ZDJoaTVtbVBOYll2VGlSMHRvUUV2U25EYkFSNXNR?=
 =?utf-8?B?UmtvVFpwTGRvY1ByZVRBakN4N0NQWGxjMk1aOXJxRXBiVTVhb0k5aE85b2Nk?=
 =?utf-8?B?OG1jcFozQlZHU1UxcmNqOXE1eGU3Qks5R291WHZCVjZuUlMzLysyaGNnSGpy?=
 =?utf-8?B?TzdTNGV2Y0JMenFNUjVnRDNHSFRpU2tUS1VZZTUxMWc2bU4yRE9nWjRNVGx0?=
 =?utf-8?Q?RG7Rmq7b2BaerQKJPdqpjA8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fe2fdb-8269-41f4-4a0f-08dd187239eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:55:03.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCjtI0Tl6l61TyMkrbVcqcxccEHgpyXBTdsC/jwI7pp5UBWgnOO/MBjHk3RxodD0uhTfAAt1MrdTD7960MoHNdfuAniuyrXfPeTel31/G/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10660

On 12/6/2024 7:12 PM, Frank Li wrote:
> On Fri, Dec 06, 2024 at 02:31:19PM +0200, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add the I2C Devicetree nodes and pinmux for S32G2 and S32G3 SoCs.
>>
>> With respect to S32G2/S32G3 SoC based boards, there are multiple RDB
>> (rdb2 vs rdb3) and EVB (for G2 vs for G3) board revisions. These versions
>> are quite similar. The common part for the EVB revisions will be
>> centralized in 's32gxxa-evb.dtsi' file, while the RDB commonalities will
>> be placed in 's32gxxa-rdb.dtsi' file.
>>
>> This refactor will also serve for other modules in the future, such as
>> FlexCAN, DSPI.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/s32g2.dtsi      |  45 ++++++
>>   .../arm64/boot/dts/freescale/s32g274a-evb.dts |   1 +
>>   .../boot/dts/freescale/s32g274a-rdb2.dts      |   1 +
>>   arch/arm64/boot/dts/freescale/s32g3.dtsi      |  50 ++++++
>>   .../boot/dts/freescale/s32g399a-rdb3.dts      |  12 ++
>>   .../boot/dts/freescale/s32gxxxa-evb.dtsi      | 150 ++++++++++++++++++
>>   .../boot/dts/freescale/s32gxxxa-rdb.dtsi      | 124 +++++++++++++++
>>   7 files changed, 383 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> index 7be430b78c83..0e6c847ab0c3 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> @@ -333,6 +333,33 @@ uart1: serial@401cc000 {
>>   			status = "disabled";
>>   		};
>>
>> +		i2c0: i2c@401e4000 {
>> +			compatible = "nxp,s32g2-i2c";
>> +			reg = <0x401e4000 0x1000>;
>> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
> 
> hardcode 40? can you use macro for clock index? Many place use it.
> 
> Frank
> 

Hello Frank,

Thank you for your review on this patch.

A discussion regarding clock indexes for S32G SoC Modules has already 
taken place on the mailing list [1]. The conclusion was to directly use 
the clock index numbers.

[1] 
https://lore.kernel.org/all/f54d947c-58dc-498f-8871-b472f97be4a8@oss.nxp.com/

>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c1: i2c@401e8000 {
>> +			compatible = "nxp,s32g2-i2c";
>> +			reg = <0x401e8000 0x1000>;
>> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c2: i2c@401ec000 {
>> +			compatible = "nxp,s32g2-i2c";
>> +			reg = <0x401ec000 0x1000>;
>> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>>   		uart2: serial@402bc000 {
>>   			compatible = "nxp,s32g2-linflexuart",
>>   				     "fsl,s32v234-linflexuart";
>> @@ -341,6 +368,24 @@ uart2: serial@402bc000 {
>>   			status = "disabled";
>>   		};
>>
>> +		i2c3: i2c@402d8000 {
>> +			compatible = "nxp,s32g2-i2c";
>> +			reg = <0x402d8000 0x1000>;
>> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c4: i2c@402dc000 {
>> +			compatible = "nxp,s32g2-i2c";
>> +			reg = <0x402dc000 0x1000>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>>   		usdhc0: mmc@402f0000 {
>>   			compatible = "nxp,s32g2-usdhc";
>>   			reg = <0x402f0000 0x1000>;
>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>> index b9a119eea2b7..c4a195dd67bf 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>> @@ -7,6 +7,7 @@
>>   /dts-v1/;
>>
>>   #include "s32g2.dtsi"
>> +#include "s32gxxxa-evb.dtsi"
>>
>>   / {
>>   	model = "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>> index aaa61a8ad0da..b5ba51696f43 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
>> @@ -7,6 +7,7 @@
>>   /dts-v1/;
>>
>>   #include "s32g2.dtsi"
>> +#include "s32gxxxa-rdb.dtsi"
>>
>>   / {
>>   	model = "NXP S32G2 Reference Design Board 2 (S32G-VNP-RDB2)";
>> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
>> index 6c572ffe37ca..666e4029e588 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
>> @@ -390,6 +390,36 @@ uart1: serial@401cc000 {
>>   			status = "disabled";
>>   		};
>>
>> +		i2c0: i2c@401e4000 {
>> +			compatible = "nxp,s32g3-i2c",
>> +				     "nxp,s32g2-i2c";
>> +			reg = <0x401e4000 0x1000>;
>> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c1: i2c@401e8000 {
>> +			compatible = "nxp,s32g3-i2c",
>> +				     "nxp,s32g2-i2c";
>> +			reg = <0x401e8000 0x1000>;
>> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c2: i2c@401ec000 {
>> +			compatible = "nxp,s32g3-i2c",
>> +				     "nxp,s32g2-i2c";
>> +			reg = <0x401ec000 0x1000>;
>> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>>   		uart2: serial@402bc000 {
>>   			compatible = "nxp,s32g3-linflexuart",
>>   				     "fsl,s32v234-linflexuart";
>> @@ -398,6 +428,26 @@ uart2: serial@402bc000 {
>>   			status = "disabled";
>>   		};
>>
>> +		i2c3: i2c@402d8000 {
>> +			compatible = "nxp,s32g3-i2c",
>> +				     "nxp,s32g2-i2c";
>> +			reg = <0x402d8000 0x1000>;
>> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>> +		i2c4: i2c@402dc000 {
>> +			compatible = "nxp,s32g3-i2c",
>> +				     "nxp,s32g2-i2c";
>> +			reg = <0x402dc000 0x1000>;
>> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 40>;
>> +			clock-names = "ipg";
>> +			status = "disabled";
>> +		};
>> +
>>   		usdhc0: mmc@402f0000 {
>>   			compatible = "nxp,s32g3-usdhc",
>>   				     "nxp,s32g2-usdhc";
>> diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
>> index 828e353455b5..eb73a5dcebe7 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
>> +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
>> @@ -8,6 +8,7 @@
>>   /dts-v1/;
>>
>>   #include "s32g3.dtsi"
>> +#include "s32gxxxa-rdb.dtsi"
>>
>>   / {
>>   	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
>> @@ -39,6 +40,17 @@ &uart1 {
>>   	status = "okay";
>>   };
>>
>> +&i2c4 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	ina231@40 {
>> +		compatible = "ti,ina231";
>> +		reg = <0x40>;
>> +		shunt-resistor = <1000>;
>> +	};
>> +};
>> +
>>   &usdhc0 {
>>   	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>>   	pinctrl-0 = <&pinctrl_usdhc0>;
>> diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
>> new file mode 100644
>> index 000000000000..a44eff28073a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/s32gxxxa-evb.dtsi
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * Copyright 2024 NXP
>> + *
>> + * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> + *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>> + *          Larisa Grigore <larisa.grigore@nxp.com>
>> + */
>> +
>> +&pinctrl {
>> +	i2c0_pins: i2c0-pins {
>> +		i2c0-grp0 {
>> +			pinmux = <0x101>, <0x111>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c0-grp1 {
>> +			pinmux = <0x2352>, <0x2362>;
>> +		};
>> +	};
>> +
>> +	i2c0_gpio_pins: i2c0-gpio-pins {
>> +		i2c0-gpio-grp0 {
>> +			pinmux = <0x100>, <0x110>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c0-gpio-grp1 {
>> +			pinmux = <0x2350>, <0x2360>;
>> +		};
>> +	};
>> +
>> +	i2c1_pins: i2c1-pins {
>> +		i2c1-grp0 {
>> +			pinmux = <0x131>, <0x141>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c1-grp1 {
>> +			pinmux = <0x2cd2>, <0x2ce2>;
>> +		};
>> +	};
>> +
>> +	i2c1_gpio_pins: i2c1-gpio-pins {
>> +		i2c1-gpio-grp0 {
>> +			pinmux = <0x130>, <0x140>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c1-gpio-grp1 {
>> +			pinmux = <0x2cd0>, <0x2ce0>;
>> +		};
>> +	};
>> +
>> +	i2c2_pins: i2c2-pins {
>> +		i2c2-grp0 {
>> +			pinmux = <0x151>, <0x161>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c2-grp1 {
>> +			pinmux = <0x2cf2>, <0x2d02>;
>> +		};
>> +	};
>> +
>> +	i2c2_gpio_pins: i2c2-gpio-pins {
>> +		i2c2-gpio-grp0 {
>> +			pinmux = <0x150>, <0x160>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c2-gpio-grp1 {
>> +			pinmux = <0x2cf0>, <0x2d00>;
>> +		};
>> +	};
>> +
>> +	i2c4_pins: i2c4-pins {
>> +		i2c4-grp0 {
>> +			pinmux = <0x211>, <0x222>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c4-grp1 {
>> +			pinmux = <0x2d43>, <0x2d33>;
>> +		};
>> +	};
>> +
>> +	i2c4_gpio_pins: i2c4-gpio-pins {
>> +		i2c4-gpio-grp0 {
>> +			pinmux = <0x210>, <0x220>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c4-gpio-grp1 {
>> +			pinmux = <0x2d40>, <0x2d30>;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c0 {
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c0_pins>;
>> +	pinctrl-1 = <&i2c0_gpio_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c1_pins>;
>> +	pinctrl-1 = <&i2c1_gpio_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c2 {
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c2_pins>;
>> +	pinctrl-1 = <&i2c2_gpio_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c4_pins>;
>> +	pinctrl-1 = <&i2c4_gpio_pins>;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
>> new file mode 100644
>> index 000000000000..d992c0c9e695
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/s32gxxxa-rdb.dtsi
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * Copyright 2024 NXP
>> + *
>> + * Authors: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> + *          Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>> + *          Larisa Grigore <larisa.grigore@nxp.com>
>> + */
>> +
>> +&pinctrl {
>> +	i2c0_pins: i2c0-pins {
>> +		i2c0-grp0 {
>> +			pinmux = <0x1f2>, <0x201>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c0-grp1 {
>> +			pinmux = <0x2353>, <0x2363>;
>> +		};
>> +	};
>> +
>> +	i2c0_gpio_pins: i2c0-gpio-pins {
>> +		i2c0-gpio-grp0 {
>> +			pinmux = <0x1f0>, <0x200>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c0-gpio-grp1 {
>> +			pinmux = <0x2350>, <0x2360>;
>> +		};
>> +	};
>> +
>> +	i2c2_pins: i2c2-pins {
>> +		i2c2-grp0 {
>> +			pinmux = <0x151>, <0x161>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c2-grp1 {
>> +			pinmux = <0x2cf2>, <0x2d02>;
>> +		};
>> +	};
>> +
>> +	i2c2_gpio_pins: i2c2-gpio-pins {
>> +		i2c2-gpio-grp0 {
>> +			pinmux = <0x2cf0>, <0x2d00>;
>> +		};
>> +
>> +		i2c2-gpio-grp1 {
>> +			pinmux = <0x150>, <0x160>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +	};
>> +
>> +	i2c4_pins: i2c4-pins {
>> +		i2c4-grp0 {
>> +			pinmux = <0x211>, <0x222>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c4-grp1 {
>> +			pinmux = <0x2d43>, <0x2d33>;
>> +		};
>> +	};
>> +
>> +	i2c4_gpio_pins: i2c4-gpio-pins {
>> +		i2c4-gpio-grp0 {
>> +			pinmux = <0x210>, <0x220>;
>> +			drive-open-drain;
>> +			output-enable;
>> +			input-enable;
>> +			slew-rate = <133>;
>> +		};
>> +
>> +		i2c4-gpio-grp1 {
>> +			pinmux = <0x2d40>, <0x2d30>;
>> +		};
>> +	};
>> +};
>> +
>> +&i2c0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
> 
> #address-cells and size-cells should be common dts to avoid set it in
> board file.
> 
> Other i2c2\i2c4 have not it. I suppose you can remove it here.
> 
> Frank
> 

Correct. I will move those in the associated 's32gxxxa-rdb.dtsi' file.

Best Regards,
Ciprian

>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c0_pins>;
>> +	pinctrl-1 = <&i2c0_gpio_pins>;
>> +	status = "okay";
>> +
>> +	pcal6524: gpio-expander@22 {
>> +		compatible = "nxp,pcal6524";
>> +		reg = <0x22>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +	};
>> +};
>> +
>> +&i2c2 {
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c2_pins>;
>> +	pinctrl-1 = <&i2c2_gpio_pins>;
>> +	status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +	pinctrl-names = "default", "gpio";
>> +	pinctrl-0 = <&i2c4_pins>;
>> +	pinctrl-1 = <&i2c4_gpio_pins>;
>> +	status = "okay";
>> +};
>> --
>> 2.45.2
>>


