Return-Path: <linux-kernel+bounces-378629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFB9AD36A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6EE2837D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B021D0418;
	Wed, 23 Oct 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="P9dFwU1D"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE40B15EFA0;
	Wed, 23 Oct 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706360; cv=fail; b=kT8OYx7FRZdkmBfpku6OwrfDhNBxzDqL6xzZjOHlzeAKUDXW89GSWBVYpEk1Y7EVEU/V31Iq5pPZY/9nPVVgs2W8igqJqSlS5zf71xSKZjSPp+aOD9/AdCeMBbKvFvttZ0RjC6/2JXh6hSZ2OU3eBgllc0liy6gCn8fVgzRhAn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706360; c=relaxed/simple;
	bh=vZfXbaQwKKtivp8SLwNdaIo/kMRYKAYnQuAQTdoA5aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sdjcs/bjV37w51OUWWpFuiJwSsVXr1j69Dx/agGQSlDxF0xDwbC4GJUty5DiNe84oz1ObGjtzIW5X1hOug/nkdhZ/oYs9nIhCfpaNedZ+Kh36ABHyKadM1GctGbIYc0FpiwHF91F+b9r1vaUA/bTb6aYcapB9Rw136SltaS/Dx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=P9dFwU1D; arc=fail smtp.client-ip=40.107.22.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9zBrT8LCVb3Nf5vI5fmK8mfE8t+jLkZ1nbh28OtckZlY6Z/zluUK8E/M3b/24vkGgR+Dh+mzoT7D3KTDe96CwdJod/YMvsOPJkvTbr9+eSokvOd2U6QQygv+jTbllZXCx1UId/xdw5pX5L6iRdI5IYgs7cyzwbp9rx4FzQDlIfSAM3rgK6DLNoHOk+PFeNFOskxRxxG+jpwJFyBecOHBN1YMjybaR6wiXnAOGtioCknNBHr4T8W5VlmwVK1Qj+72q4I/7ORyyxt/Lldls/ePgWNCOqm+e019mRKt9FoqjE5y+momUIcwMP87yRFKMkoVx6ARnWFA0kbkaAxAOaARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjfY/+hrresIBSQ2W2IVbUzwUd99LwEVSIKxV2jdInE=;
 b=Svx6f0XEZM5oKngO/c8XHEIITvREe7cJq2o/RjF8VLj6oknfKLk5Rvh+wAw6tin1+DEABlrg5+asoR2kYwRXNImNEUJ0Aoquwslk6FTGB8fZIOh6msIzu1fXd6PZGAKR7SQQVeI+jGfBLM15I5IWey0dmIGkvpw894M+1BfpYwSyqcTp7+jlQRdcYN34tFgrjsiRrs7QJSc8LJu77/Q4gLqyZ91jh2ZAIHWa/WGv/BFNEqYdCf+/zSNGuNefHbK2/bMtezGVxZncvFwKZwyUKLRp5hSdUzCELTIh/CWpCxxUAhEvvv1ZcJ1aUqPiKhnkpPN3EXHSwRabXeprcnN3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjfY/+hrresIBSQ2W2IVbUzwUd99LwEVSIKxV2jdInE=;
 b=P9dFwU1DN0IwoUh7yZhNgFmCe6o+s2Azq7ckl8vq7/hiTWkrNUNad5AWsgEVNTMrSY0CsGpJFCV5N7TEyttfSBpfh9dqkZzckw4QLBnbaGMtuwy59Wgnke+kYkgjmgEK96voTCYDUccET+ckQZiLAxMBLWeLivrsA2rhQ6LGe+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 by GVXPR04MB10972.eurprd04.prod.outlook.com (2603:10a6:150:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:59:08 +0000
Received: from PA4PR04MB7919.eurprd04.prod.outlook.com
 ([fe80::d550:6682:2c3c:a8c2]) by PA4PR04MB7919.eurprd04.prod.outlook.com
 ([fe80::d550:6682:2c3c:a8c2%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 17:59:08 +0000
Date: Wed, 23 Oct 2024 18:59:03 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Larabel <Michael@phoronix.com>,
	Casey Bowman <casey.g.bowman@intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
Message-ID: <Zxk5ZwG-61iVP3Qm@laptop>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
 <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de>
 <ZxkLz6QBahA7WAyh@laptop>
 <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de>
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To PA4PR04MB7919.eurprd04.prod.outlook.com
 (2603:10a6:102:c1::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7919:EE_|GVXPR04MB10972:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a6058a-214d-4a39-1dd4-08dcf38c63e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|41320700013|366016|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDJKTGNELzEzdVg2VExSNHYwK3BYU0VtZ2tmS1FucWgrL1d0UlIvajMvbFYy?=
 =?utf-8?B?TllDQUlQcW83L0I3SVVnb1lmSEpwQVlHY2pONkcxK1VXVi9MRXZqSjZ0SlBW?=
 =?utf-8?B?cm9HRnVmZ1ZZY0RsTFNmbTVyeXpGdnVFRHZKNkUwK3hUa1NkMERIN0lyczFa?=
 =?utf-8?B?Ky9kTVhQT2Z6WnY0NCtsUU9rYUtEdVZjUndUL0V2NngxU1JER3hsVGJ5UzRn?=
 =?utf-8?B?Mk1KeVZMYjdDVlBKc0V2R2tvNlhsVXhwbm51RjM4QUlhQm1qVUs0T1dlYk0z?=
 =?utf-8?B?NE5rZnlEdkdoc2FLTW1HQU5SNDZWU0I1R3ZBbDk2citQU25Va0pyMHFDait5?=
 =?utf-8?B?bU1iR3kwUklRdjk0OW5uajJ3TlhNQzdiQkRza2ZzbUl5SDgxVXRXZkFxcFAr?=
 =?utf-8?B?dlh0Sk0wb1BlTlptZE5oblRvTFpXVzR0a3ducjlVbkJiclVMV0srWU5mYnNi?=
 =?utf-8?B?VklaSlNoQmJwWHZOZ0s3b1lReU5tYngwUGNuN21kNnd5SG1wR2s3N1JwSmhC?=
 =?utf-8?B?Vmx3dHRSRVlHclRYc3MvWkhtQVZDYnFtSXBoYmYxMjV0ck9WOUl2R1VzUEVs?=
 =?utf-8?B?R0ZqQzRhNkcwcUhUTTBnMXVHMkZISkRaa2QwTHdxMVYwb1UvVVVYUEt0emJX?=
 =?utf-8?B?M05DK3gzYXUzZkZDcmdXajZiZzhSR1pwb1U5YThSbkZVZEhFRlEzQ2dCM2tv?=
 =?utf-8?B?N0VxVTI3cHkwTHdaL1lKVzNKbDc4UXhnc0J0c0x3M3JFVGFkakZibUNleEdX?=
 =?utf-8?B?dTJZbkp1QllSY250SWprS011bjlrR2tmOU02TUlvRHhUb1hlWlJnZU84K0Rj?=
 =?utf-8?B?dTkxYmRYQ09YTXhiYWtMSkNIZXNBenYvbFlDTkI1K1pNbEpyK1pBeWtBQ0wv?=
 =?utf-8?B?VURGNGVucVdwc1dzdDhPNms4VUkvSjJicGI4V3RPSGhqbnd4cFlVVUc3dDRp?=
 =?utf-8?B?T2xwMWVyMXdiYTFoTG0rSDBOaHp5WElHeWpldGxhV1BxdHgwUFY3SFJRV2hD?=
 =?utf-8?B?cFYyTFZiNDBKaUVIYTl2OEVCTkFOREJQSjIwSDJEdXArRnlKYVY3MjFlSGtN?=
 =?utf-8?B?aGtJMlNBTVVuQ1Znc1ZPL0ZNdTU4SHRUeUkrUU5qSStoTGtLbGNTMFdWaGp5?=
 =?utf-8?B?K3I1akJPM2RIMTZoQmh3TEdkdENNSTQxOTNkTFpacC9FRHEzcFFUYkFDSU9U?=
 =?utf-8?B?YmRYaWhzQUJLL01sLzhvSWtqWFNzak9aTkd0Nkk5SEdBdWlKdW84VHdMZUdz?=
 =?utf-8?B?R2llclg0NDE1ZlZoaUVzOXQvZ2tXeDUxa3JCbjV6V2VCcE9ybzBDaGZoRXFs?=
 =?utf-8?B?NVM3SXJuNisrYXRLMGRRYVF3cnN6blRJb3dHb2FMRkpDV3pPU2pPRGc2N29K?=
 =?utf-8?B?QThtS3Q2Qm16TWY1MjJiakZGcjVkcHhzQXg2VkRBWTVScEdZazROWUhHY1F2?=
 =?utf-8?B?emhTeUdBSHZQaDBqNnBvYmJicVJLN3F6Q0FkREhiR05jSFpQcU0yNXdmQ2w3?=
 =?utf-8?B?UTRkVzlyK2M1cWxIeWNhVVREeUwyM2FxT0JjVHZ3TzlCYVRwbEdmZVBrd01R?=
 =?utf-8?B?VGEwRU9XZDBlL3BXSVoyc2ZjWnNtTE9MMXYxZjlIWlBIY2ZaQVVSajZqaUpx?=
 =?utf-8?B?cm9uUzNtRVF1R0l3Ulh3SE1kYjZ3TzRYNUVVMWJiMGtSYkZqNmRhcXlEamJs?=
 =?utf-8?B?NXdralhqSUY1dm1XeWRZZzBnQVpsSTdNVUNWMkxQMFA1anlMbHpzc29sYXB1?=
 =?utf-8?B?azhDYkdIdTlnSGJBclFQa295T1lVanl1cW9KNldFZllrMm1SeC9xMC9YT3Zo?=
 =?utf-8?B?VzJMNXIzSmJQQnJBbk1NcnpiWFZQSTNUc2Y0ai95R1NjTGtRdGphZUFaODkz?=
 =?utf-8?Q?8e8gQWyk5C+KK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(41320700013)(366016)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGFKdGJDMUQzeFk4S04xNnR3WHZvWkdHSUV1SHNMSlAvVy9CZWh6K3A0VW1D?=
 =?utf-8?B?MFRmTDJxZ29MODg2QWd3dWJUbDdjVjRrQnF0Z2RSTTV6ZVFSMmx0QkliU1Bq?=
 =?utf-8?B?OVhKdmVXZVZ1RjdscDUxaFMwazkwSlVhV1YxVVZXK3d4VWx0NWlxRWpkaXNY?=
 =?utf-8?B?bVF3SXBPNVZwOWJVWjFMalliWkdRaVpKNERVeWNwbytLbG9lZkNITDBRczhZ?=
 =?utf-8?B?R2tGenJUckFFSXZRNmFxQWdEV3ZtQVZjcEJwWWpzY2VxYlFTbElpWHZmcXRi?=
 =?utf-8?B?ZTlZS3l1YTBVdVZJQWRLTTJJTitLajQya1pkU0NxOEpZRkxycVBOZDFSL05I?=
 =?utf-8?B?ZzRKZ2pVMitwbVRFM0p2Q0YrOXF5VEVkaUcwT08yWCtqUU1RU0VwRGM5VFgx?=
 =?utf-8?B?Y05TUFNad2tZdFhpNHpSZnBQeC92Wlp5U2pkTGhsREVyM1YxZ3hOcjJwYUI4?=
 =?utf-8?B?czJwYlBIMkdOREkrYi92NVFTd3ZlOHFtSW5qOGx6MXNkZVlFTGE4RW5CVnFR?=
 =?utf-8?B?eUNnM3B2L0tMZCtWSTRIdTdpUmZZVHNEY0Y0NS9DTkFrSlErYWFYMlZWNWt3?=
 =?utf-8?B?ZDdxOTZWalpxVmtmdk5ocGtRS21zZjdUVkNncHJCM1lIeWd3NUZBOWdGME9P?=
 =?utf-8?B?QzJuckRxWWtIeWttampmMUhEL2pTcWs5VHJ3SlJMNUVSdHdsUTlQb0Q5TGhD?=
 =?utf-8?B?c1k3S2dWcUlJQWJCSlBpZ291bCtUdWh6VjRUTzBJL0pWMzVsU2NLZEV2dUxv?=
 =?utf-8?B?Unk1YUdVbG1XZStxRFE4ZU1uUDd1TnFHWUhOTURQc3lGNUI3dU5Pd2h0aCtJ?=
 =?utf-8?B?RWM0MXZyOXBURk9zUjZFNXlTekZMRi9EOVFVNzRNSk4vR1oyWE54K1lQOUtx?=
 =?utf-8?B?Z3JJODk4QU9aNTBSUUovc3VNYlF5eVVJZm5FTWM4cUwwZ2hNVjNZU0dFT0F3?=
 =?utf-8?B?MkhlL2tOamFDTUFFZzN0S3FFOGpGa3dudkhNc3J2RktBNnRheDF4RGlHbVYw?=
 =?utf-8?B?Zk9IUHkzMlpocEFkOUYzdmZFL0FWS2ZkOG5JK0JHdVpvT0ZQOXBEcVNuUjJ3?=
 =?utf-8?B?aE1kcU1wUVFkMjZhOWl5QkkzWU1XYXZGTkZrMEhLSGN6ZnBwV3I0UWdVWWt0?=
 =?utf-8?B?d0NvTEY1ZTM2b2prb1dkaXUwOFdCaVc4NzJjS2dSY2owWGpNdSt2aHF5eUU5?=
 =?utf-8?B?NlBLOFRuYUhIMUNlN3p0Tml6S2tFcUo0T3B4aEJiOXpqUUduQlJxRmhyZTlY?=
 =?utf-8?B?TGcyS3g1Q2wyaElhWTRYSUt3V2NHLzFwMm5XUjQ3MU5DQkJUdjVVN29uS1lh?=
 =?utf-8?B?TnovYWthazhFek1BQ3BJVy9saWtKUmVMUmJsYUppQm1iYldmMWVwWGZCTXdR?=
 =?utf-8?B?NEhhdXNPUURFMW9INnBHUVd0bVU4OXF3RitKQytBd1FZaGpQRjI2Z2dTMUdN?=
 =?utf-8?B?VTk5SjNoaVp3eTNpdEViT0didUhtYlZkYncvSUpNanZqTmt1MCtNZjBlODJn?=
 =?utf-8?B?WlNFeDBHSUZ3cWN4ZnRaOXB1ZzJuOG5KVER4TjFQMHl4TXlIdEwza0lsSnd5?=
 =?utf-8?B?Y1h6RXJDb08rbjhOU3FNa2ErUGlMZUkySUFvcmN4VU9wd1cwRS95bUZDQ01N?=
 =?utf-8?B?NUlwTnlMbFY1RnJZRnNIYzJtS28xUnBVTUtnQkU0T0UyR3BpT3NnQnh1Q3d1?=
 =?utf-8?B?Zm1BKzB5OW15UGtJWkNkTzhwOUR2K0VtL1pPMHF3QVdWb1RrNzNVSjZBcWNZ?=
 =?utf-8?B?R1pyeVVGRC8ySlQ3M1lsbDZ6eFRETnI0K3IzRGNpd3VGaEFJZ1RYY05SZktY?=
 =?utf-8?B?bEtqUkRINWhSbCtlbmF1SXNkckVRSmVWQWp4clZqbVM3U2E1Z2h3amdnMjZq?=
 =?utf-8?B?cFAvWjBtS29kSnJJK3crUzJwMWdSb0duWk1wenEvdjFqWmdJcDZFMzBPeHEz?=
 =?utf-8?B?czZxUUNaZFpsWnJTOWpGUzlrM3Jnbk8vaXBKVkxNWmpmT09yd1lkc3ZhZDFq?=
 =?utf-8?B?bkFoVkFKQU50cHJXYXRYV2o5c3VLUU5RTDVjNk1kK2JLelFyK0d5cm5VOTlB?=
 =?utf-8?B?aW5IeGpRNnNZQStlSnlxNnFvejhsdW5LdFNCK1NxeGVJSURoTHF6bzFUclhz?=
 =?utf-8?B?THNtV2ZaaTkxSmlSVld1RUVLWGZZSzlNSGYvSFNZWXA4bGhUbEdhREttTEhX?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a6058a-214d-4a39-1dd4-08dcf38c63e3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:59:08.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9nDdqz0YNtKxJKj/Wi0HPcissEkbmWPDoawNq4M8EbdUzPtK9n2aUIDROwYdjj1nh07gneUqDNXf61WzE4izOjHESVIdZOSeAQjQd8J1jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10972

On Wed, Oct 23, 2024 at 06:31:17PM +0200, Armin Wolf wrote:
> Am 23.10.24 um 16:44 schrieb Mohamed Ghanmi:
> 
> > Hello !
> > On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
> > > Am 20.10.24 um 21:05 schrieb Armin Wolf:
> > > 
> > > > Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
> > > > 
> > > > > Some recent Asus laptops are supporting ASUS Intelligent Performance
> > > > > Technology (AIPT). This solution allows users to have maximized CPU
> > > > > performance in models with a chassis providing more thermal head room.
> > > > > Refer to [1].
> > > > > 
> > > > > There are major performance issues when Linux is installed on these
> > > > > laptops compared to Windows install. One such report is published for
> > > > > Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
> > > > > processors [2].
> > > > > 
> > > > > By default, these laptops are booting in "Whisper Mode" till OS power
> > > > > management or tools change this to other AIPT mode. This "Whisper" mode
> > > > > calls to set lower maximum and minimum RAPL (Running Average Power
> > > > > Limit)
> > > > > via thermal tables. On Linux this leads to lower performance even when
> > > > > platform power profile is "balanced". This "Whisper" mode should
> > > > > correspond to "quiet" mode.
> > > > > 
> > > > > So, when AIPT is present change the default mode to "Standard" during
> > > > > boot. Map the three platform power profile modes as follows:
> > > > > 
> > > > > Power Profile Mode      AIPT mode
> > > > > -----------------------------------
> > > > > quiet            Whisper
> > > > > balanced        Standard
> > > > > performance        Performance
> > > > > ------------------------------------
> > > > > 
> > > > > Here AIPT mode can be detected by checking presese of "FANL" method
> > > > > under
> > > > > PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
> > > > > precedence over the existing VIVO thermal policy. These modes are set
> > > > > using "FANL" method.
> > > > > 
> > > > > Although this “FANL” method is not used in the Asus WMI driver, users
> > > > > have used this method from user space [3] to set AIPT modes. Used this
> > > > > as a reference.
> > > > > 
> > > > > Link:
> > > > > https://www.asus.com/content/laptop-asus-intelligent-performance-technology-aipt/
> > > > > # [1]
> > > > > Reported-by: Michael Larabel <Michael@phoronix.com>
> > > > > Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
> > > > > Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # [3]
> > > > > Tested-by: Casey Bowman <casey.g.bowman@intel.com>
> > > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > > ---
> > > > >    drivers/platform/x86/asus-wmi.c | 93 +++++++++++++++++++++++++++++++--
> > > > >    1 file changed, 89 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > > > b/drivers/platform/x86/asus-wmi.c
> > > > > index 7a48220b4f5a..06689d0f98c7 100644
> > > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > > @@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
> > > > >    #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO    1
> > > > >    #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO    2
> > > > > 
> > > > > +#define AIPT_STANDARD                0
> > > > > +#define AIPT_WHISPER                1
> > > > > +#define AIPT_PERFORMANCE            2
> > > > > +#define AIPT_FULL_SPEED                3
> > > > > +
> > > > >    #define PLATFORM_PROFILE_MAX 2
> > > > > 
> > > > >    #define USB_INTEL_XUSB2PR        0xD0
> > > > > @@ -333,6 +338,9 @@ struct asus_wmi {
> > > > >        struct asus_wmi_debug debug;
> > > > > 
> > > > >        struct asus_wmi_driver *driver;
> > > > > +    acpi_handle acpi_mgmt_handle;
> > > > > +    int asus_aipt_mode;
> > > > > +    bool asus_aipt_present;
> > > > >    };
> > > > > 
> > > > >    /* WMI
> > > > > ************************************************************************/
> > > > > @@ -3804,6 +3812,19 @@ static ssize_t
> > > > > throttle_thermal_policy_store(struct device *dev,
> > > > >    static DEVICE_ATTR_RW(throttle_thermal_policy);
> > > > > 
> > > > >    /* Platform profile
> > > > > ***********************************************************/
> > > > > +static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int
> > > > > aipt_mode)
> > > > > +{
> > > > > +    int status;
> > > > > +
> > > > > +    status = acpi_execute_simple_method(asus->acpi_mgmt_handle,
> > > > > "FANL", aipt_mode);
> > > > > +    if (ACPI_FAILURE(status)) {
> > > > > +        acpi_handle_info(asus->acpi_mgmt_handle, "FANL execute
> > > > > failed\n");
> > > > > +        return -EIO;
> > > > > +    }
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >    static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
> > > > > int mode)
> > > > >    {
> > > > >        bool vivo;
> > > > > @@ -3844,6 +3865,26 @@ static int
> > > > > asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int m
> > > > >        return mode;
> > > > >    }
> > > > > 
> > > > > +static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
> > > > > +                          enum platform_profile_option *profile)
> > > > > +{
> > > > > +    switch (asus->asus_aipt_mode) {
> > > > > +    case AIPT_STANDARD:
> > > > > +        *profile = PLATFORM_PROFILE_BALANCED;
> > > > > +        break;
> > > > > +    case AIPT_PERFORMANCE:
> > > > > +        *profile = PLATFORM_PROFILE_PERFORMANCE;
> > > > > +        break;
> > > > > +    case AIPT_WHISPER:
> > > > > +        *profile = PLATFORM_PROFILE_QUIET;
> > > > > +        break;
> > > > > +    default:
> > > > > +        return -EINVAL;
> > > > > +    }
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >    static int asus_wmi_platform_profile_get(struct
> > > > > platform_profile_handler *pprof,
> > > > >                        enum platform_profile_option *profile)
> > > > >    {
> > > > > @@ -3851,6 +3892,10 @@ static int
> > > > > asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > > >        int tp;
> > > > > 
> > > > >        asus = container_of(pprof, struct asus_wmi,
> > > > > platform_profile_handler);
> > > > > +
> > > > > +    if (asus->asus_aipt_present)
> > > > > +        return asus_wmi_aipt_platform_profile_get(asus, profile);
> > > > > +
> > > > >        tp = asus->throttle_thermal_policy_mode;
> > > > > 
> > > > >        switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> > > > > @@ -3874,26 +3919,42 @@ static int
> > > > > asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > > > >                        enum platform_profile_option profile)
> > > > >    {
> > > > >        struct asus_wmi *asus;
> > > > > -    int tp;
> > > > > +    int ret = 0, tp, aipt_mode;
> > > > > 
> > > > >        asus = container_of(pprof, struct asus_wmi,
> > > > > platform_profile_handler);
> > > > > 
> > > > >        switch (profile) {
> > > > >        case PLATFORM_PROFILE_PERFORMANCE:
> > > > >            tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > > > +        aipt_mode = AIPT_PERFORMANCE;
> > > > >            break;
> > > > >        case PLATFORM_PROFILE_BALANCED:
> > > > >            tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > > +        aipt_mode = AIPT_STANDARD;
> > > > >            break;
> > > > >        case PLATFORM_PROFILE_QUIET:
> > > > >            tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > > > +        aipt_mode = AIPT_WHISPER;
> > > > >            break;
> > > > >        default:
> > > > >            return -EOPNOTSUPP;
> > > > >        }
> > > > > 
> > > > > -    asus->throttle_thermal_policy_mode =
> > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > -    return throttle_thermal_policy_write(asus);
> > > > > +    if (asus->asus_aipt_present) {
> > > > > +        ret = asus_wmi_write_aipt_mode(asus, aipt_mode);
> > > > > +        if (!ret) {
> > > > > +            asus->asus_aipt_mode = aipt_mode;
> > > > > +            goto skip_vivo;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    if (asus->throttle_thermal_policy_dev) {
> > > > > +        asus->throttle_thermal_policy_mode =
> > > > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > > +        ret = throttle_thermal_policy_write(asus);
> > > > > +    }
> > > > > +
> > > > > +skip_vivo:
> > > > > +    return ret;
> > > > >    }
> > > > > 
> > > > >    static int platform_profile_setup(struct asus_wmi *asus)
> > > > > @@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct
> > > > > asus_wmi *asus)
> > > > >         * Not an error if a component platform_profile relies on is
> > > > > unavailable
> > > > >         * so early return, skipping the setup of platform_profile.
> > > > >         */
> > > > > -    if (!asus->throttle_thermal_policy_dev)
> > > > > +    if (!asus->throttle_thermal_policy_dev && !asus->asus_aipt_present)
> > > > >            return 0;
> > > > > 
> > > > >        dev_info(dev, "Using throttle_thermal_policy for
> > > > > platform_profile support\n");
> > > > > @@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct
> > > > > platform_device *device)
> > > > >    static int asus_wmi_platform_init(struct asus_wmi *asus)
> > > > >    {
> > > > >        struct device *dev = &asus->platform_device->dev;
> > > > > +    struct acpi_device *adev;
> > > > >        char *wmi_uid;
> > > > >        int rv;
> > > > > 
> > > > > @@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct
> > > > > asus_wmi *asus)
> > > > >            asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
> > > > >                          asus->driver->quirks->wapf, NULL);
> > > > > 
> > > > > +    /*
> > > > > +     * Check presence of Intelligent Performance Technology (AIPT).
> > > > > +     * If present store acpi handle and set asus_aipt_present to true.
> > > > > +     */
> > > > > +    adev = acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);
> > > > Is there really no way of changing the AIPT mode through the WMI
> > > > interface?
> > > > I would prefer using the WMI interface if available, since the
> > > > firmware might
> > > > assume that FANL is only called through the WMI interface.
> > > > 
> > > > Do you have a acpidump from a affected device?
> > > > 
> > > > Thanks,
> > > > Armin Wolf
> > > > 
> > > I found a acpidump from a ASUS device with a matching FANL method. It seems that this method
> > > can indeed be called using the WMI interface using the DEVS() WMI method:
> > > 
> > > [WmiMethodId(1398162756), Implemented] void DEVS([in] uint32 Device_ID, [in] uint32 Control_status, [out] uint32 result);
> > > 
> > > If Device_ID is 0x00110019, then Control_status is passed to the FANL ACPI method.
> > > 
> > > It also seems that support for AIPT can be queried using the DSTS() WMI method:
> > > 
> > > [WmiMethodId(1398035268), Implemented] void DSTS([in] uint32 Device_ID, [out] uint32 device_status);
> > > 
> > > Using Device_ID 0x00110019, the returned device status seems to contain the following information:
> > > 
> > > - 16-bit current AIPT mode
> > > - 4-bit unknown value (possible values 2, 3 and 7, maybe number of supported modes or some kind of bitmap?)
> > > - 1-bit with is set when (GGIV (0x0907000C) == One) is true
> > I just saw this conversation and i think that the behaviour this
> > patch will implement in the driver was already implemented in this patch
> > that got added to kernel v6.12-rc3:
> > https://lore.kernel.org/platform-driver-x86/20240609144849.2532-2-mohamed.ghanmi@supcom.tn/
> > 
> > this patch introduced ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
> > 0x00110019 which is the device_id that changes the fan profiles. the
> > naming is not clear because it was initially intended to add support for
> > fan profiles for vivobook laptops but it ended up adding support
> > for a lot of modern laptops.
> 
> Nice, you are absolutely right.
> 
> So this patch series is effectively already upstream, very good. I did some research and found out
> that the status of this device id contains the following data:
> 
> Status		Supported Modes
> -------------------------------
> 0x00[1]300[xx]	0 1 2
> 0x000700[xx]	0 1 2
> 0x000200[xx]	??? (ODV0)
> 0x000700[xx]	0 1 2
> 0x0a0700[xx]	??? (ODV0)
> 
> While i have no clue about the meaning of the remaining bits, i can report that the first 8 Bits
> contain the current thermal mode. Maybe adding support for this would be nice, so the current
> thermal mode can be read directly from the hardware.
> 
> I also found out that on some models the thermal mode actually modifies the ODV0 variable which
> is consumed by int3400_thermal and exposed to the Intel Thermal Daemon. So maybe the lackluster
> performance also has something to do with it.
> 
> > a point that Srinivas Pandruvada mentioned about RAPL (Running Average Power Limit)
> > is valid for a lot of modern vivobook and zenbook laptops but i think
> > it's unrelated to fan profiles.
> > 
> > a lot of asus laptops that have intel cpus suffer from power throttling.
> > for exemple in my case using windows, changing fan profiles will lead to max power
> > changing to the values indicated in the table below (asus vivobook 16x
> > pro k6604) which leads to higher performance than linux
> > 
> > fan Profile		power limit
> > -----------------------------------
> > Whisper			50watts
> > Standard                120watts
> > Performance		149watts
> > ------------------------------------
> > 
> > However in linux, even after changing to the appropriate fan profile,
> > the power is still capped at 50watts and i found the reason why
> > 
> > here is the results of using the powercap-info command:
> > 
> > intel-rapl-mmio
> >    enabled: 1
> >    Zone 0
> >      name: package-0
> >      enabled: 1
> >      max_energy_range_uj: 262143328850
> >      Constraint 0
> >        name: long_term
> >        power_limit_uw: 30000000
> >        time_window_us: 55967744
> >        max_power_uw: 55000000
> >      Constraint 1
> >        name: short_term
> >        power_limit_uw: 55000000
> >        time_window_us: 2440
> >        max_power_uw: 0
> > intel-rapl
> >    enabled: 1
> >    Zone 0
> >      name: package-0
> >      enabled: 1
> >      max_energy_range_uj: 262143328850
> >      Constraint 0
> >        name: long_term
> >        power_limit_uw: 157000000
> >        time_window_us: 55967744
> >        max_power_uw: 55000000
> >      Constraint 1
> >        name: short_term
> >        power_limit_uw: 157000000
> >        time_window_us: 2440
> >        max_power_uw: 0
> >      Constraint 2
> >        name: peak_power
> >        power_limit_uw: 200000000
> >        max_power_uw: 0
> >      Zone 0:0
> >        name: core
> >        enabled: 0
> >        max_energy_range_uj: 262143328850
> >        Constraint 0
> >          name: long_term
> >          power_limit_uw: 0
> >          time_window_us: 976
> >      Zone 0:1
> >        name: uncore
> >        enabled: 0
> >        max_energy_range_uj: 262143328850
> >        Constraint 0
> >          name: long_term
> >          power_limit_uw: 0
> >          time_window_us: 976
> >    Zone 1
> >      name: psys
> >      enabled: 0
> >      max_energy_range_uj: 262143328850
> >      Constraint 0
> >        name: long_term
> >        power_limit_uw: 0
> >        time_window_us: 27983872
> >      Constraint 1
> >        name: short_term
> >        power_limit_uw: 0
> >        time_window_us: 976
> > 
> > 
> > as seen by the output of the command, the intel-rapl-mmio is causing the
> > throttling as it sets power_limit_uw to 30 watts (readonly). so the current fix
> > that i'm currently using is disabling the intel-rapl-mmio leaving only
> > the intel-rapl which sets power_limit_uw to 157watts using this
> > command: powercap-set -p intel-rapl-mmio -z 0 -e 0
> > 
> > this will lead to the laptop being able to reach it's maximum power
> > limit.
> > 
> > after doing this, when i change the platform profile through sysfs the
> > laptop will start behaving as described in the table above exactly like
> > windows.
> > 
> > in conclusion, the asus-wmi driver already has the platform profiles
> > (a.k.a fan profiles)
> > implemented and I think that the power throttling is caused by either
> > intel Power Capping Framework or asus bios.
> 
> Or the Intel Thermal Daemon somehow does not properly support intel-rapl-mmio
> or is not installed.

This was exactly it. the Intel Thermal Daemon wasn't installed. now
everything is working as expected!

Best regards,
Mohamed G.

