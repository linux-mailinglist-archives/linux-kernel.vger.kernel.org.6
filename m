Return-Path: <linux-kernel+bounces-285972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A07951509
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FB81C242CD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BADC13A41F;
	Wed, 14 Aug 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g0NCJj0D"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907E27446;
	Wed, 14 Aug 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619526; cv=fail; b=Pt2Uv4/s4bk5JYdUfBvmMFkvCpAC4bWvHVXQOFj0Ec438VK4iephv1pU7p4lEd1o6FP8xBrsrEIChxcjwN76oo8Mrr1EuRKEyGaLyfeQAQeAlmV36SvOnu7pg+gokKLiVuXScBzF/6P650O9ptu+a7xe77mgNshmdtAbGgB9/Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619526; c=relaxed/simple;
	bh=4QOqJJLnfv8ouX7O/4zErPM5tqef4eMaufc1YBSNqYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/Rxl87OILwd5bK/o9EXzhjyp+tX/YqyYUE5raGLi+0/tN12QwOf4eXpIFsGzuqWwpKZttSeF6wGEVSgD9oAP+XHurBfuy+u44xXiBdL+MXgLaozsglZFeJpKi8gqJ/HsZvs4wLjmACF/1jGoTRQEkoOYM2XAl2fiTCm5Fh0t1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g0NCJj0D; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O55aplCX5byoso7qpazbbviUJ5r/PSBMIQ46ORiOTkoQql8s+cZesnmnx4H/lPUlgc9QgIlzcbEulPEUQvMufEcYYtw+GIzJirJScItJLzNxoo32tKDvjS7Y0lFDR9T7YcpeFphNo0jDPmF6zDPJnoNLxWXKTes8YMJmvn51gW7DOd64Duh7aNQT0PrI6S5z+o40ABRjxuWT53jiA0grJ9f1dvIFbJMY2IyugiIGFSLXmKY8alZHnmQmKKkeq/Nl5/eszErYA/e9s3XRUvVaB7a7eWEZhHWnDAIMfCdKSBF7TVw+xWeCf3DBwnzEuiUdueU3dfTleE+2Dde1CbfLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR2RixZUeby84KFgLIrwXIFkeLDNWTjJWOrqFT6buqQ=;
 b=o4faniuN1mvna9ylOtzAyFdgfmvEd8JzICm9tbu04RQD5ZaQnn+RqjIRBuWcsvJlXMEQ0jROzqor9S1alzIeOX7o/hdJDhqY3XWD/wyjMtVZhwfF2OR/AtjVBC5N+XMwBlcAxRPUuAmRuDM+V4QOY7T0tc0L+2avlPDPAvMGiRIPI0zrio5AfW/9na9L+AU1/JCDErRqzyGVAEVsums8sxa0Eo/y1PM8hzf5fptasePLj8dDEdwRIhycWNA1hFL0KokKp+A0IiV4OD9Pyc12rADnUEp6Q0a1G/AJoWwZcLjJ9NOQ3Lyp29fFtMwSGrcrTa9l8QPDU9geYeptqZKhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR2RixZUeby84KFgLIrwXIFkeLDNWTjJWOrqFT6buqQ=;
 b=g0NCJj0Dxm3rGg0g6byBr09VTdouY3npK8MMVsMtCtMNeAiKruPpQ67RjXmesgSmFQOkoJt8RKBupQ/s2j4UDESQwwLllotKBF9sOhMyhrw04DOz7/AxjcWM2W2cHjIW0NQW7stYfTyrz7eAh1w4+LU6u7KGYqiOzyS89ZzeGBhrL2umn2+gJrXMeuSRvG5fElQms9Jd/yqRHw+f9WYIVeRXtWdEd8GYgqWP8qc54RJU8OIFjRRpBSlmyq2XD0R6tqMGMqxSBzXPfYvxos4rbZ9uA+KHktpQDfDAtpH7j63yrBiKsqdMA8VA9rHaqe9S1ndn00GoekKW4FM1vSgy4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 07:12:01 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 07:12:01 +0000
Message-ID: <22c7155f-0f94-44e4-be06-d3f2b9001894@nxp.com>
Date: Wed, 14 Aug 2024 15:12:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: display:
 panel-simple-lvds-dual-ports: add panel-timing: true
To: Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20240813145021.3864787-1-Frank.Li@nxp.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20240813145021.3864787-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 26468005-ec93-4955-783f-08dcbc30649a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1lOZTFDNVE5elZpWVoza1NjQ3FGYUZwNzdiRE1VbHZmdDB0VzNKWDVCUllF?=
 =?utf-8?B?Z3phb3hCS2hEUW1qYTRHQzJuRFZoUm1MTHY5MmhobGk3TUdBbFQ1RjNLYTVq?=
 =?utf-8?B?Q1lGRXhxc2thdFVET0hkbm5SL2VPOFBmSmFNVDhIZVZsUzBQakRDbjNaUjVz?=
 =?utf-8?B?dm9EZkF1Q042Y2ZJZ1RvSUdBTE9ZbmxrdkpESTh2MG90WjZRb0RmNWpYd3px?=
 =?utf-8?B?RURjY3pWZHQxVUdoTFZpb2FPc2tsRUVobGx4aktrUUVrczNzZlNaT3ZseHlp?=
 =?utf-8?B?YlFXRkVzSnJpa0ZYUU12Z3BJdUs5eUdPaEFoaXdHb3pTZmpiNjRjSy9QaUU1?=
 =?utf-8?B?dWRBUUs3M3RtU0I2V2JsVU93YkNFeXBjaHJDbTgvQVVmOSt0K3RvdmJoUUtP?=
 =?utf-8?B?Smtmd0U0UmtveE91dVV6Um5uNnBORXBTbjZ3OFJLSERLYjZtWmhieE1LOEFr?=
 =?utf-8?B?K3hLdDIxdVpHU1c3NGp1Y25OMVRTU1o1N01POTYwVEVsWU1oUWYvSjVhalNy?=
 =?utf-8?B?NnpmS1pHL1Y3cTRyWFQ1MHVidlVxbUFZcy9GNWFhVytoYldoaVdjbnpCbm9y?=
 =?utf-8?B?eUhPZnBsenRoMi82a0E5MmIyTXNsRFF1OFVONGlDa0EzeUFVdVZLSWhldTZq?=
 =?utf-8?B?R2lDQzJrTllOK3psRWRHTVg3Q1lPOUc3SHFMT2MzU2gvczZpaWd5NndrU1Nz?=
 =?utf-8?B?Wlk3YmVzNTh5SEZaN0RjUWtGZ2YzNWtLOHdhczN0S3o4RWt3UVpPWnlyLzZv?=
 =?utf-8?B?THorM1FLZytjb2VxY2UzdlU4T3Uwd00xTlQyV2VvOFhvUTJEU1l2aXVvRjFn?=
 =?utf-8?B?QURhNWEwL1lOVGZyVUpQYmNrZ3ZKWmZHNzNBR3BXdUZpY0VuZHV3dzdzQkIz?=
 =?utf-8?B?ckRsdzQ5aDJDR1lYOEJ3bkw4TVZXZ0wwKzdWbE9PWTErVEN0TGZhMU52dk1K?=
 =?utf-8?B?bXF2Y2lza0ZMeHZiaEgxazVLVVYwaDFhZ2hLOEYxOEp1Q242WXRYQU9BWVVU?=
 =?utf-8?B?cjFZOHc5QjFYb25oclhydmk4NUdiaGtscy80cTRXQnk3bFY3bUNWdzJGemFL?=
 =?utf-8?B?a3FmTUVoanMvQlhMTGEzVHJWOXAxSXpYWWRwZFlCcWEzbWNSSDBnZnpOZ0pr?=
 =?utf-8?B?STYvdXFNTDhYd0d6YVF0azhTcmczaWErdmkvckpmOWEvaDJLSTVsUmEvRlJS?=
 =?utf-8?B?emk4Ukxmc3BFdnVacEdoR3BBcDAvRWh6OGtPNmRXRThIaEVCQkROV1ZvSzVQ?=
 =?utf-8?B?TFRKK1ZNWnJtaGVlK0VVWEwzRGVoZU5ldFhBdnVUbVFzcm5SVW82K0Y0d0ZG?=
 =?utf-8?B?T2pWTkVteTZ5QmVsOEZEVVdnMzlYS2ZXbUF2OWt5SkFlTW1YV3UxT0FycmNt?=
 =?utf-8?B?YWhOSEhzTG9vRmFEb1V5eTNwaUxzZ1ZSZkJvb0VERVBpMFMwUTcyYTFLbEdX?=
 =?utf-8?B?VVRpd016L3FiSXV5NGprV1NBVEZ5S010eWxZRlRISDYxL3YwdzNRV3FhU0pj?=
 =?utf-8?B?M3dqUWdacDAyLzlaUjQ3aVcvQytCRDFCV2pCcFZydFBBWnprY3lKTlRvRnlH?=
 =?utf-8?B?bytkOGMvY3A3L3QzZHNHWVBhU2orcXNRaDEwSmUwVFhEb1J3L0tmM3lyWVlS?=
 =?utf-8?B?MndlMit6dk9IV0FnNjZvSDJuL1BLcUdWNUR3eWdLRWRPM0tVeEU0aXVnM2Vx?=
 =?utf-8?B?SHgvS0VRakFNWTg1dzRmVjVzUFNKWFBqam0zM3dDUWlzVng3bnJFR1l4Q0NZ?=
 =?utf-8?B?a0t6dk13UjI5bXo4Mm9yT2JaUjJQVGpZa1FJbWtnMzFRVFFtdlUwd2k1T0V1?=
 =?utf-8?B?eDlLZHg2cEZISHVhYXVuQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmtveWlDZllUR0dvSnloM2QvT0NRNkZXRTVUYk93UnVjMG5xVTBwY003OEtU?=
 =?utf-8?B?dmZuNXZCVWw5WEY1dnFvb25uOFVLbWkydHJBeHl6V3BSd0p4Q3pPTHZqOEVo?=
 =?utf-8?B?clBhVlJmZGJSQW54Yk9SY09sQkVxSUtPUkJQWGwyR01ZSW8yV1EybitLZjNY?=
 =?utf-8?B?aXlabGJlTTVoWjlWTXZIcSt1WXJNL3dtK1o2Z1JteW5mMzNBVWlRUGVKTnlt?=
 =?utf-8?B?b3lsSHc2RjFoUlp4ZzZGa2dMYVgxeGxnaFJzbFJlSEczZ0VOcFF0S3N2cjNj?=
 =?utf-8?B?ZlFtcUdiWHFrVWJZZmFZRjBKdUdvZTU3TjNXZzI1a2FpQVV2aUFkd0JtMllD?=
 =?utf-8?B?RXBVY3c4V0h3Z3ZhSmJpUDBsc2FjQzhCRzRVUVJ3UlJxN0UrYlNvdWczWThK?=
 =?utf-8?B?WG9ZZlpxNDlJR3pONk1PbTl4SU93YjVkRkxFMHA4aG1aNGdWR05BREZwWC84?=
 =?utf-8?B?MndTaVMwTjVVQXVTZUxXZmVDemc1QWErZ1NiOEFmbGIwNkgzeXl5S3M5UTlk?=
 =?utf-8?B?UWwvSE1QZzNoNDhmYXp2N01scGlUamdCdVpnSDBBbm9YTFhsSlJSdWphOGZT?=
 =?utf-8?B?R1VXWUxlWGtsdlBQcmxrRjIvL0VyVzhXMXRnVzRqaHhjbm94a0RjcFJHYkgz?=
 =?utf-8?B?a2xlL1J1ZysxYVpzNTkwTENTb1hybzZCcUI5UnZLeDBQdDQwQmxkWEJidVRm?=
 =?utf-8?B?d2RrVXF4R1I5aE9SNCtwVFloU1VVT3VkczhMMkdZMnRyT09keEFiUVJSMmNE?=
 =?utf-8?B?bHZTbXRVYmV4MEdyMVRydzEvTHg2NkRPVVhaeTRzdW1HNDZ3V2lBZW84cXNM?=
 =?utf-8?B?dmlzcEYzbDFGRzk3TktFSGtzbnZ1MzdaRHRSanI3ZHpINHQzaHdpTkVWUUZY?=
 =?utf-8?B?Z3ZHWkJEMXliZk9IRjJOWlVZblBHSitleTJ4MnlXZmlkTUxtWVBXT3kwRmRI?=
 =?utf-8?B?VitxeHdTZzZWTy9zYTZDVVRpbExqd0d5VE1OeW1qMUNMMUZlYnl1ejREMUJ2?=
 =?utf-8?B?M0lta0N6NGdNTUdpRmFBZTRRekg2MVZRdHQrRGZQeXpvZmMvWnlrRUNtTzdG?=
 =?utf-8?B?NzFzc0g0T0llSEZNTzdPbEV4ZWdXMEhnSmlJSnp6S3MzWnpRWVl1enFaMTJK?=
 =?utf-8?B?dlRMR2p1L3ZFb1orYW85T053MHhXL3J2L0d3M0N5VU96VWFzbGR0OFRvWHJ3?=
 =?utf-8?B?dmNvRDFRT0tQNW9pVU5aZ0RrM2FuVkdwaG1NOE5SN3pVTnVPZ3RhTEFkRTVH?=
 =?utf-8?B?V2dnKysyQkJpUWVQS3psUkppdzRuZk1ZaFpOVVl5RlpsVEI2YkxUUGpCY3Y5?=
 =?utf-8?B?MnFuRldScndNTUJKWGNySkVvNi9HYjdqT2tlaXV0Z2FaL2ZYQmduZHFRdlFo?=
 =?utf-8?B?OEEzUXRydWs0Y3VRUUNFWlJmY0Era2lha2F0QkkzUmxIOGxoaVlkaUtxaWxl?=
 =?utf-8?B?bURDV3FtWmlXYWVtKzR2Y2FFamxBTDJTY05lTmVYUml2cXRkWVhWMGJHSjBn?=
 =?utf-8?B?dWd6TldjTS9VZnFRTEZtSGY1bnE4eWtCNWdMUy9vWUozMnhFRitZd2FIZWky?=
 =?utf-8?B?eXVtSEt2S1JpbGxFSmJINjBaK3VBbGZmNkNya3ozK0YwV0tKN2YrbkhwMnJt?=
 =?utf-8?B?eVU4a0pUSUtCSGlReTNadWUrQWV0ZVhnckRwa1B5akszM1VqamduUFY0Z2VF?=
 =?utf-8?B?ZEt2QXV0NDNmMXVwQzBLeE9Ndm84OFFCMGRLOHBBRThCSzB6TlR5ZFlpT0F4?=
 =?utf-8?B?WnFwVHFOZUtjNXovM0cyNjQ4NUhhdXh4eHFORWdwczVPZkYwREFpOUppekdl?=
 =?utf-8?B?d0ZJanhVNG5tKzJDTUt6TGRpOVhRSjVjT1kyS3pIM1pqYzBuZnlzZDFzVjdZ?=
 =?utf-8?B?Y2UrditIRkxGaStMelJId1pNM1JVVndVdGNsRjA1ZzFvRTNQU2J5WjJNcVdn?=
 =?utf-8?B?SGZ1dWs0ZFViVFQwSGpSMzBXN2p0T1FmcktxeHJnMHUzVDBKYkRtSTV4WVg2?=
 =?utf-8?B?VGRLcXNpWk1uc25kY0VpVk1nZXFMd29NbXJpY0dGYURPeGtVUWtNbitBdERl?=
 =?utf-8?B?UTZCQUFYQXFzZ1ErY08rK1o5cHEzRmxDZGkxN2Vtc28xS1l1Zmg5ZFA2MCtL?=
 =?utf-8?Q?E4/PTfjCMm/5ECFZUJx5q6OSY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26468005-ec93-4955-783f-08dcbc30649a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 07:12:01.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2VVOSUhIE2koc5YPZ43ANB2CJskXp9HEfJ4ONvFLunaoJBeUBIhkRa1J79CNLXTH4gWYrr4CvZD+V5dcdInkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9080

On 08/13/2024, Frank Li wrote:
> Add property panel-timing: true to allow use 'panel-timing', which defined
> in panel-common.yaml.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtb: panel-lvds: 'panel-timing' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/display/panel/panel-simple-lvds-dual-ports.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add panel-timing instead of change to unevaluatedProperties
> ---
>  .../bindings/display/panel/panel-simple-lvds-dual-ports.yaml     | 1 +
>  1 file changed, 1 insertion(+)

You may add:
Suggested-by: Liu Ying <victor.liu@nxp.com>

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
> index e78160d1aa24c..1f3222d532787 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
> @@ -87,6 +87,7 @@ properties:
>    backlight: true
>    enable-gpios: true
>    power-supply: true
> +  panel-timing: true

Nit: As I mentioned in v1 comment, this can be put next to
'enable-gpios: true' to sort the referenced properties
alphabetically, like panel-dpi.yaml does.

>  
>  additionalProperties: false
>  

-- 
Regards,
Liu Ying


