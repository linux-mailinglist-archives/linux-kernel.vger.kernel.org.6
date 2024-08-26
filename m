Return-Path: <linux-kernel+bounces-301416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01495F050
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E303BB20B28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816916BE1C;
	Mon, 26 Aug 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vsWkOYRV"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0E15532A;
	Mon, 26 Aug 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673710; cv=fail; b=P398J1mChJLRi+ReyDeb94ET8/YKZFKAI1PvXRSbZt+oQAUN01DHvOLwWzUmgh7YffhdE11z2D4d6xYlujZIrq0ETU9OmyjHaF7yFZFvBkQ0PEr0NTRH0mNfnIYhskk7wWWrkncaN2w4IXkRyAvFdbi6aRDAgU8EJLvQGAcV5Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673710; c=relaxed/simple;
	bh=L0KtCgVocqZg/XbMaNDNRZgUcuJGr+L5MbgElQPl36w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WWdvovmdP0tjsT+P3Jyt08bOmjfXRjiwf1KeHOm9J/HUHXLcgnY4XA/gC5T0fumsVe/3lCQSYYJFUmqyZHjOFC231Gw+52ncIX0P7IwKWVVygPI2UTz6pRvoPJi5RdcUiU8BH1Vr7LjNZ1nwU3aIj8+6TKxptCmHKlW3hTNrZnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vsWkOYRV; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFD6G0mdh34nLNGFyH52oiWDArzbO/AWXZAvqDlPvdOMRK8nj0WuVpNOvnUNenw9+mh8FsVFTN4VvrUtZY5dqizA7fmEZIKxlg7E9jyK970xfYkAcAX1Avr3xAtKzfchFMq+KuG+qa8vZoBfD6S1c4aaoSMg3n6/Bn05F9JOpGyA0ggTVmZy8LE6l0757/zKJWV23swVw4B5s59WzlCO55rYBhFetkK99XWRwUjx0vX91L/vxjKaDkWau6EJ0wJPOKYR7aF9Kg0SUYDWUfdvGX3bEO5ua3E76hTGo0X4Uc5wEzKgdsPahc18nhVgW/Dd/C8q8DHWUs09lZKCqX4BKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSW8GU/rrduiNAYwgb9R9cq5Fo/DJ4fSHqs8Wo5LSBE=;
 b=ju93OdeI7Veyuij3S7efYJ1ZarX7d/TTwDOFT4vm/AIo59IJNiYo4zwOob1P+cz9BH8EXCNN5JGEhZZRugaxGggIDaj0Xa7HzHlrryFXm2TsqaxTOnGs29N7/3WN+jLTr0Uwicc0ePLfOPWNLR3SLPZecZ8r46aug9aJmDpy/rR313/AyY6XnMZPi8K/P3u8vDr4V7QNHdWp8d5nvm+2dT/ARChHslgb4h6+c+Qh826wiTJaE4LMMHp/IqJAfi5g6hk1EaZjRPLjxX+kVx0PD0KvRw/Rrelvm71oWUBQSusBJneuMG7HfsDtqbtOmiW4aTlp7PLphRdgrNBGYlWuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSW8GU/rrduiNAYwgb9R9cq5Fo/DJ4fSHqs8Wo5LSBE=;
 b=vsWkOYRVg7AOiu0Q6kqgDK9HIZ80fgVLOccdz7rkZFZs3gJRNkHGrQTV6miIhI99LXIdpyIdwIS3V8Obvxo2EQLpFG5KXJgMn8N/PMF8N2qn4QtXqRVf65Y9VXryWKTHTi5yOteY+lEcfVks53w/bNCGH48Edmkz/iRSbzu13N6hiVSvBTQLDHuiQHG0ZJA9bkUVa3NMqOKO8LFKhRICZGNqiol2ccg3e972W24IuLoJtR0VhWG0pEjHZd4K1Q7IyV5Xd5EYonEsspb8c8RGapUJhoSdIAeD5VTqAWn8UHjryIqUbSZzJrAPA/9b6S7AeFXJmMMBmwxiQxTQaVgw9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Mon, 26 Aug
 2024 12:01:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:01:44 +0000
Message-ID: <7ee8c6c0-3e1d-4262-840e-435407521324@siemens.com>
Date: Mon, 26 Aug 2024 14:01:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
To: Nishanth Menon <nm@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
 Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
 <20240824175825.bedufmhfkx4btv5n@anything>
 <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
 <20240826114259.ynxf5a5qwbm2co4u@press>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240826114259.ynxf5a5qwbm2co4u@press>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b23542-dec6-47b1-214f-08dcc5c6da88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtYZUlXS2YwaElQNzRYZnRialIrTUF1NnRkZFhQcmJWaVJObWNVUjNidUFM?=
 =?utf-8?B?dUVPaFhZMzVDSFYxa3I2WTR6VGZLN3RFbW4yTUZ2ZEJSaG1YZUVFZGl6U2Fu?=
 =?utf-8?B?bCt5eXlJdFpvOVJVYUxJVDlUQmZaN1J0a01UY3hVMy9TRFRRUnU4cnFWbVZm?=
 =?utf-8?B?RTFLMWdBUVFNWXhHQ3hrc1FucjFaRG1QWFVXYVBISHRsNU1qSVNlMzBSYk8z?=
 =?utf-8?B?cDNLbmdJOGpKN2lVMzBXc1VKZ0RTWmphTFhyeDJYbnU0K2lkYW56Zk42SUZZ?=
 =?utf-8?B?c0tvVXNwNFY3ODZOWkoxWEpScVMybW1zNTRmaGRYaExLNmVwM05tZHlScmhC?=
 =?utf-8?B?MzFLSmdIR0g1MUpMZUxLQ3A5ZlJBakpMZThldE45NkNmQWluWTA4eWUvcXZ5?=
 =?utf-8?B?b2l6dStLdnB6aFJBRnF1VUswT1JnYzFiazlGdG5RSXhQem45eWlvSG1FWTdR?=
 =?utf-8?B?a0ZSR1IrOFdSSmd1WHpVMEVYa084TzJvS05FSWxsYzlzbWg4QWVaS0FTZDJs?=
 =?utf-8?B?OStJcFV6MDRpbVYydURWckVyYW41NVhpWDh6Q0Z0T3lDbTRIZTNRM3VXZDlQ?=
 =?utf-8?B?K0hxQ09neHpxOVQzRWV2MG9DWUdReUFFeWNDa1E0RXBaR2xyczBValNUMUlP?=
 =?utf-8?B?eHAyRm5PN3BscmFKS2w4d01TL1Q1YU9XN1BocERHZXBodmZna0F4K3p4bldZ?=
 =?utf-8?B?S0NVeEQ5YnZqdGZtZ0E2OTgvb3R6YlVjQXlzTFpsWDBhUHZZYVRQb21hRFJS?=
 =?utf-8?B?ZmlkT3U5Ly9HVVdlVld5ek02NHlVT2srdlgvWVZqcFdIZ0dZZFFveFUxdHd6?=
 =?utf-8?B?MG9oOWtMVUZLRnJUampIaVEzdmU0S0VwOWk3akRYRzFSM2RJTFdla0NBSVlR?=
 =?utf-8?B?TTBYeFRDVmFpWWlFN1Njck9kdTZiaFIxdEtnTHBBZDZMMEZEVG91OGtuYzBX?=
 =?utf-8?B?UzQ5RENDRVhBQ29OZG1JMzdkVlVUTE03TkNjY0lQWmExRjQyZmVvSms5aEE4?=
 =?utf-8?B?YnRvaDNwR28zWnBQblNMbXBvdHMrUWVzWmk2amZwSFpFbk5mS0NqZGxTVlE5?=
 =?utf-8?B?TkdmKytVTDdOSTZabmxtNDk4UUpXdnRTcWkvNWI1cTF4dDdoR1Jhc2Y3RTR3?=
 =?utf-8?B?MVVwZ1dsMVhuTmVkNUJFV2lmZFlXQ3JnZldqbUE3UnM1aFk1MFdMcmg4S2tu?=
 =?utf-8?B?Skdpc3ptTTNFTDNSNGJGTGxkem5aUjQrNzFUQTNFTFMvQktnY21GaHVkWDdy?=
 =?utf-8?B?YTR6QTZYcjVGb2Voazg0Z0N0RERONGtYYUV6cE1LbVVPVit1SUxwVVl2dG5w?=
 =?utf-8?B?TnY5dTY5ajZZZ2E5cXI4eGJSWTVRbjdEV2JCeEQrK0VYbk52K0YrZU56ZnNi?=
 =?utf-8?B?TWx3TUhBeEh2Zkwzcm9pSE1PdUgwclJ0bDB6dW9ub2lTbG05ZDRxd1RHTDNl?=
 =?utf-8?B?NTNjcDRKaEVMQWxMSXpOa21YZVdDSDVlK0VNZkV3TW5rZi9tdEF0MDNlWTEr?=
 =?utf-8?B?ZFF2OFZYcUYxOXZvUWFPTTFoOVM4ZldVanBVbnk4QlM0MHZCNlpmNDBrc3Bq?=
 =?utf-8?B?WGhaSDlPRkVqVjV5dlRIelZkY0hwdnR6enNLSTlRMnZNUzIwV29IWnhOR3JW?=
 =?utf-8?B?NXFXcThUZUozTnlKNjluMzNiYkZMSkFvSVhjTjNhRDhCYVNoeHJhQjVsUCtG?=
 =?utf-8?B?NUlNL2NqM1BsN25DN2h2bUJhSW1md2o0SkRRbElCSkxWWWdRZStoWFJmam84?=
 =?utf-8?Q?sG13wWShao7nDKo7KM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHFlQ0pYQmxLN1VQcGdMaXN5VmFPbTlxTS9YUmluRHlFS2dCTlVoU0x6M2VK?=
 =?utf-8?B?NGZIeDlRSW4vZCttZEdTbStRMVlRWlY4M3pqc1k1R3BUQ0tVcEJLYXB1Mmlt?=
 =?utf-8?B?dDcxTXQydWVFcXAwTU1QWFpiN3FGbFRRc3JQZzhseXcraGl2MVdremFybkRv?=
 =?utf-8?B?Mm4vV3Vkd1NMY3NBMEY5bm83TlRIMFpKYWpkRDFiZlMzTUJqaDZZMzU2V2V5?=
 =?utf-8?B?SFJKSkZ5WXNoOHlMUWNLbmhRaUErN0FMK0xnUmlFMkc2SmYrZkZ5cDRSWFlE?=
 =?utf-8?B?aXdIYUpIQVNYa25zOXVCR1Q3eVhha0NIV1RtQkViNWxLQnFxUnUrQmNYTjdO?=
 =?utf-8?B?UXFhL25LazNyNjR3M29LMVR5WDZOTDJsMm11dFA4SlNhZHRETHlQYlVCdVlU?=
 =?utf-8?B?MjFkMmtyOGI4NXdpdjR4eng3QkhUaWdaZFJKaUF0ejhsT21EckgxelM0aTd2?=
 =?utf-8?B?NGJBYjhqVFJWR2FhbGoyTlNvT0I0bzlVcjM4MlRneEdRa3ZVVWI1RTU1Vktn?=
 =?utf-8?B?b1FheEp6UGd3WlV3RDRndDFqeEdnUkVJNTdSVndTckhhcE91ZmtiUnRkdkFY?=
 =?utf-8?B?Q0tJb2ZEMnBnNlpMY2lRSUpLNWhuQVl5dlhDdnpXb0tKSHc5bVN6SmNMTVY3?=
 =?utf-8?B?QVN3eU5FWUVPQ1liY2d1VGU0SDVXKzQyTk5aK1MybGYvTThuOGw5U0JROGVJ?=
 =?utf-8?B?c25xTnRvZDRtcW4vcjVncXRzYW5QZHBlWXlaOEdCUkliSmhkeWZGaHNhVUV5?=
 =?utf-8?B?MEZnT0dmUFBBb1kvWWVINWZrWGkxbjdNQmtzdnVLYmpWZjFJVFNyR2dySFc0?=
 =?utf-8?B?Tk1EUitrb29iUllCR0xpbHVhUHdqUDVud1FuWDF2WC95YUM1Qmd0eXRSazVR?=
 =?utf-8?B?LzE3aStEK1FPdFdrd1BUcWIrcFBEWHhha3pRdG9GSHZFaHhHYTd5YmxUSDZ4?=
 =?utf-8?B?NDVOODNjNExoME9Dd2xBMng0ZkdKSCs5VThvNGdWRUpGaXM5WUV1cytmUzZN?=
 =?utf-8?B?bitFazc5dloveUwwTDZXWEUyVnRxdzhWQUpuUnlPR05QZ3ZDaHgzMUl6UVhZ?=
 =?utf-8?B?NEJoTmRwT09meDVPNElRaHVFZmpwNzFSWTlsMW9VV2gzbmNzdC9nRjNGN3Vr?=
 =?utf-8?B?S0UxeXp6QzJYWnB4N0c5WTZZZk5SOFc1N3RJT29DVG93dXQxbUx2QkNucVRZ?=
 =?utf-8?B?angxRFlXelUxMHBTa2VhUXVVWkxkcnhreWt5NW1zSFQ1VmJqdzlsZkJteFZx?=
 =?utf-8?B?eGVocm54R2FCQUJubCswdWFWbEhZWktSMmZVZmRtRTF2dkZmYnIvRzZHRjI1?=
 =?utf-8?B?azZhTkErY2pxV05STTZKTi8wK1JicmphZ0NCditzMy90QVdHVW1nVDFiak9Y?=
 =?utf-8?B?Z1ltN0E3WWVzdmZERFdGQitxQmExQTl3elpYVWx2V0ZmbWlHSm1FMW55eFhn?=
 =?utf-8?B?YzRZb2VOVlorUCtMWHhYaWVTUXBIblZkakZyU093dEpOWSszUzVIWndnQyti?=
 =?utf-8?B?RThxVTBZd1lldlY5QU0vV2lXQlJpRmx0N3A3R2E0L215dHl2SWxlbWVIMVdu?=
 =?utf-8?B?a0x4a3hLWHdlS3JKdEFDWUZRYW43cTJlVXhrRFlLMG0wZXU0TUVuOVhzWkJx?=
 =?utf-8?B?S3g5RUhyRWdLTVU3MGZHSDV0YnU3cXQ4QVN6TUVXRWlmMUFKcG0ramtXdlRK?=
 =?utf-8?B?MnduOWJOMzBCenBkMUFhRnJIcTN3b0NhSjhEdDFHcUFZZjFORzR5d2tkZEpX?=
 =?utf-8?B?MEgyYjIwV1U2cC82enNmZElpQmk2NWZKRE9md3ViTldmbEVybTlnYWdQcXpa?=
 =?utf-8?B?YUhCSHRpT213RlpERmoxWWdKbmREaDhRYUV5VUhmcG05Tm9mUWNXL01sZmN0?=
 =?utf-8?B?aVExNzBldzNMUGNjd0RzUkExMHBPZ0VGbmxRUjVGWHRzQkl3L3JBbXJ2akxz?=
 =?utf-8?B?cnJYOXlScVptbkc3djdlUVViTGlyUnhZL21iaUNWSHNCaFFXdGxFWUY1YUV1?=
 =?utf-8?B?UXBOTzN2Z2FRSE9DQVJVMldiOUE3Sm1yb3EzVTA1Y2Y2SXRwNXFtTzE1Y2hW?=
 =?utf-8?B?QVFhamZYc0lMZlVwSzJrRVdjTjB4ajJ6dnY3aUNlNHBsOHU4UjRBZDNpc2pn?=
 =?utf-8?B?UW9qTmZ3aFRTakJ3V1RhNmk2dVFQeDZTK01tUEF6L3BpdjN6ZlhxRFBFa0lC?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b23542-dec6-47b1-214f-08dcc5c6da88
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:01:44.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9uhQUuVq+p5qY4hEk4DRHYf/TgOQ4uWh9wZtw7CiDdbWago4ie7efRoJxUciSyNq0TV8S/6bgW00W/uCJRGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7007

On 26.08.24 13:42, Nishanth Menon wrote:
> On 13:31-20240826, Jan Kiszka wrote:
>> On 24.08.24 19:58, Nishanth Menon wrote:
>>> On 18:37-20240814, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Expand bindings to cover both the MCU and the main usage of the AM654
>>>> system controller.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>>>> index e79803e586ca..cb9da3ec39a8 100644
>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>>>
>>> As per linux-next, this file does not exist? looks like you might need
>>> to rebase on latest next?
>>>
>>
>> "This goes on top of
>> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org/"
>>
>> Is that series obsolete by now?
> 
> This dependency information would have been useful when provided under the
> diffstat section of the representative patch. :(
> 

Yeah, who reads cover letters? ;) Will try to do that next time.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


