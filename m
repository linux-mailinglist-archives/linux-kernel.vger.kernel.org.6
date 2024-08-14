Return-Path: <linux-kernel+bounces-285866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF85951394
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990A31C22FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF90F5464B;
	Wed, 14 Aug 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ECk2gOaE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB77365;
	Wed, 14 Aug 2024 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723610987; cv=fail; b=jZNJgel+nllovVOxuCP5/PwyaboFvwS3+9iVulM9pH/up/TPQXU/pVD34bJuYNkt7+BN7zp/7UzkL9qqAsZ1O2DMBb7RFzhXDgzBq5HlYIdcoHyrIBwZ2mUCunGzwpnd2Rd+2eGhZN1Atcb/8sjtnUCMrK4PqXXasWKRqiGdg2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723610987; c=relaxed/simple;
	bh=sYu21V4YI6usgHLDclFV3FPQtMD9yFdBNWQ4evbzfsY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FdGf5lcb1014F+ZQt3jfvC83oSE9kfsiIkaZjeasLGSPmkp07EsyajIqhy5tR/hmuLkeaHTiTKxgu2yMOZFrnHnB+CgPepCIboyxfm4en/ZlblvNomLaMoFV2lmRBgtkKtQ72U7wI9z+M30AiF8Es99fgjxGBCGb5OqoyPzqOvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ECk2gOaE; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQV6xVOyDLgmAow8yX0axQQtm6epRSwTCuynvmEgIiwE+A4BlZaB621dF7lVR+AffOFrvJrxf/VbeorqUyg0t7AXl6rYkvwnzqRnZElSorZE23soBI75la6OEiUlBBakJLJ7/w/WZy9mKo2IihtrcPMLViFvyDRORPggMban/qhW8QKvYDnFLaTJh3j/1bzfgTn2bZQcMfTYiQzW+Pp8F1sozywvgKtP4Ykx1UuEyeCn/6i6sOpkpQB2UNjfzSb1icT40glDzDig9uFyOZpE8owoVjc6P2QhfbadIKFOoKFvCwHc4bLNJ7oIHwTLdQCAKmH18KvlaHs8I9HDQp4C6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpReaHoW/uumWv5zRf7XbvUxRJWUxwcWQJzEKvpbguI=;
 b=LKxyr0yy6riJwY5M7srvMOq7qRcPj+wXksMzFdytXABub9bOdJEYtancyyEkrnKniGxrwKte4joF15tnHh01uiQ0QW/jFVNEQj+r9lzOz0DjZrMFTCbmkVFr6fJtYyaJQle1OFMyKGdA98nVw24xLapHMT53ruzByxTpM7A06Yd47R1AFCtZpJN3ny5DBBQVnenRyqockIKibbw07rCmmtmKFi2QdN0DOmHFIBqegT1FxD5z+48+vlgAF4eQ7sCBcqU4SByZVv9B4ZumX0Np/AsDuvFMRBKfkKOJ7eB+F/p7vNf83G57WRk8MKmQRVTCXMRcj/Gd0uYh0SbXxaYDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpReaHoW/uumWv5zRf7XbvUxRJWUxwcWQJzEKvpbguI=;
 b=ECk2gOaEOvaxSp4vLRy9W+kPBURjpujZ1NedLxIJmaRvSdCtxFljCtJBOOOo6f4LVWNE+2JZY06+ZGKiaNdFeswOiL3AFSQJZ2q8wcPu18p6ez/+Mx74AT1vlnNfapDtsjItqleWTKvI+Np0oorlps9H+LKvBsRUq97j+rIXN1DUi61kL7NV59yl68ltYhKxB4uSgK/ayUbh7Bv+C0vBkBupnd7WQdCaQax9vDnTKbzARvMnHxTlKcAjX8iQBxXd07MXI8k99Hphy9uVJ1WSdVTLBN4Gh7x1J67Ph4JNewUMlK81FcTFTQhLQxs4bnM47o0k8cy5JqlG17WaToK86A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 04:49:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 04:49:41 +0000
Message-ID: <a838d867-def7-49f8-b9cf-9f4d638ff2d6@siemens.com>
Date: Wed, 14 Aug 2024 06:49:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
To: Conor Dooley <conor@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bao Cheng Su <baocheng.su@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
References: <cover.1723529100.git.jan.kiszka@siemens.com>
 <ac1622c04e5ae2bb80075e70dbde23abc2f3a4b5.1723529100.git.jan.kiszka@siemens.com>
 <20240813-outrank-mumble-8dddbfc68586@spud>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240813-outrank-mumble-8dddbfc68586@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfb499b-2751-4c1e-d3c4-08dcbc1c82a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWx1Z3JoZ2ptVHk3UmZaWTYyekplSmFDMUMyM0h4S24ySnN2a0dlR3JpWTFx?=
 =?utf-8?B?czd3SWgvS3BybFdaY2hrNmxsSXhaOHRZTU1pc1ZnV0duc3lnZmk1Y01wZUc4?=
 =?utf-8?B?dHA2SGhPVDhCeG50amE1UUZjRlgrdW1OQ2N3SWcyNW4rNHcvdDdsZkxXRS9l?=
 =?utf-8?B?S0xuZ25ybU50bzM3MUFadU5FZGFHNzVuSVF0bDRtOE5ONkNBcGErRVB5ME9P?=
 =?utf-8?B?SG8zK0Z1NlhlZVdPcHZ1Y0ptREppTk1zZnFac2s3WGdNM1FlbTR6cVI0TDMr?=
 =?utf-8?B?dlZJaXZKS0wxeFEvZkE3R0pVYXR0WHE0TXE1ajdPd3ZHdm5lWktkNEV6N2tu?=
 =?utf-8?B?TGxMcys4TmdDRUp3OVliQ1hwNmdPQU9yM1NHQm9naXZCOTdQbzRwc3didFpv?=
 =?utf-8?B?QnNKYStVOTltaEM0ZDZqNHRjQTIxQ3ltaTNiTDBHaXNsSHNYWHd6ajNpR3E3?=
 =?utf-8?B?Rjl1WW40M3pXc2lsL3ZrRXgxYkw2WXNKYXZxanJLVmJqRTdGM2pObW1kb01o?=
 =?utf-8?B?bm13RUVWTC9qYU5zYTFtMEx0WmI0VVZwR016OTllWU1oVVFzMXI2dGFxQW42?=
 =?utf-8?B?dUgrL00wY1JQcUVaWTcxL1NaeGdBWGtTakRZcUxLZ3hYYm9zSlJsRU4xODlT?=
 =?utf-8?B?akVDRUprTDJ0ZnB2V3ZBeTc2NFZUcXhTdXhHN3BNSEl1bWx1TE03MXlHNkZJ?=
 =?utf-8?B?WTRWU1Z6dDl2T0VNNkNsQ09ZODY5eVk5L3JuaUFBa1FLemVGbTMyaDlGUlo2?=
 =?utf-8?B?cUMxWTZOWUVjL1ZkWjRWR0lmTHBCQ3JSdzlucHpYdUxJMUhydU9PZndvN1hv?=
 =?utf-8?B?dHJvQkVZVVBvdzh2U0FnY054Ukx4ZUQxYUtiMUUwclJtcWFHRitqY3lsMzJh?=
 =?utf-8?B?cFdzdTd0ZUpJS2wyMURWaG92dEFZd1N6VnJqTklUbnQ5ZlludTVVb3hITGpJ?=
 =?utf-8?B?R2NzQVR1S3BUTlQvb1FUTGZSWkJLUmJJeFROaXNKamVTTFpSMzFNRnBJeG9z?=
 =?utf-8?B?cEdpdDk2TU1xbjdqWTM0VGw2M29zdmhZeFJ1RlRSN2VDZlVWQlJlblA2OENn?=
 =?utf-8?B?L2lrR1NHck80NlpCRzFYT1hqSVlsb2VuNEl3MXNVZlZKOW0vM1ZGVkZ4RWRz?=
 =?utf-8?B?QzV3aERGc0ZqMmpxcU9seGgyT3pEdlJlOCthY2syNDI1eEdqSXRBcGcwNmk5?=
 =?utf-8?B?elcyQm1UV3BzQlByczl6N2F5clppRTF0NStGa3BveU1xVU1nWkFtTG04T1cx?=
 =?utf-8?B?N3ZEVS9jOW1WbUNla002aVdiY2dtMUNxUThhSVVpclNjSzlNWW1RQWlqdk1P?=
 =?utf-8?B?eDVKZUtPM2NlelFvUUJ2d0NHNUEvaE9qZmpmVkdhUCtYWFFiS1pDV1JJZVZD?=
 =?utf-8?B?am9FcE9haVBaakwrU0dlVFIvZnJzQ1FrenJVZmNqSmdLVkJObWhzNHl1RGNt?=
 =?utf-8?B?TzFUZE43cHNDM3FRc1oyamhOenl0REZ1OWVPZi8rL1h6b21lKzJ2cXBwUmdV?=
 =?utf-8?B?T2FwNlQrN2tTN0dNM0huSHNhczFHWlhWUUg5TmFsSGMwczhrblBwRHg2WWJh?=
 =?utf-8?B?YlRKTC9QUTVRcW41a25FL3ppYnhDWTQ4Mjk5cFhDZHlMclM2YjdFM21jL3A4?=
 =?utf-8?B?U2xIUTVXTjNUdGZaeitXNlhva0RwOURhaVJUQU03QTlnbXVJU1l0bzE0a2Na?=
 =?utf-8?B?dTlKMk1NSXNwdnc3cmw4UkNvSERlMjJEa3ZzT2VjTEZzanAweVVHODFRK1NO?=
 =?utf-8?B?VkE3anIxNi9rZEs0Y0lKdy8wcnp4V3lIZDNCaW5Tc2UrcVllOGUxSkVFN0tD?=
 =?utf-8?B?TmVKNkY1enZQVHBZUGZqQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cExZaXU1VE9yVkxxOXY2bGhrZXNqbFo3Rm0vOWNJM2dsTVhRWVh2YVZ3RU5K?=
 =?utf-8?B?MTlVVGRJWmZnRjZNUTRpL2NTdURYZ3N6Zjk2ME1HY2JwTnY4dkVnWW52czA5?=
 =?utf-8?B?clJ4d0VBN3Vha1lqak5Lb3VmbXdZNUZsU0U5cDZ2N2FMcE9JdWNIaFFIeGhj?=
 =?utf-8?B?S0F2a0ZCbnBTZTdTOWtOUytHZGN4QU1lV2NNWlNpM2FXSUduczFWL2luVmQz?=
 =?utf-8?B?ZEZqbDUxY3d2bVNnaTBMOXY3djZTYmNhcTJRaWh2WWhKUUErSHk0cFN2Znk5?=
 =?utf-8?B?Y3gzdFJOclRSbkNjTm9YVElSZ1hlMy9Ec054bTlKbUhRVmtMTmlqVFlnQStj?=
 =?utf-8?B?V1orMnBtSjE1ZlUrYXg3NXBmaWNDQXhOdXYydDF1NHM4a08rM2JONW1HRTBN?=
 =?utf-8?B?ZmpFL0QzNWc3Qk4rTVRuam9SM2JvSHRYbmZkelBiRzFVbStYSnhQMjZxMGVK?=
 =?utf-8?B?czhZZDNyeE5Tb1FtUGFyZUFYWHRtd0NCTDBFRHNtODBiVmxvb0t3SmxEMFhx?=
 =?utf-8?B?QkRoTUN3Qmk4Q1N0bGRkUUM0MFZsK3gyVzgwamJQTHVOdnNqSmpqY21iV0Vv?=
 =?utf-8?B?YmJwdkJFcU1WZmlRdVdWTndoSDIwV0dQT3FvTisvNi9za0ZXV0N5VGJJL09S?=
 =?utf-8?B?NHR0Y1ZjK0hWWmdxcDRiMk52NUIyV2ZYcG5DNnlQS1ZydVpaYmlGcFNLNFJt?=
 =?utf-8?B?dXdNL29KTlNZY2QvOWd3Y1Z5MHhuc2ZRMW1BNVNTUEpGMFFlSDNJN0k0UHRz?=
 =?utf-8?B?eVFaR1EwdGMxajlwT0ozcUlSZ1JUcFJJNFhjbHl0TVlzdmYzVUNMTFpXVDVV?=
 =?utf-8?B?RlJncFg4b0I0TjkyQkQwQ3ErNWx5Q05SQkcrSWFKOStubHhnbEhTaVBOekZ5?=
 =?utf-8?B?S1AvbDZQTjJRek1PYnBxRmpiN2IyWjV5MkxRbDhjRHU5Mkl4MGpndHYvcFZS?=
 =?utf-8?B?cVo4NjZCVE82Sjg5N3dmdjZTbkEwNy94L3NvRE1peEZhWXQ3aXVySUF2TEVM?=
 =?utf-8?B?ejBrNW8xSUhRWUdvNk0xcWRibE4reTFsM0Y1QzR5bWFtSTlpbGJTQllTcnk0?=
 =?utf-8?B?Z0pWUnFxaEhaUkRKNEZLaVdYanlKVE9hWWkvVDRxVE8xVXZidDJYMWJVRzR0?=
 =?utf-8?B?b2Q4MGU2LzVkNzR6Q0FtOC94YVhtbjNmWEErMWdXL2s1MzZXTWJjSTc5aThE?=
 =?utf-8?B?K1YzamFNMkRzbkZiTWV0YzRBai80ci9YYW55RGR5c1VPYm9YWnBYUUgrWHhs?=
 =?utf-8?B?WjVHUERvcS9HQUJLQVZlTWhkWkhGbFB6QlVSRExlaTNHV1gyRDU4RkxyMG9V?=
 =?utf-8?B?c1NFWmt0aGRqWEJPbkM2dkFYV1NXcjRRa1pSTVorR1k5emw4VTdYMFVWcFNY?=
 =?utf-8?B?MGxjU0RxWWVtSm5JZE5zK1dqSitMNlpXSHQwaUwyMDFrLzgyb203K3Noekdx?=
 =?utf-8?B?ZGppL2FnOEwxcmdLK3Y2MVRvRjNNb3d5b3I5cGI5WWNaeGg5QUNSSE1VTE9z?=
 =?utf-8?B?aW56UkZ5TlB0UTlsMTdBQVJJL0NzNGZNSmd4dDhBeFpkT3cwZ3U3L0c5NjFQ?=
 =?utf-8?B?ZnZlWXhleTZReFFVaTgxVHd0ekgydTljY29kbzBoS2wxYkllNUtNYUYvRHZK?=
 =?utf-8?B?QTk3TytwL3JieVBBOXVXeXNPVEJwSVh3OFBpTW8rUW4zTThEbzUrNFJxclVj?=
 =?utf-8?B?eGFnaXZEeFpITEpqNENHYS9MMDliVnRpT3U2V3l5aUk3TEZyckFNa2hDWkxD?=
 =?utf-8?B?R1F2RTZWUW5tVFFUTHNBdUFRVVVaYmFpZm5mc243aWRweGdLN08xVmZuaURG?=
 =?utf-8?B?UkVob2kvMHJIanBNMEFRa3hwMEVkcVduV2FqaFBzWkJ0YWJmSXFhZm1uZWM4?=
 =?utf-8?B?cldzNFNOYS9Kb3djcytVRFNlUitzQzFTbWhrQ0F0WGlJUzZqQ0s5RHpIQXU1?=
 =?utf-8?B?SVh1eHlJRFo4YWdBa0xITE15ZElIZStaWnVLRDUyYUxJV01tQzNJVytxYmRE?=
 =?utf-8?B?dmdncVBaaXRub0FxbjBlNnM5V3phQlorVVZRa1VZZzB1ZHZmUS8wcVBuVFkv?=
 =?utf-8?B?VU5oTHllZUpLb1JrRlExa2YyRGtteEF3SlUrdU1oRUJibFNzR2d1aGd5WFh4?=
 =?utf-8?Q?+0Cz0066mdjafpGfoN74Fjro5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfb499b-2751-4c1e-d3c4-08dcbc1c82a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:49:41.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RUajPZFz78Ul9nbpOhJARTTIgxxOc9aTnCDwLz25cU9Y10Fp7gIwbNEfB9hDCQBeEX/Qq+LG22PvqudLx/OUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8776

On 13.08.24 17:40, Conor Dooley wrote:
> On Tue, Aug 13, 2024 at 08:04:59AM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Expand bindings to cover both the MCU and the main usage of the AM654
>> system controller.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../soc/ti/ti,am654-system-controller.yaml    | 25 +++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> index e79803e586ca..5a689ec3c5c9 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
>> @@ -29,11 +29,36 @@ properties:
>>  
>>    ranges: true
>>  
>> +  mux-controller:
>> +    type: object
>> +    ref: /schemas/mux/reg-mux.yaml#
>> +    description:
>> +      This is the SERDES lane control mux.
>> +
>>  patternProperties:
>>    "^phy@[0-9a-f]+$":
>>      type: object
>>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
>>  
>> +  "^clock@[0-9a-f]+$":
> 
> Could you explain to me why these are all patternProperties? Why are the
> addresses of these things not fixed for an am654?
> 

I could indeed spell out dss-oldi-io-ctrl@41e0 and
clock-controller@4140, and their addresses are likely fixed, indeed. But
there are also clock@4080 and clock@4090 - should I duplicate their
object descriptions while moving them to the regular properties?

Jan

>> +    type: object
>> +    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
>> +
>> +  "^dss-oldi-io-ctrl@[0-9a-f]+$":
>> +    type: object
>> +    $ref: /schemas/mfd/syscon.yaml#
>> +    properties:
>> +      compatible:
>> +        items:
>> +          - const: ti,am654-dss-oldi-io-ctrl
>> +          - const: syscon
>> +
>> +  "^clock-controller@[0-9a-f]+$":
>> +    type: object
>> +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
>> +    description:
>> +      Clock provider for TI EHRPWM nodes.
>> +
>>  required:
>>    - compatible
>>    - reg
>> -- 
>> 2.43.0
>>

-- 
Siemens AG, Technology
Linux Expert Center


